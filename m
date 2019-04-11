Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C264C10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 09:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31CD20850
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 09:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mm-sol.com header.i=@mm-sol.com header.b="icQzSd4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfDKJJm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:09:42 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:47437 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfDKJJm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Apr 2019 05:09:42 -0400
Received: from [192.168.27.209] (unknown [37.157.136.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 37330CE4B;
        Thu, 11 Apr 2019 12:09:40 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1554973780; bh=HAmbUpNVF06uxT2iVqBFwFyBAbhvD9f6pLZmzK8rpms=;
        h=Subject:To:Cc:From:Date:From;
        b=icQzSd4N0igHePEDv/EzUhQTapntDaXx7J8KqWyyL+XRlMiPnjlNFOXuHXO3U+YyB
         Zf+vNnSPGGerNOeKdJSNDo3b7XVhkF1IBYNYeivOaSZrnkzr06mcHMO8mLuZgm0PHx
         gUe7+ZxLVfHUbAgYS7zhBvMx6NVn4vpc9scQ2xH3Nnym6Ak8UeqziMVsqq7JiGYb5f
         7+mZ+yC73ZR+KYnXNKw3EJcHbIgwf6tTGv73jo/mstbKAEqcXXUUfB9Uazjdi/78r1
         EUazgECAzmFDFEGgkDgVKKH4LcKnTxrDUPQcFOr/ya0DuQVpvMVEpJvkOgxCMxu5Kg
         7phxBJH8AnPEw==
Subject: Re: [PATCH v1 3/3] arm64: dts: qcom: msm8998: Add PCIe PHY and RC
 nodes
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        MSM <linux-arm-msm@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>
References: <5eedbe6d-f440-1a77-8a7e-81a920e3a0e7@free.fr>
 <186f7ca2-84e2-a37e-79e6-f1fec8e25374@free.fr>
 <3f32cfb9-6528-9f5e-85db-cee89fdcfc5d@mm-sol.com>
 <8ee2ca1b-2a0d-0c98-f770-a47b5b529295@free.fr>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <8ada0472-0692-2f03-b52f-c1702bb0c33d@mm-sol.com>
Date:   Thu, 11 Apr 2019 12:09:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8ee2ca1b-2a0d-0c98-f770-a47b5b529295@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

On 4/11/19 11:44 AM, Marc Gonzalez wrote:
> On 10/04/2019 17:32, Stanimir Varbanov wrote:
> 
>> Few comments inline.
> 
> I'll send v3.
> 
> Changes:
> 	- Move all X-names props *after* corresponding X(s) prop
> 	- Drop comments
> 
> 
>>> +			iommu-map = <0x100 &anoc1_smmu 0x1480 1>;
>>
>> iommu-map-mask? It is optional but I had to ask :)
> 
> The only RID in the system is 0x100.
> 
> # lspci
> 00:00.0 PCI bridge: Qualcomm Device 0105
> 01:00.0 Ethernet controller: Qualcomm Atheros AR8151 v2.0 Gigabit Ethernet (rev c0)
> 
> Since we just want to map 0x100, we don't need an iommu-map-mask.

Do you see warnings during boot about missing property?

> 
> 
>>> +			/* PCIe Fundamental Reset */
>>
>> this comment is useless :) please drop it
> 
> IMO, "perst" is a poor name. Can you guess what it stands for?

The name is got from PCIE base specification. See 6.6.1.
Conventional Reset from "PCI EXPRESS BASE SPECIFICATION, REV. 3.0"

-- 
regards,
Stan
