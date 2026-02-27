Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0768A329378;
	Fri, 27 Feb 2026 18:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772216420; cv=pass; b=D2nEFM0DwfY6lEeDJJ7vD92GIGHlxO9jW1U+8Whph11IJIX3rBy6n5KcOIqqUD2W90Pe3Q7IeQCSpW3vgQg83FF3yoyDPj3lTGtB6vCcydBtabp5d8Epz94zpjLV7TiJ13vj++qz281QAF8wCKtnuMWVswnqWOH5rYa3Ksb6f9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772216420; c=relaxed/simple;
	bh=jlBgykaoybBsE50JpU+s1pJbOK1ihHam1pIJPE9uJZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m2NbIvGqoaBpjuInFKPHTLhTO2CX00+FKobHoDoqKSVXEylCvHc430DIG75vHu5NtU8Fdf3OyG3pHxT0pAdmedNGZ2RRk13xDwq1Gh1L/5WghXkLZxHwB6Lw5kz4MkNHkZIFlxn48iOttE6mWoNd1iZmfsk/miUejakgZ+bfHr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=CsIqqo1e; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="CsIqqo1e"
ARC-Seal: i=1; a=rsa-sha256; t=1772216389; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fxIaR/JsenmVlaX9N7eMoANr82gCqzfnNJDxoPfieVAzxddyufIKfMwgG+r2jRe5SzphLWAaBzNAQ1On0zZLpG9VJ+cNhVMSJWkZkQTRh97MhAvRbDRli3BlASahkY3q49SFFxRQPNkjv7eB40sP4N9KXgIwEP7C+x955owmsas=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772216389; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nbSM/THfEdWQW3wugixnc0FOxvJ9hPfcGOFPI8AYuoY=; 
	b=nGOPYaGUmZgQ5KQcQ0xIu3kySx6i8ooBDoJtX2jS8QK3MyWoWXg70qOPDRGtndZWXJAaA5b14+U3lQaRh5M584NrCZGkWBoBo0cXnaeaASiz8jeNUqSENpUKvHo1j2GYO7UNjHUKrw1MoO7SeD4wSoG7Mt09WIftzXYn5/7rSEw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772216389;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=nbSM/THfEdWQW3wugixnc0FOxvJ9hPfcGOFPI8AYuoY=;
	b=CsIqqo1eGsusoIrpoIBB9gZl4IHRWFoEhcBAokKf1oeJtu41knxOHY5ouQIZHKRP
	9J6AWNnpjpV7N/SbCVSwhJPSi6XCbSLAAgQG0WiMo5FnxIOHWRevnaave7Y9tEkJqhE
	SzUgQBEFgpTfO/8AUxbNi+G1wrT8Lv67QLnCLS2Q=
Received: by mx.zohomail.com with SMTPS id 17722163883274.204326094009275;
	Fri, 27 Feb 2026 10:19:48 -0800 (PST)
From: Yao Zi <me@ziyao.cc>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Hans Zhang <18255117159@163.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Manikandan K Pillai <mpillai@cadence.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Inochi Amaoto <inochiama@gmail.com>,
	Han Gao <rabenda.cn@gmail.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v2 1/2] PCI: cadence: Support platform-specific hooks for RC init/deinit
Date: Fri, 27 Feb 2026 18:19:24 +0000
Message-ID: <20260227181925.52475-2-me@ziyao.cc>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227181925.52475-1-me@ziyao.cc>
References: <20260227181925.52475-1-me@ziyao.cc>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Support initialization and de-initialization hooks provided by
platform-specific drivers. Initialization ones run after everything
else has been set up for RC, but before it's probed by the PCI
subsystem, to allow platform drivers to easily override RC properties
like LNKCAP. De-initialization ones run before anything else has been
cleaned-up.

Signed-off-by: Yao Zi <me@ziyao.cc>
---
 drivers/pci/controller/cadence/pcie-cadence-host.c | 8 +++++++-
 drivers/pci/controller/cadence/pcie-cadence.h      | 7 +++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index db3154c1eccb..23ee5a9c240d 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -304,6 +304,8 @@ static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
 
 static void cdns_pcie_host_deinit(struct cdns_pcie_rc *rc)
 {
+	if (rc->ops->deinit)
+		rc->ops->deinit(rc);
 	cdns_pcie_host_deinit_address_translation(rc);
 	cdns_pcie_host_deinit_root_port(rc);
 }
@@ -316,7 +318,11 @@ int cdns_pcie_host_init(struct cdns_pcie_rc *rc)
 	if (err)
 		return err;
 
-	return cdns_pcie_host_init_address_translation(rc);
+	err = cdns_pcie_host_init_address_translation(rc);
+	if (err)
+		return err;
+
+	return rc->ops->init ? rc->ops->init(rc) : 0;
 }
 EXPORT_SYMBOL_GPL(cdns_pcie_host_init);
 
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 443033c607d7..7d8f8e87915b 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -100,6 +100,11 @@ struct cdns_pcie {
 	const  struct cdns_plat_pcie_of_data *cdns_pcie_reg_offsets;
 };
 
+struct cdns_pcie_rc_ops {
+	int	(*init)(struct cdns_pcie_rc *rc);
+	void	(*deinit)(struct cdns_pcie_rc *rc);
+};
+
 /**
  * struct cdns_pcie_rc - private data for this PCIe Root Complex driver
  * @pcie: Cadence PCIe controller
@@ -115,6 +120,7 @@ struct cdns_pcie {
  * @quirk_detect_quiet_flag: LTSSM Detect Quiet min delay set as quirk
  * @ecam_supported: Whether the ECAM is supported
  * @no_inbound_map: Whether inbound mapping is supported
+ * @ops: Platform-specific hooks to initialize/de-initialize PCIe Root Complex
  */
 struct cdns_pcie_rc {
 	struct cdns_pcie	pcie;
@@ -127,6 +133,7 @@ struct cdns_pcie_rc {
 	unsigned int		quirk_detect_quiet_flag:1;
 	unsigned int            ecam_supported:1;
 	unsigned int            no_inbound_map:1;
+	const struct cdns_pcie_rc_ops *ops;
 };
 
 /**
-- 
2.53.0

