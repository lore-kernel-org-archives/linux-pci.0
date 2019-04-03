Return-Path: <SRS0=9zG9=SF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3548C10F0B
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 09:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2D821473
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 09:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="r+tfzKti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbfDCJ3X (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:29:23 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:35914 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfDCJ3W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Apr 2019 05:29:22 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id B523425AD6C;
        Wed,  3 Apr 2019 20:29:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1554283761; bh=1teH+VRU517H416j/CcpOAWL9tV1EOiMu4H/c3i20hc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r+tfzKtiwr33Lv8oWzzwunXDSepoDfJFpcsfN3sO1FE7L79gxL+T0LTT80SOXtqeu
         SNU/N6BG1ae9FLXBOQvPpXhFYv2AdCfDjmlDYBWlRX8LDULJ4p3XxranKHeqRQ/ed3
         Fn3etI3YClb540Qd4zfe5axJT20PBV9qaGmjGDW8=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id C8421940361; Wed,  3 Apr 2019 11:29:18 +0200 (CEST)
Date:   Wed, 3 Apr 2019 11:29:18 +0200
From:   Simon Horman <horms@verge.net.au>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V5 6/6] PCI: rcar: Fix 64bit MSI message address handling
Message-ID: <20190403092918.7jrrvo24s27kgzvr@verge.net.au>
References: <20190402013307.20912-1-marek.vasut@gmail.com>
 <20190402013307.20912-6-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402013307.20912-6-marek.vasut@gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 02, 2019 at 03:33:07AM +0200, marek.vasut@gmail.com wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> The MSI message address in the RC address space can be 64 bit. The
> R-Car PCIe RC supports such a 64bit MSI message address as well.
> The code currently uses virt_to_phys(__get_free_pages()) to obtain
> a reserved page for the MSI message address, and the return value
> of which can be a 64 bit physical address on 64 bit system.
> 
> However, the driver only programs PCIEMSIALR register with the bottom
> 32 bits of the virt_to_phys(__get_free_pages()) return value and does
> not program the top 32 bits into PCIEMSIAUR, but rather programs the
> PCIEMSIAUR register with 0x0. This worked fine on older 32 bit R-Car
> SoCs, however may fail on new 64 bit R-Car SoCs.
> 
> Since from a PCIe controller perspective, an inbound MSI is a memory
> write to a special address (in case of this controller, defined by
> the value in PCIEMSIAUR:PCIEMSIALR), which triggers an interrupt, but
> never hits the DRAM _and_ because allocation of an MSI by a PCIe card
> driver obtains the MSI message address by reading PCIEMSIAUR:PCIEMSIALR
> in rcar_msi_setup_irqs(), incorrectly programmed PCIEMSIAUR cannot
> cause memory corruption or other issues.
> 
> There is however the possibility that if virt_to_phys(__get_free_pages())
> returned address above the 32bit boundary _and_ PCIEMSIAUR was programmed
> to 0x0 _and_ if the system had physical RAM at the address matching the
> value of PCIEMSIALR, a PCIe card driver could allocate a buffer with a
> physical address matching the value of PCIEMSIALR and a remote write to
> such a buffer by a PCIe card would trigger a spurious MSI.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> To: linux-pci@vger.kernel.org
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

