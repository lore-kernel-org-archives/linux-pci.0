Return-Path: <SRS0=lMXa=OB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93210C43441
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 11:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD6A20870
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 11:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD6A20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388147AbeKVWHO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:07:14 -0500
Received: from foss.arm.com ([217.140.101.70]:46114 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732238AbeKVWHO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Nov 2018 17:07:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 985991DC8;
        Thu, 22 Nov 2018 03:28:16 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 844A13F71A;
        Thu, 22 Nov 2018 03:28:14 -0800 (PST)
Date:   Thu, 22 Nov 2018 11:28:09 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, leoyang.li@nxp.com, shawnguo@kernel.org,
        mark.rutland@arm.com, bhelgaas@google.com, Mingkai.Hu@nxp.com,
        Minghuan.Lian@nxp.com
Subject: Re: [PATCH 2/4] doc/layerscape-pci: removed unsuitable compatible
 string
Message-ID: <20181122112809.GA11952@e107981-ln.cambridge.arm.com>
References: <20181008031428.25293-1-Zhiqiang.Hou@nxp.com>
 <20181008031428.25293-3-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008031428.25293-3-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 08, 2018 at 11:14:26AM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Removed the compatible string "snps,dw-pcie", it is for the reference
> platform driver for PCI RC IP Protoyping Kits based on the ARC SDP,
> so it is not suitable for all platform with designware PCIe controller,
> and platform vendors have themselves' drivers.
> 
> The compatible string "snsp,dw-pcie" was added by mistake and it's not
> matched that time, but it is matched because pcie drivers has been
> collected recently.

I do not understand what you mean, please explain it to me and I will
update the commit log accordingly before merging it.

Lorenzo

> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/layerscape-pci.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> index 5eb1c202932f..9b2b8d66d1f4 100644
> --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> @@ -13,8 +13,8 @@ information.
>  
>  Required properties:
>  - compatible: should contain the platform identifier such as:
> -        "fsl,ls1021a-pcie", "snps,dw-pcie"
> -        "fsl,ls2080a-pcie", "fsl,ls2085a-pcie", "snps,dw-pcie"
> +        "fsl,ls1021a-pcie"
> +        "fsl,ls2080a-pcie", "fsl,ls2085a-pcie"
>          "fsl,ls2088a-pcie"
>          "fsl,ls1088a-pcie"
>          "fsl,ls1046a-pcie"
> @@ -36,7 +36,7 @@ Required properties:
>  Example:
>  
>  	pcie@3400000 {
> -		compatible = "fsl,ls1021a-pcie", "snps,dw-pcie";
> +		compatible = "fsl,ls1021a-pcie";
>  		reg = <0x00 0x03400000 0x0 0x00010000   /* controller registers */
>  		       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
>  		reg-names = "regs", "config";
> -- 
> 2.17.1
> 
