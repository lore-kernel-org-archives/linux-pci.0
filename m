Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450282;
	b=fv6n6gfUtMWkWBePQY5DIvqajtOne0MZ2oscZicCGdhCGCIrIqnd0znY7ULcC0Zmm2aP
	 Mt++b0QvGUtYPQmMtGs4fMN/gPqPrJAjgvsAFt4bwmi7h3qJdr/vI2VX5lU5DJBpypWb+
	 /t1qk3p0PTh8KPr5EgXQium42bkjg4VY0XJ1vxoOEWSX+0qoX7M+fHnb71FORK6SdMtbY
	 tahdXs58NnsLNhfcuBDm/2/+PDiFuCHjS4z8LWQcjBzAIRVydOy9f6AG7qkMRcAlxBkwB
	 i6R04Pl2+oKVcWZU3tZOCRxsTpOKDkDUYUtKtT542FbZ06r/3tr4S4CsL4kQauDKhDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450282;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=AuNCvErELAsRD2TsvI0NIr6pNW90+88TXZ8jEukwm1A=;
	b=VzubhJ7tyQX9PLav1WCdPT0P+zfxf8NsgyU67tpCp6g2ooA/Ao1vCGXQCL/hA0jJxXiq
	 qx+C2O2sBzL+PBP5LKgebAUsUYK0EV4MAO432+k9s1Fc+SYrwLN1nGPHoMz5kPOKkXmxh
	 MwUemxgXU5JbpSizogXVaInIq+4MQLjqa/sPCd3aGaEBVDoOSL3TrTtKhilPG7Ll3lMHs
	 v4Yl3doa+UM/9NEfKUF0WuT9UFQlPt+jlz9yWLuUtTilN8fVPAnmnAhHbgMdAaoxRbApk
	 95hlILJb7M6QYtUmJRRuLwCxO8h2/WxDJMydMqi0LApa7bGmOc1zyN/cGxYnuOYA2Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=YYYeLTj8;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B89606A326;
	Thu, 12 Nov 2026 02:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44B89606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=YYYeLTj8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Au
	NCvErELAsRD2TsvI0NIr6pNW90+88TXZ8jEukwm1A=; b=YYYeLTj8/FC0dvGkDs
	HEHmbKgjHoUiyN8PV3Q+sx/GTYAOxtNQXixXb3+qJtM3p8y29MJab61g8Uq68yI+
	fyBf3BYunpyKzYxdCQTyyeh7D2rga3qLICnDHL8QhbciNoTrEuQg92KA8s+15eCT
	4/esAIWQfju51Q77jVCGAwq8E=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXj+5GI_VqPgXEGg--.53291S7;
	Thu, 12 Nov 2026 10:24:14 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	thierry.reding@kernel.org,
	ryder.lee@mediatek.com,
	jonathanh@nvidia.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v3 5/5] PCI: Make pcie_link_speed[] private to probe.c
Date: Thu, 12 Nov 2026 10:24:05 +0800
Message-ID: <20261112022405.1230200-6-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112022405.1230200-1-18255117159@163.com>
References: <20261112022405.1230200-1-18255117159@163.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXj+5GI_VqPgXEGg--.53291S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7ArWkur17Jr1kAF1DCw4rKrg_yoW8Wr48pa
	9xJr40yr10q3W5WrZ8XayUuFy5J3ZxCay2k3y2g393ZFy3JrZxXrya9ayfXrZIyrs29ry3
	XFnxJr1jya17twUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRBMKZUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7A7zl2r1I04k6gAA36

pcie_get_link_speed() is now the only accessor for pcie_link_speed[].
Make the array static and remove its extern declaration and export so no
other code can index it directly.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pci.h   | 1 -
 drivers/pci/probe.c | 4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5441741bc330..04bdf3b86a56 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -118,7 +118,6 @@ struct pcie_tlp_log;
 #define PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
 				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
 
-extern const unsigned char pcie_link_speed[];
 unsigned char pcie_get_link_speed(unsigned int speed);
 
 extern bool pci_early_dump;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index d0283a8158f2..b2d69de00041 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -756,7 +756,7 @@ static const unsigned char pcix_bus_speed[] = {
 };
 
 /* Indexed by PCI_EXP_LNKCAP_SLS, PCI_EXP_LNKSTA_CLS */
-const unsigned char pcie_link_speed[] = {
+static const unsigned char pcie_link_speed[] = {
 	PCI_SPEED_UNKNOWN,		/* 0 */
 	PCIE_SPEED_2_5GT,		/* 1 */
 	PCIE_SPEED_5_0GT,		/* 2 */
@@ -774,8 +774,6 @@ const unsigned char pcie_link_speed[] = {
 	PCI_SPEED_UNKNOWN,		/* E */
 	PCI_SPEED_UNKNOWN		/* F */
 };
-EXPORT_SYMBOL_GPL(pcie_link_speed);
-
 /**
  * pcie_get_link_speed - Get speed value from PCIe generation number
  * @speed: PCIe speed (1-based: 1 = 2.5GT, 2 = 5GT, ...)
-- 
2.43.0

