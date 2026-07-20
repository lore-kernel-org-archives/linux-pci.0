Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3235843553E;
	Mon, 20 Jul 2026 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560119; cv=none; b=s+A3LmKNUtxH6kqMlLibLcfA0Asc8sZr6ZO37Vtuv+e7QJawVbRMyPnBVRJur6oCVVrJYblnSsKn6hg7wS1DWUkgv4JTXSoUEy8DxakAhbfjvpCC4zPOoQjOLMlhJoI4s2dER9qxY4Hcx8+/5E61wgp8pthtLrxzqfJWT2Gdjxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560119; c=relaxed/simple;
	bh=GZRRdIebw/R7rBRANI0WHKYmQLKIYwinmBYXNPBBtRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mqvez09vic6Ejke0EhAvSIz8/wNQ+isfOTs8xTVNaUjRP4qaQuoVXlTj/USL2fFxi5aVn/buOcg2Fhf6UeqCW7uv8HqbcgmbmhSUIU5T35J1j7lFEQeg1/8476mClIbDXaDThArBokpFztSfnEAWBvl4f+gXnrBQZQUqarxlPiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Rsa4jCy4; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Rsa4jCy4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=mA
	809+5dKgIh5hEU/u2sEYn54hA7ngIexLFJ1RFII/4=; b=Rsa4jCy4DZD7SMWYo7
	jBSCqh9Uym3kU3QnHscX2w+T5j8CfHl4x70kbASd0ua39cOpmpSZfFOEqU+hASMB
	M+lRnw9Rx7nT0npcoOUrBMQgY64hXsZ64tQML0k0CFYlpkNBIyZMKl7H1U0izOe6
	EZuBeYsiFHxPVCQ09c8uU66gY=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3b1rIOV5qyHOjKQ--.35310S6;
	Mon, 20 Jul 2026 23:07:59 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	jingoohan1@gmail.com
Cc: imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v3 12/16] PCI: dwc: sophgo: Use cached PCIe capability offset
Date: Mon, 20 Jul 2026 23:06:15 +0800
Message-Id: <20260720150619.24733-13-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720150619.24733-1-18255117159@163.com>
References: <20260720150619.24733-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3b1rIOV5qyHOjKQ--.35310S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF48WFW5tr1rXryrCry3Arb_yoW8Jw1kpa
	y5Zr4FkF4rJF4Yqa1Iy3WkZr1Yq3sxAryxJa93Gw4av34akFyDJw45tFyYgFnrGFWjyry3
	KFn8t3W3WF98AwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi9a9hUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6w+zV2peOc9vigAA3n

dw_pcie_host_init() calls .init before caching, so we must call
dw_pcie_get_pcie_cap() inside .init. The hardware is already enabled by
the driver's own initialization before this point. The helper will cache
the offset and avoid redundant searches.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
In pcie-sophgo, the call chain is:

  static const struct dw_pcie_host_ops sophgo_pcie_host_ops = {
    .init = sophgo_pcie_host_init,
  };
  sophgo_pcie_host_init()
    -> sophgo_pcie_disable_l0s_l1()
      -> dw_pcie_find_capability()
---
 drivers/pci/controller/dwc/pcie-sophgo.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-sophgo.c b/drivers/pci/controller/dwc/pcie-sophgo.c
index 044088898819..39703d2b7b5f 100644
--- a/drivers/pci/controller/dwc/pcie-sophgo.c
+++ b/drivers/pci/controller/dwc/pcie-sophgo.c
@@ -164,9 +164,10 @@ static void sophgo_pcie_msi_enable(struct dw_pcie_rp *pp)
 static void sophgo_pcie_disable_l0s_l1(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	u32 offset, val;
+	u8 offset;
+	u32 val;
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	offset = dw_pcie_get_pcie_cap(pci);
 
 	dw_pcie_dbi_ro_wr_en(pci);
 
-- 
2.34.1

