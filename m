Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37879 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754298Ab2F0UdU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jun 2012 16:33:20 -0400
Received: by dady13 with SMTP id y13so1885908dad.19
        for <linux-pci@vger.kernel.org>; Wed, 27 Jun 2012 13:33:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo4T5rBwoE7X2h1-CG9GoEPzXO+_1R7YVyv8wiL2qZW+XA@mail.gmail.com>
References: <bug-15362-41252@https.bugzilla.kernel.org/>
	<20120627140641.2187711F8B0@bugzilla.kernel.org>
	<CAErSpo4T5rBwoE7X2h1-CG9GoEPzXO+_1R7YVyv8wiL2qZW+XA@mail.gmail.com>
Date: Wed, 27 Jun 2012 13:33:19 -0700
Message-ID: <CAE9FiQVzYCwAAEnhZSVotiB3R+XYGcT=SJ8ySBndvo0OpRXP7w@mail.gmail.com>
Subject: Re: [Bug 15362] MPT Fusion SCSI drives no longer appear - suspect PCI
 bus scan bug
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: bugzilla-daemon@bugzilla.kernel.org, linux-pci@vger.kernel.org,
	Jiang Liu <liuj97@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 27, 2012 at 7:32 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> I do still plan to work on bisecting this.
>
> Can you also attach a dmesg log from a current kernel, e.g., 3.4 or
> newer?  We now print a lot more information during PCI enumeration.
>
> But I guess the problem is that 2.6.26 finds devices in domains 1 and
> 2, while 2.6.32 does not.  I think MMCONFIG is the only config access
> method we have for domains other than 0.  That suggests that MMCONFIG
> used to work but doesn't any more.  The dmesg logs claim that we're
> not using MMCONFIG in either 2.6.26 or 2.6.32 though, so I don't know
> why we found anything in 2.6.26.

in short: the bios is broken, it return wrong segment in DSDT.

in both case, only pci_conf1 is used.  CPU is not new enough.

after comparing the code 2.6.26 and 2.6.32.  2.6.26 is not checking
seg in pci_conf1_read. but 2.6.32 check that...

2.6.26:
static int pci_conf1_read(unsigned int seg, unsigned int bus,
                          unsigned int devfn, int reg, int len, u32 *value)
{
        unsigned long flags;

        if ((bus > 255) || (devfn > 255) || (reg > 255)) {
                *value = -1;
                return -EINVAL;
        }

2.6.32
20 static int pci_conf1_read(unsigned int seg, unsigned int bus,
21                           unsigned int devfn, int reg, int len, u32 *value)
22 {
23         unsigned long flags;
24
25         if (seg || (bus > 255) || (devfn > 255) || (reg > 4095)) {
26                 *value = -1;
27                 return -EINVAL;
28         }

so it happens to work on 2.6.26.

please get to get new BIOS from your vendor.
or you need to override your DSDT.

Thanks

Yinghai
