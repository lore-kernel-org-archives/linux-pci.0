Return-Path: <SRS0=cJ9t=SD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4ECC43381
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 11:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0EC20896
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 11:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XVVNWVro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfDALrN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:47:13 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12849 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfDALrN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Apr 2019 07:47:13 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca1fa440000>; Mon, 01 Apr 2019 04:47:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 01 Apr 2019 04:47:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 01 Apr 2019 04:47:12 -0700
Received: from [192.168.1.18] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 1 Apr
 2019 11:47:02 +0000
Subject: Re: [PATCH 03/10] PCI: dwc: Move config space capability search API
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>, <kishon@ti.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <lorenzo.pieralisi@arm.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <mperttunen@nvidia.com>,
        <tiwai@suse.de>, <spujar@nvidia.com>, <skomatineni@nvidia.com>,
        <liviu.dudau@arm.com>, <krzk@kernel.org>, <heiko@sntech.de>,
        <horms+renesas@verge.net.au>, <olof@lixom.net>,
        <maxime.ripard@bootlin.com>, <andy.gross@linaro.org>,
        <bjorn.andersson@linaro.org>, <jagan@amarulasolutions.com>,
        <enric.balletbo@collabora.com>, <ezequiel@collabora.com>,
        <stefan.wahren@i2se.com>, <marc.w.gonzalez@free.fr>,
        <l.stach@pengutronix.de>, <tpiepho@impinj.com>,
        <hayashi.kunihiko@socionext.com>, <yue.wang@amlogic.com>,
        <shawn.lin@rock-chips.com>, <xiaowei.bao@nxp.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>
References: <1553613207-3988-1-git-send-email-vidyas@nvidia.com>
 <1553613207-3988-4-git-send-email-vidyas@nvidia.com>
 <20190328123320.GA5518@ulmo>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <5a438b16-53bc-dee3-ea9d-14048547dc29@nvidia.com>
Date:   Mon, 1 Apr 2019 17:16:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190328123320.GA5518@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554119236; bh=v1JD+STom8fL4glHLi1HSJ+yKx1+y+JyNPeRuB8G3Ps=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=XVVNWVroU9AcROAlzSaxbS3ewExuiB2f8pllCY3H57mefaKlQNJe2u5/2wYTgR+Nc
         jiBETP5Vne8wb+BhGzx663hyjZ0LbsS1rkb76swrD0J2H0JIBzPPamoUOHiao/rzEZ
         4nJPUPUE4IJt5cCgj/PkzxYwo8r7HWMzNauC8P93Gtzt2mXLkeyGop7hbF/5lrB5C1
         XwJTWNV/pgTGl2hP5usm+tEk0udld+puft560F9fVz6GlGPYV4Y9yWcFFitHkIdJkL
         8EyGr7q+cjBSyLiwHsY9RWZRXfchHRibZSH04eVGM0SOISlsHI3L2704Gr0C7shAp3
         7YSwiWTWhfexQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/28/2019 6:03 PM, Thierry Reding wrote:
> On Tue, Mar 26, 2019 at 08:43:20PM +0530, Vidya Sagar wrote:
>> move PCIe config space capability search API to common designware file
>> as this can be used by both host and ep mode codes.
>> It also adds extended capability search APIs.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-designware-ep.c | 37 +------------
>>   drivers/pci/controller/dwc/pcie-designware.c    | 73 +++++++++++++++++++++++++
>>   drivers/pci/controller/dwc/pcie-designware.h    |  3 +
>>   3 files changed, 78 insertions(+), 35 deletions(-)
> 
> Just out of curiosity: is there any reason why this driver needs to
> reimplement this? Couldn't this be made to work using the standard
> pci_find_next_capability() function?
> 
> Other than that it might be a good idea to split this into two patches,
> one that moves the existing functionality to the common code and another
> that adds the extra functionality.
> 
> Thierry
> 
pci_find_next_capability() API expects struct pci_dev * pointer and this can only
be used after PCIe devices got enumerated. APIs added in this patch solves the issue
of getting capability offsets before PCIe enumeration. FWIW, APIs in this patch
take struct dw_pcie * pointer as input.
As you suggested, I'll split this into two patches in my next series.

