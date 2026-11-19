Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795050759;
	b=1pspomSknr7Bw5Gw4Ueew7oIf8sWIcwbUgH/lXqW6dcxGRxCpiEix0T9y4VIdrDkxdTr
	 6dwdrvO6N1yQ50mpsspuyPI70FWF1B112j5Gql81k7ZqaQY/hhWgAIlhPb9Lz6xOUIoDS
	 j0ElOIZyi4ThO9AWuz6Mb8qC+rmB+ea8nN/Bi6Y/v4JIhYAlGa/Lw/vpxtdMhzGxAjMCb
	 0O+3cfzkqp9Ri8sygn130Gcybt9KreCk21kDdZC/zsd6f8oh2xibezbnyUYWnU+AKraiZ
	 q8/wsQ/HtJ3i35wwwF/MCOC0B+zeOAZQcPR5K0Z5PgaW6O62V0aqnfit/z5A9wxj/5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795050759;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=by7fjbTSRtK9qhJcl4QtE4BTB7jqesvx7t7tAFmcyho=;
	b=Ys6Zyqr5qb3YLgnlgGxvzpmwaqJB940uzP8DewESKLm2LLaYruhuSL0zyxzqVduVdyiL
	 mDlc+xf6rQGb2cXOyWkM6U3x6tWg+GyGLBnZ1vndJIlZQdE4M4vPzfMAFQsAyeMJ/RXUT
	 cTnrkAS9K0jMkj1TBaqOBHcC7RjZ/OhzFG3RpsOzPboAIHENDQbgXdTDhDTy1xE1JDx67
	 WTtDE9f0VVHbFzjeIya6v4F8ksGYWIDaySVbAn0xom7Uix17zrSuby4tVFE34f/KuONQT
	 C5rgJj5w82L9xk2PeuxrWYEv9qROclP3ElCcyy+k1FWRdozxV2923awIGsTJ0n0heWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QUQRXBSx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D471606A31C;
	Thu, 19 Nov 2026 01:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QUQRXBSx
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795050759;
	b=1Cp7LI4D2BNbbH5s3h249qsx+eoUDFTQbbXJPaoZ18AnH/jLKhFSYE5c9FZgwCvMlmXD
	 2rGFA5RU78a3pQEhe5BVcx9iHuw9U+z1RjZHrjWqCJi6fg3N829YsQafDmRK+6+bHlqNq
	 aLHcsGavbmez6b1ra2XdQ4qb/LadPDtueCyP0yyNIWBlJVPfFijCpAone71bvBfI2440o
	 LSxR578HeIpMax3Qow9tiqOrdzbOB+XivwGf+aLWKIBKugSTOKJeBeIhXoCKjJdoNIaUy
	 azw9jnmOfq9RuDxQpdqUUUXf7WeXPU/BPZhiDA03IzELjHd9gvRSaYqdsnhYXdFoffA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795050759;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=by7fjbTSRtK9qhJcl4QtE4BTB7jqesvx7t7tAFmcyho=;
	b=TXuQLHVh100MYRDOWJYHtoRAc58PtCybC684o9mI1vZl3algjnIACzDa+/EMNqaofuhg
	 RgovIUDww3HLdrteNUTBeMmxoHRxYjaPkFGirG82i3NqdKv/W0w8ZtavmvyZzImg01oaB
	 dhnOsrIRNYu8qfjq9aoD9utGSPsVH95Xr6+6Feu636dqkCIxKHoUXKSWOOI1CvEmeE40G
	 U7t1ubTn9mRxbFGO/G7ocNautH3XHBvhm/XEu4r/Uc3QE0aSyJw85FW9vKA5hnPZAUiTc
	 xkJ+9oecDLqACv8EY/sbWWkq4JV6JmGJ5uqtzEITdQUZDuMNt0exAR73GCqRKflI0Zw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C2B8E1F000C5;
	Thu, 19 Nov 2026 01:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795050759;
	bh=by7fjbTSRtK9qhJcl4QtE4BTB7jqesvx7t7tAFmcyho=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=QUQRXBSxGyQcMeylOT2qYn4VrHPBKaJ+AxBcwIYwVLSogRIC3N5G8Llb7nrBZkPuR
	 P9wLEw4OiKJUOn7SbL6zBzJgHeKYaIO6AGgfz0pdegx2yN+T6nvL5cMk6/5D+S72J2
	 c6ukqeC78CHshcLH+k83b7OwLyIZfH4VizurAdSodZEsI0X/WCbOjBj5IlYl+9S2WK
	 /DgF8O83Nu6o899AZXK9y55dNHf8Phn80rvv8CMUptTQYylHWZ1rz3WAcrA0LPEeoA
	 mZOObhzhz/oexdaYNxnnRC0fZopFLBYc317as7nQ+DVfPHaXSf/GHcwJU36IWL6Rcg
	 wwb1XvlEF7JFQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5092F47D70;
	Thu, 19 Nov 2026 01:12:38 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Thu, 19 Nov 2026 01:12:36 +0000
Subject: [PATCH] PCI: rockchip-host: Support hibernation with endpoints in
 D0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261119-b4-rockchip-pcie-hib-v1-1-05df24cc77e6@iav.lv>
