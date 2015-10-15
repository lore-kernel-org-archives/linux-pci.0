Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Marc Zyngier <marc.zyngier@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>
Cc: Ma Jun <majun258@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC 6/7] platform-msi: Allow creation of a MSI-based stacked irq domain
Date: Thu, 15 Oct 2015 16:39:27 +0100
Message-Id: <1444923568-17413-7-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com>
References: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We almost have all the needed bits to be able to create a irq domain
on top of a MSI domain.

For this, we enable a few things:
- the virq is stored in the msi_desc
- device, msi_alloc_info and domain-specific data
  are stored in the platform_pric_data structure
- we introduce a new API for platform-msi:

  /* Create a MSI-based domain */
  struct irq_domain *
  platform_msi_create_device_domain(struct device *dev,
                                    unsigned int nvec,
                                    irq_write_msi_msg_t write_msi_msg,
                                    const struct irq_domain_ops *ops,
                                    void *host_data);

  /* Allocate MSIs in an MSI domain */
  int platform_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
                              unsigned int nr_irqs);

  /* Obtain the host data passed to platform_msi_create_device_domain */
  void *platform_msi_get_host_data(struct irq_domain *domain);

This now allows a wired irq to MSI bridge to be created.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/base/platform-msi.c | 71 +++++++++++++++++++++++++++++++++++++++++++--
 include/linux/msi.h         | 10 +++++++
 2 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 92666cd..29e9b63 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -32,6 +32,9 @@
  * and the callback to write the MSI message.
  */
 struct platform_msi_priv_data {
+	struct device		*dev;
+	void 			*host_data;
+	msi_alloc_info_t	arg;
 	irq_write_msi_msg_t	write_msg;
 	int			devid;
 };
@@ -124,8 +127,9 @@ static void platform_msi_free_descs(struct device *dev, int base, int nvec)
 	}
 }
 
-static int platform_msi_alloc_descs(struct device *dev, int nvec,
-				    struct platform_msi_priv_data *data)
+static int platform_msi_alloc_descs_with_irq(struct device *dev, int virq,
+					     int nvec,
+					     struct platform_msi_priv_data *data)
 
 {
 	struct msi_desc *desc;
@@ -145,6 +149,7 @@ static int platform_msi_alloc_descs(struct device *dev, int nvec,
 		desc->platform.msi_priv_data = data;
 		desc->platform.msi_index = base + i;
 		desc->nvec_used = 1;
+		desc->irq = virq ? virq + i : 0;
 
 		list_add_tail(&desc->list, dev_to_msi_list(dev));
 	}
@@ -159,6 +164,13 @@ static int platform_msi_alloc_descs(struct device *dev, int nvec,
 	return 0;
 }
 
+static int platform_msi_alloc_descs(struct device *dev, int nvec,
+				    struct platform_msi_priv_data *data)
+
+{
+	return platform_msi_alloc_descs_with_irq(dev, 0, nvec, data);
+}
+
 /**
  * platform_msi_create_irq_domain - Create a platform MSI interrupt domain
  * @fwnode:		Optional fwnode of the interrupt controller
@@ -225,6 +237,7 @@ static int platform_msi_alloc_priv_data(struct device *dev, unsigned int nvec,
 	}
 
 	datap->write_msg = write_msi_msg;
+	datap->dev = dev;
 
 	return 0;
 }
@@ -288,3 +301,57 @@ void platform_msi_domain_free_irqs(struct device *dev)
 	msi_domain_free_irqs(dev->msi_domain, dev);
 	platform_msi_free_descs(dev, 0, MAX_DEV_MSIS);
 }
+
+void *platform_msi_get_host_data(struct irq_domain *domain)
+{
+	struct platform_msi_priv_data *data = domain->host_data;
+	return data->host_data;
+}
+
+struct irq_domain *
+platform_msi_create_device_domain(struct device *dev,
+				  unsigned int nvec,
+				  irq_write_msi_msg_t write_msi_msg,
+				  const struct irq_domain_ops *ops,
+				  void *host_data)
+{
+	struct platform_msi_priv_data *data;
+	struct irq_domain *domain;
+	int err;
+
+	err = platform_msi_alloc_priv_data(dev, nvec, write_msi_msg, &data);
+	if (err)
+		return NULL;
+
+	data->host_data = host_data;
+	domain = irq_domain_create_hierarchy(dev->msi_domain, 0, nvec,
+					     of_node_to_fwnode(dev->of_node),
+					     ops, data);
+	if (!domain) {
+		platform_msi_free_priv_data(data);
+		return NULL;
+	}
+
+	/* FIXME: Add better error handling... */
+	err = msi_domain_prepare_irqs(domain->parent, dev, nvec, &data->arg);
+	BUG_ON(err);
+
+	return domain;
+}
+
+int platform_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
+			      unsigned int nr_irqs)
+{
+	struct platform_msi_priv_data *data = domain->host_data;
+	int err;
+
+	err = platform_msi_alloc_descs_with_irq(data->dev, virq, nr_irqs, data);
+	if (err)
+		return err;
+
+	err = msi_domain_populate_irqs(domain->parent, data->dev,
+				       virq, nr_irqs, &data->arg);
+	/* FIXME: memory leak on error */
+	return err;
+}
+
diff --git a/include/linux/msi.h b/include/linux/msi.h
index e35558c..594b2113 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -172,6 +172,7 @@ struct msi_controller {
 #include <asm/msi.h>
 
 struct irq_domain;
+struct irq_domain_ops;
 struct irq_chip;
 struct device_node;
 struct fwnode_handle;
@@ -283,6 +284,15 @@ int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
 			    int nvec, msi_alloc_info_t *args);
 int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
 			     int virq, int nvec, msi_alloc_info_t *args);
+struct irq_domain *
+platform_msi_create_device_domain(struct device *dev,
+				  unsigned int nvec,
+				  irq_write_msi_msg_t write_msi_msg,
+				  const struct irq_domain_ops *ops,
+				  void *host_data);
+int platform_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
+			      unsigned int nr_irqs);
+void *platform_msi_get_host_data(struct irq_domain *domain);
 #endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
 
 #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
-- 
2.1.4

