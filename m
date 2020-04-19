Return-Path: <SRS0=+/lQ=6D=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9DCC5321D
	for <linux-pci@archiver.kernel.org>; Sun, 19 Apr 2020 16:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C44962051A
	for <linux-pci@archiver.kernel.org>; Sun, 19 Apr 2020 16:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgDSQib (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 19 Apr 2020 12:38:31 -0400
Received: from smtprelay0088.hostedemail.com ([216.40.44.88]:51650 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725793AbgDSQib (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 19 Apr 2020 12:38:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id E2A595836;
        Sun, 19 Apr 2020 16:38:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bone84_2ca91b5f55455
X-Filterd-Recvd-Size: 2304
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Sun, 19 Apr 2020 16:38:26 +0000 (UTC)
Message-ID: <975f3a73bb272b8276687af609cd7e592d6ba9ac.camel@perches.com>
Subject: Re: [PATCH v8 8/8] MAINTAINERS: Add file patterns for rcar PCI
 device tree bindings
From:   Joe Perches <joe@perches.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Lad Prabhakar <prabhakar.csengg@gmail.com>
Date:   Sun, 19 Apr 2020 09:36:11 -0700
In-Reply-To: <1587302823-4435-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1587302823-4435-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
         <1587302823-4435-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 2020-04-19 at 14:27 +0100, Lad Prabhakar wrote:
> Add file pattern entry for rcar PCI devicetree binding, so that when
> people run ./scripts/get_maintainer.pl the rcar PCI maintainers could also
> be listed.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -12933,6 +12933,7 @@ L:	linux-pci@vger.kernel.org
>  L:	linux-renesas-soc@vger.kernel.org
>  S:	Maintained
>  F:	drivers/pci/controller/*rcar*
> +F:	Documentation/devicetree/bindings/pci/*rcar*

MAINTAINERS was recently sorted for consistency.

Please move this new line above drivers/ to keep alphabetic ordering.


