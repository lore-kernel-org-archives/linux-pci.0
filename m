Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9B3C433EF
	for <linux-pci@archiver.kernel.org>; Thu, 12 May 2022 14:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347405AbiELOzQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 12 May 2022 10:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346172AbiELOzQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 10:55:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DC22253A9F
        for <linux-pci@vger.kernel.org>; Thu, 12 May 2022 07:55:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35BB2106F;
        Thu, 12 May 2022 07:55:15 -0700 (PDT)
Received: from e123427-lin.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 901B13F73D;
        Thu, 12 May 2022 07:55:14 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pci@vger.kernel.org,
        Nirmal Patel <nirmal.patel@linux.intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 0/2] PCI: vmd: IRQ domain assignment to sub devices
Date:   Thu, 12 May 2022 15:55:05 +0100
Message-Id: <165236729142.991.15360403180568817088.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220511095707.25403-1-nirmal.patel@linux.intel.com>
References: <20220511095707.25403-1-nirmal.patel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 11 May 2022 02:57:05 -0700, Nirmal Patel wrote:
> Host OS fails to boot and DMAR errors were observed when interrupt
> remapping is enabled by intel_iommu because of the fact that VMD child
> devices are on different IRQ domain than all other PCI devices.
> Make sure VMD assigns proper IRQ domain to the child devices during
> device enumeration.
> 
> Nirmal Patel (2):
>   PCI: vmd: Assign VMD IRQ domain before enumeration
>   PCI: vmd: Revert 2565e5b69c44 ("PCI: vmd: Do not disable MSI-X
>     remapping if interrupt remapping is enabled by IOMMU.")
> 
> [...]

Applied to pci/vmd, thanks!

[1/2] PCI: vmd: Assign VMD IRQ domain before enumeration
      https://git.kernel.org/lpieralisi/pci/c/886e67100b
[2/2] PCI: vmd: Revert 2565e5b69c44 ("PCI: vmd: Do not disable MSI-X remapping if interrupt remapping is enabled by IOMMU.")
      https://git.kernel.org/lpieralisi/pci/c/c94f732e80

Thanks,
Lorenzo
