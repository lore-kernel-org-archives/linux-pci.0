Return-Path: <SRS0=vBCh=MJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A328C43382
	for <linux-pci@archiver.kernel.org>; Thu, 27 Sep 2018 19:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECFC21710
	for <linux-pci@archiver.kernel.org>; Thu, 27 Sep 2018 19:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="exa2LU5m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ECFC21710
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeI1Bvp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:51:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728505AbeI1Bvp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Sep 2018 21:51:45 -0400
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2270421708;
        Thu, 27 Sep 2018 19:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538076715;
        bh=ym4OWNzHRLkPbA1kxTcVwHUWoP9wAjcFzK1y7wGSkaI=;
        h=Date:From:To:Cc:Subject:From;
        b=exa2LU5m+2uJKrS+WixjgIqI670YNTNeCihjdEzNUdnuTAyZIqrN36sOr+WSWugJs
         RfXGUzwm/xV5/gg1IUp3Fgl3wK/wWNul5eeX8qhwDKN3/2+qDzFKjhSPoisuX5sv+X
         tOOaKyacot+D0XRdcuwNDhnE/qGy4imG2gBgNSew=
Date:   Thu, 27 Sep 2018 14:31:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Peter Anemone <peter.anemone@gmail.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>
Subject: [GIT PULL] PCI fixes for v4.19
Message-ID: <20180927193154.GA30598@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI fixes:

  - Fix ACPI hotplug issue that causes black screen crash at boot (Mika
    Westerberg)

  - Fix DesignWare "scheduling while atomic" issues (Jisheng Zhang)

  - Add PPC contacts to MAINTAINERS for PCI core error handling (Bjorn
    Helgaas)

  - Sort Mobiveil MAINTAINERS entry (Lorenzo Pieralisi)


The following changes since commit 7876320f88802b22d4e2daf7eb027dd14175a0f8:

  Linux 4.19-rc4 (2018-09-16 11:52:37 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.19-fixes-2

for you to fetch changes up to f188b99f0b2d33794b4af8a225f95d1e968c0a3f:

  ACPI / hotplug / PCI: Don't scan for non-hotplug bridges if slot is not bridge (2018-09-26 15:39:28 -0500)

----------------------------------------------------------------
pci-v4.19-fixes-2

----------------------------------------------------------------
Bjorn Helgaas (1):
      MAINTAINERS: Update PPC contacts for PCI core error handling

Jisheng Zhang (1):
      PCI: dwc: Fix scheduling while atomic issues

Lorenzo Pieralisi (1):
      MAINTAINERS: Move mobiveil PCI driver entry where it belongs

Mika Westerberg (1):
      ACPI / hotplug / PCI: Don't scan for non-hotplug bridges if slot is not bridge

 MAINTAINERS                                  | 20 +++++++++++++-------
 drivers/pci/controller/dwc/pcie-designware.c |  8 ++++----
 drivers/pci/controller/dwc/pcie-designware.h |  3 +--
 drivers/pci/hotplug/acpiphp_glue.c           | 11 ++++++-----
 4 files changed, 24 insertions(+), 18 deletions(-)
