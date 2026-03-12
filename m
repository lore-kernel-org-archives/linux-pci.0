Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A631391828;
	Thu, 12 Mar 2026 16:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773333505; cv=none; b=nSDckZYW3pXKGPyKSkGX0IKvTLML/puNXaBuehkkUmHHXVecY1JajFsjnRIEOXEkCxvGM2/oVut1yCBeFl/WeBii6kAl94wHeJWEE0V9tiYEp6t7/dwlWyCOzWcCjQR3z5neKGFcLAWjANTNwTd0xFsvKigDm2mG6PQagojpEGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773333505; c=relaxed/simple;
	bh=LaDMrP+pcd/JXJQNPKeJRt91RMSc2WISQEFS4Meu+2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NTMqTgqyymKZxY+GeIfMu7z7ZusqzioYB/x/NB5CPcZn+W/nBYrsOX/NxJ2zVFV/QnwgmZJfL914qg4S4Xih0upu18KqqwdtqFLdZKjSo72CawLoRbXFOhsAbCiogkQoG3C29z+1NYwp7/givmJ4K2D7tkmVHZZvP+PpBXuYVXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=X2NtGY0w; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="X2NtGY0w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=jq
	SuO3F12+BG9vDtSc8L1vzzspX/dhmwJJslZsHS+5w=; b=X2NtGY0w8SBaIDWXj5
	Il37UHQvb343cKnDnms4MUpmABVPpI9rNone/r00hKvAMwWSH449oZcM9PLYLNel
	49+SQmv2PRoO2drBhMBpbnm10yvwzTJ9xAxa+DnrjZLU3nJ7BJehmDf1FWJIgOvF
	L74Z2m3KlLuP6+Y6PtqCHbIz4=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnN1Gl67JpMC_OAQ--.12929S5;
	Fri, 13 Mar 2026 00:37:01 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	jingoohan1@gmail.com,
	mani@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	helgaas@kernel.org,
	florian.fainelli@broadcom.com,
	jim2101024@gmail.com
Cc: robh@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	claudiu.beznea.uj@bp.renesas.com,
	linux-mediatek@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	linux-omap@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v8 3/5] PCI: j721e: Validate max-link-speed from DT
Date: Fri, 13 Mar 2026 00:36:50 +0800
Message-Id: <20260312163652.113228-4-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312163652.113228-1-18255117159@163.com>
References: <20260312163652.113228-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnN1Gl67JpMC_OAQ--.12929S5
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF4rZw1ftr4xWFyxGF1DGFg_yoWDXFXE9F
	1UXFWrAr4Uuryakr1YyryayF95A34Uuw18Wa4rtF4fAFyxWay5ZrnxAFWUWa97u3W7JF17
	JFyDKFn5J3ZFkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRMjjg7UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxA0t0Gmy661RhQAA39

Use the new pcie_get_link_speed() helper to validate the value read from
the "max-link-speed" DT property.  If the value is missing or invalid,
fall back to Gen2 (speed = 2).  This prepares for the removal of the
range check in of_pci_get_max_link_speed().

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 6f2501479c70..bfdfe98d5aba 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -202,7 +202,8 @@ static int j721e_pcie_set_link_speed(struct j721e_pcie *pcie,
 	int ret;
 
 	link_speed = of_pci_get_max_link_speed(np);
-	if (link_speed < 2)
+	if ((link_speed < 2) ||
+	    (pcie_get_link_speed(link_speed) == PCI_SPEED_UNKNOWN))
 		link_speed = 2;
 
 	val = link_speed - 1;
-- 
2.34.1

