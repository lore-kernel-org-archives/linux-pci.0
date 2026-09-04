Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D401D418348;
	Fri,  4 Sep 2026 06:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502734; cv=none; b=fMLDbTFbTrZN16XV3cm4gcJwGJcb9g83viQuz8IZh4ALx6/ylh0tzubEbdpPZJoPJRJuxQgABfZkK4AzV23R1POMxc0TqPKp690PuZMHU4gHj922sDuEQKkj4jFRjz8vDszRGueXZjO8mVj4aVSJilXxue5rqSdnFRp18UQ70KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502734; c=relaxed/simple;
	bh=BpS18fGjWNtEIyUyRinzNk5WFAg09+9GweH7/c72ceE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HRVhSHZwGb9UMjR1Auw2rEF4lbq6l+QgxBhYNiA/UEQEwDqXyep5t7G/ZOCqVaT4H4qFhv50T3AsKp6WNON7rso3MEFbRhMLBUwLzsq0jVrnKXH/p0FCVEKHzUi1BXV+ahPp2M9kWxpo/zBi4vrzSV8xqPjONQyLq+11Wih5MTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=if1EV0Zc; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="if1EV0Zc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Na
	0U1ETXArRsdJUYLyCrrAbVuZNbdkkOZjrPfMI7ItE=; b=if1EV0ZcpNrb+BYl9Z
	3VyCw2B4jpvKOA5XH0qV9H+KadA6UbT7El7WRfEtrXhA/9qElh9N6X/cQW6R+GDO
	lAGWF7yHEzsMM4NckoCWXsDotZZ6bgg1Cj6QRYoaDaizoIjUUYeC7gHNmI11i4/M
	hNI41LEb29okakAv1bznp/xr4=
Received: from Precision-7960.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDXKPWxYppqN_NZPw--.57876S2;
	Fri, 04 Sep 2026 14:18:25 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: jingoohan1@gmail.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org
Cc: robh@kernel.org,
	a-garg7@ti.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>,
	Feizhou Yu <yufeizhou201@163.com>
Subject: [PATCH] pci: dwc: Rename PCIE_PORT_LINK_CONTROL to PORT_LINK_CTRL_OFF
Date: Fri,  4 Sep 2026 14:18:23 +0800
Message-ID: <20260904061823.592216-1-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDXKPWxYppqN_NZPw--.57876S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuFyrAFy3Xr1ktFWUtFW3GFg_yoW5Cw4fpa
	y5tryFkF1DAa13Z3WYka4kZF1aq3ZxArWUGFs2gwnru3WfAry0gw18XFy3tr97XFWxtr4Y
	kr17ta47JFyfA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUjPfPUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BIGqWqaYrLRiwAA3r

The register at offset 0x710 is documented in the Synopsys DesignWare
PCIe Controller Reference Manual as "PORT_LINK_CTRL_OFF" (Port Link
Control Register). The current macro name PCIE_PORT_LINK_CONTROL does
not match the documentation, making it difficult to cross-reference
with the spec when debugging or maintaining the code.

Rename the macro to PORT_LINK_CTRL_OFF to align with the Synopsys
documentation, and update all usage sites accordingly. No functional
change is intended.

This improves code maintainability and eases future reference to the
controller manual.

Co-developed-by: Feizhou Yu <yufeizhou201@163.com>
Signed-off-by: Feizhou Yu <yufeizhou201@163.com>
Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 8 ++++----
 drivers/pci/controller/dwc/pcie-designware.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 593388f29bdd..9a0d8f0be792 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -894,7 +894,7 @@ static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
 		return;
 
 	/* Set the number of lanes */
-	plc = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
+	plc = dw_pcie_readl_dbi(pci, PORT_LINK_CTRL_OFF);
 	plc &= ~PORT_LINK_FAST_LINK_MODE;
 	plc &= ~PORT_LINK_MODE_MASK;
 
@@ -922,7 +922,7 @@ static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
 		dev_err(pci->dev, "num-lanes %u: invalid value\n", num_lanes);
 		return;
 	}
-	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, plc);
+	dw_pcie_writel_dbi(pci, PORT_LINK_CTRL_OFF, plc);
 	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, lwsc);
 
 	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
@@ -1295,10 +1295,10 @@ void dw_pcie_setup(struct dw_pcie *pci)
 		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
 	}
 
-	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
+	val = dw_pcie_readl_dbi(pci, PORT_LINK_CTRL_OFF);
 	val &= ~PORT_LINK_FAST_LINK_MODE;
 	val |= PORT_LINK_DLL_LINK_EN;
-	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
+	dw_pcie_writel_dbi(pci, PORT_LINK_CTRL_OFF, val);
 
 	dw_pcie_link_set_max_link_width(pci, pci->num_lanes);
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 0735ae940924..77420230433b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -87,7 +87,7 @@
 #define PORT_AFR_L1_ENTRANCE_LAT_SHIFT	27
 #define PORT_AFR_L1_ENTRANCE_LAT_MASK	GENMASK(29, 27)
 
-#define PCIE_PORT_LINK_CONTROL		0x710
+#define PORT_LINK_CTRL_OFF		0x710
 #define PORT_LINK_DLL_LINK_EN		BIT(5)
 #define PORT_LINK_FAST_LINK_MODE	BIT(7)
 #define PORT_LINK_MODE_MASK		GENMASK(21, 16)
-- 
2.43.0

