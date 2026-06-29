Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077D12C11D9
	for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2026 22:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782770977; cv=none; b=LgIn1sJhKt02Wr2xZb6o3jV31FoiK6F7CelU9qkyxIDHtu3Vvl6W4qGA1xMa3XxRFfYFt/Tiokur5yNUymeCG02npgNB10H+mzPSH/f34q+w/v8DKoC+Aw8GGT1mSTHFZpH7ANYxUadLkX0tbJeA3Y9RwZhxEUbxcEcL+h0bltY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782770977; c=relaxed/simple;
	bh=3ZvgkqijbuMRZHZyVD7vTyjiiO3/fzLq7IsUEDeI/EI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fPG1iUUB2dWB3nOeKI6WGPQbBxMpX63wsTpKyEXz65iVDwiVQs+wFAJTmnmsWfmVQLmFAfFKZKR4G0E71JPGSCvo/+EF9DVSPCCrnNY2AeR5LyRW+k0biSKSJrF57wkip0OzqXSYN/yBUCwHwwCY13jydn5p71mSLBVAv1UiXT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nfyv7T2a; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nfyv7T2a"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-475881b9a4bso67951f8f.3
        for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2026 15:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782770974; x=1783375774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eWtjIYRwzsZNUE+tnUUrysdcLHF0sFz6gPY6Xuye6sY=;
        b=Nfyv7T2anmPIoTxMsdqt6/qvJe2Z0w1nuGNBBMDfI7Tj/Laacjf84nwbemPcE8xcS1
         lDCsvWFTAztPRcjGF1lfnVEn6qRcEGcr395/RJzQcTvjqexHyy76ZFzCsyBUZTPt3AmP
         cdeClix+O+3EXoyKDyIihifyOflHujd9cjD1WIpGCBiRkciOmAybz8k1GMe0670ayxIN
         kB0PFwOj39YiZNSjjrGS/XoB3R7ysQZlGOnF4V0v4yLEG8HpVlZ3MocYGDVZgcXeeewP
         WeeXr5uUI1fD3rWFRguueXv+z48MVq0zLRUxpbgUaBWLtOM9j/MBdw4QeznMrWAoRHHW
         UuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782770974; x=1783375774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eWtjIYRwzsZNUE+tnUUrysdcLHF0sFz6gPY6Xuye6sY=;
        b=JN22adr2Mdci+Ga67MJsxbFh6JP755fr35zvmT94btaasjxZD1AUoPbuK/uznujUVi
         ViR4IHdSp2iN4MKv41fA+7IaCEvhxBvPbRswN06zmyomqnMzyS+kga744wX4sSVg8u60
         DdyXaZesG7db5uchVx/8U6jugHTTW9COK2CzkXydmwB2ZfclOG+srAfd/MGlvEKq6TAy
         JrUy2ghfRbiDxi0l0Pv7qz5KbwVUD/DhFCNNlAtlF8U6zORP1sgfe8YVCZlGQP3bivv9
         Tw1qJuoAhCp4UvBUpq779akYlY2Xy8m4tY326Te3o/Bn9PHYOkrEGbzFDh/ikn7165/1
         0mLA==
X-Forwarded-Encrypted: i=1; AHgh+RrenNMZEHzZooU2U1N6PsqikpCcYLDbiXujJ75CAnsDwB0SS4kUot+/uUZWesXcrYM/8prtSbmxdr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDKJywkkPDTo6OFy/ve2wPTgxyE60OFOjIGLRVbtHo8dZ6qvIx
	/guvAWx/jMgiU2sUEOeSWe3UAWqHoPFCkcb6/0yizDWlK+orALsjSArO
X-Gm-Gg: AfdE7cnvId2Z1pdA4abdV6XJcnVOLEtumaSAOGsfgKrhZv8s5dNhEXG+QXSNmDeUpX8
	CmoTwZxG+fWbjFzbb4gAFjtbqmsPhPWNx1LdOJlj/KsNVkVbUuKTjzJZsm0+aWHHSmMI3IWciQi
	S1tbF7FpkjxwavlRFsqeJzHpvgWKWmMyXq6T2GRZYwtDTFaI2jhvZeG1XpT0UXIOd/mhwvQcrdy
	a0uycIf6I937UallmJUZq86n5NIF46sPBZkMgWHE9WPMCM0I6+mFOf/iP9iR2tt1HlkkKjtjCm2
	c19H/F9s8iXtSPb2KMEGol9Nrpao5fiZcMYLjd7LC/xcfzVg+UpBM7yK5SQYMs0aw/dztfUkvaI
	T0OD6L6B8LLf/ChEkll5wRoGJ6b8Vlk2MWHukrYj3dF8eVODRJa8hXU5PjglzkjHK/tDngWMcXG
	XmVT9uG2Qo561uXA4Mt1VaqDBWcJhUxZyPzHlOxItg6ec3o8moILmnyGy6RSZ0aGovAXcm6o0XM
	gz342E96pdnp6GgF5+nsmNEHWOZcL686n6Dlw==
X-Received: by 2002:a5d:5d04:0:b0:460:1301:dec6 with SMTP id ffacd0b85a97d-475506e994fmr1291051f8f.10.1782770974226;
        Mon, 29 Jun 2026 15:09:34 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:dfcc:acfa:dec0:e556])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47563d195b3sm1644670f8f.8.2026.06.29.15.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 15:09:33 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v5 0/4] Add PCIe support for RZ/V2H(P) SoC
Date: Mon, 29 Jun 2026 23:09:28 +0100
Message-ID: <20260629220932.861445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi all,

This series adds support for the PCIe host controllers found on the
Renesas RZ/V2H(P) SoCs. The RZ/V2H(P) controller includes additional
features for PCIe lane control and supports multilink operation with
two independent controllers.

v4->v5:
- Rebased on top v7.2-rc1

v3->v4:
- In rzv2h_pcie_setup_lanes() returned early in case of error
- Added RB/TB tags

v2->v3:
- Dropped using linux,pci-domain property.
- Switched property to phandle-array for renesas,sysc
  to support multiple controllers with different SYSC register sets.
- Parsed controller-id from the "renesas,sysc" property instead of
  using linux,pci-domain.
- Updated commit message for clarity in patch #1

v1->v2:
- Dropped RZ/V2N DT binding patch as it has been merged in the
  pci/dt-binding branch.
- Dropped un-necessary new line in schema.
- Renamed RZG3S_PCIE_CHANNEL_ID* to RZG3S_PCIE_CONTROLLER_ID* for clarity.
- Added locks to protect shared lane configuration state and
  prevent concurrent access issues during probe.
- Added cleanup action to release lanes on driver removal.
- Reconfigured RZG3S_SYSC_FUNC_ID_LINK_MASTER in resume path.
- Renamed num_channels to num_pcie_controllers for clarity.
- Updated commit messages for clarity in patches 1-4.

Cheers,
Prabhakar

Lad Prabhakar (4):
  dt-bindings: PCI: renesas,r9a08g045-pcie: Add RZ/V2H(P) support
  PCI: rzg3s-host: Use shared reset controls for power domain resets
  PCI: rzg3s-host: Prepare System Controller handling for multiple
    controllers
  PCI: rzg3s-host: Add support for RZ/V2H(P) SoC

 .../bindings/pci/renesas,r9a08g045-pcie.yaml  |  34 ++-
 drivers/pci/controller/pcie-rzg3s-host.c      | 233 ++++++++++++++++--
 2 files changed, 247 insertions(+), 20 deletions(-)

-- 
2.54.0

