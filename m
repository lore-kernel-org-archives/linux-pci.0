Return-Path: <SRS0=PFnE=OC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D23C43441
	for <linux-pci@archiver.kernel.org>; Fri, 23 Nov 2018 07:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC6320863
	for <linux-pci@archiver.kernel.org>; Fri, 23 Nov 2018 07:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCmRWJGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC6320863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393369AbeKWSTT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 23 Nov 2018 13:19:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:50982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731610AbeKWSTT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Nov 2018 13:19:19 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CC46206B2;
        Fri, 23 Nov 2018 07:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542958578;
        bh=wQ/gcvwrz1FtYFzQSBXr9BnBrnfcPDtGac0MJarBmFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uCmRWJGpyI5hL+ZFZngskXK+xbePCOUBpM6jAGS5S/6Qseq/5Df47QECsxrlGg86B
         APdBdVKYrbnAxAu0GfOZHRS/UQoR7L880rP6ulFQztIzoiq1wdnnf/RR4BMBfjDJk3
         q5di9dih1qEz2DvssTGOJoWEqWLdy3DPO6CIfdkc=
Date:   Fri, 23 Nov 2018 15:36:08 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        leoyang.li@nxp.com, mark.rutland@arm.com, bhelgaas@google.com,
        Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com
Subject: Re: [PATCH 0/4] dts/layerscape-pci: removed unsuitable compatible
 string
Message-ID: <20181123073606.GA21240@dragon>
References: <20181008031428.25293-1-Zhiqiang.Hou@nxp.com>
 <20181120125314.GA23472@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120125314.GA23472@e107981-ln.cambridge.arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 20, 2018 at 12:53:14PM +0000, Lorenzo Pieralisi wrote:
> On Mon, Oct 08, 2018 at 11:14:24AM +0800, Zhiqiang Hou wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > 
> > Removed the compatible string "snps,dw-pcie" from FSL layerscape-pci compatible
> > string list.
> > 
> > Hou Zhiqiang (4):
> >   doc/layerscape-pci: update the PCIe compatible strings
> >   doc/layerscape-pci: removed unsuitable compatible string
> >   dts/arm/ls1021a: Clean PCIe controller compatible strings
> >   dts/arm64/layerscape: Clean PCIe controller compatible strings
> > 
> >  .../devicetree/bindings/pci/layerscape-pci.txt       |  7 ++++---
> >  arch/arm/boot/dts/ls1021a.dtsi                       |  4 ++--
> >  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi       |  2 +-
> >  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi       |  6 +++---
> >  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi       |  6 +++---
> >  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi       |  6 +++---
> >  arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi       |  8 ++++----
> >  arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi       | 12 ++++--------
> >  8 files changed, 24 insertions(+), 27 deletions(-)
> 
> Hi Rob,
> 
> I assume the dts changes in this series are OK so I am going to
> pull them in the PCI tree, please let me know if you see any
> problem with that.

I will take the dts changes.

Shawn
