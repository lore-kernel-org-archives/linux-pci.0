Return-Path: <SRS0=/qR3=MN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D67DC43143
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 12:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653572084C
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 12:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="TTvcS9+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 653572084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbeJATeX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:34:23 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:46201 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbeJATeX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Oct 2018 15:34:23 -0400
Received: from penelope.horms.nl (ip4dab7138.direct-adsl.nl [77.171.113.56])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 4B2EB25AD76;
        Mon,  1 Oct 2018 22:56:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1538398599; bh=6lBHXq870ej45iuRQVjvWGxlV5dxTm9jPQRUK02qN+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TTvcS9+l8L07SxTYMRf74aqFAJCXv+tPKUHP66GxXsQi3qa/8WdKxeJ77vYi1mVS6
         x+fWITcSUnX6zJOYXBs0HRb5rHtDNEvrVC6cEbOWXvc04FREk1qSblNJhv24e3Bddl
         zeYtYl7FOHzbiKa11eQJqwv3oZvIjTgwnC+zYM/E=
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id 451BAE21E33; Mon,  1 Oct 2018 14:56:37 +0200 (CEST)
Date:   Mon, 1 Oct 2018 14:56:37 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Biju Das <biju.das@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: PCI: rcar: Add device tree support for
 r8a7744
Message-ID: <20181001125637.g6isjlpvarylas6q@verge.net.au>
References: <1538051331-14860-1-git-send-email-biju.das@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538051331-14860-1-git-send-email-biju.das@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 27, 2018 at 01:28:51PM +0100, Biju Das wrote:
> Add internal PCI bridge support for r8a7744 SoC.  The Renesas RZ/G1N
> (R8A7744) internal PCI bridge is identical to the R-Car Gen2 family.
> 
> This doesn't change the driver, so it does nothing by itself.  But it does
> mean that checkpatch won't complain about a future patch that adds
> "renesas,pci-r8a7744" to a DT, which helps ensure that shipped DTs use
> documented compatibility strings.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