X-B4-Tracking: v=1; b=H4sIAANN/moC/x3MQQqAIBBA0avErBtwRIK6SrTIccohKFGIQLp70
 vIt/q9QJKsUmLoKWW4tep0N1HfAcT13QQ3NYI0diGhE7zBffHDUhIlVMKpHY5zQGtgZZ6GlKcu
 mz7+dl/f9AEvHSUxmAAAA
To: Shawn Lin <shawn.lin@rock-chips.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3860; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=tt1dbxgPAsX3IFa6cNo4EeAGvruDQ8t+mQUrzu36VIA=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFn/fFkLdjOq/VvaYb5qy+rEVp9/9i1Kum+enHy7OHvJw
 +56/X8uHaUsDGJcDLJiiiwTDmncylhy9a+/h/kDmDmsTCBDGLg4BWAiW68yMiy6dXtzyes9JYFh
 EzrObIx5cy/W4desP1GbA59ozX+gZBDGyNCroHr9tm1TxhZNtfNPZ/d6byj5oWV1V2dp3Oftv5e
 IvmYDAA==
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv
Content-Transfer-Encoding: 7bit

From: Igor Velkov <iav@iav.lv>

The driver runs its suspend callback on every system sleep transition,
including hibernation freeze and the quiesce step of the kernel that
loads the image. The PCI core leaves the endpoints in D0 there, the
link does not enter L2 after PME_Turn_Off, and hibernation aborts:

  rockchip-pcie f8000000.pcie: PCIe link enter L2 timeout!
  rockchip-pcie f8000000.pcie: PM: failed to freeze noirq: error -110

Keep the link up across freeze and thaw. On restore, power the port
down and bring it up as on resume, because the kernel that loaded the
image may have left it in any state. The port may already be down if
poweroff_noirq ran, so track that state.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
Tested on v7.4-rc3 with this patch, ROCK Pi 4A with a WD SN770 NVMe:
5 of 5 hibernation cycles restored, the NVMe readable after each.
---
 drivers/pci/controller/pcie-rockchip-host.c | 33 +++++++++++++++++++++++++++--
 drivers/pci/controller/pcie-rockchip.h      |  1 +
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 1e1556e436b8..df4b9b3ec031 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -863,6 +863,8 @@ static int rockchip_pcie_suspend_noirq(struct device *dev)
 
 	regulator_disable(rockchip->vpcie0v9);
 
+	rockchip->powered_down = true;
+
 	return ret;
 }
 
@@ -893,6 +895,8 @@ static int rockchip_pcie_resume_noirq(struct device *dev)
 	rockchip_pcie_update_txcredit_mui(rockchip);
 	rockchip_pcie_enable_interrupts(rockchip);
 
+	rockchip->powered_down = false;
+
 	return 0;
 
 err_err_deinit_port:
@@ -904,6 +908,25 @@ static int rockchip_pcie_resume_noirq(struct device *dev)
 	return err;
 }
 
+static int rockchip_pcie_restore_noirq(struct device *dev)
+{
+	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
+
+	/*
+	 * The boot kernel may have left the port in any state, while the image
+	 * holds the enable counts of a running port. Power it down so that
+	 * resume brings it up from scratch.
+	 */
+	if (!rockchip->powered_down) {
+		rockchip_pcie_deinit_phys(rockchip);
+		rockchip_pcie_disable_clocks(rockchip);
+		regulator_disable(rockchip->vpcie0v9);
+		rockchip->powered_down = true;
+	}
+
+	return rockchip_pcie_resume_noirq(dev);
+}
+
 static int rockchip_pcie_probe(struct platform_device *pdev)
 {
 	struct rockchip_pcie *rockchip;
@@ -1011,9 +1034,15 @@ static void rockchip_pcie_remove(struct platform_device *pdev)
 	regulator_disable(rockchip->vpcie0v9);
 }
 
+/*
+ * Freeze leaves the endpoints in D0 and the link does not reach L2 then,
+ * so keep the link up across freeze and thaw; restore re-inits the port.
+ */
 static const struct dev_pm_ops rockchip_pcie_pm_ops = {
-	NOIRQ_SYSTEM_SLEEP_PM_OPS(rockchip_pcie_suspend_noirq,
-				  rockchip_pcie_resume_noirq)
+	.suspend_noirq = pm_sleep_ptr(rockchip_pcie_suspend_noirq),
+	.resume_noirq = pm_sleep_ptr(rockchip_pcie_resume_noirq),
+	.poweroff_noirq = pm_sleep_ptr(rockchip_pcie_suspend_noirq),
+	.restore_noirq = pm_sleep_ptr(rockchip_pcie_restore_noirq),
 };
 
 static const struct of_device_id rockchip_pcie_of_match[] = {
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index b5da15601b58..51877678d3df 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -324,6 +324,7 @@ struct rockchip_pcie {
 	void    __iomem *msg_region;
 	phys_addr_t msg_bus_addr;
 	bool is_rc;
+	bool powered_down;
 	struct resource *mem_res;
 };
 

---
base-commit: 35f800669ce835aa77364a2ab5b61be19b778d3c
change-id: 20261119-b4-rockchip-pcie-hib-004e1adc4042

Best regards,
-- 
Igor Velkov <iav@iav.lv>


