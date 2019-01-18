Return-Path: <SRS0=ljL/=P2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F809C43444
	for <linux-pci@archiver.kernel.org>; Fri, 18 Jan 2019 04:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3545020883
	for <linux-pci@archiver.kernel.org>; Fri, 18 Jan 2019 04:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VKM2b2nk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfAREXj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Jan 2019 23:23:39 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45544 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfAREXj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Jan 2019 23:23:39 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so5736361plm.12
        for <linux-pci@vger.kernel.org>; Thu, 17 Jan 2019 20:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/jqvh7/0NjQjdCpoGQspuYu2IFibDkbh5kbwMcrLjXI=;
        b=VKM2b2nkX1xH83pwAMIxpfruj9iUZPkiiTK2G0hLM7JJlN9Gg/GA0pBqw5fNACHPQd
         +pyGZDshFmBVgucinblFcph9hAD7B0sziUo9XuQ/UzhRyMhVmB6Qt9Cv08leM+EtvZO6
         x5tWvZCOYlw9CA700kdt49aaZ+gtIwWVCzfc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/jqvh7/0NjQjdCpoGQspuYu2IFibDkbh5kbwMcrLjXI=;
        b=gR4Y4YTJPy2hLPVyEwIQuOcbqopzPpVoZjhWnyOhCeFzT/BKJ8CsnrkYelNRVBMUbj
         fTsmvdYWxsOj3VMnmfV/ATVK3FvA19OY1nncAjLri1DVfwk9gfy6nIG4tetT1GWOBhGx
         YWskU8GKkdGgn8us2UFAKeT+qryogZZ8RE+4j/FqM6caezoiNJdUdVs38Uh8G2sqXQ2l
         QQqaK9YW6Lf38csuIu7I7YtltVYrxspnUfW6cMhD1nx+2k/aA3XW/fpYTcIMckFhNkRG
         C/v/32ZYRIXFEbPihzqpGKRPh3RdWCFAsNs3Xhyrc+w0F88E+vFco6vurMsL/nWeRtI2
         GP3g==
X-Gm-Message-State: AJcUukdhOQeHkxavv+DJ73IrzlqViFTdDYe5SHSS2O9IBiFRjIPl3Yqx
        73hmBEgtdkXzeHoafwA6CsF7fA==
X-Google-Smtp-Source: ALg8bN4cBJQ3WiC2vw7SAqHoW5jy8L1mvx8QwYhSKji5IbLoGk1uOy9laDeX7ES4ON1d9QPYxFFtbQ==
X-Received: by 2002:a17:902:5601:: with SMTP id h1mr18131292pli.160.1547785418410;
        Thu, 17 Jan 2019 20:23:38 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id l19sm7339642pfi.71.2019.01.17.20.23.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Jan 2019 20:23:37 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH 1/3] PCI: iproc: Add feature to set order mode
Date:   Fri, 18 Jan 2019 09:53:21 +0530
Message-Id: <1547785403-32268-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547785403-32268-1-git-send-email-srinath.mannam@broadcom.com>
References: <1547785403-32268-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Order mode in RX header of incoming pcie packets can be override to
strict or loose order based on requirement.
Sysfs entry is provided to set dynamic and default order modes of upstream
traffic.

To improve performance in few endpoints we required to modify the
ordering attributes. Using this feature we can override order modes of RX
packets at IPROC RC.

Ex:
In PCIe based NVMe SSD endpoints data read/writes from disk is using
Queue pairs (submit/completion). After completion of block read/write,
EP writes completion command to completion queue to notify RC.
So that all data transfers before completion command write are not
required to strict order except completion command. It means previous all
packets before completion command write to RC should be written to memory
and acknowledged.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/pci/controller/pcie-iproc.c | 128 ++++++++++++++++++++++++++++++++++++
 drivers/pci/controller/pcie-iproc.h |  16 +++++
 2 files changed, 144 insertions(+)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index c20fd6b..13ce80f 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -57,6 +57,9 @@
 #define PCIE_DL_ACTIVE_SHIFT		2
 #define PCIE_DL_ACTIVE			BIT(PCIE_DL_ACTIVE_SHIFT)
 
+#define MPS_MRRS_CFG_MPS_SHIFT		0
+#define MPS_MRRS_CFG_MRRS_SHIFT		16
+
 #define APB_ERR_EN_SHIFT		0
 #define APB_ERR_EN			BIT(APB_ERR_EN_SHIFT)
 
@@ -91,6 +94,14 @@
 
 #define IPROC_PCIE_REG_INVALID		0xffff
 
