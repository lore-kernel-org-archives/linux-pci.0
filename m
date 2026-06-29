Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5E337269B
	for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2026 22:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782770979; cv=none; b=lPIqK6N/joi6FFsIgZKLaZZTj4Y3wPO1+wM6k1X7MUu7rTrDDKvC6EMOnvCMyJ90TRaR9sD87CNvNvaOWdtEvVeyURE3ZqVoCiq3Wp8svFSjbF96WfzdhFwvU9tjpMbxUgEgwfsgxLY/yvR3QP5wITC81VehcAbXZFnmOOUgNjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782770979; c=relaxed/simple;
	bh=dhQzi1x48ryD4rJL4k1XyVX85Y0JnOS0wR5MAkVSy84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXgMCcgARyJ9UNgrPMY/eUU5Cao4cfloHlRIhiqYs8MAoTcdNRsIyI2Cye3zaWfg4O/i1EokGs7wvaWBOsRuqoHQlzBetjcj7nm2hTvNy2hXSz++h1OyAam9l/FuGNJbMOjm05TMksQZqXIL720kVVy1OH02KM+r/6zE9Po+AwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OG3W4wj4; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OG3W4wj4"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-471eeac43bfso2281271f8f.3
        for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2026 15:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782770976; x=1783375776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRJkjt8AickuNlQZaUOz1iy2SuKGb10tp5+3LWknCq8=;
        b=OG3W4wj4o2y27JcRQMqeS4mDgZZVuBSeJ+6VGDOc5oyd3MaicvdS3663pPq0nCZ7Vu
         93GGnQcfa9mchCdwe6Xebs0o9EqacztF8j9jzZhcnmxQ5NCsRbbV3xiHhcMaX16dxUcM
         PirTmu24GNxyYib2bEM13CckptUFb2HCjMinRUkrqEPCFEhNnZCEMRQ1+feKcfrRe6Zv
         OO6DjLBhqNhyY3K6mKYWA1zXGNtNcotBY6b8T3jehr90sw7DK6UOc20QhIS76aHlL9+h
         b+T7myqbJyErWo+pHzHXTvBE5io5XUpj6GIdtBUA5ugrD/W/ngOhipRfLRV/z5Y7c9/x
         inAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782770976; x=1783375776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iRJkjt8AickuNlQZaUOz1iy2SuKGb10tp5+3LWknCq8=;
        b=gOV45k1L8UTUCInb93lWKox3Cs9M2YGI4hr3Top1tlqJGj+eBkI4fN56/Y/x7oSSdb
         85h68o5jGMEY5PDmz4IEPQYexsHz03UlX9VL+ZttVp+nQKl1g+yg3gK4T8ORg2Wfu6Hh
         +VFwWETw917MS5TGfdALHTFWCWi2vQl5CNZqeUePHTnIWstOzg75p3NL8TjVChldgG4K
         giWsknnIA8OQA+tfodewSZtBLe6W3Q/y1YLxzp9HjQtlcZFnOY3owxUoBDYLMIjYIqGt
         ItFKokATN/x34n4XdFtoYZ5HOz4l2VDZP3JPE/Jdi9qTVqcVHsH2trgMcIy+aYW/Bqwz
         RnTw==
X-Forwarded-Encrypted: i=1; AHgh+RpbN8oWM5usQX+FlBEhLhCC+GAOtMfhAMTEW/JId3rMsWrzTEF1jsCIOGeRcHfXjch+CF+3+jT3ip0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJPEt/CFj/8Tuds2FByPKX1WVzKL3lJ3w7/A6SYNMOVpgwN6Os
	kw+wVfVismOVzfV1ntgkP21TH3Nvhb4PEDu08C2kNG8By59BJ/Ek/HRw
X-Gm-Gg: AfdE7cmoaywMQxYcIiIQqGk0pvWvnRLxNWgY4zZzoojAWGKnHnfVCWSD/dHWPZ1slTt
	YCQjqEBqIzJzYyzGBAPGisSZ/kStrpUnf88ZKViL3N3/8Ncr64GW/pZj+Javy2OK1umIfPYQA6p
	MLsohUinx+iMSruqAqf53X/MO7Y0ib5ffFa4KRVFzwL/RdoZfeh+f4me8+ChquMQqt2XdUcBUsh
	iHXbUYBMUyDaETIQ/RSJEB0H1l/vw61HSa/JM9Oc3NEwzhyC30u83OlB6l6fgAKXlR3D3KaQhb4
	aIlVfbO+VfH1XWLoL9N/gc5PDCIdGUKSfdqPpc1J95TdeYeNPqBnAFGKdbcX9PJcvJZvqZzkG1i
	/bV8PYeiy3cRkzJozc63LUnf6ZmhOKnUSpcOXYAUCrzXph0oEjTSqknBXADHM0CGlpyofhIvXK+
	jDcmwM5nwUAtM4QjsC9l1l+YYxes+VPEV5rmRKyKhfMqxMZ0kSgqT32iGEkeVrYvUXrLnah7FTE
	jx9L7Uiyw349pkCBwI+USVmLCI=
X-Received: by 2002:a05:6000:29cd:b0:46d:d90b:bbe4 with SMTP id ffacd0b85a97d-475524a86c7mr963076f8f.40.1782770975813;
        Mon, 29 Jun 2026 15:09:35 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:dfcc:acfa:dec0:e556])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47563d195b3sm1644670f8f.8.2026.06.29.15.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 15:09:35 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
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
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v5 2/4] PCI: rzg3s-host: Use shared reset controls for power domain resets
Date: Mon, 29 Jun 2026 23:09:30 +0100
Message-ID: <20260629220932.861445-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629220932.861445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260629220932.861445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v4->v5:
- No change

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
index 66f687304c1c..cca2617f2915 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1277,9 +1277,9 @@ static int rzg3s_pcie_resets_prepare_and_get(struct rzg3s_pcie_host *host)
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

