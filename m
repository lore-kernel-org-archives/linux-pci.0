Return-Path: <SRS0=IfUz=OK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DD5C04EB9
	for <linux-pci@archiver.kernel.org>; Sat,  1 Dec 2018 05:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2A32146D
	for <linux-pci@archiver.kernel.org>; Sat,  1 Dec 2018 05:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w5uD6uOj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2A32146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbeLARLk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 1 Dec 2018 12:11:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:43546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbeLARLj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 1 Dec 2018 12:11:39 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFD6A2081D;
        Sat,  1 Dec 2018 05:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543643995;
        bh=Pg3d1Bs6TfgaZQkWBTvhasrsnC6KkCRnsSJouqdeUWo=;
        h=Date:From:To:Cc:Subject:From;
        b=w5uD6uOjyksUMdDMrR0fYiw+hc5b7s43HsdS7FvceA3Wmuv+hTsSe7FCwu+kppdEW
         I07zYcaIt+XnOAlfXjbW3I85Z852iSQoNDWzALuzaOic9ktF0vr/CkBRfUHHNid0vK
         Cuvr+SqC3GUqVhs8DaHRWYz8LbRIWbTyTuO/UPc0=
Date:   Fri, 30 Nov 2018 23:59:53 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [GIT PULL] PCI fixes for v4.20
Message-ID: <20181201055953.GA207198@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI fixes:

  - Fix a link speed checking interface that broke PCIe gen3 cards in gen1
    slots (Mikulas Patocka)

  - Fix an imx6 link training error (Trent Piepho)

  - Fix a layerscape outbound window accessor calling error (Hou Zhiqiang)

  - Fix a DesignWare endpoint MSI-X address calculation error (Gustavo
    Pimentel)


The following changes since commit 0d76bcc960e6057750fcf556b65da13f8bbdfd2b:

  Revert "ACPI/PCI: Pay attention to device-specific _PXM node values" (2018-11-13 08:38:17 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.20-fixes-2

for you to fetch changes up to c74eadf881ad634c68880e2c1b504989d95993ee:

  Merge remote-tracking branch 'lorenzo/pci/controller-fixes' into for-linus (2018-11-30 23:42:08 -0600)

----------------------------------------------------------------
pci-v4.20-fixes-2

----------------------------------------------------------------
Bjorn Helgaas (1):
      Merge remote-tracking branch 'lorenzo/pci/controller-fixes' into for-linus

Gustavo Pimentel (1):
      PCI: dwc: Fix MSI-X EP framework address calculation bug

Hou Zhiqiang (1):
      PCI: layerscape: Fix wrong invocation of outbound window disable accessor

Mikulas Patocka (1):
      PCI: Fix incorrect value returned from pcie_get_speed_cap()

Trent Piepho (1):
      PCI: imx6: Fix link training status detection in link up check

 drivers/pci/controller/dwc/pci-imx6.c           | 10 +---------
 drivers/pci/controller/dwc/pci-layerscape.c     |  2 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c |  1 -
 drivers/pci/pci.c                               | 24 +++++++++++-------------
 4 files changed, 13 insertions(+), 24 deletions(-)
