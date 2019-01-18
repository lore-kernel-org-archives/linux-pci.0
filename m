Return-Path: <SRS0=ljL/=P2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6349C07EBF
	for <linux-pci@archiver.kernel.org>; Fri, 18 Jan 2019 19:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF8520883
	for <linux-pci@archiver.kernel.org>; Fri, 18 Jan 2019 19:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547838445;
	bh=tM6CPsyindET+ygSpKg+w1FM2pS3A380xZgoklAu75U=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=QIvRzaQcGJcnvI8dtQ7mx8K6pI3wAcAGnrXDmbiYnHpW8UvKECX5LeL8ZIR7EwKkV
	 PWKdAxNT3SUoSGleCuN5B43JEZJ5TNQycINNdrGMksDh7v6IGYiSXyH43o3+gCwESO
	 HtY3XZAjZF/xVt0S7CJgP/MoqAdDKWypawSV0J0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbfARTHY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:07:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:52018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728803AbfARTHY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Jan 2019 14:07:24 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDE112086D;
        Fri, 18 Jan 2019 19:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547838444;
        bh=tM6CPsyindET+ygSpKg+w1FM2pS3A380xZgoklAu75U=;
        h=Date:From:To:Cc:Subject:From;
        b=lz2hyLw8kiB3zMKpQPl3ak+c8+CoGXapBVX+9R9SD7vR8sazwJJqDPKp1sX/2NfiL
         LOq9134Ds9Y973kzdMQkwlz/YTMBeHuPXvyUxlLSqxmAcs8JcJY/EsLweF/0nKvPfi
         hudSyUd46tznqwjndo9N7enW62H+tXw0v7R/RJdw=
Date:   Fri, 18 Jan 2019 13:07:22 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>, Rob Herring <robh@kernel.org>
Subject: [GIT PULL] PCI fixes for v5.0
Message-ID: <20190118190722.GA52844@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI fixes:

  - Fix PCI kconfig menu organization (Rob Herring)

  - Fix pci_alloc_irq_vectors_affinity() error return to allow "reduce and
    retry" for drivers using IRQ sets (Ming Lei)

  - Fix "pci=disable_acs_redir" initdata use-after-free problem (Logan
    Gunthorpe)


The following changes since commit a3869d43c9800cf39496615361c83635fa3e7c82:

  PCI: amlogic: Fix build failure due to missing gpio header (2019-01-08 09:01:44 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.0-fixes-2

for you to fetch changes up to d2fd6e81912a665993b24dcdc1c1384a42a54f7e:

  PCI: Fix __initdata issue with "pci=disable_acs_redir" parameter (2019-01-17 08:46:34 -0600)

----------------------------------------------------------------
pci-v5.0-fixes-2

----------------------------------------------------------------
Logan Gunthorpe (1):
      PCI: Fix __initdata issue with "pci=disable_acs_redir" parameter

Ming Lei (1):
      PCI/MSI: Return -ENOSPC from pci_alloc_irq_vectors_affinity()

Rob Herring (1):
      PCI: Fix PCI kconfig menu organization

 drivers/pci/Kconfig | 22 ++++++++--------------
 drivers/pci/msi.c   | 22 +++++++++++++---------
 drivers/pci/pci.c   |  3 ++-
 3 files changed, 23 insertions(+), 24 deletions(-)
