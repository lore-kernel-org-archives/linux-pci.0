Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Oza Pawandeep <poza@codeaurora.org>
To: linux-pci@vger.kernel.org,
	okaya@codeaurora.org,
	timur@codeaurora.org
Subject: [PATCH v2 1/4] PCI: Add port service list node for pci_dev.
Date: Wed, 15 Nov 2017 10:26:45 +0530
Message-Id: <1510721808-27164-2-git-send-email-poza@codeaurora.org>
In-Reply-To: <1510721808-27164-1-git-send-email-poza@codeaurora.org>
References: <1510721808-27164-1-git-send-email-poza@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Oza Pawandeep <poza@codeaurora.org>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dongdong Liu <liudongdong3@huawei.com>, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds the list node to keep track of services registered to
pci port driver.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 14e0ea1..f772979 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1931,6 +1931,7 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 		return NULL;
 
 	INIT_LIST_HEAD(&dev->bus_list);
+	INIT_LIST_HEAD(&dev->service_list);
 	dev->dev.type = &pci_dev_type;
 	dev->bus = pci_bus_get(bus);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 96c9498..eb86a4b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -408,6 +408,8 @@ struct pci_dev {
 	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */
 	struct bin_attribute *res_attr_wc[DEVICE_COUNT_RESOURCE]; /* sysfs file for WC mapping of resources */
 
+	struct list_head service_list;	/* node in per-service list */
+
 #ifdef CONFIG_PCIE_PTM
 	unsigned int	ptm_root:1;
 	unsigned int	ptm_enabled:1;
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
