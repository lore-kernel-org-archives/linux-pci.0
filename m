Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EECD34CFC6
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 06:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778222214; cv=none; b=DcRe7zU8+fUQ2z3WIfx40NCZzVBwrNKH03UO0Xl+ABYIq4jVTeYGNrrjmuu4mkVY1jreD2bguxm5L0oKlOovlHaab3vTd068ovz2MtoT1fcjYBaKa/pp7xGJk5juMXFduZi+uH7p8frILBtCHrXyZ55+W2zLeHoir03P2MgoB5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778222214; c=relaxed/simple;
	bh=9jqLAACjfGjKanuQVNeQ7eoQMeqQBRzeZ3dpRjunfuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tMURTZTsYFjIlFKxqlu8FMuvftEeAzkcD2HW2ybWfYo4ssehpe/m4+X39ieAWCYRtU+uib3Sb7flD7PsjcT4Eo87ENwEkDjKMz4fxDEn6LqOWRvSVw1hzZ+Ys+azUbJ1ltizsRk49x75l5DY1e9F7tcWhKV5ORYwBzzH7J3QFzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V4KBoMSO; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V4KBoMSO"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c80148ae949so723322a12.2
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2026 23:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778222202; x=1778827002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=22ncQpWLdF2X8pTtJBnqzgTb5DeYk3+PKhZtvYNM/EM=;
        b=V4KBoMSOVmUilffq/53aV8sUf+yvt7SDCNNXjUJpOemFFhyW9EYBhX91yjFh3+jBOg
         ifnM4Puk0SkxvCcYvKTCy/oQdJ72WZ5zdA5ULyBiCzYc06/hJ1twPiMLI93GqoCrUdoY
         szZCnvJqgbcrrMTv8y0yX6I/5AmrF5NEOreBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778222202; x=1778827002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22ncQpWLdF2X8pTtJBnqzgTb5DeYk3+PKhZtvYNM/EM=;
        b=Vlve/LirP8cYaiyDmJUcUGb3+ws4hfe1jF1hgxdzJfw3jf3RVw0z1e3XvYP5NYRWLg
         TjcMvA6aTWmjM7+LYNPXnCN7BeVFb+eE5xxTaIx90+Gk5uARiLp0Dnczkq11+/A4Qaww
         4nNKpY9WZigO+Xmh0RWTvCrR/C2W8qvBXrlVoRSay7qMDXfNv1py8O2n2Q8BAyQLEXDq
         1ZQ1FdKZX7Uu5VGwts7NPRHBoMtKw24VeatuhxGalAPwfIEAJKFl3NSsN/nphlmIN/cc
         EJZNMhvR7QoBdxg6Rg6hzo7a+x6Nw6UACylymcu4UHpzpQhZLualCF0cA4wJtWv6CRRR
         IIPg==
X-Forwarded-Encrypted: i=1; AFNElJ9qyrxe3je0dZQSnkmoKDv0/dqDq43OieTwMfEqnKCOGiSVM/aLCddESolb5a/4nnTi2RzvCOJf2/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyiRW608KfW9NsEofseFKcikxq8CaXj4aSduVOld/HU7kbqZEJ
	+M0pKQJfLjZgoAy2SwcKW/Hv72JEZbsmkYG4R4blkSndyeLSpTGhn95A0rnLTCkBRA==
X-Gm-Gg: AeBDiesfXmF8QPpZvAQX8eQLm5NcnGMBs3vH4NzKG8S5qaeNoNtFAbaTocsQjDsUiVp
	kdLHzI1neb6gFVm5EM32lrzSXlK9krwgWqZYZ78SiBQrU97ey60+nXpx+pZxw9RQ/f6BfmZlHOQ
	EELKjWU6xlAR/TiulygLmHwfQroLrcqzYoNtKaRiLKFcnHb5i0KApK3Ob2d/gIf1HGJzFhaUhrR
	6BWBBtNVIID42F488rXXXx6Wdv6EyDEND3IOaahncTgFKBdYLbKXaqKDTy1QhAs39FZrBPwovCC
	EutK0cIbT5fshaRhwzann/qhASyLE7W6vMHokrRuFvOODf1eV+P/dhUhGvC31wOhlPCWCE5ckVC
	ClGZYzzHv6cLJLoxQPCAJs6k2eJvb+Y0n/fq0i4SLwJBrQbMj303oKE0pMnlJCeMq7xlU32LauM
	WUVBKdTz4RIS+7tm8Vq9oW/mPShfv1mmZKoSWQLr1l/G3uCe3E9WxEVZTTWZt3WXumppvah375q
	Yb/5UDe/GhmgMJEZg==
X-Received: by 2002:a05:6a20:939d:b0:398:6ea8:21f7 with SMTP id adf61e73a8af0-3aa5a9559ebmr11751571637.15.1778222202210;
        Thu, 07 May 2026 23:36:42 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:bac0:e137:a29f:62c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbee14sm14850717b3a.48.2026.05.07.23.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 23:36:41 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: PCI: mediatek-gen3: Allow memory-region for restricted DMA buffer
Date: Fri,  8 May 2026 14:36:32 +0800
Message-ID: <20260508063633.3894348-1-wenst@chromium.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some SoCs without an IOMMU behind the PCIe controller, the PCIe
controller memory access could be limited to a small region by the
firmware configuring a memory protection unit. This memory region
must be assigned to the PCIe controller so that the OS knows to
use that region. Otherwise PCIe devices would not work properly.

Allow the memory-region property with one item pointing to a
restricted DMA buffer.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
This patch compliments another patch that moved the memory-region from
the PCIe device to the PCIe controller [1].

[1] https://lore.kernel.org/all/20260430120725.241779-1-wenst@chromium.org/

 Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
index 4db700fc36ba..4a9e41d01628 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -115,6 +115,10 @@ properties:
   power-domains:
     maxItems: 1
 
+  memory-region:
+    maxItems: 1
+    description: phandle to restricted DMA buffer
+
   mediatek,pbus-csr:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
-- 
2.54.0.563.g4f69b47b94-goog

