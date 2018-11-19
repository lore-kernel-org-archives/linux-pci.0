Return-Path: <SRS0=q0B1=N6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F56C43441
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 12:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0692086A
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 12:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpBtAVIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E0692086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbeKSWZN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:25:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:38430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728600AbeKSWZN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Nov 2018 17:25:13 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B404B20831;
        Mon, 19 Nov 2018 12:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542628908;
        bh=cnKukoVNyMeYUzf9xev0WMCOkWzSp4ARJ8cqFyhBbM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WpBtAVIM5zdXt/FPOFv9/XgR4LNso5NqGfCoMcn1ctQzMw6ZXJteZG0bvykf+REBO
         GAtaJHnA6dHuwFDSA57nPl4n3bYmeujFXkMqVRnwM0iVB2Iblai9TxD9PE3VnFP3xk
         FXiBZ2mC/H3A7v2gPuaaN/SgdZF49j8woKd0CnnA=
Date:   Mon, 19 Nov 2018 20:01:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>
Subject: Re: [PATCHv3 0/4] dts/layerscape-pci: removed unsuitable compatible
 string
Message-ID: <20181119120123.GQ5829@dragon>
References: <20181107053500.13575-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107053500.13575-1-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 07, 2018 at 05:35:12AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Removed the compatible string "snps,dw-pcie" from FSL layerscape-pci compatible
> string list.
> 
> Hou Zhiqiang (4):
>   dt-bindings: pci: layerscape-pci: add compatible strings
>     "fsl,ls1043a-pcie"
>   dt-bindings: pci: layerscape-pci: removed compatible string
>     "snps,dw-pcie"
>   ARM: dts: ls1021a: removed compatible string "snps,dw-pcie"
>   arm64: dts: layerscape: removed compatible string "snps,dw-pcie"

Applied all, thanks.
