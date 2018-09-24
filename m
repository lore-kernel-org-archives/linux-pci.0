Return-Path: <SRS0=+fdl=MG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562FCC433F4
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 08:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0558021486
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 08:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="MZN+TTYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0558021486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbeIXOuB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 24 Sep 2018 10:50:01 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:49476 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbeIXOuB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Sep 2018 10:50:01 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 8749025B755;
        Mon, 24 Sep 2018 18:48:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1537778939; bh=FEkh+BSxP6L4lHBZqKzMNdEXE1tWwASUQPBrgzppaD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MZN+TTYjgP0GDUDy8fXdD2I1MnyTIv+EZ59Q695r8CTcfBQlXMaM2uj2s14iK4u67
         bMBJXtMYGWRFGnlf5osapMpYMMHwS+F6v1r9fYqrNT1vXFZigcN6c/JhIESTucj/pP
         oDEluc8TgKVvfL0BlA5bmxqDBTiLJqvrhPafDaVk=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 64DAA940456; Mon, 24 Sep 2018 10:48:57 +0200 (CEST)
Date:   Mon, 24 Sep 2018 10:48:57 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Tho Vu <tho.vu.wh@rvc.renesas.com>,
        Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] DT: pci: rcar-pci: document R8A77990 bindings
Message-ID: <20180924084856.ukm7o3qbqjlsqf7x@verge.net.au>
References: <20180922150252.18754-1-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180922150252.18754-1-marek.vasut+renesas@gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 22, 2018 at 05:02:52PM +0200, Marek Vasut wrote:
> From: Tho Vu <tho.vu.wh@rvc.renesas.com>
> 
> Document the R-Car E3 (R8A77990) SoC in the R-Car PCIe bindings.
> 
> Signed-off-by: Tho Vu <tho.vu.wh@rvc.renesas.com>
> Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/pci/rcar-pci.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

