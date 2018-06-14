Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
From: Srinath Mannam <srinath.mannam@broadcom.com>
Date: Thu, 14 Jun 2018 15:37:28 +0530
Message-ID: <CABe79T41Cr0mjH_k2drzccHvObFwRcW3n+WKCj0JvFUBy0wz-A@mail.gmail.com>
Subject: Requirement to get BAR pci_bus_address in user space
To: Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
 Abhishek Shah <abhishek.shah@broadcom.com>,
 Vikram Prakash <vikram.prakash@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,


We observed an issue in NVMe CMD cards in SPDK NVMe libraries.
Similar issue fixed with "nvme-pci: Use PCI bus address for
data/queues in CMB" commit in nvme kernel driver.
As per the fix, pci_bus_address of CMB bar is required to program to NVMe cards.

We need to implement similar fix for SPDK NVMe libraries also.

User space libraries get pci device resource information (resource phy
address, resource size) from resource file in sysfs.
But no mechanism available to get  pci_bus_address of corresponding
resource physical address in sysfs.

Please suggest me if any alternate mechanism available to get
pci_bus_address in user space.

Thank you.

Regards,
Srinath.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
