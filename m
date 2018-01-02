Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Subject: [PATCH V3 0/6] PCI: handle CRS response following Hot Reset and
 D3hot->D0
Date: Tue,  2 Jan 2018 12:00:17 -0500
Message-Id: <1514912423-13341-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Rev 3.1 Sec 2.3.1 Request Handling Rules:
Valid reset conditions after which a device is permitted to return CRS
are:
* Cold, Warm, and Hot Resets,
* FLR
* A reset initiated in response to a D3hot to D0 uninitialized

Try to reuse FLR implementation towards other reset types.

Changes from v2:
* Correct Conventional PCI spec reference for AF_FLR
* Commit message update to capitilize the first word following colon

Sinan Kaya (6):
  PCI: Protect restore with device lock to be consistent
  PCI: Handle FLR failure and allow other reset types
  PCI: Make pci_flr_wait() generic and rename to pci_dev_wait()
  PCI: Wait device ready after pci_pm_reset()
  PCI: Add a return type for pci_reset_bridge_secondary_bus()
  PCI: Add device wait after slot and bus reset

 drivers/pci/pci.c   | 70 ++++++++++++++++++++++++++++++++++-------------------
 include/linux/pci.h |  4 +--
 2 files changed, 47 insertions(+), 27 deletions(-)

-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
