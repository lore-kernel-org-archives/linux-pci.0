Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C183E5A07
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146330; cv=none; b=Ufs5GkKw5Anm+vAN5EqJqiFHHiWg0nA4g361jL7h4RBP7MbI44xZzQkRRsmX000h44SqvAiOSPZpm/lDTWrlh14Sr3cUDQFip2j6mFFseeGeyAqRBd2T3XlYhvOKa4y0tXAQj+51/9wAuOWMhdXGcLehTX9kSbAD4UFjvvMXW70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146330; c=relaxed/simple;
	bh=xP4ugZ59cpxKfTb/Au41fWRKXjs5iFn62NUboX+sVQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D9cb8/qGiLJeX+g/unmliffzV0LeqUxsFe80mw7Qs84bmZ6w3nv22WBnyfLQuFvynqs8jrT1J4Wenf+N7gAnFL2WyZiOHcTn9cov/90oZvrWapjdz0IPw3hYWGHAo91A7k/rQpe00ig5Jy3Bujws74lW8hTsrP089tFdv3+TdGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQ+UaHIa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQ+UaHIa"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4954d383e64so15499545e9.1
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 02:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785146327; x=1785751127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W/QaiMP9acmSAOD+sQgmrkllJ/eryX6bbN2yJkEjt+c=;
        b=SQ+UaHIa92aO6x16G0JOfYVuuzYV+FqoHVxcpfQxvErx4JvWDHW2pPm16vju5hf/47
         gYJavD4WW/lYwjX3/suHcx3fQKVtaGmV5XQ0DCkomHYSZmHa3V+C8CPg66EXzJ/wKLCo
         P7NCkriLO6+Cm5eNP+mlTH8TkJc1bQNyyv4vwtU0ALXQMpvpGI+A0+HxC7Xerz+yoYyw
         sny/WpxrFt4FWNSFIuIhShghaP7RQPGGOWan5pNV5EnhLfOKGT1psxe3jSSu+IdEbM2i
         EgNGPa5WjBQIdVMqWKHk0OrZvhic6YOxXQ1dlCEZ7+2XmoKYOHEZrajIrCvclE1SZUjh
         8R3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785146327; x=1785751127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W/QaiMP9acmSAOD+sQgmrkllJ/eryX6bbN2yJkEjt+c=;
        b=gKV/Nc4Pn5ucYQwEBI6KBl2iN2cvOdA7PnuulA0XTd5xWlw/mnA6KfM5QHOveF1io8
         r0hH43zLgTZHIoJaJU43P3jvBHaHAqS+o+xKtOpfWXobSYJGZryaC82vluoqqoBhPfFD
         DRYnrWmmDb+vZhmJhlZqvH3IWXHkkdQnqs+jMQqHKh9viLZxlROz+glC5I2r+45Q1d6e
         3kB3rA+uJAWAVrBC2Gn/e2TwzLjHBNzJEvvcXjAsniHNQTPdT3aIO8wL6TkQypB0wpuW
         zS/ngXrkZb+xRQrQNg+bKwfkd0iB51C3p/J/GxO/3OuN6fqh0c5Wli+77tICbel5v23i
         p0ew==
X-Forwarded-Encrypted: i=1; AHgh+Rpjk0kbS6XJ+dEjIzErnzj27DqI0GDicLzls4GupbdSPWlJ2dTJUxkeWqbPbNfiJEE3+fcgcgAm9UA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdXYuhrk5fEF8OLHkV7spIjNuT8TGb51wL0s8QPzDXRp1jPOzH
	wa0x12FRHstJW3ZD0u0G0H8omeq8Hkc+8Bd5gbY2OXpzHmLPEGH1myEc
X-Gm-Gg: AR+sD12MWlE4AGd9l/FAr2kBN9cH7PEtyfFj7D/em1YXeeHxJ3iMDDzs1DA2CKFZ2jI
	6JgJREB70kinJlj9fVN5PTdnyU5rVXADP2AuNiDTPigcEgnehxYHpAJIIYNXO7CW9oBq8+f5W1K
	XAiGShlqACSdH5LzPyUEbUsqignip2k4R3DRXceoWYF2AYNbe/PeMyiy+xZbAvwrFD7d+c1qKe+
	lJ5IPb4wa0oj0Bxe/hhwjpVKnC4wcMAY5FA1WH6+3J43/VmydHe1V2FbZfA5ApaouziqIHWQ+9q
	hRabz1ubBQoVBKWss2Qt0RzCHyLNL72FysA9Hl30b2H+N/uTTLgczW53KZ2d+n1BfO90ozGFSs7
	9HDyD4IxpAUI4Ahd2mgq6wjU1h8mkgAc0AXINdtSBC39QNeFS70Tyb/6IKa8Yk1M/Pj91y1x6Tx
	WrjKjo9E4vG/A+rZq9vWvOxPlegkGIQ1RXPZlxrOX7mnaIS0edyYcWOH2XP7UuZTVXQysqG1ik4
	HxnmGcl3gGdp0hD
X-Received: by 2002:a05:600c:630a:b0:493:cd3f:d051 with SMTP id 5b1f17b1804b1-496b56f1613mr93264455e9.25.1785146327259;
        Mon, 27 Jul 2026 02:58:47 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:8281:5343:33a3:cac0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957b842691sm238346295e9.1.2026.07.27.02.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 02:58:46 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/3] PCI: rzg3s: Fix issues in cleanup paths
Date: Mon, 27 Jul 2026 10:58:40 +0100
Message-ID: <20260727095843.116950-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
- This patch applies on top of pci-next (commit - 90c4d88be15e).
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

 drivers/pci/controller/pcie-rzg3s-host.c | 50 ++++++++++++++++++------
 1 file changed, 37 insertions(+), 13 deletions(-)


base-commit: 90c4d88be15e11c1e922ef93e611b5e28103e37b
-- 
2.54.0

