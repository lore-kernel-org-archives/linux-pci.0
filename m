Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:56917 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365AbaBNUsJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 14 Feb 2014 15:48:09 -0500
Received: by mail-ie0-f170.google.com with SMTP id lx4so3648241iec.1
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2014 12:48:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <F01C6967BCFFB14E8DF7F5D2FD1053EB1ECC22@PGSMSX103.gar.corp.intel.com>
References: <CAErSpo6v-QLkthigN3HdLizCa_7QxOS+dZ61Fse2jz5KJRdh0Q@mail.gmail.com>
 <Pine.LNX.4.44L0.1401161435350.1109-100000@iolanthe.rowland.org>
 <20140117182231.GA18421@google.com> <F01C6967BCFFB14E8DF7F5D2FD1053EB1A18C3@PGSMSX103.gar.corp.intel.com>
 <CAErSpo4fGBhb+pj6pTpKFTTj9rzLYzB2w-EX2ghWRYR3Cjyd9g@mail.gmail.com>
 <CAErSpo4rTHFOgUDjmrGxxFAuE-+i9y7hW+T7+xTzB7x4_72_pg@mail.gmail.com> <F01C6967BCFFB14E8DF7F5D2FD1053EB1ECC22@PGSMSX103.gar.corp.intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 14 Feb 2014 13:47:48 -0700
Message-ID: <CAErSpo4_ecD6Gom=WnH2MMSLsO=SEBnWHKhx3BiXz3Fgs8d2uQ@mail.gmail.com>
Subject: Re: EHCI host broken -- interrupts disabled
To: "Chen, Jamie" <jamie.chen@intel.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	USB list <linux-usb@vger.kernel.org>,
	"Tsai, Gaggery" <gaggery.tsai@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 14, 2014 at 9:36 AM, Chen, Jamie <jamie.chen@intel.com> wrote:
> Sorry for late response.
>
> The dmesg attach in the mail.

Thanks, I put this info in
https://bugzilla.kernel.org/show_bug.cgi?id=70601 and applied the
patch to pci/misc.

This seems like a potentially important fix, so I think I'll
cherry-pick it into for-linus for v3.14.

Bjorn

>> -----Original Message-----
>> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
>> Sent: Wednesday, February 12, 2014 7:24 AM
>> To: Chen, Jamie
>> Cc: Alan Stern; Sarah Sharp; USB list; Tsai, Gaggery; linux-pci@vger.kernel.org
>> Subject: Re: EHCI host broken -- interrupts disabled
>>
>> On Wed, Jan 29, 2014 at 5:04 PM, Bjorn Helgaas <bhelgaas@google.com>
>> wrote:
>> > On Mon, Jan 20, 2014 at 5:15 AM, Chen, Jamie <jamie.chen@intel.com>
>> wrote:
>> >> Try to apply this patch to kernel 3.8.0.
>> >>
>> >> Make sure the ehci can work fine and lspci show that
>> PCI_COMMAND_INTX_DISABLE is 0.
>> >>
>> >> The patch can resolved this issue.
>> >
>> > Thanks for testing it.  Can you collect the complete dmesg output or
>> > dmidecode output?  (Remove secret details from it, of course.)
>> >
>> > I'm going to put this info into a bugzilla report for future reference.
>>
>> Ping, I'm ready to apply this, just waiting for the dmesg log.
>>
>> Bjorn
