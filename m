Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FB31A3164;
	Sun, 15 Mar 2026 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773590485; cv=none; b=tnW4RKWwfHc5AAmLs94Kwnk11VJbqG8Tg6yhFXU46SDAYYa9euo5qdZC4QX+KwnSKaoWh+z65yPaDcmQjmMkP30OWWSvpkRkKVni4axFVnLA8Mk4oysCMyvOKiVSqvT8oj28FrmeSPXi8gjTBldmUNiEMSNouiQ7Y0UaHAJ9c34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773590485; c=relaxed/simple;
	bh=BBAj8aXqsxx6BNbIlyPstA2pBqCAYUj/Hq+asA2/ZCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O2lbLCFHZkmavAcbEBzPoeJd8DVmp+T7sO1AVnSSNhkNxxiJXt7LlIeNhYj5SDuJ0Zfi20RHx68/HatOa81Fm1wvBcfiNi87u6olV+GpxLU/jF++VoE0FXxkJ3SOQKdDbMV9hoL8wLs8CEjKbvZC//Bxe03s+5aZ1xNhQx+cHac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=E1BxutK2; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="E1BxutK2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=qu
	It4kRS+73uCd8RPqf14tOszi62vvOEJnAaqSyEPvE=; b=E1BxutK2ynYVG0g38s
	6Px4ugkRan4ocwQaOQcQixCJOeRxNmNXd978NQYDivTxg/XZ8dfV5NKHZT7+lFp+
	0GcgwvpH/ScjUH5rKKMj1bTmcLMcrwUTSKX5xf6nQahh18ORYVe/MUF/R1npCUac
	qs6Eqynx+JYaWFFjBsECqR4y4=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBHvwy817ZpjnSYBA--.30374S5;
	Mon, 16 Mar 2026 00:01:03 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v1 3/3] PCI: Remove extern declaration of pcie_link_speed array
Date: Mon, 16 Mar 2026 00:00:57 +0800
Message-Id: <20260315160057.127639-4-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260315160057.127639-1-18255117159@163.com>
References: <20260315160057.127639-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHvwy817ZpjnSYBA--.30374S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7GFW7JF17Ww45GFykJry8AFb_yoW8JF15pa
	9rGr10yr1FqF15WrZxZa48uFy5J3ZxCFWUKrW7W39xZFyayFy3X34a9ayfJrnIyrs29rW5
	XFnxtryjk3W3tr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziYZXcUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7B8t0Gm217-dzAAA3o

With all users of pcie_link_speed converted to use to_pcie_link_speed(),
the external declaration in pci.h is no longer needed. Remove it to
prevent new code from directly accessing the array and to reduce the
global symbol footprint.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pci.h   | 1 -
 drivers/pci/probe.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 053fc245a1e3..b2f91409b439 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -107,7 +107,6 @@ struct pcie_tlp_log;
 #define PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
 				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
 
-extern const unsigned char pcie_link_speed[];
 unsigned char pcie_get_link_speed(unsigned int speed);
 
 extern bool pci_early_dump;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 40f2185ac3b5..0c93eff80b71 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -781,7 +781,6 @@ const unsigned char pcie_link_speed[] = {
 	PCI_SPEED_UNKNOWN,		/* E */
 	PCI_SPEED_UNKNOWN		/* F */
 };
-EXPORT_SYMBOL_GPL(pcie_link_speed);
 
 /**
  * pcie_get_link_speed - Get speed value from PCIe generation number
-- 
2.34.1

