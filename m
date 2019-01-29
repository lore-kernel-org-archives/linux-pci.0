Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768FCC169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 12:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E6820881
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 12:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbfA2MG2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:06:28 -0500
Received: from foss.arm.com ([217.140.101.70]:35530 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728877AbfA2MG2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 07:06:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 899B6EBD;
        Tue, 29 Jan 2019 04:06:27 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 077333F589;
        Tue, 29 Jan 2019 04:06:23 -0800 (PST)
Date:   Tue, 29 Jan 2019 12:06:21 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>, robh+dt@kernel.org
Cc:     bhelgaas@google.com, mark.rutland@arm.com, shawnguo@kernel.org,
        leoyang.li@nxp.com, kishon@ti.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, roy.zang@nxp.com, kstewart@linuxfoundation.org,
        cyrille.pitchen@free-electrons.com, pombredanne@nexb.com,
        shawn.lin@rock-chips.com, niklas.cassel@axis.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCHv5 1/4] dt-bindings: add DT binding for the layerscape
 PCIe controller with EP mode
Message-ID: <20190129120621.GB7467@e107981-ln.cambridge.arm.com>
References: <20190121094500.10657-1-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121094500.10657-1-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rob,

Is it OK for you if I pull this series into the pci tree ?

Please let me know, thanks.

Lorenzo

On Mon, Jan 21, 2019 at 05:44:57PM +0800, Xiaowei Bao wrote:
> Add the documentation for the Device Tree binding for the layerscape PCIe
> controller with EP mode.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> Reviewed-by: Minghuan Lian <minghuan.lian@nxp.com>
> Reviewed-by: Zhiqiang Hou <zhiqiang.hou@nxp.com>
> ---
> v2:
>  - Add the SoC specific compatibles.
> v3:
>  - modify the commit message.
> v4:
>  - no change.
> v5:
>  - no change.
> 
>  .../devicetree/bindings/pci/layerscape-pci.txt     |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> index 9b2b8d6..e20ceaa 100644
> --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> @@ -13,6 +13,7 @@ information.
>  
>  Required properties:
>  - compatible: should contain the platform identifier such as:
> +  RC mode:
>          "fsl,ls1021a-pcie"
>          "fsl,ls2080a-pcie", "fsl,ls2085a-pcie"
>          "fsl,ls2088a-pcie"
> @@ -20,6 +21,8 @@ Required properties:
>          "fsl,ls1046a-pcie"
>          "fsl,ls1043a-pcie"
>          "fsl,ls1012a-pcie"
> +  EP mode:
> +	"fsl,ls1046a-pcie-ep", "fsl,ls-pcie-ep"
>  - reg: base addresses and lengths of the PCIe controller register blocks.
>  - interrupts: A list of interrupt outputs of the controller. Must contain an
>    entry for each entry in the interrupt-names property.
> -- 
> 1.7.1
> 
