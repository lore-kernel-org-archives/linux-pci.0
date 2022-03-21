Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF75AC433EF
	for <linux-pci@archiver.kernel.org>; Mon, 21 Mar 2022 11:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343788AbiCULBc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Mar 2022 07:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346151AbiCULBb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Mar 2022 07:01:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6EED2762BD;
        Mon, 21 Mar 2022 04:00:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19C051042;
        Mon, 21 Mar 2022 04:00:06 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.20.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43F053F766;
        Mon, 21 Mar 2022 04:00:04 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        kernel-team@android.com, dann frazier <dann.frazier@canonical.com>,
        Rob Herring <robh@kernel.org>,
        Toan Le <toan@os.amperecomputing.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/2] PCI: xgene: Restore working PCIe functionnality
Date:   Mon, 21 Mar 2022 10:59:51 +0000
Message-Id: <164786014095.24674.3958001452052636083.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220321104843.949645-1-maz@kernel.org>
References: <20220321104843.949645-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 21 Mar 2022 10:48:41 +0000, Marc Zyngier wrote:
> Since 6dce5aa59e0b ("PCI: xgene: Use inbound resources for setup") was
> merged in the 5.5 time frame, PCIe on the venerable XGene platform has
> been unusable: 6dce5aa59e0b broke both XGene-1 (Mustang and m400) and
> XGene-2 (Merlin), while the addition of c7a75d07827a ("PCI: xgene: Fix
> IB window setup") fixed XGene-2, but left the rest of the zoo
> unusable.
> 
> [...]

Applied to pci/xgene, thanks!

[1/2] PCI: xgene: Revert "PCI: xgene: Use inbound resources for setup"
      https://git.kernel.org/lpieralisi/pci/c/1874b6d7ab
[2/2] PCI: xgene: Revert "PCI: xgene: Fix IB window setup"
      https://git.kernel.org/lpieralisi/pci/c/825da4e9ce

Thanks,
Lorenzo
