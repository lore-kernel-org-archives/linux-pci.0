Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D47BC43334
	for <linux-pci@archiver.kernel.org>; Thu,  2 Jun 2022 18:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236819AbiFBStU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 2 Jun 2022 14:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238246AbiFBStT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 14:49:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BB832F;
        Thu,  2 Jun 2022 11:49:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF946B820E3;
        Thu,  2 Jun 2022 18:49:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B66C385A5;
        Thu,  2 Jun 2022 18:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654195755;
        bh=qdr08bJsfb0RZF+BBb1++E5vfQO1D8e8sXs7QcL6m+k=;
        h=Date:From:To:Cc:Subject:From;
        b=EdZOx0fgkqW/TRJPufu/Xyy9YCzLNCBoURxrcjwkBmf4MoV3Ck8FXr3dTuRNfC3aO
         XC4u0V9WgREHvn6RN6ogVGc0+klOBn1C2UUgxXUEisaFTHB6FElmgzjOLqw4aQ4riG
         7Zr6xgOtzLWG1BjNhJp2BjwULNjaaeG3lMNLb/q5sSD7xyGJStoPBA3hgHWb27NkXB
         lhXZxhQxwWXa0wny4wO0GuhePZFeBpfKXp1ijI333VOsL/JpbudKr4tWCmMmWwkIAu
         wadOiHGmIevhIt9AfVLvKwfW6h8B1KM1JnyA+h64+723DoLZQqXUw5NFU1G46E4Ecw
         sVpSLpWJQKqFQ==
Date:   Thu, 2 Jun 2022 13:49:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Cyril Brulebois <kibi@debian.org>,
        Jim Quinlan <jim2101024@gmail.com>
Subject: [GIT PULL] PCI fixes for v5.19
Message-ID: <20220602184913.GA36164@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit 3cc30140dbe2df9b5ac000898e0ae3d1df980f2c:

  Merge tag 'pci-v5.19-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci (2022-05-27 15:25:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.19-fixes-1

for you to fetch changes up to 833e53a4ffe92e742e99347c68d99dc33986598b:

  MAINTAINERS: Update Lorenzo Pieralisi's email address (2022-05-31 15:06:19 -0500)

----------------------------------------------------------------
PCI fixes:

  - Revert brcmstb patches that broke booting on Raspberry Pi Compute
    Module 4 (Bjorn Helgaas)

  - Fix bridge_d3_blacklist[] error that overwrote the existing Gigabyte
    X299 entry instead of adding a new one (Bjorn Helgaas)

  - Update Lorenzo Pieralisi's email address in MAINTAINERS (Lorenzo
    Pieralisi)

----------------------------------------------------------------
Bjorn Helgaas (5):
      Revert "PCI: brcmstb: Do not turn off WOL regulators on suspend"
      Revert "PCI: brcmstb: Add control of subdevice voltage regulators"
      Revert "PCI: brcmstb: Add mechanism to turn on subdev regulators"
      Revert "PCI: brcmstb: Split brcm_pcie_setup() into two funcs"
      PCI/PM: Fix bridge_d3_blacklist[] Elo i2 overwrite of Gigabyte X299

Lorenzo Pieralisi (1):
      MAINTAINERS: Update Lorenzo Pieralisi's email address

 .mailmap                              |   1 +
 MAINTAINERS                           |  16 +--
 drivers/pci/controller/pcie-brcmstb.c | 257 ++++------------------------------
 drivers/pci/pci.c                     |   2 +
 4 files changed, 41 insertions(+), 235 deletions(-)
