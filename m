Return-Path: <jonathan.derrick@intel.com>
Return-Path: <jonathan.derrick@intel.com>
From: Jon Derrick <jonathan.derrick@intel.com>
To: helgaas@kernel.org
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	keith.busch@intel.com,
	linux-pci@vger.kernel.org
Subject: [PATCH 0/3] VMD fixes
Date: Mon, 20 Jun 2016 09:39:50 -0600
Message-Id: <1466437193-17043-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,
This set has a few miscellaneous fixes for VMD for issues which fell-out
from various testing configurations.

Jon Derrick (1):
  vmd: Use lock save/restore in interrupt enable path

Keith Busch (2):
  vmd: Use x86_vector_domain as parent domain
  vmd: Separate MSI and MSI-x vector sharing

 arch/x86/pci/vmd.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

-- 
1.8.3.1
