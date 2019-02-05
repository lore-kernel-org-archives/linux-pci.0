Return-Path: <SRS0=ZQO4=QM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89776C282D7
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 15:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589CD2184E
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 15:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="Oh/oXzmC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfBEPhB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:37:01 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:52004 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbfBEPhB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Feb 2019 10:37:01 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id B34B325B7E9;
        Wed,  6 Feb 2019 02:36:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1549381019; bh=UdD3alDPP336NVnlgeCp1OcvMzOTg2oU+UOIqd2nMZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oh/oXzmC1lBVhYuzMZnNSeaBTtNj/ZLO585eoxcXnpqIeempQYjwCoz0Zia2QZGCd
         mAD68+9IVvji8r2Yrkh3mIy5x997QSFmKK70ztQuzbc5zwkt4Sg8555yTUNVmhtK1e
         F4jOjtVB9P3/xpYqzk3K1BjNpZprrb1V7p12cDTM=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id E5F49940486; Tue,  5 Feb 2019 16:36:56 +0100 (CET)
Date:   Tue, 5 Feb 2019 16:36:56 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: PCI: rcar: Add device tree support for
 r8a774c0
Message-ID: <20190205153656.aywg4ewpyp34i633@verge.net.au>
References: <1545134562-22450-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <20190201174005.GD22887@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201174005.GD22887@e107981-ln.cambridge.arm.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 01, 2019 at 05:40:05PM +0000, Lorenzo Pieralisi wrote:
> On Tue, Dec 18, 2018 at 12:02:42PM +0000, Fabrizio Castro wrote:
> > Add PCIe support for the RZ/G2E (a.k.a. R8A774C0).
> > 
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > v1->v2:
> > * Dropped change to the description of "phys" optional property according
> >   to Geert's comment
> > 
> >  Documentation/devicetree/bindings/pci/rcar-pci.txt | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Hi Fabrizio,
> 
> Apologies for the delay in responding.
> 
> Should I take this patch via the PCI tree ?

Thanks, that would the preferred option from my point of view.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> 
> Thanks,
> Lorenzo
> 
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> > index 976ef7b..6904882 100644
> > --- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
> > +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> > @@ -3,6 +3,7 @@
> >  Required properties:
> >  compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
> >  	    "renesas,pcie-r8a7744" for the R8A7744 SoC;
> > +	    "renesas,pcie-r8a774c0" for the R8A774C0 SoC;
> >  	    "renesas,pcie-r8a7779" for the R8A7779 SoC;
> >  	    "renesas,pcie-r8a7790" for the R8A7790 SoC;
> >  	    "renesas,pcie-r8a7791" for the R8A7791 SoC;
> > @@ -13,7 +14,8 @@ compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
> >  	    "renesas,pcie-r8a77990" for the R8A77990 SoC;
> >  	    "renesas,pcie-rcar-gen2" for a generic R-Car Gen2 or
> >  				     RZ/G1 compatible device.
> > -	    "renesas,pcie-rcar-gen3" for a generic R-Car Gen3 compatible device.
> > +	    "renesas,pcie-rcar-gen3" for a generic R-Car Gen3 or
> > +				     RZ/G2 compatible device.
> >  
> >  	    When compatible with the generic version, nodes must list the
> >  	    SoC-specific version corresponding to the platform first
> > -- 
> > 2.7.4
> > 
> 
