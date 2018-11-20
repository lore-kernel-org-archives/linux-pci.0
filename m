Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E853C04EBC
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 12:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424FC208E4
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 12:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424FC208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeKTXWZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:22:25 -0500
Received: from foss.arm.com ([217.140.101.70]:48434 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727258AbeKTXWZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 18:22:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA95380D;
        Tue, 20 Nov 2018 04:53:25 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D78833F5B7;
        Tue, 20 Nov 2018 04:53:23 -0800 (PST)
Date:   Tue, 20 Nov 2018 12:53:14 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        leoyang.li@nxp.com, shawnguo@kernel.org, mark.rutland@arm.com,
        bhelgaas@google.com, Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com
Subject: Re: [PATCH 0/4] dts/layerscape-pci: removed unsuitable compatible
 string
Message-ID: <20181120125314.GA23472@e107981-ln.cambridge.arm.com>
References: <20181008031428.25293-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008031428.25293-1-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 08, 2018 at 11:14:24AM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Removed the compatible string "snps,dw-pcie" from FSL layerscape-pci compatible
> string list.
> 
> Hou Zhiqiang (4):
>   doc/layerscape-pci: update the PCIe compatible strings
>   doc/layerscape-pci: removed unsuitable compatible string
>   dts/arm/ls1021a: Clean PCIe controller compatible strings
>   dts/arm64/layerscape: Clean PCIe controller compatible strings
> 
>  .../devicetree/bindings/pci/layerscape-pci.txt       |  7 ++++---
>  arch/arm/boot/dts/ls1021a.dtsi                       |  4 ++--
>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi       |  2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi       |  6 +++---
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi       |  6 +++---
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi       |  6 +++---
>  arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi       |  8 ++++----
>  arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi       | 12 ++++--------
>  8 files changed, 24 insertions(+), 27 deletions(-)

Hi Rob,

I assume the dts changes in this series are OK so I am going to
pull them in the PCI tree, please let me know if you see any
problem with that.

Thanks,
Lorenzo
