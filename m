Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C1F3F9F5E
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779119621; cv=none; b=aM2IzwhhUJAheuMydJlLWCkzRPBf1euppYCwfn0HHYjN1YA1B7ehLGsye2n763yw38HqzV1QHlf/dPyLHe76DqQjZrS/FcPb8o2HawLndwVUMxRp9FmFsj3gHG9cqZ3xNqJ94VZ5jIOxabfPuOMSrr7ydAxp3gHgzTAI9UVE1dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779119621; c=relaxed/simple;
	bh=ilxXJ6f6ocM13VA/URJIbBBqXtBkN2Q+ruqs2Cl8XYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y8LQwatbTLzouxTyzcbJs6uUkzNSzj8+LqP9PQ4RbDOhOt1JngOu+iu4z+HdEyyWXJKwcD4oN0VZR4gFHWVLUlNQPHEpqcr91x0aU/De2S65NXWsFH4R+Spi3ZnOWFsFgQzsEb9d9fZ9ZhPy5VDtgPMnA44+EUGIzis3LyE4HWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gooXQ9tM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gooXQ9tM"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso15065365e9.0
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779119612; x=1779724412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zmgE78suZlMwwBJChVhs0s2vjaTS32du2erStadTtvQ=;
        b=gooXQ9tM/GQEQRs8OsgB52bzqkPnODTR/xxTtxJX7Qi87/5Y6v5lmiY5CxCW+ReCKl
         Dt+cVV7oYneyVB7uPlgJ4abvdmzrv5AVq2nQGH1GxdHXok4NlpAOkKG0uzyLfsDidHb3
         RGkKocbrqeNv5kjxFD6tabvxEkMzzrDBDSyxDm4SJQsKe4AT1h1b0G88HbbJ90AJAGbE
         r6+z6uDDKrci6dVLE69QRbuEd8hjQSBX26Ys9guPengfpbf4AzaAilAe01I3qfg2yld3
         w3Ut/LFpRffT8hcyCkmYVGpYwzS3XeoO1+MNgc03l2BmMeD8Iy6twnPsAeAFqc1Ub4Ou
         dglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779119612; x=1779724412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmgE78suZlMwwBJChVhs0s2vjaTS32du2erStadTtvQ=;
        b=Y5USmoS2We7nfVQLdSrrPehdRGJnMtoBl174H8RD5YBQPUcTSsFolUETNSvWkHLnV6
         kIPe0VXRSgAhyY+bcxb8EXVttRTnUgxZrL9mG5Phv/Fd/DFNgZFu1JGvTdOtH5ti71H2
         s7dGf0RbEX2GfOkIBr/uFv71mkqkmKeCGcSfarmNfITZ6B+5tcLJWWhj/4NA7B8tn/B4
         SH3GYTPWM73ZNeC6WxWuAytYUGqx61lEAQaZioTFA7xgUz+KWmlBeGAuop2y8mbFKb4H
         mPWjd1Jmo3DtcaJ5P/Trdl4/TCmJpf9ZbZolZV9QF5qyNZXmHZPMKfp7i285oCRDJHzA
         0aTg==
X-Gm-Message-State: AOJu0Yzb3lP4WVQQp+0e4WWqt2ld/rciJvv1KN0HWU80uNQji+7sB+fF
	7gWsTKCZPDp4vnNSJLdO8xvZAcKjJARrZz6qUOJUhsBwUujuR/31bkbO
X-Gm-Gg: Acq92OEokdlP6ha+RG/kFBXF2yMQGZYor1TCCyndh0RQmOKp80fCPdShw6WfL34oIN6
	z8AMyMmxxfsqSbxAIXOc/48zb3x5FMn6MVaLQts1UahLmfJNOemcUmr8/XnzUm9li5K+c/P1tTP
	Kk48Png/cbwRH5GlfKDxRhSuQSTIe500FGAuxedwFAftYOgom0fdubqGshEStghiRKcaX9YyOU3
	zubFlYnuaIIGo+UioINOGqdmkTa7u8f93NSew1NJZbDKzNoR6gG+BzCvFpEpu9L1U5/EmgMg6P4
	yl1dp999ALB5rx43jiuq/P5pGQcQg+AWG20OCDsTFUsUnpe7d00vV/aHLGxhpn+UyCZ1blVmITG
	AOYg20LpOWwKdsQzpDddDVZ2girM4ewa2k2O6ZcZ2TXipmvvI/iDyglk8RjScnUBZIR9FJtzwtY
	tZHvnM9Kpq8UNv1GrbjAMuQ8r7mb5YC3ulm4gR8UIS7k2Yi0DQnbK2vEV8C9u02/CAOpcqaPoyE
	ydF5d+7PynTvDQS+vmbl89g/ZBKwWNcsfhd5oyMzOZpV2zE
X-Received: by 2002:a05:600c:4e46:b0:48a:75b9:5e07 with SMTP id 5b1f17b1804b1-48fe60d576dmr255690515e9.11.1779119612345;
        Mon, 18 May 2026 08:53:32 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:2409:d26f:6d8b:b2cc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c8344asm450054575e9.1.2026.05.18.08.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:53:31 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh@kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/4] Add PCIe support for RZ/V2H(P) SoC
Date: Mon, 18 May 2026 16:53:20 +0100
Message-ID: <20260518155324.168948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

note, the dt binding patch applies on top of pci/dt-binding branch.

Cheers,
Prabhakar

Lad Prabhakar (4):
  dt-bindings: PCI: renesas,r9a08g045-pcie: Add RZ/V2H(P) support
  PCI: rzg3s-host: Use shared reset controls for power domain resets
  PCI: rzg3s-host: Prepare System Controller handling for multiple
    controllers
  PCI: rzg3s-host: Add support for RZ/V2H(P) SoC

 .../bindings/pci/renesas,r9a08g045-pcie.yaml  |  21 +-
 drivers/pci/controller/pcie-rzg3s-host.c      | 229 ++++++++++++++++--
 2 files changed, 231 insertions(+), 19 deletions(-)


base-commit: d2fc550dfe13eef91b065af7a12348ba4162ac04
-- 
2.54.0

