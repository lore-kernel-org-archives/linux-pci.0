Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EF9C43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 07:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B0F214AB
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 07:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="VgTxbchJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B0F214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbeIYNzD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:55:03 -0400
Received: from 8bytes.org ([81.169.241.247]:60606 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727588AbeIYNzD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 09:55:03 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A12816FB; Tue, 25 Sep 2018 09:48:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1537861724; bh=LVYbrjqMy2WgBfYXlTwm/fehw+I4n+2yeSu8Pa/BQXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VgTxbchJK1EpFW4ereN4XQe8LN8oW5yj2eGhSh1OL5khC4A0etr2zxSZ+Mpqr4+Qc
         kZE9/nsYq9BNqI6CsRozINDxi82rjcOb4IWMmt/AI0tqlbqgl4VUZscyNJD861fAIl
         17+OSegMqd1I96COriXHg/z6zPWmtALP3Qq1qJguHT/mmlG5L1byaDQ84fietJvgnM
         NfN5cwCeNJ1RZQZWEUTRO/mJ9k9NEn4S993rfHldUsIn0M78qDj0zRJGY430Sbi3Oe
         LWgVbjhxg0cCeEDtcGlwX0ZKINSq6/87tO5itB8saHBWsHLcCt/201HdUqyPHm+fo0
         IW4v22xOC3a0Q==
Date:   Tue, 25 Sep 2018 09:48:41 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Nipun Gupta <nipun.gupta@nxp.com>
Cc:     robin.murphy@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        robh@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, laurentiu.tudor@nxp.com,
        bhelgaas@google.com, hch@lst.de, m.szyprowski@samsung.com,
        shawnguo@kernel.org, frowand.list@gmail.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        bharat.bhushan@nxp.com, stuyoder@gmail.com, leoyang.li@nxp.com
Subject: Re: [PATCH 0/7 v7] Support for fsl-mc bus and its devices in SMMU
Message-ID: <20180925074841.oukeyvrmub45kzis@8bytes.org>
References: <1536587361-11047-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536587361-11047-1-git-send-email-nipun.gupta@nxp.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 10, 2018 at 07:19:14PM +0530, Nipun Gupta wrote:
> Nipun Gupta (7):
>   Documentation: fsl-mc: add iommu-map device-tree binding for fsl-mc
>     bus
>   iommu/of: make of_pci_map_rid() available for other devices too
>   iommu/of: support iommu configuration for fsl-mc devices
>   iommu/arm-smmu: Add support for the fsl-mc bus
>   bus: fsl-mc: support dma configure for devices on fsl-mc bus
>   bus: fsl-mc: set coherent dma mask for devices on fsl-mc bus
>   arm64: dts: ls208xa: comply with the iommu map binding for fsl_mc

Applied, thanks Nipun.
