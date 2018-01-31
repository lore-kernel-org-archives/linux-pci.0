Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:39460 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752791AbeAaJ02 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Jan 2018 04:26:28 -0500
Received: from mail-pf0-f199.google.com ([209.85.192.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1egoex-0007jf-5b
        for linux-pci@vger.kernel.org; Wed, 31 Jan 2018 09:26:27 +0000
Received: by mail-pf0-f199.google.com with SMTP id b75so14019428pfk.22
        for <linux-pci@vger.kernel.org>; Wed, 31 Jan 2018 01:26:27 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: Thunderbolt PCIe card doesn't get enumerated at cold boot
From: Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20180131085150.GS27654@lahna.fi.intel.com>
Date: Wed, 31 Jan 2018 17:26:21 +0800
Cc: linux-pci@vger.kernel.org, Ethan Hsieh <ethan.hsieh@canonical.com>
Message-Id: <DBAFD3AB-DB4F-4539-B69D-B4DFC449AD94@canonical.com>
References: <8831781F-8027-4875-AF82-835FBE40F5F0@canonical.com>
 <20180130102319.GE27654@lahna.fi.intel.com>
 <C4051028-A6AD-4B78-97E2-AE1BC34694EB@canonical.com>
 <20180130103745.GG27654@lahna.fi.intel.com>
 <A4805FBC-E94C-4EA6-9DC3-290FE3BB43E9@canonical.com>
 <20180131075347.GR27654@lahna.fi.intel.com>
 <4D112585-48B0-4D6D-9176-A9768FD5AC7A@canonical.com>
 <20180131085150.GS27654@lahna.fi.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> On 31 Jan 2018, at 4:51 PM, Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> 
> On Wed, Jan 31, 2018 at 04:23:21PM +0800, Kai Heng Feng wrote:
>> Now sure which string to grep, but looks like hotplug is supported.
>> Still attach dmesg to let you confirm it’s working.
> 
> This one:
> 
> [    0.197025] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]                                                                                                                         
> [    0.197222] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug PME AER]                                                                                                                                
> [    0.197408] acpi PNP0A08:00: _OSC: OS now controls [PCIeCapability]            

So seems like it’s _OSC instead of _OSI?
 
> So native PCIe hotplug is disabled.

Sorry for asking this again… is this the root cause of this issue?
On another platform I can see the same message, but TBT card get enumerated at cold boot.

Also removing the thunderbolt mailing list - it keeps bouncing a message says I need to subscribe to it.

Kai-Heng
