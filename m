Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7090142901D
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 23:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789169760; cv=none; b=rwz3Fu4ozDQHRlD/qTRbV48q2JWebjqvinX2jvGU5CxRirUFNDQjOs52bFrN04Pw2nMMvuPyIGg3Ho/UgMJwt5VcZ0Xlo1jBe3n9/Z7KRnMAHjmZ0mb5IjBtBOJbshSByqtrpmfcZxJ20eKns8DTE2KYzFfDUs2rT6ugowKs/BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789169760; c=relaxed/simple;
	bh=T48SFl0hfG/hIeHA+WLTxN4W6zR+AqfTEym/r11qGfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X7ffmu5LVgYoBVQ0rnnLLm80M1OLj03aCrwTnfRORGBaxf0t72+cgf+PwsDMomtt+GuF+H3sv5YDEZBalfVr1MFmjqU/b/2Ku6Jhs39Ap/Eo8KtgFEw7f35tT3Bi/IHVJDrdPo6/wGtJhHEpNbLI7fYKdS6K1qOiAJwBYVDsc44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=N4hHzScj; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="N4hHzScj"
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-855d2bfae95so1885650b3a.1
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 16:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789169758; x=1789774558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VUDYRA+elxh8m3+YuX4zLBX8SlbUvqG/ZGp7B+YZHjQ=;
        b=o02fK3rvGIIpmlp08dk1hR270thYnxfOFXC8Rj7ZxIH7YcpceAA4GpoXx4O0XT5Hbd
         TcUodyiFZHMTsHupN9HHdSArBPgnBHXcNVgwR6ufeL7/fahjsuXuuG7vjht+6GaypjoO
         dm2vWv61d9C/g3dRBYoWZAw6xCr+krEYZr4zL1xfeMKI+AxaPeYbgDYh6+YmWOi0os3y
         x0ENat9RuMVnUzos02R3+2pst5G+YB0ekzmMYQQgaVuVFkAbgn6WNr9kzpwkPGil6ACc
         YRK//sK7TerwdupHF8yYL22JSuQUXzE3ImS07iJBIJ5NP+eZBJE9bK/+dh64b6NJ2S0H
         gAmw==
X-Gm-Message-State: AFuF++kzAwGpk5zcfW0z3+5saHX84VXz0e5+beFIzy8fQBAzWufqrijy
	b/hWM7tIXowdoZxegMn+z994nQsGnxjcWgHp1b+ykavtrC8MjUxR/vykY/3JM4xEj+hoaSw6cEK
	SkWeMRNWVvz9UDoojXHfScHi0BlMbDBXb6N+Y5uZsTsBYwk1PP41rWSVtbQHDpOUVmewn1ZNSfA
	/us7rULmv5c3SnBUCHLU6WrXGUhZq0oRQIihA4MOOf4N676AZH47uYc62YP6cbCrvaB/oDmM9xL
	SMrO+xd/YrdqtuG
X-Gm-Gg: AYBFou32p8hYC1aNwsfglrxj078dXdvLBHNkZ688Uh0tqeS/c/s7YloWuRT+bZJgmIY
	Tf7pEN8bxb1XrUe4knKdOZgITdlaqKxyOE07Z7r1jXWvNrzFcI/DHcomiZI3mMqIHESI3i1Ldzu
	vOhDsPLFs6kgJv7rej1K3kHfIgbN/ycxfx/Li51ED+0CZa2xsjOl/8wdX4jIIbbWt+kQ7lNhQ0D
	uaY1yJINTUXzc5gBJ8V48tQFySYmS9zxqjict/cmccDZIIn4+UzduzE1lyOZl1AONQlQrl6Oy/U
	SdIKeLkw9FhDErva47vob51KOHm7iCCi2efILi0BDblbRAWF053IlT9O8/4oaSQmtCCFWkKv5iK
	yd4as0NClHPpKhbkb72zKM7fr8sqlCIG7fMAvseFnI+63pG6AI1qj5us0IVyMqgj0pNCoFT+3qm
	PYsLiUGfMf1kIOuTw8HQulb+P7VrM2a2wBhtZW
