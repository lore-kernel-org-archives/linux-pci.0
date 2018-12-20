Return-Path: <SRS0=yvM8=O5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B0DC43387
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 07:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A783921720
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 07:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="WdsHeC44"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbeLTHyG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Dec 2018 02:54:06 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:57826 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729907AbeLTHyF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Dec 2018 02:54:05 -0500
Received: from penelope.horms.nl (softbank060150141248.bbtec.net [60.150.141.248])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 429BF25B770;
        Thu, 20 Dec 2018 18:54:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1545292443; bh=45ty2YZkhogdS8nGfqTrMAo/uAr7LAV9nW8qyk7noTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WdsHeC449lBKNmaEAKVAEyeNcqaxUUIO19kyjUxi/e24vmy3uJwD0h8xtTUIR1hgE
         WojBSH/K5kqW2nDfVlWHrHlg7hkbCR5cGCbYwqPsW/6OKqWPEfXDj+u0g/Bcn/LZzE
         qi28vMzvJSm/dpbcTybIDxPQhI78d4wy9bELhUU8=
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id AB4F6E218FB; Wed, 19 Dec 2018 23:54:01 -0800 (PST)
Date:   Thu, 20 Dec 2018 16:54:01 +0900
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: PCI: rcar: Add device tree support for
 r8a774c0
Message-ID: <20181220075401.dkm6vh3de5jsd6kx@verge.net.au>
References: <1545134562-22450-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545134562-22450-1-git-send-email-fabrizio.castro@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 18, 2018 at 12:02:42PM +0000, Fabrizio Castro wrote:
> Add PCIe support for the RZ/G2E (a.k.a. R8A774C0).
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

