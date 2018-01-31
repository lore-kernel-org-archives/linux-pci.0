Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:48984 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752625AbeAaHxv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 31 Jan 2018 02:53:51 -0500
Date: Wed, 31 Jan 2018 09:53:47 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: linux-pci@vger.kernel.org, Ethan Hsieh <ethan.hsieh@canonical.com>,
        thunderbolt-software@lists.01.org
Subject: Re: Thunderbolt PCIe card doesn't get enumerated at cold boot
Message-ID: <20180131075347.GR27654@lahna.fi.intel.com>
References: <8831781F-8027-4875-AF82-835FBE40F5F0@canonical.com>
 <20180130102319.GE27654@lahna.fi.intel.com>
 <C4051028-A6AD-4B78-97E2-AE1BC34694EB@canonical.com>
 <20180130103745.GG27654@lahna.fi.intel.com>
 <A4805FBC-E94C-4EA6-9DC3-290FE3BB43E9@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <A4805FBC-E94C-4EA6-9DC3-290FE3BB43E9@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 31, 2018 at 03:37:32PM +0800, Kai Heng Feng wrote:
> 
> > On 30 Jan 2018, at 6:37 PM, Mika Westerberg <mika.westerberg@intel.com> wrote:
> >> 
> >> Yes it is. It’s a PCIe add-in-card. It is Alpine Ridge.
> >> 
> >> Wondering if TBT requires special support from PCH or ACPI?
> >> I am asking this because the very same card can’t get detected on a Ryzen
> >> platform.
> > 
> > Yes, it needs to have BIOS support and in addition you need to have
> > those side band signals connected properly. BIOS support is needed for
> > ACPI hotplug.
> 
> Sounds like there are two different kind of supports:
> - Basic TBT support.
> - ACPI hotplug support in addition to basic support.

I think those ACPI methods should be part of the basic support.

> What do I need to check if the motherboard fully support them?
> I guess there are special ACPI methods for them?

I would start by installing Windows + TBT driver and see if it works. If
it does, then we need to figure out what we do differently in Linux. If
it does not, then there is something missing from the BIOS/HW side.

> > Unless it is in native PCIe hotplug mode but even then you need to have
> > BIOS support.
> 
> How do I check this for the TBT add-in-card?

When it is in native mode, you can see from dmesg that the BIOS has
enabled native PCIe hotplug when _OSI method is called. If you can't
find it, you can send me the dmesg and I'll check it.
