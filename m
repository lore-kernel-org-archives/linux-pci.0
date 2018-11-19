Return-Path: <SRS0=q0B1=N6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487DDC43441
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 17:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8DF2147A
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 17:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBgyraNy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8DF2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389715AbeKTEGz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:06:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:33892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389109AbeKTEGy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Nov 2018 23:06:54 -0500
Received: from [10.80.45.159] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F9DA2145D;
        Mon, 19 Nov 2018 17:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542649346;
        bh=pTK755v01/dT2muoZN3qHYXL1n/03ylIcKFKrHyrMh4=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=sBgyraNydUrFJhNaTBjDtbyMXXaBoBb/9Z4A4gTEVrzU5HTLMxDSkINKRzzN+oAWs
         9eVMdxR3H5iu8tKjCrbWn/acIwDbqzWNffAjqbW4pQ03UNRdAXhcSLrVCHfSiaozPC
         gnPm4KylS8opnYuOJeSCDiBSOE1AkvRCVlgsmQTY=
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
From:   Sinan Kaya <okaya@kernel.org>
To:     Keith Busch <keith.busch@intel.com>,
        Tyler Baicar <baicar.tyler@gmail.com>
Cc:     mr.nuke.me@gmail.com, helgaas@google.com, austin_bolen@dell.com,
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
Message-ID: <ab2427f1-c1f0-68fe-5335-1494caafdcbb@kernel.org>
Date:   Mon, 19 Nov 2018 12:42:25 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <74f2c527-0890-5e14-5e2d-48934a42dae6@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/19/2018 12:32 PM, Sinan Kaya wrote:
>>
>> But we're not using HEST as a fine grain control. We disable native AER
>> handling if *any* device has FF set in HEST, and that just forces people
>> to use pcie_ports=native to get around that.
>>
> 
> I don't see *any* in the code.  aer_hest_parse() does the HEST table parsing.
> It switches to firmware first mode if global flag in HEST is set. Otherwise
> for each BDF in device, hest_match_pci() is used to do a cross-matching against
> HEST table contents.
> 
> Am I missing something?

I see. I think you are talking about aer_firmware_first, right?

aer_set_firmware_first() and  pcie_aer_get_firmware_first() seem to do the right
thing.

aer_firmware_first is probably getting set because events are all routed to a
single root port and aer_acpi_firmware_first() is used to decide whether AER
should be initialized or not.

I think I understand what is going on now.

Still, breaking existing systems that rely on HEST table is not cool.
I'd rather have users specify "pcie_ports=native" to skip FF rather than
having broken systems by default to be honest.
