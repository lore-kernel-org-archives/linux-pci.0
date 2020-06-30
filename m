Return-Path: <SRS0=b4XB=AL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAACC433DF
	for <linux-pci@archiver.kernel.org>; Tue, 30 Jun 2020 10:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CDC8207F9
	for <linux-pci@archiver.kernel.org>; Tue, 30 Jun 2020 10:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FQFTlaYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732557AbgF3KwO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 30 Jun 2020 06:52:14 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2555 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbgF3KwO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Jun 2020 06:52:14 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efb18fb0000>; Tue, 30 Jun 2020 03:50:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 30 Jun 2020 03:52:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 30 Jun 2020 03:52:13 -0700
Received: from [10.25.72.87] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 10:52:06 +0000
Subject: Re: [PATCH V3 1/2] arm64: tegra: Re-order PCIe aperture mappings to
 support ACPI boot
To:     Jon Hunter <jonathanh@nvidia.com>, <bhelgaas@google.com>,
        <lorenzo.pieralisi@arm.com>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <andrew.murray@arm.com>, <treding@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20200106082709.14370-1-vidyas@nvidia.com>
 <20200110191500.9538-1-vidyas@nvidia.com>
 <20200110191500.9538-2-vidyas@nvidia.com>
 <d52db35b-dbf8-a706-9611-95448cf6a69e@nvidia.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <7c946e2a-6fd4-f4c8-8afe-f9d0125fdaa0@nvidia.com>
Date:   Tue, 30 Jun 2020 16:22:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <d52db35b-dbf8-a706-9611-95448cf6a69e@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593514235; bh=woO8ZH9Y+1NElM5TcwDg3TM1c41wMq5lOJNOoty2UYA=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=FQFTlaYRfwmaNdU+kPVebmW6vJX/LwHRxdHi//1NHs6JLKIgYR0P5NRG9C4y2VyYR
         +cy+d800P/KZ+JwvEuh2rHPZCbrPi3PXHVIiZfKlIsLdLpQIubRjl/Nh1oN3RLZQhL
         zCLeEJLfj/hhNbZi1UTXdpS2Bk+7k8nLXi5RqyfdvZqfvw052ELfBeU9GsQjO4hTUK
         dhBGCa2evDTKsMlaUHC0gHZrTC4BNCoYVg1PxQGFqYosd0Y2ZKbjgRoaSbCye5gfDS
         V4PkMFxxzhAE0+zOkkvMHIUzbgDrMsRIkM4dxCxNOTM5eheUVphvm5Xiga0wbGseC8
         nsEwpvOvh1vkg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 29-Jun-20 7:01 PM, Jon Hunter wrote:
> Hi Sagar,
> 
> On 10/01/2020 19:14, Vidya Sagar wrote:
>> Re-order Tegra194's PCIe aperture mappings to have IO window moved to
>> 64-bit aperture and have the entire 32-bit aperture used for accessing
>> the configuration space. This makes it to use the entire 32MB of the 32-bit
>> aperture for ECAM purpose while booting through ACPI.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> 
> Any reason why we should not merge this change, even if patch 2/2 is not
> accepted? If there is no harm in us merging this, this would be one less
> change for us to carry out-of-tree. If so, can you update and re-post
> for 5.9?
There is no issue in merging this change alone. I'll send a patch for 
review for 5.9 soon.

Thanks,
Vidya Sagar

> 
> Cheers
> Jon
> 
