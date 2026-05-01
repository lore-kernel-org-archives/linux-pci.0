Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565943E0253;
	Fri,  1 May 2026 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777651856; cv=none; b=pwUoSD79yCTnT1QthrFFe1DMUWjlwmSeGMyVZ4DiAbfpiaw23o/JyXyHzbMEW5QzwPQ8SKrgFcDnoLrkfyo0YVn81meqMKQ+xg3PHJuZuzlQzh18lHi0ZK8DbcjPXlgfWwTOKdveMrv3Y5O9BIn9tYbii9rFlFmXH1h4FEOC3oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777651856; c=relaxed/simple;
	bh=aXhC65Zb6lsdMfo0s9aGwilLcrNlX4abA5vMXDMW8Ys=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OM3LVJEAuu0lI6Ws09RAF03E3B3UJYmfr+3JV0Ii4h/ydDAKuDwq1VRtrNVbMAbxmEUIPtz4zvRqKKn/P/ftcpJDVfAbrZYnB/S48+v8k+hYFbaY13agNDRO2XkCVXt2Uh2j9McUtdJyVVluqD/vtQKRXkjRcTjaHGF8Kq7EJCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=S6zP4gvJ; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S6zP4gvJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ad
	RwuuCrFZ1DP5Y6ptJ3l0RWG3ARD5LzNtr8Y+beLwo=; b=S6zP4gvJkCaDC9/0y4
	25Y+ATtec/1MfzjfZzE8fAtkUyRaYJoRt1cjztX+1dYBdxGlU8zKd3QnuAWDiF3I
	NDLHWdWYKqQ15MXCgyGSf901Zlq9bbvZk1PIhbI8dBe3zenJHPHuSQmLAKKA3fmd
	oOhZgBAVfBMxwp45L90639III=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnj5Fk0PRprTQgCw--.53438S2;
	Sat, 02 May 2026 00:10:14 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	mani@kernel.org,
	vigneshr@ti.com
Cc: xrobh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 0/4] PCI: dwc: designware-plat: Use common mode field in struct dw_pcie
Date: Sat,  2 May 2026 00:10:06 +0800
Message-Id: <20260501161010.71688-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnj5Fk0PRprTQgCw--.53438S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw4fZFWfGr48Kw47uFyfWFg_yoW8Gr1UpF
	Z3Wa4Y9r4rCF98uF1xuF4v9ryay3Z5AFyUGrZxK34IqF9rur9rC3W0yrWrtrW3KF4Iqr1q
	kr1Yq345CF1UAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piJGYdUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwwbkiGn00GaC1AAA3U

Several DesignWare PCIe controller drivers (dra7xx, artpec6,
designware-plat, and keembay) duplicated the device mode field
in their private structures, while struct dw_pcie already contains
this field. This led to:
1. Data redundancy and potential inconsistencies
2. Increased maintenance complexity
3. Error-prone device type checks

This series fixes these issues by:
- Removing redundant mode fields from all four drivers
- Standardizing on dw_pcie->mode for device type detection
- Simplifying conditional logic in probe/suspend/resume paths
- Ensuring consistent error reporting

The changes improve code maintainability and eliminate class of bugs
related to mode synchronization.

Hans Zhang (4):
  PCI: dra7xx: Use common mode field in struct dw_pcie
  PCI: artpec6: Use common mode field in struct dw_pcie
  PCI: dwc: Use common mode field in struct dw_pcie
  PCI: keembay: Use common mode field in struct dw_pcie

 drivers/pci/controller/dwc/pci-dra7xx.c           | 11 +++++------
 drivers/pci/controller/dwc/pcie-artpec6.c         |  9 ++++-----
 drivers/pci/controller/dwc/pcie-designware-plat.c |  7 +++----
 drivers/pci/controller/dwc/pcie-keembay.c         |  9 ++++-----
 4 files changed, 16 insertions(+), 20 deletions(-)


base-commit: e75a43c7cec459a07d91ed17de4de13ede2b7758
-- 
2.34.1

