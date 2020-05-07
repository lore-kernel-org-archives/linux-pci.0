Return-Path: <SRS0=kFL5=6V=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F93C38A24
	for <linux-pci@archiver.kernel.org>; Thu,  7 May 2020 17:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F5DD218AC
	for <linux-pci@archiver.kernel.org>; Thu,  7 May 2020 17:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgEGRot (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 May 2020 13:44:49 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:40638 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgEGRot (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 13:44:49 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 34B2C1C0257; Thu,  7 May 2020 19:44:47 +0200 (CEST)
Date:   Thu, 7 May 2020 19:44:46 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Lad Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH v9 0/8] Add endpoint driver for R-Car PCIe controller
Message-ID: <20200507174446.GC1216@bug>
References: <1587666159-6035-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587666159-6035-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi!


> R-Car/RZ-G2x SoC's, this also extends the epf framework to handle multiple windows
> supported by the controller for mapping PCI address locally.
> 
> Note:
> The cadence/rockchip/designware endpoint drivers are build tested only.
> 
> Changes for v9 (Re-spun this series as there were minimal changes requested):
...
> * Replaced mdelay(1) with usleep_range(1000, 1001) in rcar_pcie_ep_assert_intx()

Are you sure that is good idea? You are requesting 1ms sleep time with 1us tolerance,
I dont believe common systems can do that.

Best regards,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
