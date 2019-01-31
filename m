Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77359C169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 22:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7F22087F
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 22:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548972215;
	bh=5O6tf8N5YCpLZxA7BGLvaKNpvzCY1MEs5jBeREIgLZI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=PcL0p2mbZ/JNVHVppiYUWo7u1OhPQOSe+Wz6pyQH/n/+Q+Op22sOa+vGXlE9R+8nN
	 zf/t6TunmcVmYkV4ckIKuE1lk2rBCmfbkldEOlPCLzznFrpup4mVryDqqErlnPeSRM
	 oS8Aw1z824aFhJGYM3Oid7ReWnaR6AcYeK1i59cE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbfAaWDe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 17:03:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:51740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727017AbfAaWDe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Jan 2019 17:03:34 -0500
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A22D20833;
        Thu, 31 Jan 2019 22:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548972213;
        bh=5O6tf8N5YCpLZxA7BGLvaKNpvzCY1MEs5jBeREIgLZI=;
        h=Date:From:To:Cc:Subject:From;
        b=pFceEO7StQZilq/MnQnp+r0vQjWAlH872eFOB+WwDXDhphPEHNE5Dkq44MHOWK53l
         Vnw0GjUKrGYCHuqK6fbyezCxtK4Dju9ZMw5Dd3jq4RFRRKe+uLCEXXS3V4IIIHsLnN
         CBz4wTt6QopwH1YjPKG5SyXyjFCQ1vtvxZJqbaY4=
Date:   Thu, 31 Jan 2019 16:03:32 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: [GIT PULL] PCI fixes for v5.0
Message-ID: <20190131220332.GQ229773@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI fixes:

  - Revert armada8k GPIO reset change that broke Macchiatobin booting
    (Baruch Siach)

  - Use actual size config reads on ARM cns3xxx (Koen Vandeputte)

  - Fix ARM cns3xxx config write alignment issue (Koen Vandeputte)

  - Fix imx6 PHY device link error checking (Leonard Crestez)

  - Fix imx6 probe failure on chips without separate PCI power domain
    (Leonard Crestez)


The following changes since commit d2fd6e81912a665993b24dcdc1c1384a42a54f7e:

  PCI: Fix __initdata issue with "pci=disable_acs_redir" parameter (2019-01-17 08:46:34 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.0-fixes-3

for you to fetch changes up to f14bcc0add3abecceca1a3fe538c4ec9566893f3:

  Revert "PCI: armada8k: Add support for gpio controlled reset signal" (2019-01-31 15:07:29 -0600)

----------------------------------------------------------------
pci-v5.0-fixes-3

----------------------------------------------------------------
Baruch Siach (1):
      Revert "PCI: armada8k: Add support for gpio controlled reset signal"

Koen Vandeputte (2):
      ARM: cns3xxx: Fix writing to wrong PCI config registers after alignment
      ARM: cns3xxx: Use actual size reads for PCIe

Leonard Crestez (2):
      PCI: imx: Fix probe failure without power domain
      PCI: imx: Fix checking pd_pcie_phy device link addition

 arch/arm/mach-cns3xxx/pcie.c               |  4 ++--
 drivers/pci/controller/dwc/pci-imx6.c      | 11 +++++++----
 drivers/pci/controller/dwc/pcie-armada8k.c | 16 ----------------
 3 files changed, 9 insertions(+), 22 deletions(-)
