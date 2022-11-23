Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFC4C433FE
	for <linux-pci@archiver.kernel.org>; Wed, 23 Nov 2022 21:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbiKWVNW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 23 Nov 2022 16:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbiKWVNV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 16:13:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AD11CFFF;
        Wed, 23 Nov 2022 13:13:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 800B261F2D;
        Wed, 23 Nov 2022 21:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B173C433C1;
        Wed, 23 Nov 2022 21:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669237999;
        bh=tV0Rfu5eLPR6Kt2HA72zzZp+RdkxXEaTeuV8y7PMhG0=;
        h=Date:From:To:Cc:Subject:From;
        b=AKGF8VHVsE+ROVCcx8PhliSPFS9KDWiQUfDeCq8f5YgIGgRgt9GBsyj4P5Bv+OXDp
         ax4J/Ymu/4zHCQJvKVZBQlumCxRM4HkVzUn7mN6NgRo+SWLo2xIeYlOtQ2kg8g60aH
         +J+NOaaVkCSymb1piK5oDmXLKzDXnwFsvkNlLkZJW1/rbP3/rz5VUjBWRshV45xmm9
         vdNxDCsWPj3+YSTE+Ran3dW9e3GYg3dB4QN0e0EPQnLCtchOiqUovDScdax2KyYUhz
         RPpNbeAl7O4tPL+Nn/QskyiiAQujqE97XEs+CpkG4VEXhicbk5AnpfS88o7/dCKypw
         rl29gOserGVqA==
Date:   Wed, 23 Nov 2022 15:13:18 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: [GIT PULL] PCI fixes for v6.1
Message-ID: <20221123211318.GA281503@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci-v6.1-fixes-3

for you to fetch changes up to ac9ccce8717df5aa5361c0cea9d8619f6d87af3c:

  MAINTAINERS: Include PCI bindings in host bridge entry (2022-11-17 13:40:39 -0600)

----------------------------------------------------------------

- Update MAINTAINERS to add Manivannan Sadhasivam as Qcom PCIe RC
  maintainer (replacing Stanimir Varbanov) and include DT PCI bindings
  in the "PCI native host bridge and endpoint drivers" entry.

----------------------------------------------------------------
Manivannan Sadhasivam (1):
      MAINTAINERS: Add Manivannan Sadhasivam as Qcom PCIe RC maintainer

Rob Herring (1):
      MAINTAINERS: Include PCI bindings in host bridge entry

 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
