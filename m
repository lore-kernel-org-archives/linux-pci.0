Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35346 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbcAHRy4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jan 2016 12:54:56 -0500
Received: by mail-wm0-f51.google.com with SMTP id f206so144193401wmf.0
        for <linux-pci@vger.kernel.org>; Fri, 08 Jan 2016 09:54:55 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH] drivers:pci Fix all whitespace issues
From: sasa bogicevic <brutallesale@gmail.com>
In-Reply-To: <CAErSpo7oaZ220hv5=LfCdWiytjJGYciwUz4qHYx6E_ZW8GBe+g@mail.gmail.com>
Date: Fri, 8 Jan 2016 18:54:52 +0100
Cc: linux-pci@vger.kernel.org
Message-Id: <7B5F9613-28B1-47BB-B081-ACB94DC45868@gmail.com>
References: <1451251271-43502-1-git-send-email-brutallesale@gmail.com> <20160108163638.GB31005@localhost> <8694496E-F4DE-4C68-98DE-CA9F1DD1D8BA@gmail.com> <CAErSpo7oaZ220hv5=LfCdWiytjJGYciwUz4qHYx6E_ZW8GBe+g@mail.gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks!
This is great, so basically all drivers from pcie need to be moved to pci folder, right ?

Thanks, Sasa
{
	name: Bogicevic Sasa
	phone: +381606006200
}



> On Jan 8, 2016, at 18:38, Bjorn Helgaas <bhelgaas@google.com> wrote:
> 
> I have sort of a to-do list here:
> 
> https://docs.google.com/spreadsheets/d/1VgEMqaG5FFkde4Se64nNaMpNzBfXdlgihXuGKVEzMbA/edit?usp=sharing
> 
> Most of those items are fairly significant, but I can help if you have
> questions (please post on linux-pci so others can benefit as well).
> 
> Integrating PCIe Kconfig into PCI Kconfig should be relatively
> straightforward (though far from trivial).
> 
> Welcome to Linux and PCI!
> 
> Bjorn
> 
> On Fri, Jan 8, 2016 at 10:58 AM, sasa bogicevic <brutallesale@gmail.com> wrote:
>> Thanks!
>> If you have some more tasks for me I would appreciate it. I am still new so I do only these kind of fixes for now but if there is something more complex that trivial coding style issues but not too complex for the start I would be glad to contribute some more. Just let me know and Ill get on it.
>> 
>> Thanks, Sasa
>> {
>>        name: Bogicevic Sasa
>>        phone: +381606006200
>> }
>> 
>> 
>> 
>>> On Jan 8, 2016, at 17:36, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>> 
>>> On Sun, Dec 27, 2015 at 01:21:11PM -0800, Bogicevic Sasa wrote:
>>>> This patch fixes all whitespace issues( missing or needed whitespace) in
>>>> all files in drivers/pci folder. Code is compiled with allyesconfig
>>>> before and after code changes and objects are recorded and checked with
>>>> objdiff and they are not changed after this commit.
>>>> 
>>>> Signed-off-by: Bogicevic Sasa <brutallesale@gmail.com>
>>> 
>>> Applied to pci/trivial for v4.5, thanks!
>>> 
>>> Bjorn
>> 

