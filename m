Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3800142A96;
	Fri, 23 Jan 2026 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769176895; cv=none; b=QtTWtsfmjFxWjTle/noB9TGI2BKQJT1026CvgHGZlcEnWweUgp4uItZOasZR3LFlDkA4WG0k41j8M6z3WnSuSIvbqLjGSJ8CyqAfv4Jl2EAv3f0KHqmBNR8/y9eWuI6CjwUrmhm7O314DEuDi7/iVeFWMT51b/BsCmWxwNeiGsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769176895; c=relaxed/simple;
	bh=a3Zoxl8WEnyAh7grQ6rJitmPcxAVIkmLRItBWkZi2VE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vj2EW8DEL3DqCQTcDvvyXEZ2H0HDQS7YNugWjjIn4/I8eGEJw7uAU185l4lc/XXfuK6TuEi7IZZzowTUN4Ap7KqfOHQoRjLLX1r1nuMy+Okp15/oOAaFNyzVKyiLCHTu7xekve6GTQ2W8PEMYzEAKv3IwlEQLQ1hsCVRL6rf5q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: YjFPbUtXSxOLA7NhN4yJBw==
X-CSE-MsgGUID: qUDNn6nBRLyAgViLtaLfcg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 23 Jan 2026 23:01:25 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.92])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D35A7406E3FB;
	Fri, 23 Jan 2026 23:01:20 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: claudiu.beznea.uj@bp.renesas.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	geert+renesas@glider.be,
	krzk+dt@kernel.org
Cc: robh@kernel.org,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	john.madieu@gmail.com,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH v2 01/15] PCI: rzg3s-host: Fix reset handling in probe error path
Date: Fri, 23 Jan 2026 15:00:17 +0100
Message-ID: <20260123140031.94752-2-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123140031.94752-1-john.madieu.xa@bp.renesas.com>
References: <20260123140031.94752-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix incorrect reset_control_bulk_deassert() call in the probe error
path. When unwinding from a failed pci_host_probe(), the configuration
resets should be asserted to restore the hardware to its initial state,
not deasserted again.

Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---

Changes:

v2: Collected Rb tag

 drivers/pci/controller/pcie-rzg3s-host.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 5aa58638903f..58e78fc52913 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1588,8 +1588,7 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 
 host_probe_teardown:
 	rzg3s_pcie_teardown_irqdomain(host);
-	reset_control_bulk_deassert(host->data->num_cfg_resets,
-				    host->cfg_resets);
+	reset_control_bulk_assert(host->data->num_cfg_resets, host->cfg_resets);
 rpm_put:
 	pm_runtime_put_sync(dev);
 rpm_disable:
-- 
2.25.1