+#define RO_FIELD(window)		BIT((window) << 1)
+#define RO_VALUE(window)		BIT(((window) << 1) + 1)
+/* All Windows are allowed */
+#define RO_ALL_WINDOW			0x33333333
+/* Wait on All Windows */
+#define RO_FIELD_ALL_WINDOW		0x11111111
+#define DYNAMIC_ORDER_MODE		0x5
+
 /**
  * iProc PCIe outbound mapping controller specific parameters
  *
@@ -295,6 +306,15 @@ enum iproc_pcie_reg {
 	/* enable APB error for unsupported requests */
 	IPROC_PCIE_APB_ERR_EN,
 
+	/* Ordering Mode configuration registers */
+	IPROC_PCIE_ORDERING_CFG,
+	IPROC_PCIE_MPS_MRRS_CFG,
+	IPROC_PCIE_IMAP0_RO_CONTROL,
+	IPROC_PCIE_IMAP1_RO_CONTROL,
+	IPROC_PCIE_IMAP2_RO_CONTROL,
+	IPROC_PCIE_IMAP3_RO_CONTROL,
+	IPROC_PCIE_IMAP4_RO_CONTROL,
+
 	/* total number of core registers */
 	IPROC_PCIE_MAX_NUM_REG,
 };
@@ -352,6 +372,13 @@ static const u16 iproc_pcie_reg_paxb_v2[] = {
 	[IPROC_PCIE_IMAP4]		= 0xe70,
 	[IPROC_PCIE_LINK_STATUS]	= 0xf0c,
 	[IPROC_PCIE_APB_ERR_EN]		= 0xf40,
+	[IPROC_PCIE_ORDERING_CFG]	= 0x2000,
+	[IPROC_PCIE_MPS_MRRS_CFG]	= 0x2008,
+	[IPROC_PCIE_IMAP0_RO_CONTROL]	= 0x201c,
+	[IPROC_PCIE_IMAP1_RO_CONTROL]	= 0x2020,
+	[IPROC_PCIE_IMAP2_RO_CONTROL]	= 0x2024,
+	[IPROC_PCIE_IMAP3_RO_CONTROL]	= 0x2028,
+	[IPROC_PCIE_IMAP4_RO_CONTROL]	= 0x202c,
 };
 
 /* iProc PCIe PAXC v1 registers */
@@ -1401,6 +1428,97 @@ static int iproc_pcie_rev_init(struct iproc_pcie *pcie)
 	return 0;
 }
 
