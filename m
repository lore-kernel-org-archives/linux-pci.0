Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27E9C433DB
	for <linux-pci@archiver.kernel.org>; Mon, 22 Mar 2021 14:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76D846192B
	for <linux-pci@archiver.kernel.org>; Mon, 22 Mar 2021 14:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhCVOsq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 22 Mar 2021 10:48:46 -0400
Received: from foss.arm.com ([217.140.110.172]:33154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhCVOsp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Mar 2021 10:48:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 717881042;
        Mon, 22 Mar 2021 07:48:44 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.55.31])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45E183F719;
        Mon, 22 Mar 2021 07:48:37 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: keystone: Let AM65 use the pci_ops defined in pcie-designware-host.c
Date:   Mon, 22 Mar 2021 14:48:31 +0000
Message-Id: <161642448420.20787.1576994239586353648.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210317131518.11040-1-kishon@ti.com>
References: <20210317131518.11040-1-kishon@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 17 Mar 2021 18:45:18 +0530, Kishon Vijay Abraham I wrote:
> Both TI's AM65x (K3) and TI's K2 PCIe driver are implemented in
> pci-keystone. However Only K2 PCIe driver should use it's own pci_ops
> for configuration space accesses. But commit 10a797c6e54a
> ("PCI: dwc: keystone: Use pci_ops for config space accessors") used
> custom pci_ops for both AM65x and K2. This breaks configuration space
> access for AM65x platform. Fix it here.

Applied to pci/dwc, thanks!

[1/1] PCI: keystone: Let AM65 use the pci_ops defined in pcie-designware-host.c
      https://git.kernel.org/lpieralisi/pci/c/3d0b2a3a87

Thanks,
Lorenzo
