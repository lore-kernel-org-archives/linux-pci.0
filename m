Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794250196;
	b=lkcLBTKlLwP6u7PRWw0XkoNNvb+rmr6TmrdwHDF+coXlzSrSmF39avb4NNtKNIDw6dOn
	 Z5l2vvKAbIscEmgmojsbNuAQ1DSZIdGNdsXpwL+LnZ16+Npnrgcc/QPW8cMve7cHbM/yn
	 18sXD4dPRCPMonwBSD7iKbGPX6KUG49Q5963GCGz4IlG9ghiNuNJZvdyTS0wgq6QYDIWB
	 8VQkKJmIKz7hP8jbLOIaCR1t6Lb6x3KQeBxxa5eZEimp85qP19i/+kKh/x2oGNKbJ00hy
	 aoHNNtZFiKKExHAz9k5x67xHwlZkTtXfHeXWCkq9lxNf/EKoMbKTayizkP9wrC0NUCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794250196;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=THGngqhatlE+u83536ffwHcOrp0mYpAierLo9Jo609U=;
	b=VJprZ+HgMOAFjJdfwMM9HRK1JhiIBeHY54LyMEnTBpyGNxUmbWnoysXyPCdQupsTlhMV
	 oOLNCDDPltnCw+gctFS72oNU5xOdysUNnBupwz4z0WrIJauqhNrx/yE1omNGkU5eI9Q9t
	 P9wZsxnYsxQbBp2GixeOTqJPbrXmPjgiI5wQoGv0XT41I6JBymprRnDCkWo8zpNyfU0xH
	 JboW+ssfE7kTh72tGvQE3A80pvBg3Yg/+PsMJKYWNb0OUkEhhimxmNK1PWrJNSGSEeO77
	 OcJn70FsFI98S3Qn5QebEtUKRIi5kL23aTP9Dzk5m4ZZwk2USyOWTXZ+aIJFlZrjtlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e9QTvSfJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D53606A325;
	Mon,  9 Nov 2026 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e9QTvSfJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C419F1F0089F;
	Mon,  9 Nov 2026 18:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794250196;
	bh=THGngqhatlE+u83536ffwHcOrp0mYpAierLo9Jo609U=;
	h=From:To:Cc:Subject:Date;
	b=e9QTvSfJ5Hq1C2T0Q320b9VMbgB/lLDPTWchtqYQ/xpzulY47Z6/Nh7c/BEKh/Oxw
	 xT5MhV4Q+SkJmDowxM1SdUJVilikxjkt9K+HY9KiI6sj77j7OzQm2+O20UZpLmPwtJ
	 v5OB4pWcmrEmKtwlKApmYj0mctAEJmOM0RnkRSX56QWh8tA78CACUUvO0QydymGvio
	 z5IWEJeuEyGd0M5vUG78PiIpoPNBMgMRsc7FE47j48HRt9Fv+CrZ6tQ1nJ4c9C/AZL
	 G8pMjhVoNnYUdHEZV8xdSfbERCZpI146ViQlIAyTx9YgVIWZ/RDZFCqI+WT71Ha3+I
	 k6GZQDSljZu0A==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: PCI: rockchip-dw: Allow endpoint supply
Date: Mon,  9 Nov 2026 12:49:47 -0600
Message-ID: <20261109184948.477095-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rockchip PCIe endpoint DTs describe the 3.3V PCIe regulator with
vpcie3v3-supply.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/rockchip-dw-pcie-ep.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-ep.yaml
index f2d1137aff50..8915ca3b9f0d 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-ep.yaml
@@ -40,6 +40,8 @@ properties:
       - const: addr_space
       - const: atu
 
+  vpcie3v3-supply: true
+
 required:
   - interrupts
   - interrupt-names
-- 
2.53.0

