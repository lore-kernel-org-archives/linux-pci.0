Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BADC433B4
	for <linux-pci@archiver.kernel.org>; Tue,  6 Apr 2021 15:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47C2A613A7
	for <linux-pci@archiver.kernel.org>; Tue,  6 Apr 2021 15:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345745AbhDFPmc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Apr 2021 11:42:32 -0400
Received: from foss.arm.com ([217.140.110.172]:44994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232462AbhDFPmc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Apr 2021 11:42:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3592A1FB;
        Tue,  6 Apr 2021 08:42:24 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.57.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 054E33F792;
        Tue,  6 Apr 2021 08:42:20 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pci@vger.kernel.org, james.quinlan@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        Jim Quinlan <jim2101024@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Jim Quinlan <jquinlan@broadcom.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:LIBATA SUBSYSTEM Serial and Parallel ATA drivers" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/2] ata: ahci_brcm: Fix use of BCM7216 reset controller
Date:   Tue,  6 Apr 2021 16:42:14 +0100
Message-Id: <161772368880.12349.1551046998078695154.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210312204556.5387-1-jim2101024@gmail.com>
References: <20210312204556.5387-1-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 12 Mar 2021 15:45:53 -0500, Jim Quinlan wrote:
> v5 -- Improved (I hope) commit description (Bjorn).
>    -- Rnamed error labels (Krzyszt).
>    -- Fixed typos.
> 
> v4 -- does not rely on a pending commit, unlike v3.
> 
> v3 -- discard commit from v2; instead rely on the new function
>       reset_control_rearm provided in a recent commit [1] applied
>       to reset/next.
>    -- New commit to correct pcie-brcmstb.c usage of a reset controller
>       to use reset/rearm verses deassert/assert.
> 
> [...]

Applied to pci/brcmstb, thanks!

[1/2] ata: ahci_brcm: Fix use of BCM7216 reset controller
      https://git.kernel.org/lpieralisi/pci/c/92b9cb55a9
[2/2] PCI: brcmstb: Use reset/rearm instead of deassert/assert
      https://git.kernel.org/lpieralisi/pci/c/a24fd1d646

Thanks,
Lorenzo
