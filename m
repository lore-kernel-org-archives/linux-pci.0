Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37294 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932135AbaFQSKt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jun 2014 14:10:49 -0400
Received: by mail-ig0-f175.google.com with SMTP id h3so39958igd.14
        for <linux-pci@vger.kernel.org>; Tue, 17 Jun 2014 11:10:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140617054457.GA30758@yanx>
References: <1402918182-13082-1-git-send-email-yan@linux.vnet.ibm.com>
 <CAErSpo5KepA52w0G2aa2y0-5W32FAkxoVQ+Kdo+hHsR2270Oxw@mail.gmail.com> <20140617054457.GA30758@yanx>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 17 Jun 2014 12:10:28 -0600
Message-ID: <CAErSpo5jn1LVCK5x8a2tHCodb9aLqVOdOfSDzQxUwOONn+A-Dw@mail.gmail.com>
Subject: Re: [PATCH] PCI: don't UNSET resource even reassign fails
To: Guo Chao <yan@linux.vnet.ibm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 16, 2014 at 11:44 PM, Guo Chao <yan@linux.vnet.ibm.com> wrote:
> On Mon, Jun 16, 2014 at 02:44:34PM -0600, Bjorn Helgaas wrote:
>> On Mon, Jun 16, 2014 at 5:29 AM, Guo Chao <yan@linux.vnet.ibm.com> wrote:
>> > Commit bd064f0a sets IORESOURCE_UNSET flag if resource can not be
>> > assgined. Part of these changes breaks resource assignment.
>> >
>> > If resource is too big, PCI core assgins basic part first and
>> > extends (reassigns) it to include optional part (notably SR-IOV resources).
>> > In this case, failure is permitted and IORESOURCE_UNSET should be not set.
>> > Otherwise, these resources are never updated to hardware even they are
>> > already propery assigned and we will see errors like this:
>> >
>> >         pci 0003:00:00.0: can't enable device: BAR 15 [mem size 0x0c000000 64bit pref] not assigned
>> >         pci 0003:00:00.0: Error enabling bridge (-22), continuing
>>
>> Please attach a complete dmesg log so I can look at this in more
>> detail.  Thanks!
>>
>
> It again appeared in the new machine and cards so it may not proper to
> send complete dmesg in public list. Attachment is an excerpt related to
> resource assignment.

Just remove the identifying information like vendor/device IDs and
dmidecode info.  You can use something like this to make it easy:

dmesg | sed -r 's/(pci ....:..:..\..:
\[)....:....(\].*)/\1VVVV:DDDD\2/' | sed -r 's/(DMI:).*/\1 (removed)/'

I still want to see the details about the kernel version, host bridge,
device enumeration, initial BAR values, BAR sizing, bridge topology,
etc.  It makes more work for me when people extract out the things
they think I should be interested in because I'm interested in lots of
things, and sometimes I don't even know all those things until I see
them.

Bjorn
