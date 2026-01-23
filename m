Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A678299AAC;
	Fri, 23 Jan 2026 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769176911; cv=none; b=VMQBPWHPhs+TCQMlk7Rsrq4ZT4QXFtjnQnrEDarbAnlg1GOR9a/ke8lKP+5KGCL9vfXvAdrr5pDfekPMe76hxia55jFYSnaZkFradCtFSbRKTDINS5WuTWU5bfAX56jN/AcOJMETBlzG+DY+CpaU71WNc+ZPnUsXTaU06ma/OO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769176911; c=relaxed/simple;
	bh=pdMY4Ltn80BAph2gCnpf0AGaVI0TJiNZYTEg4w7mtkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6aZ1u1P/2hAZ8rtXstHARzmMAI6vDhkbazLCaRwF/ZEX0C6UENyE/HV2td7jCTQlx8l5c4Uyf77KO1QYTVDqF5Gj20kC92zcxwd3xfQj1bX7u0bYwlPbj+DgnJ2HNUG2jzMsqjzp78aMdZq6c2hwUQHlKs9klLs6ogXQVS/OqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: aU54wQc1Q7++0l/4J+4FMQ==
X-CSE-MsgGUID: gQjnUyHhQUKYTNGOY9hk8w==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 23 Jan 2026 23:01:48 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.92])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 19B54406E3FB;
	Fri, 23 Jan 2026 23:01:42 +0900 (JST)
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
Subject: [PATCH v2 05/15] dt-bindings: PCI: renesas,r9a08g045s33-pcie: Fix typo in interrupt-names
Date: Fri, 23 Jan 2026 15:00:21 +0100
Message-ID: <20260123140031.94752-6-john.madieu.xa@bp.renesas.com>
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

Fix a typo in the interrupt-names property description: "ser_cor"
should be "serr_cor" (System Error Correctable).

Fixes: e7534e790557 ("dt-bindings: PCI: renesas,r9a08g045s33-pcie: Document RZ/G3E SoC")
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---

Changes:
v2: New patch

 .../devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
index d668782546a2..df30f729d4b3 100644
--- a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
@@ -42,7 +42,7 @@ properties:
   interrupt-names:
     items:
       - description: serr
-      - description: ser_cor
+      - description: serr_cor
       - description: serr_nonfatal
       - description: serr_fatal
       - description: axi_err
-- 
2.25.1

