Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:44057 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751727AbeA3KaD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Jan 2018 05:30:03 -0500
Received: from mail-pg0-f72.google.com ([74.125.83.72])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1egTAw-00050S-Eq
        for linux-pci@vger.kernel.org; Tue, 30 Jan 2018 10:30:02 +0000
Received: by mail-pg0-f72.google.com with SMTP id 66so7440910pgh.2
        for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2018 02:30:02 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: Thunderbolt PCIe card doesn't get enumerated at cold boot
From: Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20180130102319.GE27654@lahna.fi.intel.com>
Date: Tue, 30 Jan 2018 18:29:56 +0800
Cc: linux-pci@vger.kernel.org, Ethan Hsieh <ethan.hsieh@canonical.com>,
        thunderbolt-software@lists.01.org
Message-Id: <C4051028-A6AD-4B78-97E2-AE1BC34694EB@canonical.com>
References: <8831781F-8027-4875-AF82-835FBE40F5F0@canonical.com>
 <20180130102319.GE27654@lahna.fi.intel.com>
To: Mika Westerberg <mika.westerberg@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> On 30 Jan 2018, at 6:23 PM, Mika Westerberg <mika.westerberg@intel.com> wrote:
> 
> On Tue, Jan 30, 2018 at 04:32:51PM +0800, Kai Heng Feng wrote:
>> Hi Mika,
>> 
>> Bother you again because you are the only TBT expert that I know of ;)
> 
> No problem. That's what I get paid for :-)
> 
>> We are enabling a new CFL desktop with TBT card.  The TBT card in
>> question doesn’t get enumerated at cold boot, so the card isn’t listed
>> under `lspci`.  Anything that does a PCI scan (# echo 1 >
>> /sys/bus/pci/rescan, S3, warmboot) can make the card gets detected
>> correctly.
>> 
>> The same TBT card doesn’t have the issue on a KBL desktop, so I not
>> sure if it’s a driver issue though.
> 
> By TBT "card" do you mean TBT host add-in-card? Is it Alpine Ridge?

Yes it is. It’s a PCIe add-in-card. It is Alpine Ridge.

Wondering if TBT requires special support from PCH or ACPI?
I am asking this because the very same card can’t get detected on a Ryzen
platform.

> 
>> Also, is there a more appropriate mailing list for TBT discussion?
> 
> I think you can use thunderbolt-software@lists.01.org as well.

Good to know ;)

Kai-Heng
