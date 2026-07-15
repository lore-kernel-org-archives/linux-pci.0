Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B399371049
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 22:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154626; cv=none; b=IZlzIedE6lASjF/B0wZhtkcVI/kb6UlSPgK+5QsBNnnvdbPdsqyLvsekQ1TTJyh12btp5fUJfd17IqgOinad0LhZV+tZSxQsKoTeQZMTfaPmVWTiY7AHZSTWbwNj0b50+GUN77Dp3WH5DQIczCXGbEBgY37KDkdXUQOgZwZitg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154626; c=relaxed/simple;
	bh=tCqeoUjIEmuNaZaCOjtlZstXuwQpR3itJpuFpnBF3DA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WoAdSt05rFcnuWjjA0fySFDh7oTtgpjfNIkF3J++emWXZSgkKzVQNPX/lVlk4yKAWaCBCSPaMmCfiKkuBRpYtEuZ42aiWxcpNOS/ivYAYhEz6t6DyLp+PfMJbR/4g5OhjLcYXMBIeZSOOW4maKIwyAd3OuIpkqev/BGmyhlo1Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlr2PrwV; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlr2PrwV"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493f45e206dso8075205e9.1
        for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 15:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784154624; x=1784759424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dSh/ujj5LmUNHgERdW2VAUYTMg6YwowRxyWVq6xpoKA=;
        b=jlr2PrwVTq2TLI8cEY8Z9ZG1Apvbf4YR17WqhLlbrKh8hhsbSj+1BFtxyqbKQGlxP1
         XytrsYln8wshUFlhn/b8JOeB4/aZ6aeVp7PkT6SNMqKvHODIq1n7tqTvNnVX7sulI23U
         37zg/10s3wTTG/dwEGqFKLIwHe7rpbZ34kdke+hxwabq0aX4JwmtopZsCmv3HHpruL9K
         5nz3DNRkPpl6GL42T7IPE02ohps70Mq0epbMu/WDUOp/PiSEv/XOGYpx5VcXCGzm2sBw
         WVvkJhv82fgLaP+b1wSvRG86nFwQ8Eosx0SyBwEHNRurNwK5vEIiadVBHPR0w1Hqn5bF
         JEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784154624; x=1784759424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dSh/ujj5LmUNHgERdW2VAUYTMg6YwowRxyWVq6xpoKA=;
        b=OpDDke8H312i3Ysfejap3IqDiCoryd7xVHPsNtl7ew55w4Y/8VqERBBTuVhlpvb/n0
         8Nuuy8+dUnbjl7FyKRR31FrtAdB8Whh1uYvc/YtcyUx+KDOGIeIXKF1ILzw+0/VnUfCZ
         /Ernay6eafIKGhdo4gYBnFZWuist9rFDfJH7+MINcz8FzjIXodSEDNdcvijbOKvVkfPb
         S1vV8Gndr2BjgDFZEjU3mG02Vp36sLLQ9WaE2SpcBUFp4F/IVfW+Ghim3yHaVNC6lLXO
         RCAWACrnKTbo1L+DIlsR5/V5tF3Fl8l1aeaf7ZnAhQECA6Z9pHU/QuGYE9jQRlqrHqhW
         cJ8A==
X-Gm-Message-State: AOJu0YxV2F3+P74TRfaro+36siCyHPxAaLvYxyUCd1qM86b80qmm/Faw
	0BmVnrgsoFUCy2YOnrcEu+iFTpzXOCUhSVVWytsBVcyrTAbX/Lx2f0aw
X-Gm-Gg: AfdE7cm1diZdpoUh+jsp9PlDtz39UWdzLdZ6GjtY5kvGc7DGz9/ksEUfl93ZxED1xDG
	jvBZ9FhgGwfazi/lvrTDfjzCFQ8OLreL23IEeyK6Lxt/SZivPgYv5wozeVjr66ViJr6DWfiRq/0
	xaBVQ+8FxMSDQem3+90TPKKb4v7p3HT2M1sUKCwp5JoPenhnjc6BSr4B8hHjJ/NHpUQvC0sS+vB
	3Ac4L60aJEjx+1RB78fGbohVKlWwA5o8lw/KjcEEDDxr5a05zhve5IhOz6krh+pvhYs7XrL9ZLP
	Ha7p172l2dUxWg7AmwkN4E35AU5odo5wfwxRx2xhVdgxW7yQL2yHCqmXt3z+ILAb1jNJoqfpC34
	Kz7SqN5vkKKKnwx+pkNxDtmMfOfV52TIzBvRpwY511qtxAN4WGxuuJxZUE4jnQmRPJ88l0+vm55
	xJBn8gGt1OxsoPBR3RX+jvwnFHlbnWzUJd37gfgAoRRtyl44lBfYDDy98mOY1Sm4v0OSIB9psGa
	72l7zIRsSiu/O4eE9lHPZRRSak=
X-Received: by 2002:a05:600c:4e05:b0:493:ecf5:89fd with SMTP id 5b1f17b1804b1-4954288e23emr206635e9.17.1784154623568;
        Wed, 15 Jul 2026 15:30:23 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:6d4f:b160:7aea:9d1b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e9ee07sm14791025e9.15.2026.07.15.15.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:30:23 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/3] PCI: rzg3s: Fix issues in cleanup paths
Date: Wed, 15 Jul 2026 23:30:16 +0100
Message-ID: <20260715223019.3002237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

This series fixes a few issues in the cleanup paths of the Renesas RZ/G3S
PCIe host controller driver. The fixes include:
- Disabling the PCIe reference clock on probe failure.
- Propagating the original error code from platform_get_irq_byname() to
allow probe deferral.
- Unwinding chained handler registration on error in
rzg3s_pcie_init_irqdomain() and clearing chained handlers in
rzg3s_pcie_teardown_irqdomain() to avoid leaving stale handler and data
pointers attached to the parent interrupts.

Note:
- This patch applies on top of pci-next (commit - 5d9f1dd3b3e7).
- There is a patch [0] inflight for this driver which doesn't apply
  on pci-next. As there is a conflict between the two, the patch [0]
  will be rebased on top of this series and v3 will be sent out for review.

[0] https://lore.kernel.org/all/20260630141720.3938514-1-john.madieu.xa@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (3):
  PCI: rzg3s: Disable refclk on probe failure
  PCI: rzg3s: Propagate platform_get_irq_byname() errors
  PCI: rzg3s: Fix IRQ domain initialization error handling

 drivers/pci/controller/pcie-rzg3s-host.c | 38 +++++++++++++++++-------
 1 file changed, 28 insertions(+), 10 deletions(-)

-- 
2.54.0

