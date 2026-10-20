Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792499643;
	b=EltY3Pyib8lkbpfYzog4LHL5ua+lGDn+N1DzeQVas3IZL+bNqy21ymE0yObtiiV4QB8I
	 IgIUH+kRfC+n0LAt5zLLZRYnucQCURSCGmAPyEmRZ4vV3jJcA8/ZA7FAJzpd2id491jVr
	 A+jbAHy+qnMCJvFnf8KTxN7jF/MRWw69YotSLI1szYUehmNl5MEGXCIOU3gBJR0EMYOuv
	 7tysui+92IzO0okV6K6+M9yZKZJu94Ym2pmkuUZI3ueeSKpTnwgssFHTtXNqt+nbGBqb1
	 4F0sh4xQdHimGGiv2SERxGvpLrpYHDyTcnGIWV3bNX2/L3iFJVNVbZDIo+GgAiz3/RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792499643;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=+di2o+gWhV/Mdt8CDL2RNrOgyc+bSLDX+ch7unBKyeU=;
	b=pQ7GgCP5WMtkaIg8TwPe0s/s/4dcTDE3FnaY2v0Gf16YA8dmNUFO74Yj/VLi+Sxabdme
	 JL5A3zc/R11BSWrZprW5vnR/rGcz1HY0jvT79nKD04DL788rFhc310XJu6oDnSYAJqgmh
	 PYnEmpb/InmZ4sNb3tGXr1PgYGsRWmJyXxw0FzryYoXXFLywO5kOZYcr96+PraK5p6b45
	 Tq5wVuGS5bOp5qS/a4uyXJngs1r5b7uiZxluPepBJmUfNhpK8CJJxGcHcaCsyrvCZLy3s
	 HC/9cSquliCP+/xrB1gVLHuS3lrE0ulqUObprxMJCbWgbsyvg6nsDNWxY/pKhBbhTEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QvdfPGOM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB0F606A324;
	Tue, 20 Oct 2026 12:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QvdfPGOM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7A11F000C6;
	Tue, 20 Oct 2026 12:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792499642;
	bh=+di2o+gWhV/Mdt8CDL2RNrOgyc+bSLDX+ch7unBKyeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QvdfPGOMusSovjmu2J3AL+GvQ4oDkwfOH1HWlw9NnWC28kVdel0JELdb/cjr/GRCs
	 dKGxJF6Y0AFFOo9LIxUI8fjLW3DhwLzYRbtqOJLxKp0WN3QLwHh6TFArp3YZdZ8wdn
	 LbWVPhlElQbXOh3beeuH77vcbdvnoCgQT+edvdLHWgbTTx4qCh0vSORXxYtZyDdNqo
	 ybdkw4mC4Q8dC7zZCiZ5nIOeMXRqPgOOFy5ysEHgRZfSqp2a+BOWFXqvj/2hnFbSQK
	 dKyuZmiRB7Y7WAYMSEHd69oxI3JEe2Ag79IsGQsH1EJ0b6NmgWLmq5p1YLg0V35Zmo
	 3f5FRKQQugGLA==
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Yue Wang <yue.wang@Amlogic.com>,
	Hans Zhang <18255117159@163.com>,
	Rob Herring <robh@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Keith Busch <kbusch@kernel.org>,
	mx2pg@pm.me,
	Lukas Wunner <lukas@wunner.de>,
	Frank Li <Frank.Li@nxp.com>,
	Mahesh Vaidya <mahesh.vaidya@altera.com>,
	Ricardo Pardini <ricardo@pardini.net>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Myron Stowe <myron.stowe@redhat.com>,
	Jon Mason <jdmason@kudzu.us>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 3/3] PCI: meson: Remove redundant MPS configuration
Date: Tue, 20 Oct 2026 14:28:57 +0200
Message-ID: <20261020122854.1500883-8-cassel@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020122854.1500883-5-cassel@kernel.org>
References: <20261020122854.1500883-5-cassel@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3582; i=cassel@kernel.org; h=from:subject; bh=8A6kVOEOI1Elwkt2gv7aY97GUnbFGvIaDt1eD+AgmqY=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLKux3X8tX5/rt8vJ3XusbBfOnYm7UJJdzpenzdNnLtCM eDefpk/HaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZiIqwnDPxvf24ds/j82WXUp M4hV97eHm0fuGt+p659fXT9dkjHG7yXD/0z20PA11npWDyRtrfynT2rZxjA3QGWCdYnd/+f3Uma aMwEA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

