Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:58440 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754122Ab3D0JO5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 27 Apr 2013 05:14:57 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
	<jiang.liu@huawei.com>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 0/7] Add hostbridge resource release to support root bus hotplug in IA64
Date: Sat, 27 Apr 2013 17:12:22 +0800
Message-ID: <1367053949-38424-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjron,
   This patchset mainly to add hostbridge resource release to support root bus hotplug
in IA64. Just based your suggestion, link:http://marc.info/?l=linux-pci&m=134506155529536&w=2
I'm very sorry to send the new version patchset late. Currently, hotplug root bus code has been 
in kernel, But in IA64, lack the hostbridge resource code. So we cannot hot add root bus because
resource confict report.

This patchset based your pci-next branch code.


Jiang Liu (1):
  PCI/IA64: fix memleak for create pci root bus fail

Yijing Wang (6):
  PCI/X86: fix always use info->res[0] to store _CRS resource when
    pci=nocrs set
  PCI/IA64: SN: remove sn_pci_window_fixup()
  PCI/IA64: make pci_root_info holds pci hostbridge resources
  PCI/IA64: Allocate pci_root_info instead of using stack
  PCI/IA64: add host bridge resource release for _CRS path
  PCI/IA64: introduce probe_pci_root_info() to manage  _CRS resource

 arch/ia64/include/asm/pci.h   |   20 +++-
 arch/ia64/pci/pci.c           |  221 +++++++++++++++++++++++++++--------------
 arch/ia64/sn/kernel/io_init.c |  106 +++++++-------------
 arch/x86/pci/acpi.c           |    7 +-
 4 files changed, 199 insertions(+), 155 deletions(-)


