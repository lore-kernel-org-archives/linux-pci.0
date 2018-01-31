Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:37799 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751826AbeAaHhj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Jan 2018 02:37:39 -0500
Received: from mail-pf0-f199.google.com ([209.85.192.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1egmxe-0001AM-HI
        for linux-pci@vger.kernel.org; Wed, 31 Jan 2018 07:37:38 +0000
Received: by mail-pf0-f199.google.com with SMTP id s22so13728420pfh.21
        for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2018 23:37:38 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: Thunderbolt PCIe card doesn't get enumerated at cold boot
From: Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20180130103745.GG27654@lahna.fi.intel.com>
Date: Wed, 31 Jan 2018 15:37:32 +0800
Cc: linux-pci@vger.kernel.org, Ethan Hsieh <ethan.hsieh@canonical.com>,
        thunderbolt-software@lists.01.org
Message-Id: <A4805FBC-E94C-4EA6-9DC3-290FE3BB43E9@canonical.com>
References: <8831781F-8027-4875-AF82-835FBE40F5F0@canonical.com>
 <20180130102319.GE27654@lahna.fi.intel.com>
 <C4051028-A6AD-4B78-97E2-AE1BC34694EB@canonical.com>
 <20180130103745.GG27654@lahna.fi.intel.com>
To: Mika Westerberg <mika.westerberg@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> On 30 Jan 2018, at 6:37 PM, Mika Westerberg <mika.westerberg@intel.com> wrote:
>> 
>> Yes it is. It’s a PCIe add-in-card. It is Alpine Ridge.
>> 
>> Wondering if TBT requires special support from PCH or ACPI?
>> I am asking this because the very same card can’t get detected on a Ryzen
>> platform.
> 
> Yes, it needs to have BIOS support and in addition you need to have
> those side band signals connected properly. BIOS support is needed for
> ACPI hotplug.

Sounds like there are two different kind of supports:
- Basic TBT support.
- ACPI hotplug support in addition to basic support.

What do I need to check if the motherboard fully support them?
I guess there are special ACPI methods for them?

> Unless it is in native PCIe hotplug mode but even then you need to have
> BIOS support.

How do I check this for the TBT add-in-card?

Kai-Heng
