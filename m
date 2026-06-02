Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36562F25F5
	for <linux-pci@vger.kernel.org>; Tue,  2 Jun 2026 19:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780429827; cv=none; b=Ufb2Ub5X28cZ3HlqjC4RklcwNIlLRQ1JGpISZcJffmp8u+VdO12cL7S/pqCgDJv0WeVCmRc1Jukp1pPr57RXPY90shZytBqPxottOB9jyH9+p5ZiIwPBcQ/fujcQxnxlj8RLkp+WXg4G+8+Rtt3DtWOEvUn0kdkAdAZDgWJaY8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780429827; c=relaxed/simple;
	bh=wQyQbCXJyDcxuF7T/MfPTZburTY0O5Do2c1AzrMLeKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sBmi3aIg8EJM13kGVibaoiDQBXn0C5xqb/cDqeKK2I3V0QeOM23PIo5urvVUi3bOYXLrUbiX54nhlNnEGFhG7URF+IjQdZVwKxnjryS1uGUGTXwYajYIyl5pQaUUZQQ/WcsUnAtDnRzLARm3Vi7OjddruLnJdKzqDxc9nVi8FmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhfMz0yV; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhfMz0yV"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490388fd0dbso118438045e9.0
        for <linux-pci@vger.kernel.org>; Tue, 02 Jun 2026 12:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780429824; x=1781034624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZT80MAX+bO9RoRC5OjSLZM3wOHAxfoWPS2zpj0XDIqY=;
        b=EhfMz0yVXQFyZBia98YnCSqkZIwDEozMM+GzthUQybr1FySOyuKxKV0/T/0dkHuQ4b
         WasqgoUdtpKDCxcKcsuCrCDIT8HUclWJEBPitKRTFqRxREJFmKX6VkehfzgQP+Uo5cY1
         45LS22UO/1Llrec9bGkhnYVJP4n+btzSnEGBNhpe7D8KO/gOCZeotl6NG9k4lgjePObU
         ifprfnjKy9oOqSdC3k5Z7EsVT28OaXQtvDAJoI4QK3AZTR8MsapIl9gHyTumeJLnDzG5
         28MiNMCpqVOAGwac5Cbp+8FiGNYzQ1+VWJEFAER0jX0IQmfWAdp2piqdvMjGxcCoUsTK
         zRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780429824; x=1781034624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZT80MAX+bO9RoRC5OjSLZM3wOHAxfoWPS2zpj0XDIqY=;
        b=O9YcLP5uPYOPAZRAt33ci94dHVmnN9ZUdLxUPtNXGAEx4WWbyh6Ghw8HBSYsie3Tks
         5IbS/XJpYA+wRRd7egm7B2i2SDbdT7fpuM2APgQQDgcJAjypjjpcOXeOYZ5DRpRpg6eb
         WCF96ogU+HAIlomt+o1MJ9pYLqi4z6704KumyaF8E+U61ifmsdeMvOgbvLAv5tjBl6lw
         Uk3AEN70T5c2dWGVeoCQkoxpafwSatxsdvXMhEMYXBPS4V6X1OxXQWzs4IaDEBRd46Wj
         3MML8i8dAjVqpybqIHZuUHcY6kndq/uhNvAhnS6P0hBfO47ZV/0j8SLuPZ/WUfaOXqG2
         mTfQ==
X-Forwarded-Encrypted: i=1; AFNElJ+VDJMe50tMZQwgKIwWuY8yKVxi+HFQikzsVtOZsdWZpnSm6XJnCWE+Kd1mkGeqkSmVkxhpmrHDU/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJfhDWSyg/zQmZZLZXtYXAzC8tdIyutM21vp7jEErXuyyOewHh
	Y0A525ZfnGAMmYlh9S9AxybUihStRsJgroE+civCiRy5sJcKJbLqKDUS
X-Gm-Gg: Acq92OHhraWPEL4RSRgD5uZRCakM2AVvJFQhHzfyEg/novgfg9hJaSWRWRsjGvIvFMS
	dU5OpNRM7+KiztzLCmYF4mrZVox23jCAFV/kz2npbvzhDsb0uATO1oGFy6jmgm7M+sLtwbiggEW
	Bv3VD5sFXOgYGj9+RR3jb7DiHfG4UDa3HkyRM3pS4YT3ErdaANtNjT2hQ8+5PSSnK4d0akCoCUR
	l7nC6BzeIN5tnLi4MmjlOFHffxDBDf6HkOGMK1jsJ5+0D43rCJ6EIX8l84c1jTKcnRGaUQ8yATu
	nybhpnWZG+0KXh8CTKtREGhNBQx/BnBP5ivGJ6eK2Mo1mYyHhmBdqn1LF92bNJowL0oWstx6XRj
	uymXe+2/XY15EuBS4x/J0Awya8s+zeZR1gTPN6vbl+gHs0ftrmnbKoxpqi9f5EEw5jCTkgWqgVu
	kSWvE8wxdmvmL3FAH8aFQzB72kK+qLE78YQd6y8IruGXmInSGVx7TvGWIEoEUT4jbMcp8pIcY34
	Xw+1tqiLex0G2kQik9CUIlOhCPop4NW7OTepTGLIBrvfVaO9dyQW+EP
X-Received: by 2002:a05:600c:314e:b0:490:45bb:8dd9 with SMTP id 5b1f17b1804b1-490b5d2f857mr5228945e9.8.1780429824002;
        Tue, 02 Jun 2026 12:50:24 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:5ef:9913:4a77:3bcf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e13eefsm87353395e9.2.2026.06.02.12.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 12:50:23 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
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
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 0/4] Add PCIe support for RZ/V2H(P) SoC
Date: Tue,  2 Jun 2026 20:50:15 +0100
Message-ID: <20260602195019.1798126-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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


base-commit: 3a97877d13e1a29c50ab15ed0a0aba87b75061dd
-- 
2.54.0

