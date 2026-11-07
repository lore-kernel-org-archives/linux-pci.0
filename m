Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.69.126.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794026141;
	b=kspq9S4D3K1s4lZgY1bJ688oRmZaiND9gzxWknc0iWjYOCnNBB7qnSpo4kurddd8WgaH
	 0murEDX7+j8BL4YvJuy0LOyI8k8upVH7DXiZZxjVEpn82OZ0JaEBkGYcj93FZSl0fRkL4
	 mOZRlx9kk7jwZP1UpWRwUZq/eOpZKBcobHOgRLvrXizNRXfXLDHLSfhQDMmXN0qbUYhTX
	 A5dJgAMaxrkzbdFM1H8z1yLzckRQxGbF42jjGU0yN7CtfsQ144z6RsSR1y62F5AWl+twy
	 faOByowcda2bHBACb3nvFXkRO4fKwtx5jMFmTQPUcgj78vugCMEqPY4FVl2eidk0z0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794026141;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=MvHfwqxnITLEmZ60YMsWy2FLliYhfwUeFt5wDcWcge0=;
	b=mEiYV7SM33qUioLBmJpuMCYYDiQH/kIxM2fTbkChiCmlPMmBwUGouENeqdUA4fJpBL2p
	 ckKkDeUzr72u92LS3rSWKV8lw91ih4JO/bPSlFcnvGCZZwCvEG0wkkc2bUMHSpCI6nxkm
	 jsj3p+a52XxPSoJsTcc9BrDmLvW8ubtKq5v/cXPvFTAlp7ug/HXfFgmTm/QuuJXXNG/aB
	 VcF0OcWSbuePIqofJC/DZLIWBgSN2Kz4uXX/CL0iB8pOYaKoswTCyEe0tietTm1yCtyQB
	 +ClIbNnkSBqaDv15apB2LNE9CEnxr0QVPaKyN2wIiFnq0cE3menwwzDXqSC4fCY0HPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=weissschuh.net;
	spf=pass smtp.mailfrom=weissschuh.net;
	dkim=pass header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=kxQ7+oKU;
	arc=none smtp.remote-ip=159.69.126.157
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F53F606A326;
	Sat,  7 Nov 2026 04:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F53F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=kxQ7+oKU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1794026137;
	bh=xGrqAPM3/yGheJqqlcuYYHnksr4oG20RsPZFgl1bBFA=;
	h=From:Date:Subject:To:Cc:From;
	b=kxQ7+oKUB2lJmNxhxL2SoviSmJUWyUjxQLNq2XXyVdYAJPnamdBhHUiki7IY8OHnR
	 xWNuGarXF2STBAdzSQEnhVn+X6cWQT9I0f0VKEAU62wElSqz522iwEJfFz06CIuvgB
	 LT0o1AhAvusGgkhJYVq2LqxOl3FxOkXlAmGgVbow=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 07 Nov 2026 04:35:29 +0000
Subject: [PATCH] PCI: Constify struct configfs_attribute pointers
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261107-configfs-const-pci-v1-1-8545f5886a01@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NywqDMBREf0Xu2kCSgn38SnGhcWJvF9HmRhHEf
 2987ObAzJmVBJEh9CpWiphZeAgZTFmQ+zShh+IuM1ltK2P0XbkheO697EGSGh2rzlYej+dNaxj
 KwzHC83JI3/XJMrVfuLSbrkbEb8pv6apt2x+t31axiwAAAA==
X-Change-ID: 20261107-configfs-const-pci-d26fe89300e1
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794026133; l=4715;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=xGrqAPM3/yGheJqqlcuYYHnksr4oG20RsPZFgl1bBFA=;
 b=CnEILBanyVprfAhdyywENhFkctXXmmJIZezCMhgVADEPc/UkO7wl0pf5NV9HrHuCaMm3PhT5s
 RVbXszA4HmAD0k5scdpngNXILSm5UiBba/BuFDCEZEDkbrkgR14+R1g
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

In preparation for the constification of configfs attributes, make the
pointers to struct configfs_attribute in drivers/pci/ const
and use the new ct_attrs_const field of struct config_item_type.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/pci/endpoint/functions/pci-epf-ntb.c  | 4 ++--
 drivers/pci/endpoint/functions/pci-epf-test.c | 4 ++--
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 4 ++--
 drivers/pci/endpoint/pci-ep-cfs.c             | 8 ++++----
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index 5314aca2188a..ae3efbe4ef41 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -1984,7 +1984,7 @@ CONFIGFS_ATTR(epf_ntb_, mw2);
 CONFIGFS_ATTR(epf_ntb_, mw3);
 CONFIGFS_ATTR(epf_ntb_, mw4);
 
