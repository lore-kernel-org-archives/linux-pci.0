Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD96137A4BA
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 16:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295755; cv=none; b=np5S/Q8ls5am3ulqjuHGJl5rD6pp/J2miWiMaFxmgEjQw6AJ0zzlsvsgnMHQrPQ6kcK52+A43z6rOCIgg/BEQNbvM34C/BMoGumrfw3upgZiPsc5harc5VYUkCrUdCUTbUytDyR1VaAWIBM/JxGAYQCBAquECpFBQ4A/k2MLFvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295755; c=relaxed/simple;
	bh=1wdbQGuw6HvmZIeFn+pMLa4ccPKyAcHlFLo3mDEmmuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=exvA0Ij+FkjlMCFo6DcjvcE9WIRwrJhhYvc7HEwB1wKT5CCW1UhoffMiU4C3+4NJw8lBp0W67M6C+wOBoROLIugBbAihrDO4L+T4pXQl0b4i3WJRcDT6E5eEHmBesHY0VDb8ytpFri3kq9EZMwrg7K7qy+7cZgn04uoEcqKmE7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfKLfiyX; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfKLfiyX"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48fe26a177cso38685855e9.1
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 09:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779295751; x=1779900551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I9V3EBCqEjOEBqzqMBD7+ufR2GQPQMJRKrFaD0tdiJU=;
        b=DfKLfiyXIgG1aD37LJUqaHfLFOJZ4FGIixMlYb3lhoElmalo7j92dDiIPq6z1mCox4
         8zsZ6j1vRBaYTp0BELd6E4COLwbIilwmjuXzQdYiwkI1Y1UmP/QuIvjMESlNuLFSIOuO
         UL5LCuPIrhJJP9ybzR3WjOMikMt1SP6/RVsP7wEyDtvBO3bgBOEEDr3U26xTXuNO8WN5
         SVX4sYKWHcKoR2PzGxx9XiCGEiFqDJjkhwYSGIMufoifkU9ZDCr1zl2CaRTcpRT0PHpG
         g+1HDIfjNT6r9KaXuZCk8Vn21v/GOAGfnYG7w+OPmG3hYJMEczEJCklQnLcPzfMNLKOC
         JrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779295751; x=1779900551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9V3EBCqEjOEBqzqMBD7+ufR2GQPQMJRKrFaD0tdiJU=;
        b=AS/tstBGfHPgDhxZpZ4ucKMI0qiprnRUWywIOUrils9ff1g6KWC5xBW8l6VPZVEmdw
         Ok3PgnUD+U1P/+p1pZ9G3nygG/LHwBNk81nOz1A/+ebzFRSp6drtXn7n3n0tBX6GYb5V
         nKTalqEMUso6QhUreZAp1I9aARo+MLGgXBUpLLDyKUFmaC0D+VCgUoSX0NEdr9M2+PK2
         iNubQoHxojj6c0PHK10FwpHLZIxgBWdzXUE19Alp04Ir85EUNkAiapFRqt3xEYLxFdZD
         TggOLDl9apaQLdS8BAOYinUZ4AY4+nT/dzUUoBfY6E4lD9mMfFeX7I3y7XFUKVqZQlSm
         M6pg==
X-Gm-Message-State: AOJu0Yx1AkznAgZAexzM2roo0+HrV+4M3/Smy2luDe4NwqmsHdV5vXeB
	4oDc5MVAuZ7BzVXs/c0o+Du0i0TL1EMePRVmiR2LfQpZOAgxYWr9m6GX
X-Gm-Gg: Acq92OEaLO3cKexxSHSiT+sixjau+RkkNDErddhAai+ffMz9dECbixkpP7s3EuXGWwx
	nF7wU8X12aiejjgiq6En0N632JL/jaNQJSzEwkdRGO8P/VLeqnXwoNvjm6C98j9yE3MObuOU8Su
	ZrwWz/EN05Q/0xkjCfB4JZjK5Jbeb1FKKbQaAXgUlb0YAfVY6BwFXQbRyUh7abevpVCIwIZaoQH
	gdel+LfgBJjvZs2LfPBhueiji9NK8eZD4OgtnTD+JpXzCvw3a+TZdERnR8sOsPcPopH9xIgAtNT
	Wdt5S0RP+qYFASrmcLux4rjZvttt5nQs9NX2muXBWZZ+G201Jq5PQBEnwzrn1jjxiK8QOc8teU1
	Sb6E8MXE/mlOM1RPeiL5qGSH8Covj+K3HwRquQL4UaeDgz4pWjS//gABPeetUsCL8BYS5CKKw9U
	9+3dZD7wHpt8HK4cYQLSwRct+DS+GVMgrPnMxD3gojwZV6teU83xdBjZ3v1fmF2hRts1WBM034j
	En7kNHVtlpksLD9BD2f0B0ssO3ghXuZaV/XQo+HAN6K6aY=
X-Received: by 2002:a05:600d:8:b0:488:904b:f31 with SMTP id 5b1f17b1804b1-48fe6325213mr316461235e9.22.1779295750801;
        Wed, 20 May 2026 09:49:10 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:dcb8:81c1:dc9e:cd68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033d8e71dsm3110285e9.9.2026.05.20.09.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 09:49:10 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
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
Subject: [PATCH v3 0/4] Add PCIe support for RZ/V2H(P) SoC
Date: Wed, 20 May 2026 17:48:19 +0100
Message-ID: <20260520164823.436992-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

note, the patches have been rebased on top of next-20260520.

Cheers,
Prabhakar

Lad Prabhakar (4):
  dt-bindings: PCI: renesas,r9a08g045-pcie: Add RZ/V2H(P) support
  PCI: rzg3s-host: Use shared reset controls for power domain resets
  PCI: rzg3s-host: Prepare System Controller handling for multiple
    controllers
  PCI: rzg3s-host: Add support for RZ/V2H(P) SoC

 .../bindings/pci/renesas,r9a08g045-pcie.yaml  |  34 ++-
 drivers/pci/controller/pcie-rzg3s-host.c      | 232 ++++++++++++++++--
 2 files changed, 246 insertions(+), 20 deletions(-)

-- 
2.54.0

