Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794694384;
	b=T1BOhwBA5vY2VRrP4B2ntd6FXwzXiFsxb2580ncSYMl6qtoxGRJ/O6iRqMs88NllmRq6
	 AlK2StOKWY9EvbkrBgsFqSu8wJxOEpTALqopyVoXX12GExVy2VI3zRvdw0Xevd9EApp/6
	 BUK9hXtew+ABIAx66sqM9ASKxoqYX7AGKIsDtwsigBFc/rjHjcQASOD97zY/dxp0lnTxk
	 c0qe1z2VUMEtAX6GiQ29wdbm7m1tXo6Y5C96hmxKDigXKTzSIgEEfLgcIK/CqVPqtvucU
	 6uzFwP4/lEjlfTIti4Lx681PX93mTmFHOXDXrjoD/EVBm8rXWsnzDkVl6QpdayFA7AA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794694384;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=D3i3JtW8zZwhx3O8fVAAShGYEZv1RrlrSS1d37HB+mg=;
	b=jyLt/pCN2XZeHcFq0BEzPBQ8OAWl5g5EBEsfljAWDCKGpFLAtaa9ukGB9DnAMx97DHbn
	 gMX6AOJQLAHDTfDTITiWj8bAbkx2dQLXW5QTSRx/1tZnkuG2Wj4ulHDTad5lNcQ33PSpO
	 ypFcp7nRZu9Xh6AcjomhpGekNQ55HOkfDwJnTAZ3m6K3G9S4ltcpxcAY7zeD/YePvLDQx
	 VqjYt7VgBV/w/pejy90hIOo0A02smD4fnSSLeR9n8HjzksOyF9E6+tkHOl8wss+VWXJep
	 oZv9jYnwPQx12Mb7346jv6jGEmQVtg4Lb+Qph/h3aYhkRNAtrPwSc0ss52Qr0QH1DOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YBZKwPBE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6493A606A331;
	Sat, 14 Nov 2026 22:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YBZKwPBE
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794694384;
	b=c3hOBt+ljH3cz/zZwWhaYmG70opnZpX87bRFXCycxaWErCyhv70DYn4R8jGE5yfHnqTT
	 BGwX9iSfZvwoCqttZqYBWuoPJK/NO/DZ8+YEArOReEPAJx2n5uXADOrZk1N7hwHGuLAk+
	 eRYo5dJAg8P/Yy2qI/CCNe9cHLpCDlRSmKrHoIZG69hika/iyCYrB23DoD3gD8nPl0M36
	 JoUrDiYqDtyOqJHj44NnjfDmnJfMfqRDnm3xY/XnUakfDWs8TFy9PdXSw5Y3uaf7NFzze
	 aBzcVBw2rnt/LBhoHrGKwXLF7Fo2EFOBPK6zMoIeAaM68MzbavlYVl8kdtX32t/Mclw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794694384;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=D3i3JtW8zZwhx3O8fVAAShGYEZv1RrlrSS1d37HB+mg=;
	b=WYrNAE+YbaOUKJQUdAVknx0c2JcgccA75llITLp+VGXT2p96CYPjfD8dRqLkVnjbZAcf
	 ehODC0MlqJ/0FhZvjWLGijJWAy543s97l2VpgB5OcXkDJJSlO97LiBmEQaOeFPKm9gGU5
	 Flo26bAj5/3E5rjywW6oa6FI4Uqv9nSEBsRxdeoNcwkk2ZwsOpEqa9X2XQio9cBZthOUq
	 cGS2PGZdUDOOSPWlltMKTeor6kov2AJyTBIVRPmTrwo2Nti33nHJl7U4jnC3ROegTURjp
	 i3sDjrUnxdbcu+Uya62EfXQ8FhVZtpU63lgvH6ryx+tzFObOx2eIVkONWtr+9v+OBpQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4EDAB1F000C6;
	Sat, 14 Nov 2026 22:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794694384;
	bh=D3i3JtW8zZwhx3O8fVAAShGYEZv1RrlrSS1d37HB+mg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=YBZKwPBEwyI/DlElZSR0LeWMdp8fjZqKnrnkTGFyKB5BXKPoBTS9g34l99UgItIIC
	 ey/2VoRLKubPTeWX2EESvc498Ub/YSjGAagJJQHJvf1rF/gnzjNaSAP/Ey0/2WF4gH
	 07hpxiXUYcpndf9Bn8Nbb0TVRuPguo0KGDkOVd7DrrbP+NuV9oami4s3pjX753xVcm
	 dYWkC8nxti8BgnVywmGRA5zY+j7gUeSy+kG/aKJzPRDpoOvnoZhIKxxVmgFvBnhoP+
	 wTcJq6hwmQm6rlftSHwcZ+XDmrFpUaeM5Ql/tVYwplNMpPcowbcQ5E3hAH6D2/urW8
	 4DUr5vkg+2OwQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D039F49E7A;
	Sat, 14 Nov 2026 22:13:02 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Sat, 14 Nov 2026 22:12:58 +0000
