Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA81033936B
	for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2026 20:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786478486; cv=none; b=QlBEDjl4BrD8X8jLH1S01pCf7U1cAC289um5/X7APWn90UmKEGzyaSzixXsXtJlAjy2X+9SKgfWA0alJe8WlacVoOwI0y+fZVoGR8aWc4cilSWGKX67W4n+s7GClkJy6h9BvxytDTSSQFQo7r3yHoeOoS3SXzWUT37VnGCkVPGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786478486; c=relaxed/simple;
	bh=DGFPaI/HIR8U2fvUI5b0Ja9kPhkcuf49PzywIiM/P44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OClBqMjsCIcDIM692/CTlE6ojhe+ageWQ+ZpPppZxPSzcBn2fgO9BaBQDs7mLDHUXawcNvuhyvyoj27UZkiSZyy23pBR/d5ERKoWPGPCv34ORAripAP+uis6tMHnibbICGRmZsNl1iORxLEuMGPesUpKOUZSwcj3fzAGbwYnR9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ke0pubwQ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ke0pubwQ"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cbedc9ec119so106027a12.1
        for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2026 13:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786478484; x=1787083284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WfeVVg+F0ZgEZPP/QBPqavyvnVz11F1c7ptuiwe6H08=;
        b=ke0pubwQeDD4i1NKWauOmC57ls0jOlM3LJNa4bddcsYyW7WCGHHsmGCCSFgBNUZHpY
         A/xI5a4UTaUiIIhbuQ1tk5PFmJz8nL2z1sifx5CR37o+EOnowhmEFkU7skpQ3YE7E25C
         suGJzy6yJb3SWnIrpRlZwIC+8nQgALwcwwj1SXH63a718gPHwFAUFlyO8LSi63yrwQWj
         fP52uHNpWxlh0bIqBz+yCoNXGMlyqs+4yiCVMP9lk71mk8d1xlb1oTExgOpFkq8bWyk+
         O6oAPhvfRI2nqYosHigM56tTH0X08J/jRuyD0B2XQAXxnclqHSfTYK1GN+rktHnVHmCg
         k7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786478484; x=1787083284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WfeVVg+F0ZgEZPP/QBPqavyvnVz11F1c7ptuiwe6H08=;
        b=VY23Cw+WlnAwBW4SJYG5kDGsUZ341j62AB6UWIctRyU87QoR5XwvtKYvKJN35F6ede
         +YgfTi62rsd7kOhOAalboxCmY0WBAsM2xAArLygBblyJrmmq2A6Sm96vhG/J1JVPpMza
         2csiDSSuj5g6fWasHJqW0gePGUO0k8MuIlsMHfcQxJBhdSFVvuLgxnb/igaCbfCE/HlV
         yDS2/aq8owqz+QAuRlQlXRzQ8IfFuzayE3yQWMYfNnDLJjgH4u2TtSgETByWF6NTTKPu
         CUN5XVcBQKeTNlcior+0MdSg58/LLQIJxV2R77lX2lehNNWY3rcp525YgYGrDLS6GOtB
         OoMg==
X-Gm-Message-State: AOJu0Yzy3x1VqYzpzMiuVMxbJIZ8AlVSo5XAMIykdq5tOKL8rZp6JVOL
	6SkU8IQuH6UI6f+NfyBv7hpbeCuRaNlhSRkM1DDokEh017PwPrt36hK+
X-Gm-Gg: AR+sD12LbTIqFY9w+iZiZ8o709QzS5HfuITIvmZZZz24owM4HOlGzWhF/rzxXlIj1zx
	WcNumnSOb6DlzDF7yWcnDPvAD+FiBfR0vMzGbar1ku2kuCm0k5MPSwGHN8tt/dnmOZz+fqrLrmJ
	Nw+OL1nsd213tx/uxo+e+5iAVHKbwTpwxlwP6Fz0Bqb6Pkwh8PNAJbZqnOYkf1RpYVt2o5SNTgE
	u0sulvfp0VDwfDvPYIewvctPNQIMsnT5pDvMHJiRhXnKeMWGM+p0ePEv7oIafvbh9ASj67mtKr3
	E1jSwtIJkMDglje/EUDB7Wi9IVWdbaIlPlvS+pMLGioER88PqGh64CoFKtnxh+OgDHHxNjLNuuk
	5CkklNGCSr6sIxeogFb4C4dtFPiG8W7aUYh+kz2vcb3sDM5c1NOxwVzC3+BuDM0PcAyz6JFBP1V
	LKS7YsDAJUKd7OkwIWCIcRS7Vg4rV3v8X4q7oa+fPk3/fYc6b1wx89abfqQfC66xwfvk4FwFAIy
	Q+X1vhiZjAE9tn6Icsu2sSb2/optlKhSdDRHZp5BSpSZgKo7n2ZeS+Og2iXfRkfq7FpN88/nKvh
	c8pMXfHokQ==
X-Received: by 2002:a05:6a21:3189:b0:3c3:a20f:f720 with SMTP id adf61e73a8af0-3cc2bca59a4mr8127803637.36.1786478484024;
        Tue, 11 Aug 2026 13:01:24 -0700 (PDT)
Received: from iku.example.org ([2401:4900:1c07:ceae:5da9:e5f2:ea74:b6c3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf6791351sm2216447eec.23.2026.08.11.13.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 13:01:23 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 0/3] PCI: rzg3s: Fix issues in cleanup paths
Date: Tue, 11 Aug 2026 21:00:10 +0100
Message-ID: <20260811200013.185956-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi all,

This series fixes a few issues in the cleanup paths of the Renesas RZ/G3S
PCIe host controller driver. The fixes include:
- Disabling the PCIe reference clock on probe failure.
- Propagating the original error code from platform_get_irq_byname() to
allow probe deferral.
- Unwinding chained handler registration on error in
rzg3s_pcie_init_irqdomain() and clearing chained handlers in
rzg3s_pcie_teardown_irqdomain() to avoid leaving stale handler and data
pointers attached to the parent interrupts.


v2->v3:
- Added rzg3s_pcie_teardown_intx() helper to remove the irqdomain
  and clear chained handlers.
- Updated commit message for patch 3.

Cheers,
Prabhakar

Lad Prabhakar (3):
  PCI: rzg3s: Disable refclk on probe failure
  PCI: rzg3s: Propagate platform_get_irq_byname() errors
  PCI: rzg3s: Fix IRQ domain initialization error handling

 drivers/pci/controller/pcie-rzg3s-host.c | 51 +++++++++++++++++-------
 1 file changed, 37 insertions(+), 14 deletions(-)

-- 
2.43.0