X-Received: by 2002:a05:6a00:c489:b0:86b:d660:c60f with SMTP id d2e1a72fcca58-86bd660d0b7mr2320703b3a.17.1789169757715;
        Fri, 11 Sep 2026 16:35:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-14.dlp.protect.broadcom.com. [144.49.247.14])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-86b4256fe0fsm1089571b3a.3.2026.09.11.16.35.57
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2026 16:35:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-9105be46009so31513896d6.1
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 16:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789169756; x=1789774556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VUDYRA+elxh8m3+YuX4zLBX8SlbUvqG/ZGp7B+YZHjQ=;
        b=N4hHzScjuki7aapQCdjclzeyqCcdPamMy5TmK5lkZur8ahKA1BnQGyipfFGx38/+cJ
         Hfo9Hkl3vDT1P6TV/zObHZ2jLc1jk1byQk31FG0FcuirVuX3qZebcfPpgGHu6xxp3wB/
         YIIdErnPSJWn8CtB6JGPHFKb4jFESwXPcQXrs=
X-Received: by 2002:a05:6214:2b09:b0:8e9:51b7:2d49 with SMTP id 6a1803df08f44-912028a08bdmr150317726d6.2.1789169756422;
        Fri, 11 Sep 2026 16:35:56 -0700 (PDT)
X-Received: by 2002:a05:6214:2b09:b0:8e9:51b7:2d49 with SMTP id 6a1803df08f44-912028a08bdmr150317256d6.2.1789169755927;
        Fri, 11 Sep 2026 16:35:55 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f45ab71sm31717326d6.12.2026.09.11.16.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 16:35:54 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 05/13] PCI: brcmstb: Declare and assign quirk OB_WIN_MAXSZ_128MB
Date: Fri, 11 Sep 2026 19:35:30 -0400
Message-Id: <20260911233541.1650895-6-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911233541.1650895-1-james.quinlan@broadcom.com>
References: <20260911233541.1650895-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Even though only BMIPs chips have this quirk, it is more uniform and
readable to define this specific quirk where each outbound window is must
be <= SZ_128M.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 71ddd8a760af..401898d04d52 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -290,6 +290,8 @@ struct inbound_win {
 #define CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN		BIT(0)
 /* The outbound windows must be within the 0-4GB region */
 #define CFG_QUIRK_OB_WIN_32BIT_ADDR		BIT(1)
+/* Each of the outbound windows size must be <= SZ_128M */
+#define CFG_QUIRK_OB_WIN_MAXSZ_128MB		BIT(2)
 
 /* FLAGS */
 #define BFLAG(pcie, flag)			((pcie)->cfg->flags & CFG_FLG_ ## flag)
@@ -1294,11 +1296,11 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 			return -EINVAL;
 		}
 
-		if (is_bmips(pcie)) {
+		if (BQUIRK(pcie, OB_WIN_MAXSZ_128MB)) {
 			u64 start = res->start;
 			unsigned int j, nwins = resource_size(res) / SZ_128M;
 
-			/* bmips PCIe outbound windows have a 128MB max size */
+			/* PCIe outbound windows have a 128MB max size */
 			if (nwins > BRCM_NUM_PCIE_OUT_WINS)
 				nwins = BRCM_NUM_PCIE_OUT_WINS;
 			for (j = 0; j < nwins; j++, start += SZ_128M)
@@ -1997,7 +1999,8 @@ static const struct pcie_cfg_data bcm7425_cfg = {
 	.perst_set	= brcm_pcie_perst_set_generic,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 	.num_inbound_wins = 3,
-	.quirks		= CFG_QUIRK_OB_WIN_32BIT_ADDR,
+	.quirks		= CFG_QUIRK_OB_WIN_32BIT_ADDR
+		| CFG_QUIRK_OB_WIN_MAXSZ_128MB,
 };
 
 static const struct pcie_cfg_data bcm7435_cfg = {
@@ -2006,7 +2009,8 @@ static const struct pcie_cfg_data bcm7435_cfg = {
 	.perst_set	= brcm_pcie_perst_set_generic,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 	.num_inbound_wins = 3,
-	.quirks		= CFG_QUIRK_OB_WIN_32BIT_ADDR,
+	.quirks		= CFG_QUIRK_OB_WIN_32BIT_ADDR
+		| CFG_QUIRK_OB_WIN_MAXSZ_128MB,
 };
 
 static const struct pcie_cfg_data bcm7216_cfg = {
-- 
2.34.1

