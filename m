Return-Path: <SRS0=jDI6=QI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D7EC282D8
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 22:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A3321726
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 22:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549059971;
	bh=Cpss+fy5+fIQKtkw3L9ii9ARlhoVGKDaDPobdutu4nM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=EbhF/TSJiKKhPCFIkG/SI9I1y1q02Ydeq4w3oDWxCSr+u+IcsIODMEYrWwp/x+t7v
	 gtH++mFVbxohRCNmy760PWzibLBu3khldtT/pqi5lj9kdkLzPb3sWVhW2I3foN1qfJ
	 meLiRbH4kiO44B37GcR7KOMpPRSNAksB/JzBopSQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbfBAW0K (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:26:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:52972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbfBAW0K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Feb 2019 17:26:10 -0500
Received: from [192.168.0.111] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 476082086C;
        Fri,  1 Feb 2019 22:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549059969;
        bh=Cpss+fy5+fIQKtkw3L9ii9ARlhoVGKDaDPobdutu4nM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=igdjPmCalh9HVaw6UFFjnUe+4WoqL26vrMBYQV58kwW2kW1gNbLV7ugbumDX8twMl
         Ye1AnnnTQDUbfJ6VksqA73RlDD07C58gGQlDUNuHQUMW5IeywlTQkJl3IiMFYPDiF+
         TRWy4+7CreuTsaY/NH8h4Q8x05LaSQRdVZpiSqCg=
Subject: Re: PCI extended tags regression: 3ware 9650SE-2LP RAID controller
 not working on AMD Ryzen system
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Robert Smith <robert.smith51@protonmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org
References: <20190201215249.GT229773@google.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <403fdf3f-9777-1f14-f02a-30c3897e948d@kernel.org>
Date:   Fri, 1 Feb 2019 17:26:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190201215249.GT229773@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/1/2019 4:52 PM, Bjorn Helgaas wrote:
> See https://bugzilla.kernel.org/show_bug.cgi?id=202425.
> 
> Robert bisected a problem with a 3ware 9650SE-2LP controller to
> 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported") and
> verified that reverting it solves the problem.
> 
> We have found issues in the past where Root Ports don't handle
> extended tags correctly and have added quirks to avoid use of them:
> 
>    1b30dfd376e2 ("PCI: Mark Broadcom HT1100 and HT2000 Root Port Extended Tags as broken")
>    62ce94a7a5a5 ("PCI: Mark Broadcom HT2100 Root Port Extended Tags as broken")
> 
> I don't know yet what Root Ports Robert has, but maybe we need a
> similar quirk?
> 
> I'm pretty sure Root Ports that don't handle extended tags are out of
> spec, so it would be ideal if we could get the manufacturer to provide
> an erratum as documentation.
> 

I agree. The issue needs to be directed to AMD. PCI spec says it is
safe to enable this option. I also have not heart of a single complaint
from Intel systems.


> Bjorn
> 
