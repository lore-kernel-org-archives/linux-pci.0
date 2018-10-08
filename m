Return-Path: <SRS0=j7M/=MU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90622C00449
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 07:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568F32089D
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 07:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="LUhGZZYR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568F32089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeJHOpK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Oct 2018 10:45:10 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:38323 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeJHOpK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Oct 2018 10:45:10 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id AB21E25BDE5;
        Mon,  8 Oct 2018 18:34:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1538984088; bh=QdfyR4ryf0lO0i7zAAULa15WgsNeWJcUlAmPIv8N214=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LUhGZZYRNKLHbFaS1OlPKcuoxJz0OMQVTGAtNSNjGW2GxE60Zuwrs65q4M5vwzTph
         LyUCTCMJXcC7zN7K1+E25cew9pOkjBdZji1Ztxct4HHUVUbMP3Ov5PZVzQTn9fu9iI
         9f5Lm9mTj9NXivGlJbZoHM/egzIE70wk4XYgq08E=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 8BA5494040B; Mon,  8 Oct 2018 09:34:45 +0200 (CEST)
Date:   Mon, 8 Oct 2018 09:34:45 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Biju Das <biju.das@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: rcar: Add device tree support for
 r8a7744
Message-ID: <20181008073445.ni4doozxflbqaanw@verge.net.au>
References: <1538669267-17576-1-git-send-email-biju.das@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538669267-17576-1-git-send-email-biju.das@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 04, 2018 at 05:07:47PM +0100, Biju Das wrote:
> Add support for r8a7744. The Renesas RZ/G1N (R8A7744) PCIe controller
> is identical to the R-Car Gen2 family.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

