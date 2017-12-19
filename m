Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Subject: [PATCH V4 26/26] PCI: Remove pci_get_bus_and_slot() function
Date: Tue, 19 Dec 2017 00:38:02 -0500
Message-Id: <1513661883-28662-27-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, open list <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Now that all users of pci_get_bus_and_slot() switched to
pci_get_domain_bus_and_slot(), it is now safe to remove this function.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 include/linux/pci.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 66cca1c..04cecbe 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -948,11 +948,6 @@ struct pci_dev *pci_get_subsys(unsigned int vendor, unsigned int device,
 struct pci_dev *pci_get_slot(struct pci_bus *bus, unsigned int devfn);
 struct pci_dev *pci_get_domain_bus_and_slot(int domain, unsigned int bus,
 					    unsigned int devfn);
-static inline struct pci_dev *pci_get_bus_and_slot(unsigned int bus,
-						   unsigned int devfn)
-{
-	return pci_get_domain_bus_and_slot(0, bus, devfn);
-}
 struct pci_dev *pci_get_class(unsigned int class, struct pci_dev *from);
 int pci_dev_present(const struct pci_device_id *ids);
 
@@ -1660,9 +1655,6 @@ static inline struct pci_bus *pci_find_next_bus(const struct pci_bus *from)
 static inline struct pci_dev *pci_get_slot(struct pci_bus *bus,
 						unsigned int devfn)
 { return NULL; }
-static inline struct pci_dev *pci_get_bus_and_slot(unsigned int bus,
-						unsigned int devfn)
-{ return NULL; }
 static inline struct pci_dev *pci_get_domain_bus_and_slot(int domain,
 					unsigned int bus, unsigned int devfn)
 { return NULL; }
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
