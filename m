Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:33444 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456Ab3JGVR6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 Oct 2013 17:17:58 -0400
Received: by mail-ie0-f178.google.com with SMTP id to1so16797977ieb.23
        for <linux-pci@vger.kernel.org>; Mon, 07 Oct 2013 14:17:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo64J9bzGw3U7WC+4ykWZTsDn0=hs8mhuwmy_m8cg-XgfQ@mail.gmail.com>
References: <1380363121-1977-1-git-send-email-sachin.kamat@linaro.org>
 <CAErSpo77zy6K3yMa8_31zbrehA6MByXTBbn5Trr8Sv5TL7ScZQ@mail.gmail.com>
 <CAK9yfHxxxpZx5Yd=nUdNMe2kz_bZupZFdizG2tL3wUffDOkPCQ@mail.gmail.com> <CAErSpo64J9bzGw3U7WC+4ykWZTsDn0=hs8mhuwmy_m8cg-XgfQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 7 Oct 2013 15:17:37 -0600
Message-ID: <CAErSpo5XYnj2cYO0hMcSms9h+9014UD62D8AH_QMK1kjCAsZLQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: sysfs: Staticize local symbols
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Greg]

On Mon, Oct 7, 2013 at 11:40 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Sun, Oct 6, 2013 at 9:55 PM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>> On 4 October 2013 23:39, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> On Sat, Sep 28, 2013 at 4:12 AM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>>>>
>>>> -struct attribute *pci_bus_attrs[] = {
>>>> +static struct attribute *pci_bus_attrs[] = {
>>>
>>> Did you compile this?  I see this:
>>>
>>> drivers/pci/pci-sysfs.c:306:29: error: static declaration of
>>> ‘pci_bus_attrs’ follows non-static declaration
>>> drivers/pci/pci.h:159:29: note: previous declaration of ‘pci_bus_attrs’ was here
>>
>> Hmm.. strange. I did compile both these patches and did not see this
>> error on my setup.
>> Infact it was during compilation that I came across the need for this
>> change and verified it after. However I used
>> the linux-next tree and not your tree to generate these.
>
> Oh, I see what happened.  Greg's 244afeca ("PCI: convert bus code to
> use bus_groups") removed the use of pci_bus_attrs[] in pci-driver.c.
> That commit is in linux-next, but not in my tree.  I probably should
> have merged that commit via my tree to avoid confusion like this.  Oh,
> well, maybe I'll do better next time.

OK, I cherry-picked Greg's changes, then applied your original patch on top:

16373b2 PCI: Make pci_bus_attrs, dev_rescan_attr, dev_remove_attr,
vga_attr static
5136b2d PCI: convert bus code to use dev_groups
2229c1f PCI: convert bus code to use drv_groups
0f49ba5 PCI: convert bus code to use bus_groups

These are all in my pci/gregkh-driver-core branch, which will go in
v3.13.  Thanks!

Bjorn
