Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462F9282F26
	for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 02:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777515958; cv=none; b=RLjunmke3B98/SiT+RWT45anJBGsbpvuOTZrvujOLM+vt5D6oYQESP5NuFsgOeOf1EOFC7WWcYrPjKyQDd/6zVPghzN1+GMO1Jc4Unj2v8S1niv7rHEzLVtmGG8i+TxUDBdB4VLpbDf9pNWOPtiqvpnv2V85toIj/nCm+17T9kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777515958; c=relaxed/simple;
	bh=2YfcaCpVj8I0+6vfMIX/411ZUiHo41zjdzHXYSM43QE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tFJjixebDudCC2OV0FOohiP9wrj4ptzdjAHdBXIVVYaD1n+tNZOAdKQ1fPQMufkISkFOScZ72cVHSID2iKyIiW7kcwohZ3RB5oGmvqXbn/TUQ8U9iDVevmjm1PNP3siabPH9PhPc7axGDjmY3cATCU1y4nHrnbd9DF2cCMxZ/34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=RBnHOaT8; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="RBnHOaT8"
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C090F2C03DB;
	Thu, 30 Apr 2026 14:16:46 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1777515406;
	bh=HCK71yqemvhP7M6VURV0XNIhfF8xXPI+wMqttk0c3rI=;
	h=From:To:Cc:Subject:Date:From;
	b=RBnHOaT8DSYkT5MNqWxPAjxIqaG7zpkgXdJ+Lc1ahiwIV7WPD8/gUwQbgBXc7Qoj+
	 fDXu29nSnT1O0soJMDByI7nfxJKLS/jNTlyOcO17+fxYZgxWezznsxerT31ulqCHxY
	 6zXj7tnlHJ+iJJQXEYTuU2/efYGtVtxIeOmNNkIF+OroiXu2TPas5/A0aeMqqxICT7
	 dKW0bb51kEYIsazPj6p8mDGN0+dghcIEw3svDlZvdOr2CsPy/gBFG1fI0ABCEZPe+T
	 Ne0WN/IuJXfrzqsKsUfzMOIwnF0PwtctT2WWeki1Jpk6sZaT6upGnMk0prohTrKgKp
	 mkQgHNbUZXV1g==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B69f2bb8e0000>; Thu, 30 Apr 2026 14:16:46 +1200
Received: from markto-dl.ws.atlnz.lc (markto-dl.ws.atlnz.lc [10.33.23.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 9352D13EE37;
	Thu, 30 Apr 2026 14:16:46 +1200 (NZST)
Received: by markto-dl.ws.atlnz.lc (Postfix, from userid 1155)
	id 8D9BA40695; Thu, 30 Apr 2026 14:16:46 +1200 (NZST)
From: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
To: rjui@broadcom.com,
	sbranden@broadcom.com,
	lpieralisi@kernel.org,
	robh@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Subject: [PATCH] PCI: iproc: Restore map_irq
Date: Thu, 30 Apr 2026 14:16:28 +1200
Message-ID: <20260430021628.1343154-1-mark.tomlinson@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=FPe4xPos c=1 sm=1 tr=0 ts=69f2bb8e a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=A5OVakUREuEA:10 a=0iGZelks7BQB0ZmUgWIA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Some time back, the PCI bridge map_irq and swizzle_irq were set up with
default functions. The iproc PCIe driver was broken by this change, with
the mapping function ending up being set to NULL. Restore the original
(and intended) behaviour to use the default functions.

The iproc pcie kept the mapping function in a private data structure,
which was then copied into the pci_host_bridge structure. As the private
data was initialised to NULL, the NULL would end up being copied. The
fix is not to keep the mapping function in the private data, but just
set the function pointer directly when needed.

Fixes: b64aa11eb2dd ("PCI: Set bridge map_irq and swizzle_irq to default =
functions")
Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
---
 drivers/pci/controller/pcie-iproc-bcma.c     | 2 +-
 drivers/pci/controller/pcie-iproc-platform.c | 2 +-
 drivers/pci/controller/pcie-iproc.c          | 1 -
 drivers/pci/controller/pcie-iproc.h          | 2 --
 4 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc-bcma.c b/drivers/pci/contr=
oller/pcie-iproc-bcma.c
index 99a99900444d..593418c2bc3a 100644
--- a/drivers/pci/controller/pcie-iproc-bcma.c
+++ b/drivers/pci/controller/pcie-iproc-bcma.c
@@ -64,7 +64,7 @@ static int iproc_bcma_pcie_probe(struct bcma_device *bd=
ev)
 	if (ret)
 		return ret;
=20
-	pcie->map_irq =3D iproc_bcma_pcie_map_irq;
+	bridge->map_irq =3D iproc_bcma_pcie_map_irq;
=20
 	bcma_set_drvdata(bdev, pcie);
=20
diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/c=
ontroller/pcie-iproc-platform.c
index 0cb78c583c7e..4c9a0c4bb923 100644
--- a/drivers/pci/controller/pcie-iproc-platform.c
+++ b/drivers/pci/controller/pcie-iproc-platform.c
@@ -98,7 +98,7 @@ static int iproc_pltfm_pcie_probe(struct platform_devic=
e *pdev)
 	switch (pcie->type) {
 	case IPROC_PCIE_PAXC:
 	case IPROC_PCIE_PAXC_V2:
-		pcie->map_irq =3D NULL;
+		bridge->map_irq =3D NULL;
 		break;
 	default:
 		break;
diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller=
/pcie-iproc.c
index ccf71993ea35..c22d0aecaaac 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -1502,7 +1502,6 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struc=
t list_head *res)
=20
 	host->ops =3D &iproc_pcie_ops;
 	host->sysdata =3D pcie;
-	host->map_irq =3D pcie->map_irq;
=20
 	ret =3D pci_host_probe(host);
 	if (ret < 0) {
diff --git a/drivers/pci/controller/pcie-iproc.h b/drivers/pci/controller=
/pcie-iproc.h
index 969ded03b8c2..c4443f236ca3 100644
--- a/drivers/pci/controller/pcie-iproc.h
+++ b/drivers/pci/controller/pcie-iproc.h
@@ -61,7 +61,6 @@ struct iproc_msi;
  * @base_addr: PCIe host controller register base physical address
  * @mem: host bridge memory window resource
  * @phy: optional PHY device that controls the Serdes
- * @map_irq: function callback to map interrupts
  * @ep_is_internal: indicates an internal emulated endpoint device is co=
nnected
  * @iproc_cfg_read: indicates the iProc config read function should be u=
sed
  * @rej_unconfig_pf: indicates the root complex needs to detect and reje=
ct
@@ -91,7 +90,6 @@ struct iproc_pcie {
 	phys_addr_t base_addr;
 	struct resource mem;
 	struct phy *phy;
-	int (*map_irq)(const struct pci_dev *, u8, u8);
 	bool ep_is_internal;
 	bool iproc_cfg_read;
 	bool rej_unconfig_pf;
--=20
2.54.0

