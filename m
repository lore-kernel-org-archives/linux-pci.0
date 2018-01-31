Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:52348 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752616AbeAaIvx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 31 Jan 2018 03:51:53 -0500
Date: Wed, 31 Jan 2018 10:51:50 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: linux-pci@vger.kernel.org, Ethan Hsieh <ethan.hsieh@canonical.com>,
        thunderbolt-software@lists.01.org
Subject: Re: Thunderbolt PCIe card doesn't get enumerated at cold boot
Message-ID: <20180131085150.GS27654@lahna.fi.intel.com>
References: <8831781F-8027-4875-AF82-835FBE40F5F0@canonical.com>
 <20180130102319.GE27654@lahna.fi.intel.com>
 <C4051028-A6AD-4B78-97E2-AE1BC34694EB@canonical.com>
 <20180130103745.GG27654@lahna.fi.intel.com>
 <A4805FBC-E94C-4EA6-9DC3-290FE3BB43E9@canonical.com>
 <20180131075347.GR27654@lahna.fi.intel.com>
 <4D112585-48B0-4D6D-9176-A9768FD5AC7A@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4D112585-48B0-4D6D-9176-A9768FD5AC7A@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 31, 2018 at 04:23:21PM +0800, Kai Heng Feng wrote:
> Now sure which string to grep, but looks like hotplug is supported.
> Still attach dmesg to let you confirm it’s working.

This one:

[    0.197025] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]                                                                                                                         
[    0.197222] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug PME AER]                                                                                                                                
[    0.197408] acpi PNP0A08:00: _OSC: OS now controls [PCIeCapability]               

So native PCIe hotplug is disabled.
