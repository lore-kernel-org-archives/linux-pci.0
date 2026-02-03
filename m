Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913F5394466
	for <linux-pci@vger.kernel.org>; Tue,  3 Feb 2026 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770137192; cv=none; b=hPoAmm62V5Y5NlWMa1KMU0BopOWfh/KejPibDXycGKbU0EiGxIooMB5oDqCJjeBrErmAu3h8r4EtwqD6YZhPjHtspQVPpjOjmz/DZa5HManjYgfGv6d0DkEaP86Vm25M/UF9YyLQ0EoiL9VKe32z9Rpi9tf7qeRNl61OV3Gm13g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770137192; c=relaxed/simple;
	bh=Gi1htnYpLsbfBZ4uIWrPR1buObmElY1r/sNxGV1Nc04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=e+xZRvmbrx001tpbi9CMuafuEw5X44eUZm6h9nJ/J/sKkLHnx4Eaov+lMIePouUzt+6UE1KaU9K/znQVt8UxIEBzQo/aGJchqr8cp1uei/r8zLB4mlgWtZIp1p36n+/g6Mr2kofrPXO/6C5qDnj91cMhd/WIgubr2iYhDDq3ZIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnV0Uxno; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnV0Uxno"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34c868b197eso4253298a91.2
        for <linux-pci@vger.kernel.org>; Tue, 03 Feb 2026 08:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770137191; x=1770741991; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=49b0/xPdvxtHrk0c1rp4r1O+40H+pdifaRAqxA1I5XM=;
        b=QnV0UxnoWMicq7tyxI6fcbcy+3g86q779zFaRY9scFsiksuQBsZi/XcYM67Fo7NH+t
         BEjX0UCE4gha0yVzTIZErhVIsikH0ieb534TDt4bjO3qel0fjyVsML3lUOoDzlOpQn2l
         YAL7nrwigVeYa0i5ubxPUFXm/joaOSnc8xEYAJ5/ozBFItL7sGPpc+P+vprXqYs42HsX
         MEcdjt7qKe49+7blDZog+YRCNOlPr8gi0qxOg1ytQLsmfiNjKhHK+hvy+rbsOAkB+Rcr
         D0uQ5Ej62hf8cScGe4qBx3pyEQAe7Ra5TZILITlKB/XZNXab9qtu1kbh0HhBLGizGNa+
         k6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770137191; x=1770741991;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49b0/xPdvxtHrk0c1rp4r1O+40H+pdifaRAqxA1I5XM=;
        b=SIGY8c332am7Yh/0dBtRPmPXoJ3+v//9Apo6VCg/Vu570goUqaxhlEMQJEuu3LqKhO
         AOOnj04Rm9eF+lnXAarbwZt8bJ3YI0jhodWkyWNLtKzUNQJV5pBiJBRCb6vRip0g1qaf
         aIj5qZeYpRwPkTFKDSWKfNxC0+4R7D4dkEsP35oEUsQIEbH+1a/ht6EHlZWOdFAl2GHT
         +l10foOJ5vMvy17TtOGhT+vJHUac5Eag+5Yg+EtOwpSM/1zyIJRnV3lrwt4VKawpX0tI
         ESzsF8WnFm/Al5ZYbI0KAu8I8uZdHteHee/ZvQHZAuA0Wz7LTSHisikQio8+VWw+WVWA
         CihA==
X-Gm-Message-State: AOJu0Yxd+fVWbU9JhazmTDXHx7KVdO/12qZLuLYIYGGVkiliSgMzyqTv
	jRC0LYggbOAqgcnHNMlO0jwIbYD0SuoC6ag1yb1Bs1qTANRRuyPvObhp
X-Gm-Gg: AZuq6aINUTZbL96uNF8lvxriuWFnN0Ete2DsbHR3zIKEusSGVtAIbEy9/r0EPHDEtu+
	H6GG99R9i0W8iinZfTL6B9/beKr6FEq7OXak+nj/B8SBP0HKEv4j1gvtLWVs6h/MKbffPcaogPn
	wRkcbZnW5GR/wFLO3QsoDRjV2GrPpQSEHbXgDvwgrknOQtItb20pYMiJLa7T7PDlcKOA/7FZBvQ
	YP0OcvGfa0BRJgGSpzCqwtqVQ/0rte93DUfGH4tpcBUrDcXN0hXEZWAXrB1QQHXDZGpy2mXPh8P
	eohW1vU2dU16+QnRb9a4AWTRyCuRyvfVtRBvDv8UIOVRnAG5iG5/e1y5rY7AaULC0KaadzYgNoe
	ilEIW/S8q44Npq5pCDMeg0yxG4BaBf76Lq/aEkfiFtRG07Oxl8qnCwNdNwVDr4/5E6RMDN6bHAI
	/rXyLXsqA2nGgTReTQMlW+AVaBmg==
X-Received: by 2002:a17:90b:4a07:b0:353:3934:1449 with SMTP id 98e67ed59e1d1-3543b2fa68amr14816121a91.12.1770137190912;
        Tue, 03 Feb 2026 08:46:30 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9008:ba52:f091:7dff:927e:f788])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3548630df97sm106070a91.13.2026.02.03.08.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 08:46:30 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Wed, 04 Feb 2026 00:46:24 +0800
Subject: [PATCH] PCI: rzg3s-host: Fix device node reference leak in
 rzg3s_pcie_host_parse_port()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-rzg3s-v1-1-142bc81c3312@gmail.com>
X-B4-Tracking: v=1; b=H4sIAF8mgmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIwMT3aKqdONi3aRk82Qj82QLg0QLSyWg2oKi1LTMCrA50bG1tQA4zyJ
 XVwAAAA==
X-Change-ID: 20260204-rzg3s-bc7c27c80a89
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770137186; l=1372;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=Gi1htnYpLsbfBZ4uIWrPR1buObmElY1r/sNxGV1Nc04=;
 b=QpftaQ90i7I2mrQt51hu+ZGKUrMhiL5YyUKtGGs6kgS9XmS+vYOGSatMhKV8YPfb6BW2t3g05
 4gTTZVgcPN2B12jL9lxZqbOXsACPvnu4BJu5BJkivg2ydwezA9D89i2
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

In rzg3s_pcie_host_parse_port(), of_get_next_child() returns a device
node with an incremented reference count that must be released with
of_node_put(). The current code fails to call of_node_put() which
causes a reference leak.

Use the __free(device_node) attribute to ensure automatic cleanup when
the variable goes out of scope.

Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 5aa58638903f..2809112e6317 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1142,7 +1142,8 @@ static int rzg3s_pcie_resets_prepare_and_get(struct rzg3s_pcie_host *host)
 
 static int rzg3s_pcie_host_parse_port(struct rzg3s_pcie_host *host)
 {
-	struct device_node *of_port = of_get_next_child(host->dev->of_node, NULL);
+	struct device_node *of_port __free(device_node) =
+		of_get_next_child(host->dev->of_node, NULL);
 	struct rzg3s_pcie_port *port = &host->port;
 	int ret;
 

---
base-commit: 193579fe01389bc21aff0051d13f24e8ea95b47d
change-id: 20260204-rzg3s-bc7c27c80a89

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

