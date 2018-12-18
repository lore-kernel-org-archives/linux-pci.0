Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37A1C43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 13:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC4E218A4
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 13:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbeLRNxA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:53:00 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46150 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbeLRNw7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Dec 2018 08:52:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7489980D;
        Tue, 18 Dec 2018 05:52:59 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A9FD3F575;
        Tue, 18 Dec 2018 05:52:57 -0800 (PST)
Date:   Tue, 18 Dec 2018 13:52:51 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     honghui.zhang@mediatek.com
Cc:     bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryder.lee@mediatek.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org, youlin.pei@mediatek.com,
        jianjun.wang@mediatek.com
Subject: Re: [PATCH 0/4] Cleanup un-used variant and un-used property for
 MediaTek PCIe
Message-ID: <20181218135251.GA3560@e107981-ln.cambridge.arm.com>
References: <1544750742-31419-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544750742-31419-1-git-send-email-honghui.zhang@mediatek.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 14, 2018 at 09:25:38AM +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> The "num-lanes" property in MediaTek's PCIe device node is not used by
> its driver or anyone else, cleanup those related code.
> 
> Honghui Zhang (4):
>   PCI: mediatek: Remove un-used variant in struct mtk_pcie_port
>   dt-bindings: PCI: MediaTek: Remove un-used property
>   arm: dts: mt7623: Remove un-used property for PCIe
>   arm64: dts: mt7622: Remove un-used property for PCIe
> 
>  Documentation/devicetree/bindings/pci/mediatek-pcie.txt | 8 --------
>  arch/arm/boot/dts/mt7623.dtsi                           | 3 ---
>  arch/arm64/boot/dts/mediatek/mt7622.dtsi                | 2 --
>  drivers/pci/controller/pcie-mediatek.c                  | 8 --------
>  4 files changed, 21 deletions(-)

Applied to pci/mediatek for v4.21, thanks.

Lorenzo
