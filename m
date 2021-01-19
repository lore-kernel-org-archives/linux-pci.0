Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46398C4332B
	for <linux-pci@archiver.kernel.org>; Tue, 19 Jan 2021 13:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F33CD2312D
	for <linux-pci@archiver.kernel.org>; Tue, 19 Jan 2021 13:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392249AbhASM6Q (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Jan 2021 07:58:16 -0500
Received: from foss.arm.com ([217.140.110.172]:53610 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392272AbhASMDj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Jan 2021 07:03:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11E16113E;
        Tue, 19 Jan 2021 04:02:47 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.35.195])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B0733F719;
        Tue, 19 Jan 2021 04:02:44 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Drop PCIE_RCAR config option
Date:   Tue, 19 Jan 2021 12:02:37 +0000
Message-Id: <161105770999.14004.4826810359475024379.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20201229170848.18482-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201229170848.18482-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 29 Dec 2020 17:08:48 +0000, Lad Prabhakar wrote:
> All the defconfig files have replaced PCIE_RCAR config option with
> PCIE_RCAR_HOST config option which built the same driver, so we can
> now safely drop PCIE_RCAR config option.

Applied to pci/misc, thanks!

[1/1] PCI: Drop PCIE_RCAR config option
      https://git.kernel.org/lpieralisi/pci/c/ff591f7490

Thanks,
Lorenzo
