Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0682C3255
	for <linux-pci@vger.kernel.org>; Tue,  2 Jun 2026 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780429832; cv=none; b=SrmDw5OfjbBhrd+1t84oIQeUruQmGDPzbroDFDyAZnsjVsVvZv5IFKszOnQMl5p+TVcv1iXYsPKtwPbiC+3Ik9E3IdBj47Nba1eVz0CY9/OFTGZQryAKqhpiSdPSyAmBMRbBfiTCwKHtDceK2J7DfJLLsKw1WrlHwfNHF7whj3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780429832; c=relaxed/simple;
	bh=ICsOPPnxezUsTeLqn0LswfluUIrWBBXoACSLyfd4mJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oige4wdP97+mDV7LOHUW45/V9agLHU63HdKCSXLNUt2hUCK3sGesfvA1uT/djA/+YTsPdScf64fKRklrenkNrv9ftFA+AvSxULW0jvE7NcgGfFoMebYSa6+Xx3ObJFAUf2CFtzPe2sBJQoGIR2A9DfBHYrog15QCuc6Uxw1SDag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNnZCnSZ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNnZCnSZ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b4a8e28bso3991705e9.1
        for <linux-pci@vger.kernel.org>; Tue, 02 Jun 2026 12:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780429825; x=1781034625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYXbG4suH7pFw0IrR422TpDoJXmZjD7Z4NW2wPRZuB8=;
        b=PNnZCnSZUZJCqguLnv3g3BQ4UAjf1JPFev/n5LqI2oKMFezB4q/wXw7sfvj0kLu2w3
         i9U8RrKJmFwkWncF5JMzWGwnRy5YM3sBnjay7cgqcuTW8BDA23MJILtG9PunEuct0uw/
         c4YGWB+zUS9ORS2DEXz7AX7odQaQeOn+RPqLHUD4TowKekH7UfW9bwn/2fq+r8guiUQY
         x66IayqvwyWy7l1t/pX0rSXTOhdGp264RV9p6mm2Xi7OAmC2kX2Yc4dTiRn7KVwThjxf
         SCGavamo2CGzFyT+UztAP1zLQsCn6kU9wqzcVCWld7ODRJU6WTnGqMi2nHGUpUNXbRr7
         c7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780429825; x=1781034625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZYXbG4suH7pFw0IrR422TpDoJXmZjD7Z4NW2wPRZuB8=;
        b=OygckWh/ECESP099eavfGvQYVVyS6+QWTY/h4yCVUzZyet3gUlg+/3NyAPlio/51tw
         aKTRhQuvFCBGTtHqsXSS2XfcVtX1BGQtrjM5o961L0FXnn+4ZNAb/uwThT4VMiATiz6F
         kZ3M8bZTh138WhZtvSHQTTUXb33Q+bZ3jg5a243pSiMkRR3O4IrD4SwBci/yV9v869rA
         RoTkkvmmfygQNepyG+GTjIZcHg7XFfwTdFkBmNBr+ME65dGpCE0rbHEiQu0hUrhFkxui
         kaLNmgR42OULMMQMO1D/24cQ+dtIUHJ2KcFZjT+TPSCauhM0xDtZn/hn1eMCGWEBCgf2
         HAeQ==
X-Forwarded-Encrypted: i=1; AFNElJ9dCxsv1oGXVW4dK87yEQT+MMfGN4WJ7kBhytb+9t5BcE7+8t03KxDrpo85c04rtrX0yrMWC7fVleQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ToZBIaRNfhQf9R6KHxqnZr62fyFbm3Z/I4saBOckTe9lsYK6
	5y5ge3c/p+CgZiO5+NCPfaJnDpg2O890/9z63B3SDgeeS7mpl3okTip3
X-Gm-Gg: Acq92OErAjA+9jT7ekTHODk1H4l88ACcabByY30PvcV4rIEHdjUskrQ/f2ZG0EWhD/R
	L6eziPtvGEJzREs6hQa6QJRxst3hvKIJW5y6bWVN8xS35/Qd4zZ61d19RPLUIft85luF1vbWRgz
	m0olM4kQrZnsF6QJyiSr8/O8LmKC9732SFq0f0u0fe4Av2a6oZPaV4+U2BeKzY1mqwEfJXyDqII
	SRG7nCNih7YCTSv02kYEqGMvzO8KCvzq+MADHhrPKQZVgZ7idIoUBA35DPBoh2qxQgWuXcyO2Z5
	miIzQUL6qiAVqHS9PQsin7FpBtr2tpzSPIGxb+zFfbpvBK6dIHVLJHTUUtwnVkNZFpTxXqy2wmx
	o1E/oWo6TB5D8O/H10KJD19OsxP2GVTt3beaPqooiBt+F+Jp0RB/Ozmzz4hHuQlQDvquoFgqfkY
	tJvfEk5sI+XzpZdZF4i0LTSOLm6P2tifB/k/T3PdgPjOdoN+nJ06vuwLE1SZbwdK5X3ZqqJEOgG
	nAikE6VVotDjyHciH0W64HslAu+cvK5igkP9twEtSNeSyDBig3SDHkf
X-Received: by 2002:a05:600c:a49:b0:490:b3e7:4614 with SMTP id 5b1f17b1804b1-490b5e64ac8mr3939265e9.25.1780429825427;
        Tue, 02 Jun 2026 12:50:25 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:5ef:9913:4a77:3bcf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e13eefsm87353395e9.2.2026.06.02.12.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 12:50:25 -0700 (PDT)
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
Subject: [PATCH v4 2/4] PCI: rzg3s-host: Use shared reset controls for power domain resets
Date: Tue,  2 Jun 2026 20:50:17 +0100
Message-ID: <20260602195019.1798126-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602195019.1798126-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260602195019.1798126-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Switch to shared reset controls for PCIe power resets to prepare for
RZ/V2H(P) support. On this platform, multiple PCIe controllers share
the same reset line, requiring shared ownership of the reset control.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
v3->v4:
- Added RB/TB tags.

v2->v3:
- No change.

v1->v2:
- Updated commit message.
---
 drivers/pci/controller/pcie-rzg3s-host.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index d86e7516dcc2..a5192e4b58df 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1276,9 +1276,9 @@ static int rzg3s_pcie_resets_prepare_and_get(struct rzg3s_pcie_host *host)
 	for (i = 0; i < data->num_cfg_resets; i++)
 		host->cfg_resets[i].id = data->cfg_resets[i];
 
-	ret = devm_reset_control_bulk_get_exclusive(host->dev,
-						    data->num_power_resets,
-						    host->power_resets);
+	ret = devm_reset_control_bulk_get_shared(host->dev,
+						 data->num_power_resets,
+						 host->power_resets);
 	if (ret)
 		return ret;
 
-- 
2.54.0

