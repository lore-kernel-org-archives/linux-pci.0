Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8C93630A3
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 09:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268279; cv=none; b=glojuBa+aDmKm67GZgXzJfLgu/cZyxBF/mH0NTDDOBE4HI5M2B8Fj9XJmcX0BEZrHf3XxUeDtar7WRLDPjkeLSqkRSZLFeNVXlfWXxgGS4hImE8NTWtY+WaidIBLA62qCT5HiJ2gf59gKd+GnTK2FjY4Ly7PVBzVkaA251j1Pmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268279; c=relaxed/simple;
	bh=1/7IxJyjpTfBJFV/yq5BJwTYOwEn7vDhfSJH6+kbVC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RlW4Ppagr+JyC8g0q53+oTTWv0NCUMI9QHBmxYyU8/pQrr5rrOsHlk+JZ825U/0RcwZBeHzW75ypaRyApSfJEUmW0NdJJ0/kjlDG9yP5bJUCKpqH+ij37Alc2VkFkCPyLkQxykuuHZlvVUQ8dNbqzEe9Cs8E2BuDZT6pJsPlFhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITdwCMLW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITdwCMLW"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48e8132c6d0so30351955e9.1
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 02:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779268277; x=1779873077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YqPCtrbA/dvAY78m4Gz/YYvnD1nvK6Kz3sBWRMCrN/k=;
        b=ITdwCMLWGBUGMGfpv2S5nAajROlK4eM6CKTqDiJUtiIS1cB0jk7cd+jzaIKPKhVUXt
         QmWP119hLUhOxvNTgh1M0zCGITDb+VnzwlmaNs0OwWbKqrrycaRDI2JuPuyw6fwNweCp
         NEAaK32+trQXhu5PofgLLmmncIs3sl0tOCXEv+vg6EdzmMXAZsVzFtOnjIG5zQ5N1V/D
         kjm0Jea5/Xh2H4yurtJqlq6Gjpa8lstxQPQcM2zYWhX3NBWeEEZ/88ISFBO7rmhrk2EG
         oRuxyPM/cV4jHqEGT3zZ5t1L651RBlCTHKZ1w3Ptx1JgOe/hNseTHA7tT0/1rKTwtq72
         sZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779268277; x=1779873077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqPCtrbA/dvAY78m4Gz/YYvnD1nvK6Kz3sBWRMCrN/k=;
        b=ClvTagQaXi9yTUKwbhFQUckRQE7idYXkw2Q6ScaraSb7YcEvgnxPqALEJt+lbo4aHl
         MLjco5ptXBG5++7FE+heI/B8BupyAgDN0HmP0rg4rgI0mgwRSxLWquBzemZ/9Y5TkLgy
         vOooTAqi3Vnl9MyK6Mdsnc8hs6iqFlQY9CpktoCqL3+aU7yPjp4WrZG44JHazL1CRvuW
         QMYJOcH8jOnuNzBcSwEzANMSSKArAsr7YBUyj7ZYJVO1HpnVX28Es/Da83oc2cizArO1
         pgBHkLeOMzY6+n6eUD1+Oq345roquzra+2LDwUSeyr31k40iyAInJISKmd892s30Gc+a
         y8gg==
X-Gm-Message-State: AOJu0YyeJDF0p2MVhsMUusMFhAdjk74VFMCyDXiw9IRB5DMAo3yQ5OT9
	rOon1Bfv1iMx4dGlLzhs5RmJdBd/uT1wa7yU7TU/u/hqiHL3jQucRInG
X-Gm-Gg: Acq92OE+ehMGbk5799zEmfpXBMfv6ZLywj7xqr+14mWOEgQSajyOOg8C6lOq2eRxibO
	gjaijf/qxJ/xGaNGIeZPCSeRLLSqYNTfWLUadh0FSgVHOl+J66iqOpcWMkfVERSlDj+b4blJT8o
	GFN21qHQEog3iTLv+O3z7JFsweG7zDJRuf0jfu7HEBDzS8KUK8VciwgcKEP1clIf1jSp0ujo2rq
	FRqg12XLhbLl41XU80H2Ita9VzL03rcD+F+2QJiXya151vVlPmIRLC1lPvK9uPuYbJpcZUiqtlR
	KkNdFuzsJhXPG87b5stLuxszJZEoHOJlwLrv7Jrbdfud6mMCNSuAzC3wwAhrvxi23CjPL8ZnYTb
	si8p3ZRZ6BWrD6pPkidw//9JvRLVwYKlSV6artJgRpGxEHIF2DJ7tBs1BU6uC6p8Qem75f8Frhc
	nJFxtkcWsvuTKgX3rg58Nyew7ND9sxdIeOeDVtdxQgWO1FZv99x96G3OGdaIWONTCwJyTlHgMMu
	lmaFbNTmSEysb9+ap0UFQkaSeJF8wVZm5b2fg==
X-Received: by 2002:a05:600c:34d4:b0:48f:e230:c3fa with SMTP id 5b1f17b1804b1-48fe6626a58mr368205225e9.32.1779268276515;
        Wed, 20 May 2026 02:11:16 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:dcb8:81c1:dc9e:cd68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490225bf8d6sm76409715e9.13.2026.05.20.02.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 02:11:15 -0700 (PDT)
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
Subject: [PATCH] PCI: rcar-host: Remove unused LIST_HEAD(res)
Date: Wed, 20 May 2026 10:11:11 +0100
Message-ID: <20260520091111.67666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Remove the unused LIST_HEAD(res) declaration from
rcar_pcie_hw_enable().

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

