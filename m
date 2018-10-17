Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D36ECDE32
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 09:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FB421523
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 09:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="cg7rFPFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71FB421523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbeJQRNV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:13:21 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:45145 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbeJQRNV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Oct 2018 13:13:21 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id AB7FF25B784;
        Wed, 17 Oct 2018 20:18:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1539767912; bh=pGIaknu5K3ZrvwU1gliMb28tux2JNacmPuDkjlpLpCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cg7rFPFv4hz2FMCI4ZzrDSECOtXzGwS7LAzfytovUM7EluGRRtOq1xaaact8p1hjg
         qZW6C63/FaeUlrzwVJ+1m1f2HJFK4EIqX5VA4FaCsEle3bxiuxL+mJt1DgxVhfb4zU
         6ceP2ZM5QCuU4diq65KBmhAYmMw2T7t+o5FydMlM=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 816D6940443; Wed, 17 Oct 2018 11:18:29 +0200 (CEST)
Date:   Wed, 17 Oct 2018 11:18:29 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Biju Das <biju.das@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: rcar: Add device tree support for
 r8a7744
Message-ID: <20181017091829.tkorr4mdvpimfrqf@verge.net.au>
References: <1538669267-17576-1-git-send-email-biju.das@bp.renesas.com>
 <20181008073445.ni4doozxflbqaanw@verge.net.au>
 <20181012160408.GE23257@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012160408.GE23257@e107981-ln.cambridge.arm.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 12, 2018 at 05:04:08PM +0100, Lorenzo Pieralisi wrote:
> On Mon, Oct 08, 2018 at 09:34:45AM +0200, Simon Horman wrote:
> > On Thu, Oct 04, 2018 at 05:07:47PM +0100, Biju Das wrote:
> > > Add support for r8a7744. The Renesas RZ/G1N (R8A7744) PCIe controller
> > > is identical to the R-Car Gen2 family.
> > > 
> > > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > > Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> > 
> > Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Simon, Biju,
> 
> I pulled the same binding for rcar2, I would pull this in the PCI tree
> too unless you object, please let me know.

No objection.
