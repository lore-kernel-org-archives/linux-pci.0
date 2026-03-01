Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4451F7541;
	Sun,  1 Mar 2026 01:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772327713; cv=none; b=sxX7/T5UGSJ9//upnviVYevaJRabxuXnzKvOo1Fb0tYCjlvup2S3Xpd+GPATkyxCER3jfa50E9a+ptBd9Q8ZCf3hyxJXx2pNOvoHfHLtf9qoTb8x4wdQSE0CxfPHMzxC5M7/REyjpI272rT0bEpUl624YKbJuiakfnyE/gpEYrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772327713; c=relaxed/simple;
	bh=TzfHRjikC4mXJxw70nHiI3sTzBTXHcO+bZfXpx2LNN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TuxaueZpbJyK7pe51NXgiJqdPVrJzLi+UkCCN05lgTiC0ylD1gm3AJd14sm0CGjBSVYulCdqEW6WcD30yvKa4A3MOLFnnyp6TH0wtkZzWQlMClD38nQYAMX1iK4yq4NBExGi8eL3GvRPD1HIP7qC400JkJZJ5tpPbUnHSRcLe84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiuQGxsR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiuQGxsR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FD6C19421;
	Sun,  1 Mar 2026 01:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772327713;
	bh=TzfHRjikC4mXJxw70nHiI3sTzBTXHcO+bZfXpx2LNN4=;
	h=From:To:Cc:Subject:Date:From;
	b=AiuQGxsRCZg0oJfOV35WUubgio+51vBxqANQq2p7lNL9zf5NHMG7hG1YTL+QHvgjP
	 gBjgl2JcVrZRRaeEkqESHaJuPMVdnDvZHbZ6TLeITaIukj8uuJFrTfNZbD9pi0zUSd
	 bhYt2uV3c8S4HX7f13PM/JM+yP5H20Lo19uPVgUBBmagc3oeAEilXubw1JeBYT1Dp1
	 8enhFiA6Dz+zeJFa/cWtrTZfhEGpz4SK1bb4vS7kz7s5/cZ2ja3DlnPk3dQpSJSsHi
	 UHPHeWF4taGfJFDwgN86JrHMotajBKDUHgujwfzbDlF01LYqPx3HSbSxH127EpMJQu
	 SryZSdf1DmX8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	s-vadapalli@ti.com
Cc: kernel test robot <lkp@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: FAILED: Patch "PCI: j721e: Add config guards for Cadence Host and Endpoint library APIs" failed to apply to 6.18-stable tree
Date: Sat, 28 Feb 2026 20:15:10 -0500
Message-ID: <20260301011511.1668175-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 4b361b1e92be255ff923453fe8db74086cc7cf66 Mon Sep 17 00:00:00 2001
From: Siddharth Vadapalli <s-vadapalli@ti.com>
Date: Mon, 17 Nov 2025 17:02:06 +0530
Subject: [PATCH] PCI: j721e: Add config guards for Cadence Host and Endpoint
 library APIs

Commit under Fixes enabled loadable module support for the driver under
the assumption that it shall be the sole user of the Cadence Host and
Endpoint library APIs. This assumption guarantees that we won't end up
in a case where the driver is built-in and the library support is built
as a loadable module.

With the introduction of [1], this assumption is no longer valid. The
SG2042 driver could be built as a loadable module, implying that the
Cadence Host library is also selected as a loadable module. However, the
pci-j721e.c driver could be built-in as indicated by CONFIG_PCI_J721E=y
due to which the Cadence Endpoint library is built-in. Despite the
library drivers being built as specified by their respective consumers,
since the 'pci-j721e.c' driver has references to the Cadence Host
library APIs as well, we run into a build error as reported at [0].

Fix this by adding config guards as a temporary workaround. The proper
fix is to split the 'pci-j721e.c' driver into independent Host and
Endpoint drivers as aligned at [2].

[0]: https://lore.kernel.org/r/202511111705.MZ7ls8Hm-lkp@intel.com/
[1]: commit 1c72774df028 ("PCI: sg2042: Add Sophgo SG2042 PCIe driver")
[2]: https://lore.kernel.org/r/37f6f8ce-12b2-44ee-a94c-f21b29c98821@app.fastmail.com/

Fixes: a2790bf81f0f ("PCI: j721e: Add support to build as a loadable module")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511111705.MZ7ls8Hm-lkp@intel.com/
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251117113246.1460644-1-s-vadapalli@ti.com
---
 drivers/pci/controller/cadence/pci-j721e.c | 41 +++++++++++++---------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index ecd1b03124006..6f2501479c701 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -620,9 +620,11 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 			gpiod_set_value_cansleep(pcie->reset_gpio, 1);
 		}
 
-		ret = cdns_pcie_host_setup(rc);
-		if (ret < 0)
-			goto err_pcie_setup;
+		if (IS_ENABLED(CONFIG_PCI_J721E_HOST)) {
+			ret = cdns_pcie_host_setup(rc);
+			if (ret < 0)
+				goto err_pcie_setup;
+		}
 
 		break;
 	case PCI_MODE_EP:
@@ -632,9 +634,11 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 			goto err_get_sync;
 		}
 
-		ret = cdns_pcie_ep_setup(ep);
-		if (ret < 0)
-			goto err_pcie_setup;
+		if (IS_ENABLED(CONFIG_PCI_J721E_EP)) {
+			ret = cdns_pcie_ep_setup(ep);
+			if (ret < 0)
+				goto err_pcie_setup;
+		}
 
 		break;
 	}
@@ -659,10 +663,11 @@ static void j721e_pcie_remove(struct platform_device *pdev)
 	struct cdns_pcie_ep *ep;
 	struct cdns_pcie_rc *rc;
 
-	if (pcie->mode == PCI_MODE_RC) {
+	if (IS_ENABLED(CONFIG_PCI_J721E_HOST) &&
+	    pcie->mode == PCI_MODE_RC) {
 		rc = container_of(cdns_pcie, struct cdns_pcie_rc, pcie);
 		cdns_pcie_host_disable(rc);
-	} else {
+	} else if (IS_ENABLED(CONFIG_PCI_J721E_EP)) {
 		ep = container_of(cdns_pcie, struct cdns_pcie_ep, pcie);
 		cdns_pcie_ep_disable(ep);
 	}
@@ -728,10 +733,12 @@ static int j721e_pcie_resume_noirq(struct device *dev)
 			gpiod_set_value_cansleep(pcie->reset_gpio, 1);
 		}
 
-		ret = cdns_pcie_host_link_setup(rc);
-		if (ret < 0) {
-			clk_disable_unprepare(pcie->refclk);
-			return ret;
+		if (IS_ENABLED(CONFIG_PCI_J721E_HOST)) {
+			ret = cdns_pcie_host_link_setup(rc);
+			if (ret < 0) {
+				clk_disable_unprepare(pcie->refclk);
+				return ret;
+			}
 		}
 
 		/*
@@ -741,10 +748,12 @@ static int j721e_pcie_resume_noirq(struct device *dev)
 		for (enum cdns_pcie_rp_bar bar = RP_BAR0; bar <= RP_NO_BAR; bar++)
 			rc->avail_ib_bar[bar] = true;
 
-		ret = cdns_pcie_host_init(rc);
-		if (ret) {
-			clk_disable_unprepare(pcie->refclk);
-			return ret;
+		if (IS_ENABLED(CONFIG_PCI_J721E_HOST)) {
+			ret = cdns_pcie_host_init(rc);
+			if (ret) {
+				clk_disable_unprepare(pcie->refclk);
+				return ret;
+			}
 		}
 	}
 
-- 
2.51.0




