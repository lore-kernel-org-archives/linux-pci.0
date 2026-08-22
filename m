Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9237B3CAE7F
	for <linux-pci@vger.kernel.org>; Sat, 22 Aug 2026 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787411289; cv=none; b=iDpTvdfteGC3hzMC3/nx8oWS+YXhfBcfW8iyTKAtyURIqG5B7iwg0HnVcZho7QNYODhOrSljaVsol+9OcpyicjRHdS4orINRKYSatA47Q2PjXUkIVvGXY4vYj0w38xqqs5Hx4uQ7qZI+rBmQLvgkz/VT+f52IHaPACWlcrs19Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787411289; c=relaxed/simple;
	bh=iqwaq39/Zpa0iH6/a6W3yQV4x79xW81LRfZe/TmtbhQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VcIK/GY2P98faYrKHwFQkjJiV55kMJcKnbKd/xR6pq8FZcC3zEgkwexcaq5RUnBJglJExYBy4wbN1SPG53oyUiRfmARqxT6JTAYOR+xMK8bwF97Ver71ivxTyFzYdp+nP3U0Fen4M4wsx23QPsWR9UrTa9hxqD7CJCHWU4LcIeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJPwKErX; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJPwKErX"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso1404892a12.0
        for <linux-pci@vger.kernel.org>; Sat, 22 Aug 2026 08:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787411288; x=1788016088; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3WRamQXpDUK+MxHYzTl3WtRIEBUdJqjnF0kXvecvEq4=;
        b=QJPwKErXINwroUyaBXwl7z+C7w4M53TYAvgwn2DaJp6gIJWHI+iU5A9PKm+/N1kX3q
         rdtAzEUb4LUd82+2yup3iqXdDsInAuS9e+d9EP5v+Imefb5Zy8ODllPyenWkmCDIgkh7
         4l8bSDwl/aziD+YFS8Zlb7oOMuPHniVFexo1XFsNP3iPhW/AJbdnRRppRKi7m+DVxD7h
         d7v7XMhR/W4fMQ3/gj3BFC89+eU6WM4TayhOPnh3WIA+VKqfj7WGJLTBxd+qDYEEzFHH
         xeGenPtNVEE7g3iXPu88tblzUdBMBzru4YYj+0xyHqaUiZZqzxc9uqdFZQbfrxuXH/py
         5QWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787411288; x=1788016088;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3WRamQXpDUK+MxHYzTl3WtRIEBUdJqjnF0kXvecvEq4=;
        b=j6ccUl1NKJeLYVCkXplFRe+jOjzgR/qbxUk4B0eJBxLZpkiVdjrmxrcEElceru0r8G
         hDwcmj8o/IJDNRIZVT5IgrnfDrOTdzF4871GKg9YFw3e7PVPulYDgUp/G2fvfHDr4CnW
         tuW72dlalMx03yRVcy5uWKCPyZ3gqLOLsFrb9yy0B26KrhAuQZFYIzKmefMh+UkqFKF2
         PobVMx51HUJ5LTmZRvRRQLCUL7VPULmSD4GEbJJDIPMKEBSOIJ0z7vj6L3twDuh8dBl3
         tA2mbb1LD1YF1qyeiFZnrqq//1cmVTcvZ6IfOXYpnMMu5BfsQkdrQplJRO3BZnHQUYt3
         wtdw==
X-Forwarded-Encrypted: i=1; AHgh+Rpq3BEWOWK/NHBTs/nWafSk/xs0HnCW1HzJCyKrlZyH05hzo3J9IzWNYS+dnjjd/CSDXfyXvbhy5lQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mVlEfwHoEdwsy4hhnO5xB5CG2C+Jvv7wlaalfruYSlfRjY7ugP
	MMN+8MW6F9ysBMBBXu0lxdrV559UbWNt7ImMdOO/KcdmmAk/O0smAqEg
X-Gm-Gg: AR+sD11xQy+QHv4LIMfGBR8PbM9iymwsbwNOlLvg78sSKhASe0J/Vng+BnrYxqjMPm3
	M0Hnddc2JEM0/4mmCG2uYu1I2f7w4KcdG4MgEiuFpWdS9YlpRmqM8MeB+b6gtE2lc142rUlYoec
	g++g/KpZHKKeNOvITDrNuK8PPC2ZDKihonYSSxzGxzUGggbx2TFheutJYGKI2D1PbtKwoDryXtW
	TX6g3Nobus67OZFXznnqfZjbHleqBMsqK5pgtaSkxzcCgcgiJyt689TkneFajxVHBP5W9L/nl4Y
	yU/xsAwrlNJOO1ny+hPm8Z3fwA+ycrjUMHWV1KU4hyTgi9gbFChIYOX/XR77zNdJaKEGYKP0rgh
	Bw0r6EweRBqLHmsRitt359o/350AzJoAZbPfitiCx3f/cBEYjAMV1tc+AbxC/8hXKtMp0AeshiQ
	2eolN0Xy/E1vdK3ow43EbWIIFVj6qAdLJTTO3N8YoEmQvOdCvYS5HskLKJznyxAR5jMwkCalrVf
	/mjcHrj/OxuzFu0H8ykSUDYFivuHqsDlakIbvpqtLosMH6rQomKmiRcRZf+aQ==
X-Received: by 2002:aa7:88c4:0:b0:82f:2b0:2809 with SMTP id d2e1a72fcca58-8520b942d1fmr10233534b3a.1.1787411287768;
        Sat, 22 Aug 2026 08:08:07 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.166.246.74])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f03b1ebsm628242b3a.30.2026.08.22.08.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 08:08:07 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sat, 22 Aug 2026 23:07:47 +0800
Subject: [PATCH 1/3] PCI: dra7xx: Fix clock enable leak on probe failure
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-dra7xx-v1-1-23e204d5548b@gmail.com>
References: <20260822-dra7xx-v1-0-23e204d5548b@gmail.com>
In-Reply-To: <20260822-dra7xx-v1-0-23e204d5548b@gmail.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sekhar Nori <nsekhar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787411275; l=1209;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=iqwaq39/Zpa0iH6/a6W3yQV4x79xW81LRfZe/TmtbhQ=;
 b=JQwJxBp9JSiXLkuvgP9DsAqIhnNVN95oebkqBf5QP+o8m9TooJuuD3/GmQ47Qgmh0RJ1HbYN/
 XhZFZF9+3GCASDzQMKX+JxGYZMzSbVHilzqclpMzDdh1CfPZODqjapy
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

dra7xx_pcie_probe() enables the optional clock but never disables it
when probing fails afterwards.

Switch to devm_clk_get_optional_enabled(), which disables the clock
automatically on failure.

Fixes: 5af9405397bf ("PCI: dra7xx: Get an optional clock")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 6ae5b27e27b3..d43253f7dea6 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -732,15 +732,11 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	if (!link)
 		return -ENOMEM;
 
-	dra7xx->clk = devm_clk_get_optional(dev, NULL);
+	dra7xx->clk = devm_clk_get_optional_enabled(dev, NULL);
 	if (IS_ERR(dra7xx->clk))
 		return dev_err_probe(dev, PTR_ERR(dra7xx->clk),
 				     "clock request failed");
 
-	ret = clk_prepare_enable(dra7xx->clk);
-	if (ret)
-		return ret;
-
 	for (i = 0; i < phy_count; i++) {
 		snprintf(name, sizeof(name), "pcie-phy%d", i);
 		phy[i] = devm_phy_get(dev, name);

-- 
2.43.0

