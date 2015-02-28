Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:24341 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750885AbbB1Ink (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 28 Feb 2015 03:43:40 -0500
Message-ID: <54F17FB6.8040308@linux.intel.com>
Date: Sat, 28 Feb 2015 16:43:34 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>,
	Dave Airlie <airlied@gmail.com>
CC: LKML <linux-kernel@vger.kernel.org>,
	Rafael Wysocki <rjw@rjwysocki.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lv Zheng <lv.zheng@intel.com>
Subject: Re: regression in 4.0.0-rc1 with r8169 ethernet
References: <CAPM=9tz8HQAZbdfgE15++i++NkArjxqiY3-BjANqDBTo1g-pOw@mail.gmail.com> <CAErSpo4kG_RrpFtZ6QyRFkMO51Zx62q94L+r60-HfSZY3VHD1g@mail.gmail.com>
In-Reply-To: <CAErSpo4kG_RrpFtZ6QyRFkMO51Zx62q94L+r60-HfSZY3VHD1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/2/25 15:10, Bjorn Helgaas wrote:
> [+cc Jiang, Thomas, Lv, Rafael, linux-pci, linux-acpi]
> 
> On Tue, Feb 24, 2015 at 9:47 PM, Dave Airlie <airlied@gmail.com> wrote:
>> Hey,
>>
>> just booted an old AMD rs780 box with new kernel and my ethernet
>> failed to come up!
>>
>> Looks like the MAC addr is all ff's because the PCI bridge windows are
>> messed up.
>>
>> I've attached two dmesg one from a 3.19.0-rc6 I had on it, and one
>> failing from the 4.0.0-rc1 time.
>>
>> b24e2bdde4af656bb0679a101265ebb8f8735d3c is latest Linus commit in
>> that tree (I have some radeon patches on top).
>>
>> motherboard is a Gigabyte GA-MA78GM-S2H, lspci also attached.
> 
> Here's the dmesg diff that looks relevant to me:
> 
> -pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
> -pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
> -pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
> -pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff]
> -pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed44fff]
> -pci_bus 0000:00: root bus resource [mem 0x7ff00000-0xfebfffff]
> +pci_bus 0000:00: root bus resource [io  0x0cf8-0x0cff]
> +pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> +pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> +pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> +pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
> +pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed44fff window]
> 
> What's interesting is:
> 
> * v3.19 ignored [io  0x0cf8-0x0cff], but v4.0 includes it.  I think
> it's wrong to include it because that's the configuration space
> address/data registers, so it's consumed by the host bridge and not
> produced on the downstream side.
Hi Bjorn,
	We should ignore resources occupied by host bridge itself.
Will work out a patch to fix this issue.

> 
> * v3.19 includes [mem 0x7ff00000-0xfebfffff], but v4.0 does not.  This
> is what's screwing up the devices.
I need more information to figure out why resource [mem
0x7ff00000-0xfebfffff] is ignored by new ACPI parser.
Could you please help to forward the original dmesg attachments?
Regards!
Gerry

> 
> I think all the windows should be marked as ACPI_PRODUCER in _CRS
> since the space is "produced" on the downstream side of the bridge.
> The [io  0x0cf8-0x0cff] region should probably be marked
> ACPI_CONSUMER, and maybe that accounts for why v3.19 ignores it.  But
> I haven't found the code that does that yet.
> 
> I suspect this is all related to the ACPI resource parsing rework.  I
> looked through that briefly, but no issues jumped out at me, so this
> is just a heads-up in case it is obvious to you guys.
> 
> Dave, it'd be useful if you could collect an acpidump so we can look
> at the _CRS data in more detail.
> 
> Bjorn
> 