Subject: [PATCH 1/2] PCI: meson: Power the PHY on and reset the controller
 in host .init
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
Message-Id: <20261114-b4-pci-meson-suspend-v1-1-be3d04a13304@iav.lv>
References: <20261114-b4-pci-meson-suspend-v1-0-be3d04a13304@iav.lv>
In-Reply-To: <20261114-b4-pci-meson-suspend-v1-0-be3d04a13304@iav.lv>
To: Yue Wang <yue.wang@Amlogic.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3928; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=sVRTJrvFuucyhaCx7JzxASlark4tRG0RVp/ihG4vEWE=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFk/7rx1crwUHcWQ9/LE2mO5cybv+yaw9b7a4n25FpN22
 BzqP7Ogr6OUhUGMi0FWTJFlwiGNWxlLrv719zB/ADOHlQlkCAMXpwBMRNaF4X/KFAHrSadWJzod
 ecf1sNm6h+uI4MXTs8/wbr0w5X7ElAUSDP+LK0P5kp+66V05aZh1dmL7PZvaifxNDU39tbofTsc
 snMwOAA==
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv
Content-Transfer-Encoding: 7bit

From: Igor Velkov <iav@iav.lv>

Move the PHY power on and the PHY and controller reset from probe into
the host .init callback, and add a .deinit that asserts PERST# and
powers the PHY off, and a .stop_link that disables the LTSSM.
dw_pcie_host_init() calls .deinit on a later probe error and
dw_pcie_host_deinit() calls it at remove, so probe and remove do not
power the PHY off themselves.

This prepares for system suspend, where dw_pcie_suspend_noirq() and
dw_pcie_resume_noirq() run the same callbacks.

It also changes the order in probe: the clocks are enabled before the
PHY is powered on and the controller is reset.  Resume runs .init with
the clocks still on, so both take the same order.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
 drivers/pci/controller/dwc/pci-meson.c | 55 ++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 03dd1282f3f3..627470c83bb5 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -315,6 +315,16 @@ static int meson_pcie_start_link(struct dw_pcie *pci)
 	return 0;
 }
 
+static void meson_pcie_stop_link(struct dw_pcie *pci)
+{
+	struct meson_pcie *mp = to_meson_pcie(pci);
+	u32 val;
+
+	val = meson_cfg_readl(mp, PCIE_CFG0);
+	val &= ~APP_LTSSM_ENABLE;
+	meson_cfg_writel(mp, val, PCIE_CFG0);
+}
+
 static int meson_pcie_rd_own_conf(struct pci_bus *bus, u32 devfn,
 				  int where, int size, u32 *val)
 {
@@ -360,6 +370,20 @@ static int meson_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct meson_pcie *mp = to_meson_pcie(pci);
+	int ret;
+
+	ret = meson_pcie_power_on(mp);
+	if (ret) {
+		dev_err(pci->dev, "phy power on failed, %d\n", ret);
+		return ret;
+	}
+
+	ret = meson_pcie_reset(mp);
+	if (ret) {
+		dev_err(pci->dev, "reset failed, %d\n", ret);
+		meson_pcie_power_off(mp);
+		return ret;
+	}
 
 	pp->bridge->ops = &meson_pci_ops;
 
@@ -369,13 +393,23 @@ static int meson_pcie_host_init(struct dw_pcie_rp *pp)
 	return 0;
 }
 
+static void meson_pcie_host_deinit(struct dw_pcie_rp *pp)
+{
+	struct meson_pcie *mp = to_meson_pcie(to_dw_pcie_from_pp(pp));
+
+	gpiod_set_value_cansleep(mp->reset_gpio, 1);
+	meson_pcie_power_off(mp);
+}
+
 static const struct dw_pcie_host_ops meson_pcie_host_ops = {
 	.init = meson_pcie_host_init,
+	.deinit = meson_pcie_host_deinit,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = meson_pcie_link_up,
 	.start_link = meson_pcie_start_link,
+	.stop_link = meson_pcie_stop_link,
 };
 
 static int meson_pcie_probe(struct platform_device *pdev)
@@ -419,22 +453,10 @@ static int meson_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = meson_pcie_power_on(mp);
-	if (ret) {
-		dev_err(dev, "phy power on failed, %d\n", ret);
-		return ret;
-	}
-
-	ret = meson_pcie_reset(mp);
-	if (ret) {
-		dev_err(dev, "reset failed, %d\n", ret);
-		goto err_phy;
-	}
-
 	ret = meson_pcie_probe_clocks(mp);
 	if (ret) {
 		dev_err(dev, "init clock resources failed, %d\n", ret);
-		goto err_phy;
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, mp);
@@ -442,14 +464,10 @@ static int meson_pcie_probe(struct platform_device *pdev)
 	ret = dw_pcie_host_init(&pci->pp);
 	if (ret < 0) {
 		dev_err(dev, "Add PCIe port failed, %d\n", ret);
-		goto err_phy;
+		return ret;
 	}
 
 	return 0;
-
-err_phy:
-	meson_pcie_power_off(mp);
-	return ret;
 }
 
 static void meson_pcie_remove(struct platform_device *pdev)
@@ -457,7 +475,6 @@ static void meson_pcie_remove(struct platform_device *pdev)
 	struct meson_pcie *mp = platform_get_drvdata(pdev);
 
 	dw_pcie_host_deinit(&mp->pci.pp);
-	meson_pcie_power_off(mp);
 }
 
 static const struct of_device_id meson_pcie_of_match[] = {

-- 
2.43.0


