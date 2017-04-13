Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jayachandran C <jnair@caviumnetworks.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v5 0/2] Handle Cavium ThunderX2 PCI topology quirk
Date: Thu, 13 Apr 2017 20:30:43 +0000
Message-Id: <1492115445-4069-1-git-send-email-jnair@caviumnetworks.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Jon Masters <jcm@redhat.com>, Joerg Roedel <joro@8bytes.org>,
 iommu@lists.linux-foundation.org, Jayachandran C <jnair@caviumnetworks.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Here's v5 of the patchset with an updated commit message based on your
suggestion. I have added a paragraph at the end about MSI-X as well.

This is the newest in the series based on the discussion here:
https://www.spinics.net/lists/arm-kernel/msg575581.html

Previous discussions and patches:
http://www.spinics.net/lists/linux-pci/msg51001.html
https://patchwork.ozlabs.org/patch/582633/ and
https://lists.linuxfoundation.org/pipermail/iommu/2016-June/017681.html

Let me know if I missed anything, Thanks,
JC.

v4->v5:
 - updated commit message for patch 2/2

v3->v4:
 - new address of author

v2>v3:
 - changed device flag name from PCI_DEV_FLAGS_DMA_ALIAS_ROOT to
   PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT
 - updated commit message to make the quirk clearer.
 
Jayachandran C (2):
  PCI: Add device flag PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT
  PCI: quirks: Fix ThunderX2 dma alias handling

 drivers/pci/quirks.c | 14 ++++++++++++++
 drivers/pci/search.c |  4 ++++
 include/linux/pci.h  |  2 ++
 3 files changed, 20 insertions(+)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