-static struct configfs_attribute *epf_ntb_attrs[] = {
+static const struct configfs_attribute *const epf_ntb_attrs[] = {
 	&epf_ntb_attr_spad_count,
 	&epf_ntb_attr_db_count,
 	&epf_ntb_attr_num_mws,
@@ -1996,7 +1996,7 @@ static struct configfs_attribute *epf_ntb_attrs[] = {
 };
 
 static const struct config_item_type ntb_group_type = {
-	.ct_attrs	= epf_ntb_attrs,
+	.ct_attrs_const	= epf_ntb_attrs,
 	.ct_owner	= THIS_MODULE,
 };
 
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index d4905aa8e4c0..a97a986ddf51 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -1441,7 +1441,7 @@ CONFIGFS_ATTR(pci_epf_test_, bar3_size);
 CONFIGFS_ATTR(pci_epf_test_, bar4_size);
 CONFIGFS_ATTR(pci_epf_test_, bar5_size);
 
-static struct configfs_attribute *pci_epf_test_attrs[] = {
+static const struct configfs_attribute *const pci_epf_test_attrs[] = {
 	&pci_epf_test_attr_bar0_size,
 	&pci_epf_test_attr_bar1_size,
 	&pci_epf_test_attr_bar2_size,
@@ -1452,7 +1452,7 @@ static struct configfs_attribute *pci_epf_test_attrs[] = {
 };
 
 static const struct config_item_type pci_epf_test_group_type = {
-	.ct_attrs	= pci_epf_test_attrs,
+	.ct_attrs_const	= pci_epf_test_attrs,
 	.ct_owner	= THIS_MODULE,
 };
 
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index f77e28f2fe96..31f527ae34c8 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1314,7 +1314,7 @@ CONFIGFS_ATTR(epf_ntb_, mw2_bar);
 CONFIGFS_ATTR(epf_ntb_, mw3_bar);
 CONFIGFS_ATTR(epf_ntb_, mw4_bar);
 
-static struct configfs_attribute *epf_ntb_attrs[] = {
+static const struct configfs_attribute *const epf_ntb_attrs[] = {
 	&epf_ntb_attr_spad_count,
 	&epf_ntb_attr_db_count,
 	&epf_ntb_attr_num_mws,
@@ -1335,7 +1335,7 @@ static struct configfs_attribute *epf_ntb_attrs[] = {
 };
 
 static const struct config_item_type ntb_group_type = {
-	.ct_attrs	= epf_ntb_attrs,
+	.ct_attrs_const	= epf_ntb_attrs,
 	.ct_owner	= THIS_MODULE,
 };
 
diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index 590e5bde57ef..44f68188f307 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -210,7 +210,7 @@ static ssize_t pci_epc_start_show(struct config_item *item, char *page)
 
 CONFIGFS_ATTR(pci_epc_, start);
 
-static struct configfs_attribute *pci_epc_attrs[] = {
+static const struct configfs_attribute *const pci_epc_attrs[] = {
 	&pci_epc_attr_start,
 	NULL,
 };
@@ -263,7 +263,7 @@ static const struct configfs_item_operations pci_epc_item_ops = {
 
 static const struct config_item_type pci_epc_type = {
 	.ct_item_ops	= &pci_epc_item_ops,
-	.ct_attrs	= pci_epc_attrs,
+	.ct_attrs_const	= pci_epc_attrs,
 	.ct_owner	= THIS_MODULE,
 };
 
@@ -458,7 +458,7 @@ CONFIGFS_ATTR(pci_epf_, interrupt_pin);
 CONFIGFS_ATTR(pci_epf_, msi_interrupts);
 CONFIGFS_ATTR(pci_epf_, msix_interrupts);
 
-static struct configfs_attribute *pci_epf_attrs[] = {
+static const struct configfs_attribute *const pci_epf_attrs[] = {
 	&pci_epf_attr_vendorid,
 	&pci_epf_attr_deviceid,
 	&pci_epf_attr_revid,
@@ -515,7 +515,7 @@ static const struct configfs_item_operations pci_epf_ops = {
 
 static const struct config_item_type pci_epf_type = {
 	.ct_item_ops	= &pci_epf_ops,
-	.ct_attrs	= pci_epf_attrs,
+	.ct_attrs_const	= pci_epf_attrs,
 	.ct_owner	= THIS_MODULE,
 };
 

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
change-id: 20261107-configfs-const-pci-d26fe89300e1

Best regards,
--  
Thomas Weißschuh <linux@weissschuh.net>

