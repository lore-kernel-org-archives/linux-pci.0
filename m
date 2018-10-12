Return-Path: <SRS0=mL0v=MY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1E8C6783C
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 16:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4BA21470
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 16:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4BA21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbeJLXhW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:37:22 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53766 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728744AbeJLXhW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Oct 2018 19:37:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2815AF;
        Fri, 12 Oct 2018 09:04:13 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A8AC3F5BC;
        Fri, 12 Oct 2018 09:04:11 -0700 (PDT)
Date:   Fri, 12 Oct 2018 17:04:08 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Simon Horman <horms@verge.net.au>
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
Message-ID: <20181012160408.GE23257@e107981-ln.cambridge.arm.com>
References: <1538669267-17576-1-git-send-email-biju.das@bp.renesas.com>
 <20181008073445.ni4doozxflbqaanw@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008073445.ni4doozxflbqaanw@verge.net.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 08, 2018 at 09:34:45AM +0200, Simon Horman wrote:
> On Thu, Oct 04, 2018 at 05:07:47PM +0100, Biju Das wrote:
> > Add support for r8a7744. The Renesas RZ/G1N (R8A7744) PCIe controller
> > is identical to the R-Car Gen2 family.
> > 
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> 
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Simon, Biju,

I pulled the same binding for rcar2, I would pull this in the PCI tree
too unless you object, please let me know.

Thanks,
Lorenzo
