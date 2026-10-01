Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2654752B1D7;
	Thu,  1 Oct 2026 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868818; cv=none; b=mjymrGnuogtj7RY7s+IZWw0xDHslfAAo4akRa02VDdJWWd2+d5zDxoBA8nsvwqFxsAiJ/ku5tvkEl1b4pwaYplglNHzp9RR3V6F8J6CvxzRWf9THFg6jyykmjqi704777Vy3evxQhknv+Ss79Y42E8pTmrtaI/Mjr0GYuitIjS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868818; c=relaxed/simple;
	bh=2hx8QpOvVg+2EnX0QRVoJobooEJ0DOO2G5CBBvSKlPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=om5aKHyyuEzhiCOriEwVAWBky79I2/0cXfaOJ9eflBHx9ZS//AyCtaqwHenqdCU0qx+kb4AI2YWuSXfw0YGFk3/rrRG6illhfXNr1S9VCnFtndv4ceuJauz96JiKY6QANZf908r1cM0ZBKd8qQPiDB5QuxELaHWcbtLExRo5AAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cZ/hamC8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cZ/hamC8"
Received: from jeffbarnes-ThinkPad-P14s-Gen-2i.corp.microsoft.com (unknown [52.167.112.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id E37D820B7168;
	Thu,  1 Oct 2026 08:32:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E37D820B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790868763;
	bh=Gl19LhtWLKjfcWFniW5fiNkolXSpsFJsnrsmyFVH1q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cZ/hamC8umn0spRY/J9y8JezNfPCWT31hurpmlA7bpJhXsB7rbEtlOczIJ9IgD5ki
	 DQUFZKgNroCLsA4WmmLh72Pahbh2xOp5hYRpsBSEzyBn678LaUGN6qOlSNWu5hDGQ3
	 tiMpxWpqtJFgt/naaUNw8msDURvZcdOGerzo/ekw=
From: Jeff Barnes <jeffbarnes@linux.microsoft.com>
To: linux-pci@vger.kernel.org
Cc: Frank.li@oss.nxp.com,
	minghuan.Lian@nxp.com,
	mingkai.hu@nxp.com,
	roy.zang@nxp.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	Zhiqiang.Hou@nxp.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Revert "PCI: layerscape: Change default error response behavior"
Date: Thu,  1 Oct 2026 11:33:23 -0400
Message-ID: <20261001153323.1965074-1-jeffbarnes@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0FEA6868-5A7C-4955-9FBB-BE9A1AE8D3F7@getmailspring.com>
References: <0FEA6868-5A7C-4955-9FBB-BE9A1AE8D3F7@getmailspring.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 84d897d69938
("PCI: layerscape: Change default error response behavior").

The Layerscape PCIe driver programs the DesignWare
AMBA_ERROR_RESPONSE_DEFAULT register at offset 0x8d0 with 0x9401.

For AXI, the documented default with AMBA_ERROR_RESPONSE_GLOBAL cleared
returns OKAY with all-ones data for errors on non-posted requests.
Setting AMBA_ERROR_RESPONSE_GLOBAL causes an AXI error response instead,
with AMBA_ERROR_RESPONSE_MAP selecting SLVERR or DECERR for individual
PCIe completion errors.

The value 0x9401 sets AMBA_ERROR_RESPONSE_GLOBAL and maps Unsupported
Request, Completer Abort, and Completion Timeout to SLVERR.

A PCI configuration access can race with the link going down after
dw_pcie_other_conf_map_bus() checks the link but before
pci_generic_config_read() performs the MMIO access. If the transaction
results in a Completion Timeout, the Layerscape error response setting
propagates it to AXI as SLVERR, resulting in an asynchronous SError and
kernel panic.

Reproduce the race by obtaining the configuration-space mapping while
the link is up, then disabling the link from another CPU immediately
before performing the MMIO configuration read.

With the error response override enabled, the overlapping configuration
read results in an asynchronous SError and kernel panic. With the
DesignWare default behavior restored, the same test returns 0xffffffff.
AER reports a non-fatal Completion Timeout, and no SError or kernel
panic occurs.

Restore the documented DesignWare default error response behavior so a
failed non-posted PCIe transaction does not become a fatal AXI error.

Fixes: 84d897d69938 ("PCI: layerscape: Change default error response behavior")
Cc: stable@vger.kernel.org
Signed-off-by: Jeff Barnes <jeffbarnes@linux.microsoft.com>

Changes in v2:
- Change the subject to identify this as a revert, as requested by
  Frank Li.
- Document the DesignWare AMBA_ERROR_RESPONSE_DEFAULT behavior and
  decode the 0x9401 setting used by Layerscape.
- Clarify that the setting propagates Completion Timeout as AXI SLVERR
  rather than causing the underlying PCIe transaction failure.

---
 drivers/pci/controller/dwc/pci-layerscape.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index 14d6ac4fc53f..d333f1ae8a41 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -28,8 +28,6 @@
 
 /* PEX Internal Configuration Registers */
 #define PCIE_STRFMR1		0x71c /* Symbol Timer & Filter Mask Register1 */
-#define PCIE_ABSERR		0x8d0 /* Bridge Slave Error Response Register */
-#define PCIE_ABSERR_SETTING	0x9401 /* Forward error of non-posted request */
 
 /* PF Message Command Register */
 #define LS_PCIE_PF_MCR		0x2c
@@ -103,14 +101,6 @@ static void ls_pcie_drop_msg_tlp(struct ls_pcie *pcie)
 	iowrite32(val, pci->dbi_base + PCIE_STRFMR1);
 }
 
-/* Forward error response of outbound non-posted requests */
-static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
-{
-	struct dw_pcie *pci = pcie->pci;
-
-	iowrite32(PCIE_ABSERR_SETTING, pci->dbi_base + PCIE_ABSERR);
-}
-
 static u32 ls_pcie_pf_lut_readl(struct ls_pcie *pcie, u32 off)
 {
 	if (pcie->big_endian)
@@ -180,8 +170,6 @@ static int ls_pcie_host_init(struct dw_pcie_rp *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct ls_pcie *pcie = to_ls_pcie(pci);
 
-	ls_pcie_fix_error_response(pcie);
-
 	dw_pcie_dbi_ro_wr_en(pci);
 	ls_pcie_clear_multifunction(pcie);
 	dw_pcie_dbi_ro_wr_dis(pci);
-- 
2.43.0

