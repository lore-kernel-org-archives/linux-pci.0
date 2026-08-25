Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E963F0A92
	for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787651454; cv=none; b=VN6YQ79hFwBYnpr2zF+3V3lJgTsgYfbFM9Bx+YorUPP+5E9P9isKidAQoHGw33U/JEApToNTnqKlaDN4t4UpLvm/NAfR99HpGMak5qz2eGOq4LprMbvwdr68qLrTq/gEqwDF4HoEr51ozbY1afJp3hhbMP3yWjYlUmSxBU2zTQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787651454; c=relaxed/simple;
	bh=PZ9qIitPQZRsBamqRGgzCN53LuQxOmZYmBNDP2aMrSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OLaN2EluDO/9HcFq7GvuWPt4wzXlHFdRVR7R/gZnPo0dTIWw2iV8zH/di0SbotZjylOfnN5tb1/E60PiJkUlAJUOUxgLh+sW/BDGGxVqcCvZHZq7H0sBPue+JhaQCFTUQ3Tob1c+Mfs0Z2tYhQWiIHYkctm4IO+u+iwLbo+3NQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gf/TXKzb; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gf/TXKzb"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c197e7e4e94so796157366b.2
        for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 02:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787651452; x=1788256252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7fbSGif2msTasGqCebxF57uBolO1YU7FnzxNIrdyH2k=;
        b=gf/TXKzbKCnZFwo+9OjRWAWXjalfBzTxufSTbcIWmvqz749vGLRCWly2ukrPvjLx9C
         vOrM6FyZyGh9g66IfXTvsyFIybKWw96uwO+kcdvJ1jMeS83DA1s8dJMYPjeHb+CfrP25
         8ZkssoI9LrZ9F+u8AtcsoW55dOJiue4Zrd6qd1dzXLYoLjDm63eed4T9N/8JNpgwXhsD
         Z2IRGB9gpQo7g/QYsPujPCv0BlPUPdl5dXxMzhJHxw2AtOQdwoD77/GnlkxISjBTlW6S
         t1zVa+Uu2bGT4hp1U2eNhYmnnGoa3VxhyribJOeZkiutgEwOjzi+B1AHDz5Ir2p7K4vG
         iQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787651452; x=1788256252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7fbSGif2msTasGqCebxF57uBolO1YU7FnzxNIrdyH2k=;
        b=i6LUERvKeGytuwjlnvNrYQJpoXlRAV2vkalDXe21orwwlf6/ezTkBW310aD/sluoKx
         ipJYCICYwiWhrYFXa3sEK0BDJ8WpILF7vZyeNTTloqsSD3Yh93JuzAmBqmuWAfUHrs2o
         S/NZsXClRDlYo3M1J1d2XdkvCNqcdhmAwQewlqxppIrF6tXOXAEgtagoVWjUYa0A+u25
         qIE2/YqhBVk7JfSZPMdsA4bw4D27Xc4nFsUXSWp74BkGMKuOUXLIqZV2eEVyXvOmFe+Q
         Cm7NE02eZdu3Tki9gws736yZM6xJc4Hx9JWZOsuQ5j4IXFn1KORC2XPLIVKxhPyA7l3N
         mItw==
X-Forwarded-Encrypted: i=1; AHgh+RoDRl/xeE8CeIctH3U8VaRwgXdWFOoqt0M8CdEoRL/n5+FfCci/N+VUyAIHy4tfnD/w73Fogbn1JoQ=@vger.kernel.org
X-Gm-Message-State: AFuF++ndGCIrNm93FLqoFx7EBn9XgXjU1iHkpu0L4gQvBaPeLxu6tKOW
	gO2LxChCHOBuZ9i+A2cmGSeKU5LHMtoe0co+eQ6TMscLD0hD3CRNeciZ
X-Gm-Gg: AR+sD12UTgWH301HAoRQMUf2ZS/OkDtHiblz6DdmcKo5FqRaZG8O+iWYx920tXqSdJ2
	3CIyJg4XKQEV00iZ2LH5H3qHNfhaKTj4CoOOq2OsNArrBR3CYf/K2Owug9/NaoYjBFMJN25bcxo
	p2QMmB5Skkx7l3wxl9sDUM80EcIozbF0U7eiD2aK9QfdTKI/7l/qcO0ru//iwvpUXSCT78NPXy0
	eZ1oMyPsx+Lyj362BkewzELu+8vSBW9NA4RKjgo2ujbEqom+35Q/RSNcSq+wIl4Y2kIN2pwqWjg
	SRUOpEMRptYvDwIvdFHenlIUYBuXEYrsRtQAg3HDkmS5HlazGKVN2QGtSKPBfymkkDVXKcLp+jw
	FGjuscw2ZpIRp6m/OlGg9RZu1aUBNu0a3lTBYY+6dgSjz2vk3aWMAvZ15VmW6g/K3e3TW+tE6Ci
	vMYxjCWaBrKozT/HtfUWxMUG1u7PItlVQoMIXzZg3RVhh7bYL2L2mzJseAXREVQlS/Ah2Mdoh8h
	3+IqY3d7lUPFc7YbRb5gN8=
X-Received: by 2002:a17:907:94d0:b0:c24:8a09:8195 with SMTP id a640c23a62f3a-c249238cd91mr2499249066b.3.1787651451279;
        Tue, 25 Aug 2026 02:50:51 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:81d:57c0:e4cb:959c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249629929dsm1749320666b.23.2026.08.25.02.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 02:50:50 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 0/4] Add RZ/G3L PCIe support
Date: Tue, 25 Aug 2026 10:50:39 +0100
Message-ID: <20260825095047.9971-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Hi All,

The RZ/G3L PCIe controller is similar to RZ/G3S but has
some key differences:
     - Has 3 clocks compared to 2 on other SoCs.
     - Has a different set of reset signals
Add support for RZ/G3L PCIe.

Patch 3 apply on top of [1] and [2]
[1] https://lore.kernel.org/all/20260811200013.185956-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
[2] https://lore.kernel.org/linux-renesas-soc/20260814141312.2947972-1-claudiu.beznea+renesas@tuxon.dev/

Biju Das (4):
  dt-bindings: PCI: renesas,r9a08g045s33-pcie: Document RZ/G3L SoC
  clk: renesas: r9a08g046: Add PCIe clocks and reset
  PCI: rzg3s-host: Add support for RZ/G3L SoC
  arm64: dts: renesas: r9a08g046: Add PCIe support

 .../bindings/pci/renesas,r9a08g045-pcie.yaml  | 33 +++++++++++++-
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi    | 45 ++++++++++++++++++-
 .../boot/dts/renesas/r9a08g046l48-smarc.dts   | 16 +++++++
 .../boot/dts/renesas/rzg3l-smarc-som.dtsi     | 11 +++++
 drivers/clk/renesas/r9a08g046-cpg.c           |  9 ++++
 drivers/pci/controller/pcie-rzg3s-host.c      | 25 ++++++++++-
 6 files changed, 135 insertions(+), 4 deletions(-)

-- 
2.43.0

