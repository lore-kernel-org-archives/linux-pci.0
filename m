Return-Path: <SRS0=zpRJ=PD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1310DC43387
	for <linux-pci@archiver.kernel.org>; Wed, 26 Dec 2018 14:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8124214C6
	for <linux-pci@archiver.kernel.org>; Wed, 26 Dec 2018 14:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="hhWqCMTB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbeLZOyL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Dec 2018 09:54:11 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:48476 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbeLZOyK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Dec 2018 09:54:10 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id E175110C1BEF;
        Wed, 26 Dec 2018 06:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1545836050; bh=XZ0M6aTbiLnN7vLP04AKdrFw1dNv86ioIh/1pCAt8W8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=hhWqCMTBI1CH9WrWTEzxW59J47p1gL/oR6rzlErGrOVqPCtDy14V3J1TRcWooKKw9
         Ey5t2OqBxFK5crLaUJOUXrFXIuPXMLvh9QVAdGp039H6Ym1BDnHcnWOArE7h1qhpak
         GFVkq+HNIuzr/ihTa25/X+NaR31YzREBYILevnpGRbBC03piN2jtNdMN7hxSHWEEJh
         1thJYcnySGaxl1spJZnIM6Qu2A39H6xZ2TRfeR+p1svRbJkY6VgnGQGhMLUZy71Zd6
         SMMJThMnkg6U8AblSQknojTfp44dA5wGE/H/ayJChC20FTo2tjGCXUVqbS9z5mfzTT
         M1lthW2B6Kz7w==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id 7E6A32370;
        Wed, 26 Dec 2018 06:54:08 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 26 Dec 2018 06:54:08 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 26 Dec 2018 15:54:06 +0100
Received: from [10.225.2.45] (10.225.2.45) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 26 Dec
 2018 15:54:05 +0100
Subject: Re: [PATCH 21/21] PCI: designware: Remove superfluous shifting in
 definitions
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
 <20181221072716.29017-22-andrew.smirnov@gmail.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <341608b2-fd7c-54b0-b5c5-7d8e6b9e55e5@synopsys.com>
Date:   Wed, 26 Dec 2018 14:49:35 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181221072716.29017-22-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.225.2.45]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 21/12/2018 07:27, Andrey Smirnov wrote:
> Surrounding definitions no longer use explicit shift, so "<< 0" here
> serve no purpose. Remove them. No functional change intended.
> 
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 0de653284fca..636689fd4ee7 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -63,14 +63,14 @@
>  #define PCIE_ATU_VIEWPORT		0x900
>  #define PCIE_ATU_REGION_INBOUND		BIT(31)
>  #define PCIE_ATU_REGION_OUTBOUND	0
> -#define PCIE_ATU_REGION_INDEX2		(0x2 << 0)
> -#define PCIE_ATU_REGION_INDEX1		(0x1 << 0)
> -#define PCIE_ATU_REGION_INDEX0		(0x0 << 0)
> +#define PCIE_ATU_REGION_INDEX2		0x2
> +#define PCIE_ATU_REGION_INDEX1		0x1
> +#define PCIE_ATU_REGION_INDEX0		0x0
>  #define PCIE_ATU_CR1			0x904
> -#define PCIE_ATU_TYPE_MEM		(0x0 << 0)
> -#define PCIE_ATU_TYPE_IO		(0x2 << 0)
> -#define PCIE_ATU_TYPE_CFG0		(0x4 << 0)
> -#define PCIE_ATU_TYPE_CFG1		(0x5 << 0)
> +#define PCIE_ATU_TYPE_MEM		0x0
> +#define PCIE_ATU_TYPE_IO		0x2
> +#define PCIE_ATU_TYPE_CFG0		0x4
> +#define PCIE_ATU_TYPE_CFG1		0x5
>  #define PCIE_ATU_CR2			0x908
>  #define PCIE_ATU_ENABLE			BIT(31)
>  #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
> 

Agree.

Acked-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Thanks.