+static
+ssize_t order_mode_show(struct device *dev,
+			struct device_attribute *attr,
+			char *buff)
+{
+	struct pci_host_bridge *host = to_pci_host_bridge(dev);
+	struct iproc_pcie *pcie = pci_host_bridge_priv(host);
+
+	return sprintf(buff, "Current PAXB order configuration %d\n",
+		       pcie->order_cfg);
+}
+
+static void pcie_iproc_set_dynamic_order(struct iproc_pcie *pcie)
+{
+	u32 val = 0, mps;
+
+	/* Set all IMAPs to relaxed order in dynamic order mode */
+	iproc_pcie_write_reg(pcie, IPROC_PCIE_ORDERING_CFG,
+			     DYNAMIC_ORDER_MODE);
+	iproc_pcie_write_reg(pcie, IPROC_PCIE_IMAP0_RO_CONTROL,
+			     RO_ALL_WINDOW);
+	iproc_pcie_write_reg(pcie, IPROC_PCIE_IMAP1_RO_CONTROL,
+			     RO_ALL_WINDOW);
+	iproc_pcie_write_reg(pcie, IPROC_PCIE_IMAP2_RO_CONTROL,
+			     RO_ALL_WINDOW);
+	iproc_pcie_write_reg(pcie, IPROC_PCIE_IMAP3_RO_CONTROL,
+			     RO_ALL_WINDOW);
+	iproc_pcie_write_reg(pcie, IPROC_PCIE_IMAP4_RO_CONTROL,
+			     RO_ALL_WINDOW);
+
+	/* PAXB MPS/MRRS settings configuration */
+	iproc_pci_raw_config_read32(pcie, 0, IPROC_PCI_EXP_CAP + PCI_EXP_DEVCTL,
+				    2, &mps);
+	mps = (mps & PCI_EXP_DEVCTL_PAYLOAD) >> 5;
+	/* set MRRS to match system MPS */
+	val |= (mps << MPS_MRRS_CFG_MRRS_SHIFT);
+	/* set MPS to 4096 bytes */
+	val |= (0x5 << MPS_MRRS_CFG_MPS_SHIFT);
+	iproc_pcie_write_reg(pcie, IPROC_PCIE_MPS_MRRS_CFG, val);
+}
+
+static
+ssize_t order_mode_store(struct device *dev,
+			 struct device_attribute *attr,
+			 const char *buf,
+			 size_t count)
+{
+	struct pci_host_bridge *host = to_pci_host_bridge(dev);
+	struct iproc_pcie *pcie = pci_host_bridge_priv(host);
+	unsigned long  val, regval;
+
+	if (kstrtoul(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	if (val > PAXB_ORDER_DEV_MEM_ONLY) {
+		dev_err(dev, "Invalid Value passed %lu\n", val);
+		dev_err(dev, "0: Everything in strict order\n");
+		dev_err(dev, "1: Only IMAP2 in strict order\n");
+		dev_err(dev, "2: Only device memory in strict order (MSI/MSIX)\n");
+		return -EINVAL;
+	}
+
+	if (val == pcie->order_cfg)
+		return count;
+
+	switch (val) {
+	case PAXB_ORDER_IMAP2_ONLY:
+		pcie_iproc_set_dynamic_order(pcie);
+		regval = RO_ALL_WINDOW;
+		regval &= ~(RO_VALUE(0));
+		/* Set IMAP2 to strict order */
+		iproc_pcie_write_reg(pcie, IPROC_PCIE_IMAP2_RO_CONTROL, regval);
+		dev_info(dev, "RO_IMAP2 set to %#lx\n", regval);
+		break;
+	case PAXB_ORDER_DEV_MEM_ONLY:
+		pcie_iproc_set_dynamic_order(pcie);
+		/* Set IMAP0 to strict order */
+		iproc_pcie_write_reg(pcie, IPROC_PCIE_IMAP0_RO_CONTROL,
+				     RO_FIELD_ALL_WINDOW);
+		dev_info(dev, "RO_IMAP0 set to %#x\n", RO_FIELD_ALL_WINDOW);
+		break;
+	default:
+		iproc_pcie_write_reg(pcie, IPROC_PCIE_ORDERING_CFG, 0);
+		break;
+	}
+	pcie->order_cfg = val;
+	return count;
+}
+
+static DEVICE_ATTR_RW(order_mode);
+
 int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 {
 	struct device *dev;
@@ -1484,6 +1602,11 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 
 	pci_bus_add_devices(host->bus);
 
+	if (pcie->type == IPROC_PCIE_PAXB_V2) {
+		ret = device_create_file(&host->dev, &dev_attr_order_mode);
+		if (ret < 0)
+			goto err_power_off_phy;
+	}
 	return 0;
 
 err_power_off_phy:
@@ -1496,6 +1619,11 @@ EXPORT_SYMBOL(iproc_pcie_setup);
 
 int iproc_pcie_remove(struct iproc_pcie *pcie)
 {
+	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
+
+	if (pcie->type == IPROC_PCIE_PAXB_V2)
+		device_remove_file(&host->dev, &dev_attr_order_mode);
+
 	pci_stop_root_bus(pcie->root_bus);
 	pci_remove_root_bus(pcie->root_bus);
 
diff --git a/drivers/pci/controller/pcie-iproc.h b/drivers/pci/controller/pcie-iproc.h
index 4f03ea5..6e100cd 100644
--- a/drivers/pci/controller/pcie-iproc.h
+++ b/drivers/pci/controller/pcie-iproc.h
@@ -24,6 +24,18 @@ enum iproc_pcie_type {
 };
 
 /**
+ * PAXB Dynamic ordering modes
+ * PAXB_ORDER_EVERYTHING: Everything in strict order
+ * PAXB_ORDER_IMAP2_ONLY: Only IMAP2 memory window strict order
+ * PAXB_ORDER_DEV_MEM_ONLY: Only device memory (MSI/MSIX) is strict order
+ */
+enum paxb_order_cfg {
+	PAXB_ORDER_EVERYTHING,
+	PAXB_ORDER_IMAP2_ONLY,
+	PAXB_ORDER_DEV_MEM_ONLY,
+};
+
+/**
  * iProc PCIe outbound mapping
  * @axi_offset: offset from the AXI address to the internal address used by
  * the iProc PCIe core
@@ -74,6 +86,8 @@ struct iproc_msi;
  * @ib: inbound mapping related parameters
  * @ib_map: outbound mapping region related parameters
  *
+ * @order_cfg: indicates current value of the order mode.
+ *
  * @need_msi_steer: indicates additional configuration of the iProc PCIe
  * controller is required to steer MSI writes to external interrupt controller
  * @msi: MSI data
@@ -102,6 +116,8 @@ struct iproc_pcie {
 	struct iproc_pcie_ib ib;
 	const struct iproc_pcie_ib_map *ib_map;
 
+	enum paxb_order_cfg order_cfg;
+
 	bool need_msi_steer;
 	struct iproc_msi *msi;
 };
-- 
2.7.4

