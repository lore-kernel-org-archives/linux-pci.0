Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 13 Feb 2018 13:05:50 -0600
Message-ID: <20180213130550.Horde.JMezTfF5lIykmPMB49PKEwG@gator4166.hostgator.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI/ASPM: Use 64-bit arithmetic instead of 32-bit
References: <20180213165948.GA14035@embeddedor.com>
 <CAHp75VfdDUooc=zy2rk8ep0PdsEsD1TGbaD9nm8DBB1NmYYTTw@mail.gmail.com>
In-Reply-To: <CAHp75VfdDUooc=zy2rk8ep0PdsEsD1TGbaD9nm8DBB1NmYYTTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Andy,

Quoting Andy Shevchenko <andy.shevchenko@gmail.com>:

> On Tue, Feb 13, 2018 at 6:59 PM, Gustavo A. R. Silva
> <garsilva@embeddedor.com> wrote:
>> Add suffix ULL to constant 1000 in order to give the compiler complete
>> information about the proper arithmetic to use. Notice that this
>> constant is used in a context that expects an expression of type
>> u64 (64 bits, unsigned).
>>
>> The expression threshold_us * 1000 is currently being evaluated
>> using 32-bit arithmetic.
>
>> -       u64 threshold_ns = threshold_us * 1000;
>> +       u64 threshold_ns = threshold_us * 1000ULL;
>
> Shouldn't be other way around, i.e.
>
> (u64)threshold_us ?
>

Either way works. The thing is that casting threshold_us to u64 may  
imply that there is something wrong with threshold_us, which does not  
seem to be the case. So adding the suffix ULL to the constant 1000 is  
good enough to make the expression be evaluated using 64-bit  
arithmetic instead of 32-bit.

But, again, either way works.

> But still the question. have you checked all callers? Does it even  
> makes sense?
>

The proposed patch was due to fact that currently threshold_ns is of  
type u64. But based on the following piece of code (which is the only  
piece of code from where encode_l12_threshold is being called):

          * Based on PCIe r3.1, sec 5.5.3.3.1, Figures 5-16 and 5-17, and
          * Table 5-11.  T(POWER_OFF) is at most 2us and T(L1.2) is at
          * least 4us.
          */
         l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
         encode_l12_threshold(l1_2_threshold, &scale, &value);

It seems to me that it makes no sense for threshold_ns to be of type  
u64, because the expression threshold_us * 1000 will never exceed the  
32-bit limits. So if you agree I can send a patch to change its type  
to u32 instead.

Thanks
--
Gustavo
