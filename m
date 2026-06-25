Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B39B374E73
	for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 21:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782424679; cv=none; b=LDlPiLyU3daPLjn96WDTNyvoMMMRmW/c1CMnGGn9Pu4IWqS4+s5zMvRdcmAzOrvirF/ZcEs7H3RuFIQK083lkNKsQ7IF1hdIPPlFY4c6DI+ezLzak785U6fyinGalRaQHZv/PbBosmPuyPxVVHgUrZe8ZHS5vih1RnrR8rG4TAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782424679; c=relaxed/simple;
	bh=46jnChl2wMQ+0gZn2yaYikR3dO6y8zMPR9FWL51dirc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QDB3tOjJU294HYLapgzMlmoT9m3C1/3Q2pxgCZjESd1akL37LhePoQxXj0KQg3TTgXRXPyZ0vbjW6wbWpRoVS6lVinbQ56n0n/dV1gzwbbdn0UsW04DIjphRb78p2TeupYoRhbhCNcealKiXr2aSfbDV72Cd19kt6RknGcPD1NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hC7JLwuO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hC7JLwuO"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b9318997so2551925e9.2
        for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 14:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782424677; x=1783029477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/GDPKha/I8hlDx0JY3/FoA06iUy7EbgInPO5kMOUnzM=;
        b=hC7JLwuO0WYi0WhAb7P0MGyaaRuVutebLmfOKIz+6dNJBUhYpzKFb7Oj4HhSSt3Ht/
         j1aQ5IZub3BZuK3dPFebnWHmpkUOMjG5m1NXqtw0pyYzU7VKLduWttzZ66d+EVq3vxUd
         Z6f55TaH+1pwY2YtK2whgphRaya3Q9+cpfrL5DamzlS4vfQzPbW/SCZOXub/VNFxVcnd
         XMYZyc4hftgcD6bEKLacn6r7+icwcEdDxZqOD/jJWDL3uVqxYjKVmdFwSNufDarFJWdd
         Ab/FiQlju492ejXJ0Z3+i5AQdSat9QCaIlwzbUqa6e6Wdvrpzx7BJ00kcLcdmaKrcysy
         b6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782424677; x=1783029477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/GDPKha/I8hlDx0JY3/FoA06iUy7EbgInPO5kMOUnzM=;
        b=ssLFaqzSVjKXJyrEi3Kgf631vcTGidQLCO3ttOxYsFRzkhVKJhNnKEh9g5SL53fg7k
         SxXXXaSr4ZmexDdanxmCMSmYTLeKyuJ/7R7O9Q8K2OejuKVSRQMg3rjI13yH8ZdawEbO
         dZMHkzxM3k+AnERuJSynMxTbv/Q+iLL8sqeOXlfDuvbn+qvv+vW/PO7tvSsAzQGhZQXr
         Yds7HyFFvla/BodfySRq9g0KEBa5l/Fd+Y1vI2viH82SqYfjudMGo6GD9whDF+bx2BEa
         Y5UNUMTfvU4X3YMfc2UEq+EAsoEKbxL13WKFdWnN4CptPZRJi1CN0+b9hMoeNCJdaosk
         2VEg==
X-Forwarded-Encrypted: i=1; AFNElJ+l6ul85Rbu7BaSTr9ka6p4+DPInPcW3zkbNQu2o4aWZ1LqATMG2dwU+7fUk3vbLSZ+6XbypJzFfM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjCh1tQ38WML6BXbWEqhj+tJ9XgzfdLywZQPVR4iyeN6Knd/Qj
	36x0zIlqs3N6cDqSFYGZrO0W0NNCEsNrjVFL0EoUOBwXW3L6+EPUXk8R
X-Gm-Gg: AfdE7ckNbL2sjUdclkl2q90Yt7Gf/7iXuyZxdc2WA2Pt3TWUiohOaQ0P6qV3B2TnPpz
	ZRx8KM/pFmjQHkUZpZCe5KGhrHk9purfc2Rrtu2VAs4wycA3SXCMvPAHb5hdH10DsuMjntey3n8
	CGUVJ+6pewrec3k74h6GkeZm1ozFnnX38OKK633rWAN8ex28/yqmwlGQirCegIoI2/0FLulo9ZP
	EHTksbBo6kdrNcXw6eP308oMwso462AjUS/VVEpHA+5BYweWtSnU32rE26pAeTa7GuigLIZEjFl
	NYgU+IQJHGwm3EGYSXAPtKEgGdduWxo781NBw3Ezog27bWCTtyhIkQwRYW8RvtGwwsSaqWXQmlx
	zqS7FiuwXrLsznGPH8Ct6EMjspGbHb/o1jcd1C13v1ZusDyC6qNsPfSoj5326sT0OD2knJHpzsF
	yvylA5nxIDbdcNfdIKqlrEB1Aor2Stx2IAVivPl47CB+ryYLcK4h/Weg3Q8gwodw2z33YXgJwDP
	bmCVv8RTMZh
X-Received: by 2002:a05:600c:4353:b0:492:1eed:3e67 with SMTP id 5b1f17b1804b1-49266893383mr39799415e9.26.1782424676723;
        Thu, 25 Jun 2026 14:57:56 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-80-183-219-152.pool80183.interbusiness.it. [80.183.219.152])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-492690988e0sm27339185e9.14.2026.06.25.14.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 14:57:56 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/4] PCI: mediatek-gen3: Add 2-lanes mode support + clock
Date: Thu, 25 Jun 2026 23:57:33 +0200
Message-ID: <20260625215741.3253212-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series introduce support for 2-lanes mode for Airoha AN7581
SoC. This is needed for correctly functionality of Eagle WiFi Card
normally attached to this SoC that require a 2-line PCIe card to
correctly work (and give the proper performance)

The first 2 patch address a limitation of the PCIe implementation
where the PERSTOUT reset were indirectly asserted and deasserted
all at the same time (for all the 3 PCIe card) with PCIe
enable and disable.
The 2 patch address this and introduce correct reset to control
reset line for the relevant PCIe line.

The last 2 patch add additional logic and support to assert
and deassert the PERSTOUT and also apply the required configuration
for 2-lanes mode.

2-lanes mode is implemented in DT by adding the required property
and by defining the "num-lanes" to 2.

Christian Marangi (4):
  dt-bindings: clock: airoha: Add additional reset for PCIe PERSTOUT
  clk: en7523: add support for dedicated PCIe PERSTOUT reset
  dt-bindings: PCI: mediatek-gen3: Split Airoha schema and document
    2-lanes
  PCI: mediatek-gen3: Add 2-lanes mode support for Airoha AN7581

 .../bindings/pci/airoha,en7581-pcie.yaml      | 251 ++++++++++++++++++
 .../bindings/pci/mediatek-pcie-gen3.yaml      |  77 +-----
 drivers/clk/clk-en7523.c                      |  27 +-
 drivers/pci/controller/pcie-mediatek-gen3.c   |  98 +++++--
 .../dt-bindings/reset/airoha,en7581-reset.h   |   4 +
 5 files changed, 358 insertions(+), 99 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/airoha,en7581-pcie.yaml

-- 
2.53.0

