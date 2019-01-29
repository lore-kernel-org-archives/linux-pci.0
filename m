Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBC3C282D0
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 04:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993DC2177E
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 04:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nlrVvorl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfA2EN3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 28 Jan 2019 23:13:29 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:44228 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfA2EN3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2019 23:13:29 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0T4DOdW065624;
        Mon, 28 Jan 2019 22:13:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548735204;
        bh=dmtZU1rFwi/FvidBhbG/Fz5Cu/yfcsnwVUDQU6KrauE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nlrVvorl5RFgewo+p7bcwIAbyCcbA16AUPKpBtuz++HGUqEwHAvkBWYNuy1Nk3N98
         HyOABFBLOxpBEjXdIjuMrXvhQLbIm2lC+9VcNRyX9KqQemXKgPu8KCMQaWud3rR96H
         eftjns7juyqlM14+AaS4jSmxs8fwSCneWHyRXYsI=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0T4DOPI116082
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Jan 2019 22:13:24 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 28
 Jan 2019 22:13:24 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 28 Jan 2019 22:13:24 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0T4DLfw024989;
        Mon, 28 Jan 2019 22:13:22 -0600
Subject: Re: [PATCH] PCI: dwc: Fix stop condition on
 __dw_pcie_ep_find_next_cap()
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <linux-pci@vger.kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <stable@vger.kernel.org>
References: <9780b57125c83d6742bae3405d95e6b52686c450.1548699779.git.gustavo.pimentel@synopsys.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <6839a0f3-6fec-15bf-4179-9d355a5c5155@ti.com>
Date:   Tue, 29 Jan 2019 09:42:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <9780b57125c83d6742bae3405d95e6b52686c450.1548699779.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Gustavo,

On 28/01/19 11:52 PM, Gustavo Pimentel wrote:
> The combination of __dw_pcie_ep_find_next_cap() and
> dw_pcie_ep_find_capability() allows to search on the Endpoint
> configuration space for a specific capability ID.
> 
> This search is done recursively by __dw_pcie_ep_find_next_cap() jumping
> from capability to capability (using the next offset register to calculate
> next jump address), stopping until the next offset register is null or
> the current capability meets the desired ID.
> 
> However, if the desired capability is at the end of that list, the
> recursive search will be returning because the next offset will
> be null (thus filling the first stop condition) and not because it
> has reached the desired ID and therefore reporting capability "not
> found".
> 
> This fix will swap the stop conditions order of
> __dw_pcie_ep_find_next_cap(), allowing to find the desired capability ID,
> if it encounters at the end of the list.
> 
> Fixes: beb4641a787d ("PCI: dwc: Add MSI-X callbacks handler")
> Reported-by: Jian Wang <jianwang@ra.rockwell.com>
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: stable@vger.kernel.org

I had already posted a patch fixing it as part of my AM654 PCIe support series [1].

Thanks
Kishon
[1] -> https://lore.kernel.org/lkml/20190114132424.6445-19-kishon@ti.com/T/#u
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index a543c45..0258894 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -50,12 +50,12 @@ static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
>  	next_cap_ptr = (reg & 0xff00) >> 8;
>  	cap_id = (reg & 0x00ff);
>  
> -	if (!next_cap_ptr || cap_id > PCI_CAP_ID_MAX)
> -		return 0;
> -
>  	if (cap_id == cap)
>  		return cap_ptr;
>  
> +	if (!next_cap_ptr || cap_id > PCI_CAP_ID_MAX)
> +		return 0;
> +
>  	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);
>  }
>  
> 
