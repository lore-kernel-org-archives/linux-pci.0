Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BD3C4338F
	for <linux-pci@archiver.kernel.org>; Wed,  4 Aug 2021 11:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB35761029
	for <linux-pci@archiver.kernel.org>; Wed,  4 Aug 2021 11:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbhHDLXg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 4 Aug 2021 07:23:36 -0400
Received: from foss.arm.com ([217.140.110.172]:59496 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237437AbhHDLXg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Aug 2021 07:23:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AADC713D5;
        Wed,  4 Aug 2021 04:23:23 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.38.165])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F2813F719;
        Wed,  4 Aug 2021 04:23:21 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Abhishek Shah <abhishek.shah@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        linux-pci@vger.kernel.org,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        Roman Bacik <roman.bacik@broadcom.com>,
        Bharat Gooty <bharat.gooty@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH 1/2] PCI: of: Don't fail devm_pci_alloc_host_bridge() on missing 'ranges'
Date:   Wed,  4 Aug 2021 12:23:10 +0100
Message-Id: <162807604073.10493.5773914111068469846.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210803215656.3803204-1-robh@kernel.org>
References: <20210803215656.3803204-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 3 Aug 2021 15:56:55 -0600, Rob Herring wrote:
> Commit 669cbc708122 ("PCI: Move DT resource setup into
> devm_pci_alloc_host_bridge()") made devm_pci_alloc_host_bridge() fail on
> any DT resource parsing errors, but Broadcom iProc uses
> devm_pci_alloc_host_bridge() on BCMA bus devices that don't have DT
> resources. In particular, there is no 'ranges' property. Fix iProc by
> making 'ranges' optional.
> 
> [...]

Applied to pci/iproc, thanks!

[1/2] PCI: of: Don't fail devm_pci_alloc_host_bridge() on missing 'ranges'
      https://git.kernel.org/lpieralisi/pci/c/d277f6e88c
[2/2] PCI: iproc: Fix BCMA probe resource handling
      https://git.kernel.org/lpieralisi/pci/c/aeaea8969b

Thanks,
Lorenzo
