Return-Path: <SRS0=zNOM=TJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37A6C04AB1
	for <linux-pci@archiver.kernel.org>; Thu,  9 May 2019 14:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9996F2173B
	for <linux-pci@archiver.kernel.org>; Thu,  9 May 2019 14:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557411307;
	bh=ZXnms2XISoMk6lmGcs1t1uhWdI/ovHT0N4DlJSF6f8k=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hc1alVap/K1MS5GvLHCooeQpetP9s0WuSTrB61wpVBU4VGjQFqUpQe5qILv8/4utA
	 5ZQOllOQNcXKHrGgj0UgqUpW8qRhu6kGI1zHCRuJrRB+l1baeNleFcdFPUVSfLyc4C
	 OsN0STg4WyitbqDnA5lv8bTqXy30G38mJ4rYM3xw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfEIOPH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 9 May 2019 10:15:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbfEIOPG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 May 2019 10:15:06 -0400
Received: from localhost (50-81-63-4.client.mchsi.com [50.81.63.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA89E2085A;
        Thu,  9 May 2019 14:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557411306;
        bh=ZXnms2XISoMk6lmGcs1t1uhWdI/ovHT0N4DlJSF6f8k=;
        h=From:To:Cc:Subject:Date:From;
        b=BYqhr6yJtnMK9UwNZs49hVKIKBXD2DMrPECHO3EHvcSq6+SmLsmKB36d/GXXicxuY
         Ru6VeMd/3wjz3apl5FA3uOUgWL+tNnalynkzP8KCKa6Fbyiy3f1gzJrXC+YR7wjmwy
         DjIpKhO5RUqW42+NeThBB4tFe1YCNtxQWV4AxnZ0=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frederick Lawler <fred@fredlawl.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v4 00/10] PCI: Log with pci_dev, not pcie_device
Date:   Thu,  9 May 2019 09:14:46 -0500
Message-Id: <20190509141456.223614-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

This is a collection of updates to Fred's v2 patches from:

  https://lore.kernel.org/lkml/20190503035946.23608-1-fred@fredlawl.com

and some follow-on discussion.

Bjorn Helgaas (3):
  PCI: pciehp: Remove pciehp_debug uses
  PCI: pciehp: Remove pointless PCIE_MODULE_NAME definition
  PCI: pciehp: Remove pointless MY_NAME definition

Frederick Lawler (7):
  PCI/AER: Replace dev_printk(KERN_DEBUG) with dev_info()
  PCI/PME: Replace dev_printk(KERN_DEBUG) with dev_info()
  PCI/DPC: Log messages with pci_dev, not pcie_device
  PCI/AER: Log messages with pci_dev, not pcie_device
  PCI: pciehp: Replace pciehp_debug module param with dyndbg
  PCI: pciehp: Log messages with pci_dev, not pcie_device
  PCI: pciehp: Remove unused dbg/err/info/warn() wrappers

 drivers/pci/hotplug/pciehp.h      | 31 +++++++-------------------
 drivers/pci/hotplug/pciehp_core.c | 18 +++++++--------
 drivers/pci/hotplug/pciehp_ctrl.c |  2 ++
 drivers/pci/hotplug/pciehp_hpc.c  | 17 +++++++-------
 drivers/pci/hotplug/pciehp_pci.c  |  2 ++
 drivers/pci/pcie/aer.c            | 32 ++++++++++++++------------
 drivers/pci/pcie/aer_inject.c     | 22 +++++++++---------
 drivers/pci/pcie/dpc.c            | 37 +++++++++++++++----------------
 drivers/pci/pcie/pme.c            | 10 +++++----
 9 files changed, 82 insertions(+), 89 deletions(-)

-- 
2.21.0.1020.gf2820cf01a-goog

