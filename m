Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF47B2EBBA1
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779354784; cv=none; b=PmzFEeXTTa7w/a4nG+9n3jydP6iN1ZDBEOowen/UcvffKBVKRQozY2jirXch4TCuZDHMJOVH/WpmT5noQZEbDe7eO3b3y3w7FaipTnuT0V7yzxe76CyP4I08aA0bVsIa7rWtiXukbzUXpgH7fZ2sPOPRk8805z63r2jvDAEJG2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779354784; c=relaxed/simple;
	bh=nw+AbDWSkF/0mQVIA+TV4A4Ed65ipc2EyE1oFsQt/LU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JcoyWbdKyGrZH4OqK+5PVxlEOgcjNsAriQtZglTtcfrZ1eSZwjOb9tmLzODfDn3EY3TsoxWpuxWldABDoKskPm87kq5KmAmZGqx6gJ8Z0kyeP/DqiRip5gJfu/p3t0oQ4Iogo4Ma6L9yVuN74azvYbRTa0tuSWewWJasHhV4IsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koyJbRb2; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koyJbRb2"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-44dd5cb0f81so4698124f8f.0
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 02:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779354780; x=1779959580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eKdwRFTM7NQFW2q3Gwv2bxtOXYeZ9TnQRhzY2TP3tE8=;
        b=koyJbRb29+xoYIYqccjyNlgNSr8neQz9QFTmHO6qhhUwR4FKMfMbyGngLjTuwabuwS
         iFTqTESa6hSVPcP3jRrc6bia7NtgUq4yJwJ9z17ZNUH19MlE+f324KQWymSrRJ/NJK1J
         SMOXE4SmsCr2lV0gX/7oJrSKxVGDKei29bn7IMqcKFSMoJDKYj6vVNuOQ47K/xBXDIAB
         b23P48sS2AkwfnoPx9XFfe0sVE0A7r2wkkvIE2dg0WfjYS7fg7lVFoXudxb3HjCa5Sj+
         HjmuhIC4OATXXbnp/p/3lwcyBoVUWkHZ/x5qG/C/BjUx1S8q585IccOdr3FgTtimquSY
         vMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779354780; x=1779959580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKdwRFTM7NQFW2q3Gwv2bxtOXYeZ9TnQRhzY2TP3tE8=;
        b=ETjgD6rcSJROP8JLJj0Iblt8PhB3/2f71EoIUDDbxbOG/sSeMiPM8jBrcu037RQsA4
         YTvk94FZwVYOoOXviOLj6nGeJ74a5rrr/TNJjC8SANuzQdXstlM5ePhKCXsG7cdxQ4EI
         5d0uIRN9tzfEfM5ZmSwuJ0utorqxozTawgfN/S+JCiS+rgSQHEaRZB1JElANwppQrvUz
         xcjt9xKBZ5xNvPuU+nUHtcSWy2uJ5H+NWA/2Fb+O8OG70j/g0dZVO+wesTgXLJVhOKqN
         EAkapZd5wlC3rCFmlNFFyUouVQ0Ew62jb2kxEC8/ycIO91P79sQ2qdYAcoFfALPoypPg
         tLCw==
X-Gm-Message-State: AOJu0YxlZwsnqgRhMJJiHTE0wTwgIHE/lPwFK3qkHtnnLkpnjv7gw12w
	L+uJ4k08rKLo9+XYvD+Ao4JHjMf0dxoxnM8tMM9yf83+DlDdrRWxBGBm
X-Gm-Gg: Acq92OGgBOCChBM578SteeiHvncC+P2rJ1YPWpMbDV8iy5VKSZxrBqsiSBFQTDO62ab
	0lyTqCMKvO757+umq+1X/xEXI/q2WFEwAV+JvELLUo/qP7xFh/cok/5blmhDKMi7RdPnGj/YvlC
	BlMDxMcdPzjkj8g6c00+c7lhq0DR8X8aP9oShMOa8T/Lv5f56kqE4RzhVzJ+9rbP/88zx4rmRjh
	dS3OYDaQ9tJsdqRGWhtufyPPa6nYU4sM5F4mmIYF18JxWbK/iLxPXTnV0CMjXrtEqzvAdWxiU/G
	XDW4iogy2P0ppsdyq3DjuIOoX50XxNWX60sdWq+RLEpZBLaXzL5D2CaEGGY/wyKGnKjfDYWUCTZ
	JZkKDQLnhOH2GBSmr3pscJu2s3YeuiIHQZVr/sl4nNwTYQD7z0GBMiR05NMyGIb1ODUaL94/o4U
	ftc48Fc8cirFSlJMbYah043C3ivMdX2zucfxmuQC4jk1EJz3F7N0fGE1QRtsIQxd42H738qOzue
	GjJTyY4CEB5SjQ7z5b6rXIrR1XkpymSiDLhNWw7w8sxGjn3
X-Received: by 2002:a05:6000:2388:b0:45b:d872:592d with SMTP id ffacd0b85a97d-45ea349a320mr2805009f8f.10.1779354779965;
        Thu, 21 May 2026 02:12:59 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:e184:549b:e5bf:ab7f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa7cf58fsm1955940f8f.3.2026.05.21.02.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 02:12:59 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2] PCI: rcar-host: Remove unused LIST_HEAD(res)
Date: Thu, 21 May 2026 10:12:56 +0100
Message-ID: <20260521091256.15737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Remove the unused LIST_HEAD(res) declaration from rcar_pcie_hw_enable().

The macro instantiation defines an unused 'struct list_head res' variable,
which conflicts with a valid resource loop-local 'struct resource *res'
declaration further down in the function, triggering a compiler variable
shadowing warning:

drivers/pci/controller/pcie-rcar-host.c:357:34: warning: declaration of 'res' shadows a previous local [-Wshadow]
357 |                  struct resource *res = win->res;

Fixes: ce351636c67f75a9 ("PCI: rcar: Add suspend/resume")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
v1->v2:
- Updated the commit message to include the warning.
- Added the Fixes tag.
- Added Reviewed-by tags for Geert and Marek.
---
 drivers/pci/controller/pcie-rcar-host.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 213028052aa5..cd9171eebc28 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -346,7 +346,6 @@ static void rcar_pcie_hw_enable(struct rcar_pcie_host *host)
 	struct rcar_pcie *pcie = &host->pcie;
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
 	struct resource_entry *win;
-	LIST_HEAD(res);
 	int i = 0;
 
 	/* Try setting 5 GT/s link speed */
-- 
2.54.0

