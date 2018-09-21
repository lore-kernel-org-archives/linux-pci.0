Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C770CECE560
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 19:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2D02156B
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 19:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cqnwBiE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2D02156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391243AbeIVBdd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 21:33:33 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59266 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391185AbeIVBdd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Sep 2018 21:33:33 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8LJgdET006913;
        Fri, 21 Sep 2018 14:42:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537558959;
        bh=dlw7I7haU1KGDfAkGf1FhxxpSWQlC7elvosBNOy+auk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=cqnwBiE8TdADvYEuk7gapADXHBD1EctbS2DaY49CrAgVtFQj4nitoAkJARP0dAM8r
         7wB+4hu41oaUtj0tEFTztMBZ01LNifIrzNGTq/8HRoK6REznO98gqhAJzmAoBAsg9n
         w9BN545ovOD/m8jWEvRfmMvnAe2hId86GrIVw3uo=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LJgdRY028559;
        Fri, 21 Sep 2018 14:42:39 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 21
 Sep 2018 14:42:38 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 21 Sep 2018 14:42:39 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LJgcaX030954;
        Fri, 21 Sep 2018 14:42:38 -0500
Date:   Fri, 21 Sep 2018 14:42:38 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        <Gustavo.Pimentel@synopsys.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH 36/40] arm64: dts: k3-am6: Add
 "socionext,synquacer-pre-its" property to gic_its
Message-ID: <20180921194238.mhckqlsztk2eduwp@kahuna>
References: <20180921102155.22839-1-kishon@ti.com>
 <20180921102155.22839-37-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180921102155.22839-37-kishon@ti.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10:21-20180921, Kishon Vijay Abraham I wrote:
> GIC_ITS used in AM65x platform has the same configuration as that of
> GIC_ITS used in Socionext SoCs. Add "socionext,synquacer-pre-its"
> property to get PCI MSI working.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index adcd6341e40c..2df4acb198bd 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -24,6 +24,7 @@
>  		gic_its: gic-its@18200000 {
>  			compatible = "arm,gic-v3-its";
>  			reg = <0x00 0x01820000 0x00 0x10000>;
> +			socionext,synquacer-pre-its = <0x1000000 0x400000>;
>  			msi-controller;
>  			#msi-cells = <1>;
>  		};
> -- 
> 2.17.1
> 


Please post the DTS series separately. This specific patch is a GIC ITS
patch, and does'nt need to depend on rest of the PCI series. Also looks
like you missed the v4.20-rc1 bandwagon.

 
-- 
Regards,
Nishanth Menon
