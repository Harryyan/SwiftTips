using System;
using System.Threading;
using System.Threading.Tasks;

namespace Task_Test
{
    class Program
    {
        static async Task<int> Main(string[] args)
        {
            Thread thread1 = Thread.CurrentThread;
            Console.WriteLine(thread1.ManagedThreadId + " : Main Before");

            Console.ReadKey();

            await callMethodAsync();

            Thread thread = Thread.CurrentThread;
            Console.WriteLine("Hello World!");
            Console.WriteLine(thread.ManagedThreadId + " :Main After");

            Console.ReadKey();

            return 0;
        }
        public static async Task callMethodAsync()
        {
            await Method1();

            Console.WriteLine("#####################");

            await Method2();

            Console.WriteLine("#####################");

            await Method3();

            Console.WriteLine("#####################");

            await Method4();

            Console.WriteLine("#####################");
        }

        public static async Task<int> Method1()
        {
            int count = 0;
            Thread thread = Thread.CurrentThread;

            await Task.Run(() =>
            {
                for (int i = 0; i < 5; i++)
                {
                    Console.WriteLine(thread.ManagedThreadId + ": Method 1");
                    count += 1;
                }
            });

            return await Task.FromResult(count);
        }

        public static async Task<int> Method2()
        {
            int count = 0;
            Thread thread = Thread.CurrentThread;

            await Task.Run(() =>
            {
                for (int i = 0; i < 10; i++)
                {
                    Console.WriteLine(thread.ManagedThreadId + ": Method 2");
                    count += 1;
                }
            });

            return await Task.FromResult(count);
        }

        public static async Task<int> Method3()
        {
            int count = 0;
            Thread thread = Thread.CurrentThread;

            await Task.Run(() =>
            {
                for (int i = 0; i < 15; i++)
                {
                    Console.WriteLine(thread.ManagedThreadId + ": Method 3");
                    count += 1;
                }
            });

            return await Task.FromResult(count);
        }

        public static async Task<int> Method4()
        {
            int count = 0;
            Thread thread = Thread.CurrentThread;

            await Task.Run(() =>
            {
                for (int i = 0; i < 20; i++)
                {
                    Console.WriteLine(thread.ManagedThreadId + ": Method 4");
                    count += 1;
                }
            });

            return await Task.FromResult(count);
        }
    }
}
