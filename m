Return-Path: <SRS0=UcqY=5Y=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C0CC2BA2B
	for <linux-pci@archiver.kernel.org>; Wed,  8 Apr 2020 23:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A9320757
	for <linux-pci@archiver.kernel.org>; Wed,  8 Apr 2020 23:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586388611;
	bh=BS0ZFoiAjqfPxe9bkyobcDKcwdePpxw1588Rc7wSJJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=u4fb4ks5FoOVrQcBisi2wA0i1q5N/ErB9SW5ES6TW+lD2AuHYXSwzUy6esAwQ8ci+
	 vdcnLiDoD1ASDGXKcqRnkrhb//MgIaJ0GOIlBX8fvuiR1XKDQP60B4qk0mdApCtZQX
	 e0duFz8ip+43rWpqveqpWsNC3vqZ34gTzD4o9WIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgDHXaK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 8 Apr 2020 19:30:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbgDHXaK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Apr 2020 19:30:10 -0400
Received: from localhost (mobile-166-175-188-68.mycingular.net [166.175.188.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD0ED20730;
        Wed,  8 Apr 2020 23:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586388610;
        bh=BS0ZFoiAjqfPxe9bkyobcDKcwdePpxw1588Rc7wSJJc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Tq87FDiJYzSROkNza6MmRJ2L1MvMFuSLJty0f8QCOXhEryVgro3JUW+LY/jpx7JPt
         A7jaNs8uU86tY53XAVsYf0RTGTgLzLVqKwY6wAnzho8QsVNndmxcHD9JMQQexFAcsh
         uoCvMiiFs+QBCqEiVWGbNzi82E0hU7wSdJzZzKRs=
Date:   Wed, 8 Apr 2020 18:30:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-rockchip@lists.infradead.org,
        Lad Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH v7 2/8] PCI: rcar: Move shareable code to a common file
Message-ID: <20200408233008.GA150200@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586360280-10956-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 08, 2020 at 04:37:54PM +0100, Lad Prabhakar wrote:
> This patch moves sharable code to common file pcie-rcar.c and the #defines
> to pcie-rcar.h so that the common code can be reused with endpoint driver.
> There are no functional changes with this patch for the host controller
> driver.

s/This patch moves/Move/
s/sharable/shareable/
