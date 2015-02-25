Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPM=9tz8HQAZbdfgE15++i++NkArjxqiY3-BjANqDBTo1g-pOw@mail.gmail.com>
References: <CAPM=9tz8HQAZbdfgE15++i++NkArjxqiY3-BjANqDBTo1g-pOw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 25 Feb 2015 01:10:56 -0600
Message-ID: <CAErSpo4kG_RrpFtZ6QyRFkMO51Zx62q94L+r60-HfSZY3VHD1g@mail.gmail.com>
Subject: Re: regression in 4.0.0-rc1 with r8169 ethernet
To: Dave Airlie <airlied@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Rafael Wysocki <rjw@rjwysocki.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lv Zheng <lv.zheng@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Jiang, Thomas, Lv, Rafael, linux-pci, linux-acpi]

On Tue, Feb 24, 2015 at 9:47 PM, Dave Airlie <airlied@gmail.com> wrote:
> Hey,
>
> just booted an old AMD rs780 box with new kernel and my ethernet
> failed to come up!
>
> Looks like the MAC addr is all ff's because the PCI bridge windows are
> messed up.
>
> I've attached two dmesg one from a 3.19.0-rc6 I had on it, and one
> failing from the 4.0.0-rc1 time.
>
> b24e2bdde4af656bb0679a101265ebb8f8735d3c is latest Linus commit in
> that tree (I have some radeon patches on top).
>
> motherboard is a Gigabyte GA-MA78GM-S2H, lspci also attached.

Here's the dmesg diff that looks relevant to me:

-pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
-pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
-pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
-pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff]
-pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed44fff]
-pci_bus 0000:00: root bus resource [mem 0x7ff00000-0xfebfffff]
+pci_bus 0000:00: root bus resource [io  0x0cf8-0x0cff]
+pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
+pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
+pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
+pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
+pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed44fff window]

What's interesting is:

* v3.19 ignored [io  0x0cf8-0x0cff], but v4.0 includes it.  I think
it's wrong to include it because that's the configuration space
address/data registers, so it's consumed by the host bridge and not
produced on the downstream side.

* v3.19 includes [mem 0x7ff00000-0xfebfffff], but v4.0 does not.  This
is what's screwing up the devices.

I think all the windows should be marked as ACPI_PRODUCER in _CRS
since the space is "produced" on the downstream side of the bridge.
The [io  0x0cf8-0x0cff] region should probably be marked
ACPI_CONSUMER, and maybe that accounts for why v3.19 ignores it.  But
I haven't found the code that does that yet.

I suspect this is all related to the ACPI resource parsing rework.  I
looked through that briefly, but no issues jumped out at me, so this
is just a heads-up in case it is obvious to you guys.

Dave, it'd be useful if you could collect an acpidump so we can look
at the _CRS data in more detail.

Bjorn
