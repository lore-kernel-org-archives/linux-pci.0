Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8423E5570
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 09:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782465647; cv=none; b=ZiU0e7WOB0qCR5Fte5dULDFXD0m0t8tijCEeX99h6vxsJFLvb/Uq4N+zTlIQP7XVQrGnt8W8LU+PDlwdWbU8Dz65lDPncVuIQ2PJLdDu1tfl3bizOj50g6f+SUb6WAKOkl3piFDdx1rDO+6wYmgajw4qmQ18i5sM2ylW21JvPtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782465647; c=relaxed/simple;
	bh=FCGrZ4ia9moub3vpndSIDoB0WJ00EU6aXtezVQRRMPc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=AUsCgFiPonsMnpcLDzEMQMzpNFQ6GV9ul0J8oiSTrK/QoUy/5jWdU+9FFx3uuFhDqgYgXZrbzaNKw5+XUrKOB6zhW+fyvKtabus5LMynVccLR+7Hy8qt5T9WZ+PxAHPzmAT+dVkaSpXYS3naN9WshYlNSjUO6svN4Jp/5KcfIPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Elypdu4x; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Elypdu4x"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4629051c946so452326f8f.1
        for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 02:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782465642; x=1783070442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7RIq6wHh9BtCzFgGyY7sK62eHn+d9xSU82SzTr05Co=;
        b=Elypdu4xi0M8dd2ntH3MR89nYmZoTtHRgc5LGXAlTwR07gD918mQ7nHYC9B9irBq6b
         HQEgPt+REk2YlKR6IhMmvsCS+ftOD0+ey8ikl7RH50MZHHNZSf0ClUDSmNET75vPfWI8
         /TY5s1zwrrMZmah8GsXqBP9xAnqJWWTDkPezQo7pgKr//OzkJ3E7bsIeLlcDaGrIfTiY
         PcLUhP/52jiJv27YJjQPrUhZbXc9xG3Zw40arc3acNExqrQWcCryBqa2PKhKMriS133g
         Xr9lm2sxdQbe8SWI5fS17wVEc9Bre9viIXgwkzOIbAx75KDD6Gmb03NDCaHHGtyFmBzC
         DbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782465642; x=1783070442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z7RIq6wHh9BtCzFgGyY7sK62eHn+d9xSU82SzTr05Co=;
        b=VYApPdiLoUpSDyaiBKS2YHXSDLH0vFT+Qe18HVpraXMlKGAE8807csEx5+u7ojBQlG
         tmsXVrwqALMsXLiMKFGCdTuGr5d+oipcUuVnI276xD8lT9syC0tfC0BpVpjWd2rG6VFd
         KSOhFBVXbfWGM6lquXhScUGoGzX8SK5dI6APvM6G6ZgEvJVWCCd8r9lB5j5GDYQ8rOwo
         mk6pzi4CGdD8xEORt2K7dwTXI+ukTrro9ib+dEVl3FkJ8uk8gvYR6gZQf4+Ss6KtgWCG
         W7wOrdAJTTUTi9SrKMJyUodEftC/Z10eZM6XqzE4uJ7+vP1ztbWcTdpfzK2Cf/h5/ita
         Bwsw==
X-Forwarded-Encrypted: i=1; AHgh+Rqz56fwIRtiWwnknVXtVb/PMbZ+k0w2+oZA+RV0PvA9gYvUlDAPhT/jEXKrRsjdjXzKzin0YGrYAdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ceq2aqof9DNMYMzdex7j4TmeEbFQmN9mm7q22gUje8OEDoiF
	ouuoQ7YtPhKhlyc6GOpPYAruTZLJ5luEsUB+pY8ZWlbuej9I2Vd/3+cC
X-Gm-Gg: AfdE7cnBDDE3TFAcoH23Fs526dlCZJ3u1felHA5Q7crf1k/mPInzUQ9TN5XvkLLugjj
	OB5mnO0lrRWrg1dcMEIdiV9E05v6auFHxxrTKmSfYNm/b371ia71IAxzfokgC9i9ht+qC4lu9Ly
	NXPIYOhy2v4/ymzP1FivbPEYO7c7U2IAormiAmcNszpvyVmKUZt0QmmniJK4FJnFwSAiOY4vMPR
	gXI98XBOtJ+Fxx3erd83yQKVy5e/r4tJRA95zBL6SHVsdZwFDmFzEyq7KcCzWJZt932b8w6oUU/
	2Vq5SX9uTshTP7c7vr76O7e7TUxcU/BLFo+C2F7G4EhraI9sCSgxjx1+wqs5YhP+5DnqmOVr4Bh
	Nd4IU5Fij5+B/AgVH258bvf4dIB3yiOIkzK/vc0TqLCg7nvgNA9OFw7QWKOF5afwgjR9bhUChY2
	umRHkpuk2qlUw/xl4xCBiGtXawid7VKYe6lkmmVcYmIc/MbzwVmhrZJHA26PzH3w3yFVn8ZJh/N
	KOdakbZJytl
X-Received: by 2002:a05:6000:18a9:b0:461:a15a:4160 with SMTP id ffacd0b85a97d-46da8c5fcb6mr10187397f8f.13.1782465642257;
        Fri, 26 Jun 2026 02:20:42 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-80-183-219-152.pool80183.interbusiness.it. [80.183.219.152])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-46e6167c05fsm9094388f8f.25.2026.06.26.02.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 02:20:41 -0700 (PDT)
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
Subject: [PATCH v2 0/4] PCI: mediatek-gen3: Add 2-lanes mode support + clock
Date: Fri, 26 Jun 2026 11:20:24 +0200
Message-ID: <20260626092029.3525264-1-ansuelsmth@gmail.com>
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

 .../bindings/pci/airoha,en7581-pcie.yaml      | 251 ++++++++++++++++++
 .../bindings/pci/mediatek-pcie-gen3.yaml      |  77 +-----
 drivers/clk/clk-en7523.c                      |  39 ++-
 drivers/pci/controller/pcie-mediatek-gen3.c   | 101 +++++--
 .../dt-bindings/reset/airoha,en7581-reset.h   |   4 +
 5 files changed, 370 insertions(+), 102 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/airoha,en7581-pcie.yaml

-- 
2.53.0

