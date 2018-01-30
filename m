Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:13100 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751257AbeA3Khv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jan 2018 05:37:51 -0500
Date: Tue, 30 Jan 2018 12:37:45 +0200
From: Mika Westerberg <mika.westerberg@intel.com>
To: Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: linux-pci@vger.kernel.org, Ethan Hsieh <ethan.hsieh@canonical.com>,
        thunderbolt-software@lists.01.org
Subject: Re: Thunderbolt PCIe card doesn't get enumerated at cold boot
Message-ID: <20180130103745.GG27654@lahna.fi.intel.com>
References: <8831781F-8027-4875-AF82-835FBE40F5F0@canonical.com>
 <20180130102319.GE27654@lahna.fi.intel.com>
 <C4051028-A6AD-4B78-97E2-AE1BC34694EB@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <C4051028-A6AD-4B78-97E2-AE1BC34694EB@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 30, 2018 at 06:29:56PM +0800, Kai Heng Feng wrote:
> 
> 
> > On 30 Jan 2018, at 6:23 PM, Mika Westerberg <mika.westerberg@intel.com> wrote:
> > 
> > On Tue, Jan 30, 2018 at 04:32:51PM +0800, Kai Heng Feng wrote:
> >> Hi Mika,
> >> 
> >> Bother you again because you are the only TBT expert that I know of ;)
> > 
> > No problem. That's what I get paid for :-)
> > 
> >> We are enabling a new CFL desktop with TBT card.  The TBT card in
> >> question doesn’t get enumerated at cold boot, so the card isn’t listed
> >> under `lspci`.  Anything that does a PCI scan (# echo 1 >
> >> /sys/bus/pci/rescan, S3, warmboot) can make the card gets detected
> >> correctly.
> >> 
> >> The same TBT card doesn’t have the issue on a KBL desktop, so I not
> >> sure if it’s a driver issue though.
> > 
> > By TBT "card" do you mean TBT host add-in-card? Is it Alpine Ridge?
> 
> Yes it is. It’s a PCIe add-in-card. It is Alpine Ridge.
> 
> Wondering if TBT requires special support from PCH or ACPI?
> I am asking this because the very same card can’t get detected on a Ryzen
> platform.

Yes, it needs to have BIOS support and in addition you need to have
those side band signals connected properly. BIOS support is needed for
ACPI hotplug.

Unless it is in native PCIe hotplug mode but even then you need to have
BIOS support.

> > 
> >> Also, is there a more appropriate mailing list for TBT discussion?
> > 
> > I think you can use thunderbolt-software@lists.01.org as well.
> 
> Good to know ;)
> 
> Kai-Heng
