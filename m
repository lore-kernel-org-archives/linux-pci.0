Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792445491;
	b=zQ3K4bCetAb+jocsDdwfGIc8HySKUKYg1z3jia/lUL/eQkwgcVnEKjSEZ8105SM/egBa
	 vDInM9OfAQj5rn/tKYN3Wia3Q1WxH6gYDqtlOp/6Jbx1/1ZrVWmHTkqtIkypp4NEkw2Nj
	 Gy7mUnW4c1JrdIPH9QKrZbWR9QxHSpv+AkMoChdmIdEYzfAnSBiiacGP1k4rKLvmnUx/C
	 9GJVYQJrnwp8G8XruD+47vjzmRSPLzkYGzo3jSkMcOzBm53pqCAAbESKEt3Ji6H0RCUVj
	 l2fVeML+0p+a1BMYvnrDEJIEaTeOhd2tfIV18VxOJxyyhbPWmAzNJnC6BmMlzcya7sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792445491;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=rccGvdC4VDGY+kjlq/11HJtI0x1dTEfzAQPx1OmbdOk=;
	b=Sr6olhovF7oxBfpSBfy4l6fI7WCeeeZw7VluleUiUA0HdONWKq+jtqgmfEkH7QK++GfB
	 hPdofM89X4fow+/EWx6u36WMDRP66VTUY5st7CxBvV1a7XkTbMN7+INk6WFqybhgyOp8X
	 nG2H4PGDfP/B56kausAgTORu0XgiMYqlzW+1r0QNzJz7otbSPrBAFK1JD/T2W73QTiyZj
	 t9fWk0iEnTlGvRJkam3YRTm3e1HQ8ujhkfwF3QsXj24XTnGY1wsqZJezkaAArkMoLb01U
	 9ipkr3xM+1dW4b4eizCzPnKeTg6CoCZ8eG7sLQ82RqoND44U0M3X5TnyJiAdcZmFnuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="lCB/cTUN";
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93803606A328
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 21:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93803606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=lCB/cTUN
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e987ec84afso23017205ad.3
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 14:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792445486; x=1793050286; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rccGvdC4VDGY+kjlq/11HJtI0x1dTEfzAQPx1OmbdOk=;
        b=lCB/cTUNtTm6nuMOARpJaIXSViDltOFlsZY5CpR1t80Lgxfrcb65X6T0N1e6nPpykp
         +so8acqBa57AwC5fiztUSP1b4afDLZb7q7INU+EbArTV96pjyqdyCx9nAYxJ4/YMn0Sf
         oWh5dSV/wUS2IvZRkH3GFsiRxIDvDkDhIrgM35mZqQC7qMpPBmIruMupt+oELCyhjE/q
         mtRDkQgyGRlAKLdhCbShfKitg/LjFGFptkYyFBwTs75UK52rjWVmkiIIFAlgWD4X7fbf
         Jl/EbAojnjlhRCI/iKWPXd/NnIv5+kycfRIk7CuiC3h0u4ux58GXgjAuAsRIkVmlifc8
         9J5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792445486; x=1793050286;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rccGvdC4VDGY+kjlq/11HJtI0x1dTEfzAQPx1OmbdOk=;
        b=d/EAOczTS742rYGBJI1Ke03WsZrVxpUJhZxSj4OkCaPXtUVUMX5eL3OB1DyX2uas9G
         tF8tvJS8UDQ7u3kT6uVOVy6njtaob/7CgqeHT4DOumPL4KoFDt0ZjX4mX2gH2Sv/o1rA
         G9XSqnM2sxV7tfYmOBL99hq/hV8uBWot/EmjNPC8bMYia6xquP8O/GOb8IN2nVAscvET
         R7+9Y5d8jUiy4El7/xBMTrOa753s1ox0UTVfjzuS1Ym24ZoAhSFEnbS5e2LFqYttOEhP
         37cpD27WOgywplShus4fbFTG9JdGdVIH/QrzOjpwVgfA4aIrbN0Ozawl167Zj8TKabB4
         LgNQ==
X-Forwarded-Encrypted: i=1; AKwUvBzbN+bwwppNhMRQ3Vi4149aOdLY+kicAMeH5c9AxzSy1k0zh2XbRPIzrRmsbshH3NSZxBlwFYIz58E=@vger.kernel.org
X-Gm-Message-State: AFq9FYI8i2zxFresY5kcDwJlrmxO+QItwzfQnEbwR9esngZlPLB2uJ4S
	lP/S6BoLli6dYiq24gAqmp8Ts62w3pNd63HWUS0sbb/MVScyYCD+tqhHIhKgt0xjvqCNXGFPZZo
	2xIzvApRIHOeVIA==
X-Received: from plok11.prod.google.com ([2002:a17:903:3bcb:b0:2e9:5b68:4b7d])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e949:b0:2e2:d02d:a173 with SMTP id d9443c01a7336-2e9a6f59777mr77394715ad.49.1792445485578;
 Mon, 19 Oct 2026 14:31:25 -0700 (PDT)
Date: Mon, 19 Oct 2026 21:30:49 +0000
In-Reply-To: <20261019213054.3157159-1-dmatlack@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261019213054.3157159-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261019213054.3157159-6-dmatlack@google.com>
Subject: [PATCH 05/10] PCI: Skip programming bridge windows that are already programmed
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	David Matlack <dmatlack@google.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Logan Gunthorpe <logang@deltatee.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Skip updating the window registers of a bridge in
pci_setup_bridge_io(), pci_setup_bridge_mmio(), and
pci_setup_bridge_mmio_pref() if they already contain the values being
written (ignoring the read-only low bits of the base and limit
registers).

