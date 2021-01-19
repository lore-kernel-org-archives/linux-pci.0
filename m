Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8ECC4332E
	for <linux-pci@archiver.kernel.org>; Tue, 19 Jan 2021 13:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D22B23132
	for <linux-pci@archiver.kernel.org>; Tue, 19 Jan 2021 13:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392260AbhASM63 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Jan 2021 07:58:29 -0500
Received: from foss.arm.com ([217.140.110.172]:54842 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404164AbhASMZJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Jan 2021 07:25:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C286111FB;
        Tue, 19 Jan 2021 04:24:23 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.35.195])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BD673F719;
        Tue, 19 Jan 2021 04:24:22 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v4] PCI: brcmstb: Remove chained IRQ handler and data in one go
Date:   Tue, 19 Jan 2021 12:24:16 +0000
Message-Id: <161105904798.24980.11203133970059677653.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210115211532.19837-1-martin@kaiser.cx>
References: <20201108184208.19790-1-martin@kaiser.cx> <20210115211532.19837-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 15 Jan 2021 22:15:32 +0100, Martin Kaiser wrote:
> Call irq_set_chained_handler_and_data() to clear the chained handler
> and the handler's data under irq_desc->lock.
> 
> See also 2cf5a03cb29d ("PCI/keystone: Fix race in installing chained
> IRQ handler").

Applied to pci/misc, thanks!

[1/1] PCI: brcmstb: Remove chained IRQ handler and data in one go
      https://git.kernel.org/lpieralisi/pci/c/5ce6697a44

Thanks,
Lorenzo
