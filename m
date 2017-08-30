Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jan Glauber <jglauber@cavium.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 0/3] Workaround for bus/slot reset on Cavium cn8xxx root
 ports
Date: Wed, 30 Aug 2017 16:24:51 +0200
Message-Id: <20170830142454.10971-1-jglauber@cavium.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: kvm@vger.kernel.org, david.daney@cavium.com, linux-pci@vger.kernel.org,
 Jan Glauber <jglauber@cavium.com>, Robert Richter <robert.richter@cavium.com>,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Jon Masters <jcm@redhat.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Using vfio-pci on a combination of cn8xxx and some PCI devices results in
a kernel panic. This is triggered by issuing a bus or a slot reset
on the PCI device.

The solution is to prevent the reset. I've dropped the vfio patch from the
previous series as vfio-pci already checks in the reset path for
pci_bus_resetable() and pci_slot_resetable().

With this series both checks indicate that the reset is not possible
preventing the kernel panic.

David Daney (2):
  PCI: Allow PCI_DEV_FLAGS_NO_BUS_RESET to be used on bus device
  PCI: Avoid bus reset for Cavium cn8xxx root ports

Jan Glauber (1):
  PCI: Avoid slot reset for Cavium cn8xxx root ports

 drivers/pci/pci.c    |  4 ++++
 drivers/pci/quirks.c | 24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

-- 
2.9.0.rc0.21.g7777322


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