From: Hans Zhang <18255117159@163.com>

The Meson PCIe controller driver manually configures maximum payload
size (MPS) through meson_set_max_payload, duplicating functionality now
centralized in the PCI core.  Deprecating redundant code simplifies the
driver and aligns it with the consolidated MPS management strategy,
improving long-term maintainability.

With meson_set_max_payload() gone, meson_size_to_payload() is only used
for MRRS.  Rename it to meson_size_to_mrrs(), update its comment and
warning message, and drop the now-unused PCIE_CAP_MAX_PAYLOAD_SIZE and
MAX_PAYLOAD_SIZE macros.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Hans Zhang <18255117159@163.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pci-meson.c | 27 ++++----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 8559d132dcde..48e88e425474 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -21,7 +21,6 @@
 
 #define to_meson_pcie(x) dev_get_drvdata((x)->dev)
 
-#define PCIE_CAP_MAX_PAYLOAD_SIZE(x)	((x) << 5)
 #define PCIE_CAP_MAX_READ_REQ_SIZE(x)	((x) << 12)
 
 /* PCIe specific config registers */
@@ -37,7 +36,6 @@
 #define PM_CURRENT_STATE(x)		(((x) >> 7) & 0x1)
 
 #define PORT_CLK_RATE			100000000UL
-#define MAX_PAYLOAD_SIZE		256
 #define MAX_READ_REQ_SIZE		256
 #define PCIE_RESET_DELAY		500
 #define PCIE_SHARED_RESET		1
@@ -256,45 +254,29 @@ static void meson_pcie_ltssm_enable(struct meson_pcie *mp)
 	meson_cfg_writel(mp, val, PCIE_CFG0);
 }
 
-static int meson_size_to_payload(struct meson_pcie *mp, int size)
+static int meson_size_to_mrrs(struct meson_pcie *mp, int size)
 {
 	struct device *dev = mp->pci.dev;
 
 	/*
-	 * dwc supports 2^(val+7) payload size, which val is 0~5 default to 1.
+	 * dwc supports 2^(val+7) MRRS, which val is 0~5 default to 1.
 	 * So if input size is not 2^order alignment or less than 2^7 or bigger
 	 * than 2^12, just set to default size 2^(1+7).
 	 */
 	if (!is_power_of_2(size) || size < 128 || size > 4096) {
-		dev_warn(dev, "payload size %d, set to default 256\n", size);
+		dev_warn(dev, "MRRS %d, set to default 256\n", size);
 		return 1;
 	}
 
 	return fls(size) - 8;
 }
 
-static void meson_set_max_payload(struct meson_pcie *mp, int size)
-{
-	struct dw_pcie *pci = &mp->pci;
-	u32 val;
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	int max_payload_size = meson_size_to_payload(mp, size);
-
-	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
-	val &= ~PCI_EXP_DEVCTL_PAYLOAD;
-	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
-
-	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
-	val |= PCIE_CAP_MAX_PAYLOAD_SIZE(max_payload_size);
-	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
-}
-
 static void meson_set_max_rd_req_size(struct meson_pcie *mp, int size)
 {
 	struct dw_pcie *pci = &mp->pci;
 	u32 val;
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	int max_rd_req_size = meson_size_to_payload(mp, size);
+	int max_rd_req_size = meson_size_to_mrrs(mp, size);
 
 	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
 	val &= ~PCI_EXP_DEVCTL_READRQ;
@@ -363,7 +345,6 @@ static int meson_pcie_host_init(struct dw_pcie_rp *pp)
 
 	pp->bridge->ops = &meson_pci_ops;
 
-	meson_set_max_payload(mp, MAX_PAYLOAD_SIZE);
 	meson_set_max_rd_req_size(mp, MAX_READ_REQ_SIZE);
 
 	return 0;
-- 
2.56.0

