Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:40862 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753966Ab2HHBHv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 7 Aug 2012 21:07:51 -0400
From: Huang Ying <ying.huang@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Huang Ying <ying.huang@intel.com>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH -v3 0/4] PCI/PM: PCI D3cold support fixes for 3.6-rc1
Date: Wed,  8 Aug 2012 09:07:37 +0800
Message-Id: <1344388061-18981-1-git-send-email-ying.huang@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Changes:

v3:

- Add some comments per Rafael's comments.

v2:

- Change some pm_runtime_put to pm_runtime_put_sync per Alan and Rafael's comments.


[BUGFIX -v3 1/4] PCI/PM: enable D3/D3cold by default for most devices
[BUGFIX -v3 2/4] PCI/PM: Keep parent bridge active when probing device
[BUGFIX -v3 3/4] PCI/PM: Fix config reg access for D3cold and bridge suspending
[PATCH -v3 4/4] PCI/PM: Add ABI document for sysfs file d3cold_allowed

Best Regards,
Huang Ying
