Return-Path: <SRS0=q0B1=N6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92088C43441
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 19:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2F620870
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 19:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2qpYOSr5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2F620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbeKTF5N (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:57:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:50704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729995AbeKTF5N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 00:57:13 -0500
Received: from [10.80.45.159] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B89C02075B;
        Mon, 19 Nov 2018 19:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542655929;
        bh=NnVnKv61t5wHI5WrKHh5zGKc/h2tnNHwmFNgkgpVOFU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=2qpYOSr5Idunb91/Dusf5Xnwj/g6s52Tx7n61f6V8MITf6YnRm4X5rORWWcMWa7Na
         OYxRrHzwott4JKXD5GwuNT+lkQqE88SjXQyiUj7eEepQEjsGHCcUj8Smhi9efdQu3f
         pkNP7VTQz3VP6Dd12m0Qa938IJjFFhr0J3HzYxnQ=
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
To:     "Alex G." <mr.nuke.me@gmail.com>,
        Keith Busch <keith.busch@intel.com>
Cc:     Tyler Baicar <baicar.tyler@gmail.com>, austin_bolen@dell.com,
        alex_gagniuc@dellteam.com, Shyam_Iyer@dell.com, lukas@wunner.de,
        bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org,
        ruscur@russell.cc, sbobroff@linux.ibm.com, oohall@gmail.com,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
 <b9a739c8-80bd-e04c-ac19-97bc54f20eff@kernel.org>
 <CABo9ajD5GJY7MrMjQc3hE=4tpPKpeceMtVEHwCwgjrvJUYjLvg@mail.gmail.com>
 <20181119165318.GB26595@localhost.localdomain>
 <74f2c527-0890-5e14-5e2d-48934a42dae6@kernel.org>
 <ab2427f1-c1f0-68fe-5335-1494caafdcbb@kernel.org>
 <20181119174127.GE26595@localhost.localdomain>
 <ef0a24e4-906e-f6df-c646-1fe47ea0dcc0@kernel.org>
 <20181119181051.GA26707@localhost.localdomain>
 <c0d6535f-324b-557a-3d0e-ccec070459a7@kernel.org>
 <3f923367-2cc1-c0d6-bca6-bf9a03d1b9ca@gmail.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <ef6b19de-dd18-850f-4db9-8ab71b975e94@kernel.org>
Date:   Mon, 19 Nov 2018 14:32:06 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <3f923367-2cc1-c0d6-bca6-bf9a03d1b9ca@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>> UEFI HEST table specification also claims that it should be the ultimate
>> table for when PCI firmware-first should be disabled/enabled.
> 
> IIRC, EFI absorbed ACPI before FFS was a thing. Could you point me to the UEFI 
> chapter that says HEST is authoritative?
> (not being a smartie, just that my free software PDF readers can't search within 
> a file that large)
> 

ACPI 6.2:

18.3.2.4 PCI Express Root Port AER Structure

Flags:

Bit [0] - FIRMWARE_FIRST: If set, this bit indicates to the OSPM that system 
firmware will handle errors from this source first.
Bit [1] - GLOBAL: If set, indicates that the settings contained in this 
structure apply globally to all PCI Express Devices.
All other bits must be set to zero.

It doesn't say shall, may or might. It says will.

> 
>> I think somebody needs to fix these. I saw an email from Harb Abdulhamid
>> sent to aswg this morning.
>>
>> That's why I suggested circulating this idea in UEFI forums first.
>> Let's see what everybody thinks. We can go from there.
> 
> However you look at it, we have a glaring inconsistency in how we handle AER 
> control in linux. I'm surprised we didn't see huge issues because of mixing 
> HEST/_OSC.
> 
> What systems rely on the HEST definition as opposed to _OSC? It doesn't make 
> sense to me that you could have a system with mixed FFS and native AER on the 
> same root port. The granularity of HEST shouldn't matter here because of how AER 
> works.

I think It depends on your PCI topology.

For other topologies with multiple PCI root complexes, I can see this being
used per root complex flag to indicate which root complex needs firmware first
and which one doesn't.

> 
> I'd like see how exactly we break one of those elusive systems with _OSC. I 
> suspect _OSC and HEST end up having the same information, and that's why we 
> didn't see any real-life issue with mixing the approaches.

I'm already aware of two systems that rely on HEST table to pass information to
the OS that firmware first is enabled. Both of the systems do not change their
_OSC bits during this assuming HEST table has priority over _OSC for firmware
first.

If we add this patch, OS will try to claim the AER address space while firmware
wants exclusive access.

As I said in my previous email, the right place to talk about this is UEFI
forum.

> 
> Alex
> 
> 
> P.S.
> (SARCASM ALERT) Isn't UEFI is a pile of stuff that didn't stick to the wall?
> 
> P.P.S
> I remember someone asking why we don't disable FFS in the BIOS. I think it would 
> be next to impossible to get certain platform vendors to relinquish FFS control, 
> unless the specs required things to be that way -- and had a "standard" way to 
> do so.
> 
> Then getting the specs to change in that direction is also a battle.
> 

