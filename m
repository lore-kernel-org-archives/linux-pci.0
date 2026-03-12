Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6053835A3B8
	for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773320594; cv=none; b=lho/J+m+pLCJqxrD0TojQjDi0Zr/yRwhN8VXLmQhH0L3POWBSVine9roJNLXDMH+DSItLXhs6fzJROV5pq9cLd9htqvxtG7kUr7g7vCyT/1z3EHs2xheQc4bmSrDKoPwosAfKyU8b7729CL6tG87ckf+u3hBmk0ZIihNiG+URbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773320594; c=relaxed/simple;
	bh=EL1Ak+/XgCLmlB+se7hEtFsE+nXFp86rcFosBJKdbDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X2GHhpNyp2uoDe6fNBj12jSij66fS8dR3kZqnfRdgOWprv3i9Wuc/CHymwoSOIoriEPE68tC9aaOJRPUgmjFFT0biOzG1+M8U4ciJZ26YqRGmdmdFtbcU3vf/E/0ymlzES6avwx8OmQT1GmJSQx3WLkcj/7KSnqzP+rJUImPass=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYub4hXQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYub4hXQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9E9C19424;
	Thu, 12 Mar 2026 13:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773320594;
	bh=EL1Ak+/XgCLmlB+se7hEtFsE+nXFp86rcFosBJKdbDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CYub4hXQSOFLS3XMVKdXQFp1ItMwu2PaYBxrdEdgpqC4LYEDuWWiM+h7bfGTmATt+
	 UonWPJdA1AUIL5XcdRJ7enitgiRRJrhsKICs6xiE84f3To1eU/bQVjocSQ0O31iy81
	 hifAFaeYFcTEvNX+cEmmU0VuVkJO93+dDwrNElP2f9H0LNvcYsJ9lf9BFLat9yjZ4/
	 /MFN+9kKkUZaXvQe+PjfqQibj8yeEV8IEUlpdBPotBJ3V8FvmNLdAZaSRtbauZHBUp
	 V22KBgYa4G/dKuKBkXeECTM4JWNO67yVqC/KLqhDW+b+eyzMeJ0bJ9a/dLSCPvdGP6
	 cZLBD8ymIJUMg==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 05/10] PCI: endpoint: Introduce pci_epc_bar_type BAR_DISABLED
Date: Thu, 12 Mar 2026 14:02:33 +0100
Message-ID: <20260312130229.2282001-17-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312130229.2282001-12-cassel@kernel.org>
References: <20260312130229.2282001-12-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2621; i=cassel@kernel.org; h=from:subject; bh=EL1Ak+/XgCLmlB+se7hEtFsE+nXFp86rcFosBJKdbDE=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDI37cx5nxVsah29MMjhHfvVgNSIS5FHXHxmvy758iL1S /aq0C8bOkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjAR/deMDJeuywk//ftIrqXy n/vvyVpBZwzN6+UaktIffT+wsOCb6DRGhtcXc2cwPIpNC5c7nVYxtWbJL9uLZodiZx7bsD/ZIva nEi8A
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Add a pci_epc_bar_type BAR_DISABLED to more clearly differentiate from
BAR_RESERVED.

This BAR type will only be used to describe a BAR that the EPC driver
should disable, and will thus never be available to an EPF drive.
(Unlike BAR_RESERVED, which will never be disabled by default by an EPC
driver.)

Tested-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Co-developed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/pci-epc-core.c |  5 +++--
 include/linux/pci-epc.h             | 10 +++++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index e546b3dbb240..6c3c58185fc5 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -103,8 +103,9 @@ enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
 		bar++;
 
 	for (i = bar; i < PCI_STD_NUM_BARS; i++) {
-		/* If the BAR is not reserved, return it. */
-		if (epc_features->bar[i].type != BAR_RESERVED)
+		/* If the BAR is not reserved or disabled, return it. */
+		if (epc_features->bar[i].type != BAR_RESERVED &&
+		    epc_features->bar[i].type != BAR_DISABLED)
 			return i;
 	}
 
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index ebcdf70aa9b9..334c2b7578d0 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -191,13 +191,21 @@ struct pci_epc {
  * @BAR_RESIZABLE: The BAR implements the PCI-SIG Resizable BAR Capability.
  *		   NOTE: An EPC driver can currently only set a single supported
  *		   size.
- * @BAR_RESERVED: The BAR should not be touched by an EPF driver.
+ * @BAR_RESERVED: Used for HW-backed BARs (e.g. MSI-X table, DMA regs). The BAR
+ *		  should not be disabled by an EPC driver. The BAR should not be
+ *		  reprogrammed by an EPF driver. An EPF driver is allowed to
+ *		  disable the BAR if absolutely necessary. (However, right now
+ *		  there is no EPC operation to disable a BAR that has not been
+ *		  programmed using pci_epc_set_bar().)
+ * @BAR_DISABLED: The BAR should be disabled by an EPC driver. The BAR will be
+ *		  unavailable to an EPF driver.
  */
 enum pci_epc_bar_type {
 	BAR_PROGRAMMABLE = 0,
 	BAR_FIXED,
 	BAR_RESIZABLE,
 	BAR_RESERVED,
+	BAR_DISABLED,
 };
 
 /**
-- 
2.53.0