pci_setup_bridge_io() and pci_setup_bridge_mmio_pref() temporarily
disable the I/O and prefetchable memory windows while updating them,
since the base and limit of each window are split across multiple
registers. This happens even if the window is not changing, e.g. for
every bridge whose windows were assigned by firmware and claimed, since
__pci_bus_assign_resources_one() calls pci_setup_bridge() on every
bridge that is not yet enabled during enumeration.
pci_setup_bridge_mmio() updates the memory window with a single write,
but skip unchanged writes there too for consistency.

This prevents disabling the windows of bridges preserved across Live
Update during enumeration, which would disrupt memory transactions
targeting preserved devices below them, such as P2PDMA from other
preserved devices, or MMIO from VMs whose vCPUs keep running during
kexec.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/setup-bus.c | 52 ++++++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index e8c94aa1d3c1..4bec76950f46 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -799,8 +799,8 @@ static void pci_setup_bridge_io(struct pci_dev *bridge)
 	struct pci_bus_region region;
 	unsigned long io_mask;
 	u8 io_base_lo, io_limit_lo;
-	u16 l;
-	u32 io_upper16;
+	u16 l, cur_l, l_mask;
+	u32 io_upper16, cur_io_upper16;
 
 	io_mask = PCI_IO_RANGE_MASK;
 	if (bridge->io_window_1k)
@@ -823,6 +823,18 @@ static void pci_setup_bridge_io(struct pci_dev *bridge)
 		io_upper16 = 0;
 		l = 0x00f0;
 	}
+
+	/*
+	 * Leave the I/O range alone if it is already programmed as needed,
+	 * rather than temporarily disabling it below. The low bits of the I/O
+	 * Base and Limit registers are read-only.
+	 */
+	pci_read_config_word(bridge, PCI_IO_BASE, &cur_l);
+	pci_read_config_dword(bridge, PCI_IO_BASE_UPPER16, &cur_io_upper16);
+	l_mask = ((u8)io_mask << 8) | (u8)io_mask;
+	if (!((cur_l ^ l) & l_mask) && cur_io_upper16 == io_upper16)
+		return;
+
 	/* Temporarily disable the I/O range before updating PCI_IO_BASE */
 	pci_write_config_dword(bridge, PCI_IO_BASE_UPPER16, 0x0000ffff);
 	/* Update lower 16 bits of I/O base/limit */
@@ -836,7 +848,7 @@ static void pci_setup_bridge_mmio(struct pci_dev *bridge)
 	struct resource *res;
 	const char *res_name;
 	struct pci_bus_region region;
-	u32 l;
+	u32 l, cur_l;
 
 	/* Set up the top and bottom of the PCI Memory segment for this bus */
 	res = &bridge->resource[PCI_BRIDGE_MEM_WINDOW];
@@ -849,6 +861,12 @@ static void pci_setup_bridge_mmio(struct pci_dev *bridge)
 	} else {
 		l = 0x0000fff0;
 	}
+
+	/* The low bits of the Memory Base and Limit registers are read-only */
+	pci_read_config_dword(bridge, PCI_MEMORY_BASE, &cur_l);
+	if (!((cur_l ^ l) & 0xfff0fff0))
+		return;
+
 	pci_write_config_dword(bridge, PCI_MEMORY_BASE, l);
 }
 
@@ -857,14 +875,7 @@ static void pci_setup_bridge_mmio_pref(struct pci_dev *bridge)
 	struct resource *res;
 	const char *res_name;
 	struct pci_bus_region region;
-	u32 l, bu, lu;
-
-	/*
-	 * Clear out the upper 32 bits of PREF limit.  If
-	 * PCI_PREF_BASE_UPPER32 was non-zero, this temporarily disables
-	 * PREF range, which is ok.
-	 */
-	pci_write_config_dword(bridge, PCI_PREF_LIMIT_UPPER32, 0);
+	u32 l, bu, lu, cur_l, cur_bu, cur_lu;
 
 	/* Set up PREF base/limit */
 	bu = lu = 0;
@@ -882,6 +893,25 @@ static void pci_setup_bridge_mmio_pref(struct pci_dev *bridge)
 	} else {
 		l = 0x0000fff0;
 	}
+
+	/*
+	 * Leave the PREF range alone if it is already programmed as needed,
+	 * rather than temporarily disabling it below. The low bits of the
+	 * Prefetchable Memory Base and Limit registers are read-only.
+	 */
+	pci_read_config_dword(bridge, PCI_PREF_MEMORY_BASE, &cur_l);
+	pci_read_config_dword(bridge, PCI_PREF_BASE_UPPER32, &cur_bu);
+	pci_read_config_dword(bridge, PCI_PREF_LIMIT_UPPER32, &cur_lu);
+	if (!((cur_l ^ l) & 0xfff0fff0) && cur_bu == bu && cur_lu == lu)
+		return;
+
+	/*
+	 * Clear out the upper 32 bits of PREF limit.  If
+	 * PCI_PREF_BASE_UPPER32 was non-zero, this temporarily disables
+	 * PREF range, which is ok.
+	 */
+	pci_write_config_dword(bridge, PCI_PREF_LIMIT_UPPER32, 0);
+
 	pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE, l);
 
 	/* Set the upper 32 bits of PREF base & limit */
-- 
2.56.0.212.g129ede20d9-goog

