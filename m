Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15FA3D6CD2
	for <linux-pci@vger.kernel.org>; Wed, 18 Mar 2026 12:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773837914; cv=none; b=Gg9se7KKsuOvbVBQQfJ3spX0bsupfBkEkRUT0EPPAKAHpWeiy2HILcWDWUAEyU0MtKLdS1LMs5JX6Vt6KQGiE7AozIuk38PwLVX678Opqhbv0cKo1HDZI78xzNmxtchm/X5pETTiKTtbf9dNR0ZcFDltluwExkRpManGRehIvfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773837914; c=relaxed/simple;
	bh=7h/HGlld4QUZ8/6amWHzk8Y1v7CTpf+63EYDdvnKPsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mKQ+Iv10D4C5m+9SboQhiyegylgNP3QBkHO4QvlYzOnvPGm29myKXE8z7GFwkK5Vo82o94Uuv8SoCfhPwzCXr92KrtRk0wd/EC3QNhfzY2bC9D0Ie4fgJHj6ZJiy+jbSrWObN7VSGbsaYawvLbWvmFd0OP61omw3H1W2bWapS18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+q2969g; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+q2969g"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4853c3c2fe7so3698175e9.0
        for <linux-pci@vger.kernel.org>; Wed, 18 Mar 2026 05:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773837907; x=1774442707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8uibrI3W9d4RMuqjhPjL4rWVHNQ9ZJs9HJd7qxmHcrQ=;
        b=C+q2969grF5WkLXMY13vy1mjIpwQybgMCbfp87o88Ot1SK+kaIe9V3vPYrDdinRg8a
         gwpvZoFUeIBI2vrFi2BHtQnmQRuMT//5D+evRX/CP1qclJqfipf6zN59C1TLLaGo48Hp
         HCHwkuZK5pHL86gdTf1cZGExJXz5Rc6xz073GUNfpTpDt3CPSTQ3AFXD1CF/KbwUgsiH
         EhdCg/Xg2pky15tDkJEFqOXAgKgL8QzjiSQ71Kr5/hghHxAVwtWXDnA7DnqaMXC8gVy+
         topYdfrpNIvsHKLYiYtle+LNXy0cx13OX+w0aqb6NnV8Bc6E7jyrNEB2UQSl7g5UOsxZ
         K1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773837907; x=1774442707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uibrI3W9d4RMuqjhPjL4rWVHNQ9ZJs9HJd7qxmHcrQ=;
        b=MFRfSBP7MjZdD88nk4JmS64cA9SSCx6eUxpQBdqphK0cmY7zT+Htr6xdVNvPtNNgcp
         jBwOoj77PsxkIcN6AiunI+pWdaC8ztA9ppmPR+s22OEvuyPWTB2bngkpji3kAvvh81pc
         9J710D1KQsOV8gScY3nLwnkX/5TTuAogarvhY3I832fYkdaVH4isWSMhQx5MtQXoIKKn
         WrPm8NZxC2LR+WP/8SAyNtHjSQ8CpSySTdfiXg5kdsCzKisoXci455432UQjP9RBxDHj
         WP4ihmx22o5005uArIJRjmsk9132kzv+SBJD4VWOTJJF3xzjmyqnyRy5WUWqXDWEyF0O
         EIqA==
X-Forwarded-Encrypted: i=1; AJvYcCWB34xlmRNkX7JaV8+SmuRm4w58xypV+diNg2MGe63lvqJRPtFGlULnhvUUBcY4m2VEd2IO201d2bE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5DOZxhTORuiKfnM+VO/hW8CxPKf+WC/ReX7bFqdUpmd+MA9MN
	ErqrIep4zUOFZe+uOiJqbzAIg4lytR/XSrVV3+GRPMTCI1zJLbKQXMaU
X-Gm-Gg: ATEYQzzok9nXP9TwddM7nCLi29mvKNKZ29bNtxEyTSAtHeQMvtoSmJo1ObRMrYDvP0z
	+q6Iiw1RWhPQlXjZkDF/tHtHnAP3mMn57YRfibbVB26bHv2aCYNMzPUaHF8+dCTmV2PZgttr42w
	DCjFYmazSNxmC+8xX18LyVyJvPMt/Ktb+mN9a9I6fUAw8CjNcirxbXZCTVqgJDLlF2XBJb76DlO
	D4DBfc6/i5FdI+SW2B9g1ah+hgYZYbipbJP2TL3dUytE5lUusVqy47gmzfn4kXx1I2jEHfJbv9S
	rxu0Rnh6jcrQif+i5i3S/XNczKvipG4AoJ0/+MXPLgm0nWM6QZ3ezHSVYKv8U1a4+Qyy+cfuv2P
	CKOnwY8AHVwp/DDPq5Xg4HkFDvC8DLd037xnSPWkUD7mlu96/4XhwFmGQLJ1YOFqFVsGwx142Zx
	uMWrJAUwEvET9APtsq6BXi9KgzafrH0Eri8h14XT1h/iI7aoVbHRK7sva66tzyo18zalPd5gYxo
	rgZsIraHWGLsJndjYVW/LEuKLUS3KVFrScvrCp7jT7KnSU=
X-Received: by 2002:a05:600c:c8d:b0:485:2fe9:336f with SMTP id 5b1f17b1804b1-486f446d88bmr53075075e9.30.1773837906381;
        Wed, 18 Mar 2026 05:45:06 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:5f14:a98b:b4be:efbd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b518985f6sm7888162f8f.25.2026.03.18.05.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 05:45:05 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: John Madieu <john.madieu.xa@bp.renesas.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/5] Add PCIe support for RZ/V2N and RZ/V2H(P) SoCs
Date: Wed, 18 Mar 2026 12:44:45 +0000
Message-ID: <20260318124450.163471-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.53.0
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
Renesas RZ/V2N and RZ/V2H(P) SoCs. The RZ/V2N controller is similar
to the existing RZ/G3E variant but uses a different device ID, while
the RZ/V2H(P) controller includes additional features for PCIe lane
control and supports multilink operation with two independent channels.

The series includes the following changes:
- Add device tree bindings for the RZ/V2N and RZ/V2H(P) PCIe
  controllers, documenting their capabilities and requirements.
- Update the rzg3s-host driver to support the new SoCs, including
  handling for multiple PCIe channels and shared reset controls.

Note, Ive created two seprate commits for bindings file for easier
review if these needs to be merged into one please let me know.

Cheers,
Prabhakar

Lad Prabhakar (5):
  dt-bindings: pci: renesas,r9a08g045-pcie: Add RZ/V2N support
  dt-bindings: pci: renesas,r9a08g045-pcie: Add RZ/V2H(P) support
  PCI: rzg3s-host: Use shared reset controls for power domain resets
  PCI: rzg3s-host: Prepare System Controller handling for multiple PCIe
    channels
  PCI: rzg3s-host: Add support for RZ/V2H(P) SoC

 .../bindings/pci/renesas,r9a08g045-pcie.yaml  |  43 +++-
 drivers/pci/controller/pcie-rzg3s-host.c      | 194 ++++++++++++++++--
 2 files changed, 211 insertions(+), 26 deletions(-)

-- 
2.53.0

