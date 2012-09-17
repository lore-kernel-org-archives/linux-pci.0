Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12419 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753492Ab2IQIys (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 17 Sep 2012 04:54:48 -0400
From: Huang Ying <ying.huang@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Huang Ying <ying.huang@intel.com>
Subject: [RFC 0/3] PCI/PM: RTD3 fixes/changes for 3.7
Date: Mon, 17 Sep 2012 16:54:33 +0800
Message-Id: <1347872076-5260-1-git-send-email-ying.huang@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[RFC 1/3] PCI/PM: Fix kexec for D3cold and bridge suspending
[RFC 2/3] PCI/PM: Make PCI devices notified when its power
[RFC 3/3] PCI/PM: Disable PME poll for PCIe devices

Best Regards,
Huang Ying
