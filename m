Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:36125 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756301AbcAHS1M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jan 2016 13:27:12 -0500
Received: by mail-yk0-f172.google.com with SMTP id v14so277981434ykd.3
        for <linux-pci@vger.kernel.org>; Fri, 08 Jan 2016 10:27:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <7B5F9613-28B1-47BB-B081-ACB94DC45868@gmail.com>
References: <1451251271-43502-1-git-send-email-brutallesale@gmail.com>
 <20160108163638.GB31005@localhost> <8694496E-F4DE-4C68-98DE-CA9F1DD1D8BA@gmail.com>
 <CAErSpo7oaZ220hv5=LfCdWiytjJGYciwUz4qHYx6E_ZW8GBe+g@mail.gmail.com> <7B5F9613-28B1-47BB-B081-ACB94DC45868@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 8 Jan 2016 12:26:52 -0600
Message-ID: <CAErSpo59One_XZgYE+ZpyAu4Xmr7EsxkbuKbe2Xp_yfjK5PdLg@mail.gmail.com>
Subject: Re: [PATCH] drivers:pci Fix all whitespace issues
To: sasa bogicevic <brutallesale@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

No, this change would only affect Kconfig files.  For example,
arch/x86/Kconfig contains:

  source "drivers/pci/pcie/Kconfig"
  source "drivers/pci/Kconfig"
  source "drivers/pci/hotplug/Kconfig"

I would like it to contain only the "drivers/pci/Kconfig" line.  The
drivers/pci/Kconfig file should take care of including pcie/Kconfig
and pci/hotplug/Kconfig itself.

Other arches have the same issue.


On Fri, Jan 8, 2016 at 11:54 AM, sasa bogicevic <brutallesale@gmail.com> wrote:
> Thanks!
> This is great, so basically all drivers from pcie need to be moved to pci folder, right ?
>
> Thanks, Sasa
> {
>         name: Bogicevic Sasa
>         phone: +381606006200
> }
>
>
>
>> On Jan 8, 2016, at 18:38, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>
>> I have sort of a to-do list here:
>>
>> https://docs.google.com/spreadsheets/d/1VgEMqaG5FFkde4Se64nNaMpNzBfXdlgihXuGKVEzMbA/edit?usp=sharing
>>
>> Most of those items are fairly significant, but I can help if you have
>> questions (please post on linux-pci so others can benefit as well).
>>
>> Integrating PCIe Kconfig into PCI Kconfig should be relatively
>> straightforward (though far from trivial).
>>
>> Welcome to Linux and PCI!
>>
>> Bjorn
>>
>> On Fri, Jan 8, 2016 at 10:58 AM, sasa bogicevic <brutallesale@gmail.com> wrote:
>>> Thanks!
>>> If you have some more tasks for me I would appreciate it. I am still new so I do only these kind of fixes for now but if there is something more complex that trivial coding style issues but not too complex for the start I would be glad to contribute some more. Just let me know and Ill get on it.
>>>
>>> Thanks, Sasa
>>> {
>>>        name: Bogicevic Sasa
>>>        phone: +381606006200
>>> }
>>>
>>>
>>>
>>>> On Jan 8, 2016, at 17:36, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>
>>>> On Sun, Dec 27, 2015 at 01:21:11PM -0800, Bogicevic Sasa wrote:
>>>>> This patch fixes all whitespace issues( missing or needed whitespace) in
>>>>> all files in drivers/pci folder. Code is compiled with allyesconfig
>>>>> before and after code changes and objects are recorded and checked with
>>>>> objdiff and they are not changed after this commit.
>>>>>
>>>>> Signed-off-by: Bogicevic Sasa <brutallesale@gmail.com>
>>>>
>>>> Applied to pci/trivial for v4.5, thanks!
>>>>
>>>> Bjorn
>>>
>
