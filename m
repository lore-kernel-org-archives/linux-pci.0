Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB8F36F8F3
	for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 11:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030340; cv=none; b=ZxBz19wJLowv8NL7a9ZZSk2jpUPsteSjzmD/ctsasvltXnx//cAeDA/Rc43bjM0bTkgShy9xop15YZji4zdEfMvV0aCyaqsK5lMmkBwcUES3KEdkZDxAxDNrPBEHyrQgMThf/ImYenpZugtMtUCOyh83Do9luvtPIcSE6oW6/SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030340; c=relaxed/simple;
	bh=mxrGALvislomijpsl2T7r8zxTFeAUZUtTNDbCWnMoRw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fX4K9OZkn8KwagzQwXf+OpgYyWwUGJd04wWBSu9buox4+i+Dm9x9js9JQdS9IvMmUrZesiRYhsHC79OPeNgnA6nj0nSBPHIXS39PuthPDex9GudNQv0qFFLSgAVN525JEe4Fseo1Tti6h3K5NVYuVpZ4TUwZV0hWCazodEduxzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kv69kPyA; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kv69kPyA"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47df43bfb07so965089f8f.1
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 04:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784030336; x=1784635136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jU6f3XE2G/RBii05RKcLkrGv0zTxeh52OJEdZ0UzbF4=;
        b=Kv69kPyAnhv1AZnx8l2oVqrUblgj0o01A9ePeFTNF/cGaZqcoqiOA+2cvlxX4tZIAF
         7uqKA5JuZnwfu158ndtDOho50PsHmOvHYmoGn3Gwz3MjZ+vCXVk/SDPvc1dDE8ZmE7lV
         X4BWWq0B7DXddsF8t2+rWovXKMrxVpkML2cMza2mIqTDsp7LeET8Me2QoHNJddrL1lFo
         lOFECIVuKkHxXoYxe6xkoF6b0pokHgWYUiLfgskuYm26WAGMnb0NEypg+DjlAEA8btfm
         dmqmILnSnRQDJM0rYCRjT+zR9DDA/BpEAWpwdkO4zxU/t2bwFPnYFx/kwQ3BosYwnfZ+
         kqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030336; x=1784635136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jU6f3XE2G/RBii05RKcLkrGv0zTxeh52OJEdZ0UzbF4=;
        b=a9s4KNebFvvKlg3CKr7xJ1v486GHm5Vs3tuBTa99iqPKYvP02rMxYQ5717mWM6hvuS
         HTrzebh7JH/EwDmprp3KaK8bBYV2dcUyK3c0mbIUGO8cYfRktKYiJCfW66gPnLOmqLR/
         jVNp4K3y8vymjhqMwQUOLHq/vBTQJ+QVIMFRawH+uXh9GtFeopzrzOrQF0wcm3CRkd+2
         BYXBBxkTCN8Zp7uKpBKPFf853glXovsksOEL++BfOmZtmJX/2HChuO3UBEWVtay8nc9n
         ENi7t2q76Cgif0EwgTmXBS8jPlt1tpyx9wDp88/JiXn56Swro/1dWqOB3nOB/eq7v2iU
         dUuw==
X-Forwarded-Encrypted: i=1; AHgh+Rr1ByGWAVIn5EWxEaUqIrJeyIwjMPr2OQGRCkFt/hd0PzYMIAV5tjI7tG5DyQ+wFvdA7aVwm9KJxzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRESA3SWA53Jb+RhF/L4xT/wMDDvFwlc6Qb/pvn1225IBL7MZe
	WoKfm3J1qVlS6/K8CoYQW/sfeVKA5sczsvLW7tjRhIrXHktgQ6mgEvCZ
X-Gm-Gg: AfdE7clIksx0H/revFGrODg2vji1W5zRA9Rf8T2zYdFk95nen7Tl8VjGfZbjdXimkPd
	GBJhqPW9JXalehCB5Dobabp+83v7Nv/bjvwkiL5bK4/b72JrSPKHltefwyGwL+4rLVE064pW8CE
	LGxV5L19Wn8l6RmTFKX8UGfTfBtVag4af2P5RI16BQKHN9auB1Tq9/6p/b2qJcsRBMMpmjM1IGW
	fQZelr03tAIxZDSMemV0Y6JnKXtnMn9is+98v7uVcolOt8U7ECksrUDggESchiw1343eZ/BK9RQ
	HHuyd3sC8aiHwWEbhJvLHzNQaFCOM/Ixz7N/VE2F+wETNloC3T+31YqPuqAhSu+VrJQWijIyIJc
	0yJ8U/dkU07rIRmckx+4uN6hspKT/dLqw63c8kxj4AIKxgwbvsOgxMsVkE74rmErb6e15NsALZA
	P/AnLvwvujqVMFyWZVkPxmrt1Mmlsf6t28KYMg13gyLbki5cDl9alHk1NdVvyxiOmUVo1k25SSv
	ObpEpzo
X-Received: by 2002:a05:600c:8705:b0:493:b61c:72c3 with SMTP id 5b1f17b1804b1-49518312cd6mr37467935e9.32.1784030335841;
        Tue, 14 Jul 2026 04:58:55 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-95-248-227-210.retail.telecomitalia.it. [95.248.227.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-493fd3ccfd4sm180531655e9.2.2026.07.14.04.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:58:55 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
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
Subject: [PATCH v4 0/4] PCI: mediatek-gen3: Add 2-lanes mode support + clock
Date: Tue, 14 Jul 2026 13:58:42 +0200
Message-ID: <20260714115848.8537-1-ansuelsmth@gmail.com>
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

Changes v4:
- Improve DT split patch (drop unneeded property)
- Handle power_down PERSTOUT
Changes v3:
- Add Ack from Krzysztof
- Improve commit description of PCIe patch
- Use pcie->num_lanes instead of possible uninit variable num_lanes
Changes v2:
- Address typo regs -> reg in Documentation
- Address typo lan -> lane in Documentation
- Apply a suggested fix from Airoha for PCIe MUX configuration
  before PHY init
- Parse secondary reg in probe
- Add missing reset_status handling for inverted bits
- Move SCU to local handling in power_up
- Add check for max num-lanes for EN7581

Christian Marangi (4):
  dt-bindings: clock: airoha: Add additional reset for PCIe PERSTOUT
  clk: en7523: add support for dedicated PCIe PERSTOUT reset
  dt-bindings: PCI: mediatek-gen3: Split Airoha schema and document
    2-lanes
  PCI: mediatek-gen3: Add 2-lanes mode support for Airoha AN7581

 .../bindings/pci/airoha,en7581-pcie.yaml      | 244 ++++++++++++++++++
 .../bindings/pci/mediatek-pcie-gen3.yaml      |  77 +-----
 drivers/clk/clk-en7523.c                      |  39 ++-
 drivers/pci/controller/pcie-mediatek-gen3.c   | 106 ++++++--
 .../dt-bindings/reset/airoha,en7581-reset.h   |   4 +
 5 files changed, 370 insertions(+), 100 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/airoha,en7581-pcie.yaml

-- 
2.53.0

