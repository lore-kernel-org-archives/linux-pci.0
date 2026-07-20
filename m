Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1FA3AFD09
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539301; cv=none; b=dDWEXZftjCyfep0g8BPPwQch+5SZepBkvEjwinu8Vd6jsyiMOFBaribgGDr52VXtsXMpMRTgiEy9iWi2VNHCbW3pP8MOgg1YN8WZ5akzlIHIt+kmboEGxHy1Hq/CQUMR9hEr1cago/jT4nom2YfOCx0rYVOtYeeB3v+fR/tOiPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539301; c=relaxed/simple;
	bh=zaw4S1LTgksTd7JqLX2+9jYrm669Liu7tsZGJ1zxoiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YF1//v9PPGtSVy5AHRNceTFMCbveU+N1Np/PRoKX1UaqD1mLBOCPe2i8kb5Asdn3rtFy63JKPoeWUWEeQS4XG+OuvkOPsfq580N8Df9tNA2kd5a8Zc/I+d1dzC3sNpp8+0ZJhZqN+EwoRfDzTHuSBHXoGFrQmfUFNNCYWGhvhLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LVAfACH5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LVAfACH5"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cf52d15d88so12929085ad.2
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 02:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784539299; x=1785144099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dEo1zfdAxyxkmckxTePHzZtAsHT/hlKIP/V7KkMgw7A=;
        b=LVAfACH5zWYu+rAdWtdnQXMvjtoVMj9ed4ytr5gUPJBblRJUVRK43RvX+1dX/Cql8B
         3aBaHfdKcMEC6nZn3K+IJdvORq85X2q6oiqO5M139gpe394nX25vEhdrqDhhYIaH7v+W
         Ao4jnbaxdL10p5IXpJ/WAhHhmYiHIWFaPDcUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784539299; x=1785144099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dEo1zfdAxyxkmckxTePHzZtAsHT/hlKIP/V7KkMgw7A=;
        b=eDir1lwxQ7KhSFSn4v6AC+RTrKlV4tPUtEeXq7Lagt/BNqfPO0lK8SkKwExW+6LGHi
         AA8cPMamWfnb50gyGlEK5Zh7TXzX26ETZMdFAyrXNXFjbxBljgizNeXgRhHjJHFhSDyK
         /u0HDw7MbZvplPja5r0O7hXlOdT6SjLxPabjJi6CgnK0oZ1dmC6T/e+IQmsU5pWJC/Lk
         nbVwcwPbDeqNLAP3j/ncBTW3mErgadF+hElhMyxjRspVVQXR3kWQqyH/bOU+WWwRS0N+
         lBFiQ3QC9sxgYP+swCYnXSzN7cdCRTOC8haG6xIumKhu6MXcFUN3Lul71n1ia30hwfZo
         C3ww==
X-Forwarded-Encrypted: i=1; AHgh+RqKiOGzOd0/kDjgnFBXyZv9ZQVj4heE/3uEa9d0w2IE1Ncg8AALfImLviWHuAAIQ3IgWMPi/+iaOfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDoLTIFoe3UmHh//96mHCtrte93+s5il0OXwGHrFGdIxsjRDw7
	kpTa7lnDpknvBk5rNMQfOijjQCFSaHnVL60g6LzNCkJyOe1BWfGe1QHuGhNpVX4Nvg==
X-Gm-Gg: AfdE7clyaff/8jUPPVVXWACcC5AxRCBgpQwv/Kmqy8b0QPIalq62wmRLXxtWRh+2k+C
	9m74pted69fe1OXoNp5ToAL+QhvUUHSDFpKYt6yc7QekgJvtyaf2mIPCkgLqukdJrYxDvoTEhHZ
	mxiqIgsTBeXAi2m3TClMwMBnih72HDfoZd0s12dRVxBTiR4hMGFsZXNDElYcyZcfokbwXAHAqGR
	0/3O9VufEbmv3hn8My35dmANxB1awtVSuO4mPYQpg00rzPgKvQo/IB1HRef0pSBBiwZ9jwHwZU/
	muIDapqnr/SsPSiqCVSO4i+XApampGJEQOxkb1O8wd0VFR2OJDE4ycJt5JNdV2jPmKgFUW5IvtL
	t3a0QcVZ9/xIAJRIXwVCRD6E0uQ+VClKIWG0/0FaLWhTpxB1DOAw8Gta/oNKrhI0J+U/Ph5aTVQ
	GnoslgE32aeDSxvuyvH6RxbUCYVcyemHOUonUdXRhhwbik62NG5ABmik6raNsg8MG4q0yMBg==
X-Received: by 2002:a17:902:e80e:b0:2cc:8267:31b5 with SMTP id d9443c01a7336-2cf3489a830mr141008405ad.19.1784539299565;
        Mon, 20 Jul 2026 02:21:39 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3916:f048:32c3:931f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344be458sm53775345ad.25.2026.07.20.02.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:21:39 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH RESEND] dt-bindings: PCI: mediatek-gen3: Allow memory-region for restricted DMA buffer
Date: Mon, 20 Jul 2026 17:21:15 +0800
Message-ID: <20260720092116.1823562-1-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
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

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Can we get this merged for v7.2? A matching device tree change was
already merged in v7.2-rc1.


 Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
index fbc0378392d4..b88717dec1fa 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -116,6 +116,10 @@ properties:
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
2.55.0.229.g6434b31f56-goog

