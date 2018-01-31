Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:61955 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751899AbeAaJdh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 31 Jan 2018 04:33:37 -0500
Date: Wed, 31 Jan 2018 11:33:33 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: linux-pci@vger.kernel.org, Ethan Hsieh <ethan.hsieh@canonical.com>
Subject: Re: Thunderbolt PCIe card doesn't get enumerated at cold boot
Message-ID: <20180131093333.GU27654@lahna.fi.intel.com>
References: <8831781F-8027-4875-AF82-835FBE40F5F0@canonical.com>
 <20180130102319.GE27654@lahna.fi.intel.com>
 <C4051028-A6AD-4B78-97E2-AE1BC34694EB@canonical.com>
 <20180130103745.GG27654@lahna.fi.intel.com>
 <A4805FBC-E94C-4EA6-9DC3-290FE3BB43E9@canonical.com>
 <20180131075347.GR27654@lahna.fi.intel.com>
 <4D112585-48B0-4D6D-9176-A9768FD5AC7A@canonical.com>
 <20180131085150.GS27654@lahna.fi.intel.com>
 <DBAFD3AB-DB4F-4539-B69D-B4DFC449AD94@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <DBAFD3AB-DB4F-4539-B69D-B4DFC449AD94@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 31, 2018 at 05:26:21PM +0800, Kai Heng Feng wrote:
> 
> > On 31 Jan 2018, at 4:51 PM, Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> > 
> > On Wed, Jan 31, 2018 at 04:23:21PM +0800, Kai Heng Feng wrote:
> >> Now sure which string to grep, but looks like hotplug is supported.
> >> Still attach dmesg to let you confirm it’s working.
> > 
> > This one:
> > 
> > [    0.197025] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]                                                                                                                         
> > [    0.197222] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug PME AER]                                                                                                                                
> > [    0.197408] acpi PNP0A08:00: _OSC: OS now controls [PCIeCapability]            
> 
> So seems like it’s _OSC instead of _OSI?

Right, I always confuse the two.

> > So native PCIe hotplug is disabled.
> 
> Sorry for asking this again… is this the root cause of this issue?
> On another platform I can see the same message, but TBT card get enumerated at cold boot.

No, I just wanted to check which hotplug the system is using. Now it is
clear that it's using ACPI hotplug. So if possible try Windows first.
