Return-Path: <SRS0=81jy=LO=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=81jy=LO=intel.com=jonathan.derrick@kernel.org>
From: Jon Derrick <jonathan.derrick@intel.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Keith Busch <keith.busch@intel.com>,
	<linux-pci@vger.kernel.org>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH] VMD firmware first
Date: Thu, 30 Aug 2018 18:30:02 -0600
Message-Id: <1535675403-2903-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo, Keith,

I was hoping to wait for the host_bridge->add_device extensions but had to
expedite this. Could we see if we can get this into 4.19?

Jon Derrick (1):
  PCI/VMD: Set up firmware first if capable

 arch/x86/pci/common.c        | 17 ++++++++++++++++-
 drivers/pci/controller/vmd.c | 25 ++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 2 deletions(-)

-- 
1.8.3.1
