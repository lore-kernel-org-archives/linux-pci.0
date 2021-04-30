Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD43C433ED
	for <linux-pci@archiver.kernel.org>; Fri, 30 Apr 2021 19:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D3CE613F8
	for <linux-pci@archiver.kernel.org>; Fri, 30 Apr 2021 19:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbhD3TxF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 30 Apr 2021 15:53:05 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:53679 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbhD3TxE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Apr 2021 15:53:04 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 00E96CFED6;
        Fri, 30 Apr 2021 19:44:50 +0000 (UTC)
X-Originating-IP: 92.184.110.200
Received: from xps13 (pop.92-184-110-200.mobile.abo.orange.fr [92.184.110.200])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id C60AEC0004;
        Fri, 30 Apr 2021 19:44:26 +0000 (UTC)
Date:   Fri, 30 Apr 2021 21:44:24 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-mtd@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Remove unused Sigma Designs Tango bindings
Message-ID: <20210430214424.1987dc0b@xps13>
In-Reply-To: <20210430153225.3366000-1-robh@kernel.org>
References: <20210430153225.3366000-1-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

Rob Herring <robh@kernel.org> wrote on Fri, 30 Apr 2021 10:32:25 -0500:

> The Sigma Designs Tango support has been removed, but 2 binding docs
> for NAND and PCIe were missed. Remove them.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-mtd@lists.infradead.org
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

For the NAND binding doc:
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl
