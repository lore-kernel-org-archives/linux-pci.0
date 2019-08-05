Return-Path: <SRS0=UhFO=WB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA35C0650F
	for <linux-pci@archiver.kernel.org>; Mon,  5 Aug 2019 20:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C14A2147A
	for <linux-pci@archiver.kernel.org>; Mon,  5 Aug 2019 20:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565038350;
	bh=9CgsPpjxcm2VBvw+qYJalhj8ZNygZ+JCR3l2qjlHSkM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=nBJBTjaJ7oxzBevz6fqEuIc6A1h41ntBVRYFF0l3wHkiDCIDRv+eZ7yZaOU7a4YUp
	 iL+6z5g3Y6C5hpfCjNNiZ3Op1CKhwcqbmfK6ZJpD50qFMxF4fyn41PcVuq4HcmpCSo
	 fXITkb/h0XPoLUQJkGxs1zUHFbVkdzZXWSDY8BVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfHEUwa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 5 Aug 2019 16:52:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729566AbfHEUw3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Aug 2019 16:52:29 -0400
Received: from localhost (unknown [64.22.228.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0C6020C01;
        Mon,  5 Aug 2019 20:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565038349;
        bh=9CgsPpjxcm2VBvw+qYJalhj8ZNygZ+JCR3l2qjlHSkM=;
        h=From:To:Cc:Subject:Date:From;
        b=OeoJa4rJfTv/feVHKErtoJchuYCE1qlqpeyQ2+M8LbyRSDPX1aqdpwNmgg7E1fKqF
         ovSrj1H+OVwARRhHQOvYT9q22ZbtNR3eJg79PpxKl2zz73Ks7TbBKtB482hwaaZENp
         w+M9dknv1083JlUaLxET4q6jU0ZiAwUyzPO3dmco=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/5] PCI: Add PCI_ERROR_RESPONSE, check for errors
Date:   Mon,  5 Aug 2019 15:52:09 -0500
Message-Id: <20190805205214.194981-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Reads from a PCI device may fail if the device has been turned off (put
into D3cold), removed, or if some other error occurs.  The PCI host bridge
typically fabricates ~0 data to complete the CPU's read.

We check for that in a few places, but not in a consistent way.  This
series adds a PCI_ERROR_RESPONSE definition to make the checks more
consistent and easier to find.  Note that ~0 may indicate a PCI error, but
it may also be valid read data, so you need more information (such as
knowing that a register can never contain ~0) before concluding that it's
an error.

This series also adds some new checks for PCI_ERROR_RESPONSE in the power
management code because that code frequently encounters devices in D3cold,
where we previously misinterpreted ~0 data.

Bjorn Helgaas (5):
  PCI: Add PCI_ERROR_RESPONSE definition
  PCI / PM: Return error when changing power state from D3cold
  PCI / PM: Check for error when reading PME status
  PCI / PM: Check for error when reading Power State
  PCI / PM: Decode D3cold power state correctly

 drivers/pci/access.c                          | 13 +++----
 .../pci/controller/dwc/pcie-designware-host.c |  2 +-
 drivers/pci/controller/pci-aardvark.c         |  2 +-
 drivers/pci/controller/pci-mvebu.c            |  4 +-
 drivers/pci/controller/pci-thunder-ecam.c     | 20 +++++-----
 drivers/pci/controller/pci-thunder-pem.c      |  2 +-
 drivers/pci/controller/pcie-altera.c          |  2 +-
 drivers/pci/controller/pcie-iproc.c           |  2 +-
 drivers/pci/controller/pcie-mediatek.c        |  4 +-
 drivers/pci/controller/pcie-rcar.c            |  2 +-
 drivers/pci/controller/pcie-rockchip-host.c   |  2 +-
 drivers/pci/controller/vmd.c                  |  2 +-
 drivers/pci/hotplug/cpqphp_ctrl.c             | 12 +++---
 drivers/pci/hotplug/cpqphp_pci.c              | 20 +++++-----
 drivers/pci/hotplug/pciehp_hpc.c              |  6 +--
 drivers/pci/pci.c                             | 38 ++++++++++++-------
 drivers/pci/pcie/dpc.c                        |  3 +-
 drivers/pci/pcie/pme.c                        |  4 +-
 drivers/pci/probe.c                           |  4 +-
 drivers/pci/quirks.c                          |  2 +-
 include/linux/pci.h                           | 20 ++++++++++
 21 files changed, 98 insertions(+), 68 deletions(-)

-- 
2.22.0.770.g0f2c4a37fd-goog

