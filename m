Return-Path: <SRS0=dA88=2D=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A98C2D0C9
	for <linux-pci@archiver.kernel.org>; Fri, 13 Dec 2019 21:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257C52468C
	for <linux-pci@archiver.kernel.org>; Fri, 13 Dec 2019 21:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576271204;
	bh=hWUTsi+517PaE+0S0Vj4/AHhcznAaHtL9dM69acMjt0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=1AjWfitC661ID94pnJZsQfQi2jELU5EzocuIKgywpQE5in+Hs1aWoSMpLsaAn4N5B
	 UGJt7uP+ke1qbxVS5wRUES68a7yVQz7ENFpLLtAMxUVbMr6GIbfIr30FivVQiZWqGE
	 5EM9qsZ6MTr1Y0IFJXEepK6BCkW2s+H3wPQhIYSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfLMVGo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 13 Dec 2019 16:06:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:45906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbfLMVGn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Dec 2019 16:06:43 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D6D72467A;
        Fri, 13 Dec 2019 21:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576271202;
        bh=hWUTsi+517PaE+0S0Vj4/AHhcznAaHtL9dM69acMjt0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cObaL2ydIExDh5FQfy04mYtNWg8OGAWhz8lGSbGtxeNyVZ2k16gCNohgzA/fV+IBS
         9cFMAMDj4nGr6XQKqdmWTNDQRO5ykXoBKm9Ncektrv6hzd7/TEU83Mfl0rChSKJn7j
         qY1XoccfsWjH7157hNnDcoweI7eFUjAByHwEYBgg=
Date:   Fri, 13 Dec 2019 15:06:41 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lad Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Murray <andrew.murray@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [v2 0/6] Add support for PCIe controller to work in endpoint
 mode on R-Car SoCs
Message-ID: <20191213184627.GA169673@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213084748.11210-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 13, 2019 at 08:47:42AM +0000, Lad Prabhakar wrote:

> Lad, Prabhakar (6):
>   pci: pcie-rcar: preparation for adding endpoint support
>   pci: endpoint: add support to handle features of outbound memory
>   of: address: add support to parse PCI outbound-ranges
>   dt-bindings: PCI: rcar: Add bindings for R-Car PCIe endpoint
>     controller
>   pci: rcar: add support for rcar pcie controller in endpoint mode
>   misc: pci_endpoint_test: add device-id for RZ/G2E pcie controller

The next time you post this, please update the subject lines to match
existing conventions (capitalize "PCI", description is a complete
sentence starting with a capitalized verb, etc").  Run "git log
--online" on the file you're changing and make yours look the same.

  s/pci: /PCI: /
  s/pcie-rcar: /rcar: /
  s/pcie/PCIe/
  s/device-id/Device ID/
