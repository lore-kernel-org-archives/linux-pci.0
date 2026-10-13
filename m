Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7EE4AA569;
	Tue, 13 Oct 2026 22:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791929086; cv=none; b=OaEk8wQOabAaMbL8+xwClZ5cwJSouteG2LoUwKIMHimJVyrqrA7B2tcz++UOeUnfP8kt88dfVYO1hcTp4rby7upz2nlXm00c6ZoD50dNCmNmpdFoJndp+H2BMX05TMJjWPcql/UOngM2Pijd5GxgdeiuOnFsWO4iAAlqeKAJy0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791929086; c=relaxed/simple;
	bh=HVOXoGGqXAbKyXaSWnQO73VXFtknSn+jRczq2JTRjEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pO6cGYaffKMukUEm1ZsbUGI1kyw5DCRgDMqVDhnL9P1XxyVTKIkefAET/MKdaYjx/Bizh89QVsg/wJHqqXcp6GcwgN2hgflZndpacrnFBPL+RR/Ki291ETzIt70F819qAd6AoQos4v7NLjvoz/EHMz4vzG/jk+GKdg86Z+3XfqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtVDUylQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtVDUylQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A9D1F00893;
	Tue, 13 Oct 2026 22:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791929084;
	bh=tnLWPN74AHBIaLDvOBtrD1EbTBWBcfnhxcDXArDXl2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mtVDUylQ1lNJPnFZhMPcXLIn4u86dWSvceE9nvzxhE5YBHr73m2pCRkZRu6RFNDMp
	 j1dqv0gpnbmxcWx8Rx9dCj/BsRqhzfLROYVpKrKX1Z2NN2+4klYtTJVNQpLPetFekZ
	 PhpOpF4vWN/P0rnHhYGkRlg6kgHORwRBdc211CGsLSIZ5rOjH07yA0VlBwYStap/tY
	 FGAAqnE381c4yLjtQFRK4rb6Te2Ej4x3n6qrdeQO/HPwBGV3/HZZ92pfhgg6e/ZDb7
	 1z7j+gkU1yqw+bO3q4tn8/xDGKHo9D557kmBoOZH6mts0JX7XCsNcsKZswi4xyeVUt
	 Jalxvqg4duumA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Semih Baskan <strst.gs@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Rosen Penev <rosenp@gmail.com>,
	Rani Hod <rani.hod@gmail.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v4 1/2] PCI: Expose devm_pci_alloc_host_bridge_release()
Date: Tue, 13 Oct 2026 17:04:20 -0500
Message-ID: <20261013220421.1588051-2-bhelgaas@google.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013220421.1588051-1-bhelgaas@google.com>
References: <20261013220421.1588051-1-bhelgaas@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_pci_alloc_host_bridge() allocates a struct pci_host_bridge and also
parses device tree resources and claims them.  There are drivers, e.g.,
pcie-iproc-bcma.c, that need to allocate a pci_host_bridge but do not need
device tree resources.

Expose devm_pci_alloc_host_bridge_release() so they can avoid the device
tree parts by calling pci_alloc_host_bridge() directly and adding the devm
release function manually.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.h   | 1 +
 drivers/pci/probe.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ba3c3fddddc2..5e21cd29cc7c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -502,6 +502,7 @@ enum pci_bar_type {
 	pci_bar_mem64,		/* A 64-bit memory BAR */
 };
 
+void devm_pci_alloc_host_bridge_release(void *data);
 struct device *pci_get_host_bridge_device(struct pci_dev *dev);
 void pci_put_host_bridge_device(struct device *dev);
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5af..e214da95ca94 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -696,7 +696,7 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
 }
 EXPORT_SYMBOL(pci_alloc_host_bridge);
 
-static void devm_pci_alloc_host_bridge_release(void *data)
+void devm_pci_alloc_host_bridge_release(void *data)
 {
 	pci_free_host_bridge(data);
 }
-- 
2.53.0

