Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C13C4320A
	for <linux-pci@archiver.kernel.org>; Mon, 16 Aug 2021 14:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7495B63307
	for <linux-pci@archiver.kernel.org>; Mon, 16 Aug 2021 14:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhHPOAi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 16 Aug 2021 10:00:38 -0400
Received: from foss.arm.com ([217.140.110.172]:45098 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231297AbhHPN5r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Aug 2021 09:57:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72AAB6D;
        Mon, 16 Aug 2021 06:57:15 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.42.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 167723F66F;
        Mon, 16 Aug 2021 06:57:13 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pci@vger.kernel.org,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-renesas-soc@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>
Subject: Re: [PATCH V7] PCI: rcar: Add L1 link state fix into data abort hook
Date:   Mon, 16 Aug 2021 14:57:04 +0100
Message-Id: <162912206617.7498.10791199140703646138.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210815181650.132579-1-marek.vasut@gmail.com>
References: <20210815181650.132579-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 15 Aug 2021 20:16:50 +0200, marek.vasut@gmail.com wrote:
> When the link is in L1, hardware should return it to L0
> automatically whenever a transaction targets a component on the
> other end of the link (PCIe r5.0, sec 5.2).
> 
> The R-Car PCIe controller doesn't handle this transition correctly.
> If the link is not in L0, an MMIO transaction targeting a downstream
> device fails, and the controller reports an ARM imprecise external
> abort.
> 
> [...]

Applied to pci/rcar, thanks!

[1/1] PCI: rcar: Add L1 link state fix into data abort hook
      https://git.kernel.org/lpieralisi/pci/c/a115b1bd3a

Thanks,
Lorenzo
