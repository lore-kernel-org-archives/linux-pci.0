Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFE83ED3A4
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288314; cv=none; b=dG5nuIB7ZXUC8bmsLPC7qwFV+/b6liAumTAi+SiSxjkS4ZiFzZ4c9RET/Spvk3qqq2s9yC+Uzi2Kam59ol0kpZq5t/2C152tGCDhRG2M1KyzEuij1cEJjpakexNBkSS49hJPDrSVPf6B1bBo0GCs4z9I7A+1ztUEMU8ldnDYG4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288314; c=relaxed/simple;
	bh=LQbm15rAKPz7MFzVtKlTkrfu5UxXb3siz4fc6NJeMKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qx8jOt6fk09SoMEDnvWVglL0PfOfNnhrKb/OWddruNINvLcIHV8JfIIviFIZxpU8qISL40nuQM3PItsWxfHxtLYsD8ZUQAihr1Q3ibeDiLpaPsfW7OVNK4Tko29jbDiDjy/e8ok/orfMLvo0+uaMMooDiqOfj5nEN8hJqwqK6lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9Z48owy; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9Z48owy"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so2287795a12.0
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 07:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779288312; x=1779893112; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ks/pYuySM/VySSLZBKDsm+9ZYqarxYGQ3/xDReTI44=;
        b=K9Z48owyfYODDYJmis4V9B2k8DR8qJA5WhyuTWzltjseDojOeZImaKAJsyYO5tSqge
         QuolCTB8+IBzkYrGufLZRK6zRV/aWvSv7AKTsoYe4fmzsOYvIZJfqcUHLTJ/9v8Kqevb
         rAd/8hscf8IhS5z5WhoNc0yOhu3ZiUsSxcaJERPLnrE8BEcjhZ8bHw+dT8PxhcTim3gh
         k8LnLwkVwn6jDPTvxpbr0h6j+hNQQ42RLGoCDR0mBONVVV/H0UEHGvcJ3yzYRRwu2WFO
         XXb47fuGZun534OKGMEpgxLfujnIwbYSJPCcb7zu4jjkE1dLYfvyGKEYJs9AidigaGJT
         14wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779288312; x=1779893112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ks/pYuySM/VySSLZBKDsm+9ZYqarxYGQ3/xDReTI44=;
        b=krMz6QIQv/I3ZnSVwBOamb4g3vHAXk51tvPuTw5/xCzQShqktmk2Cc2f5MbapRrol7
         KLAROZ5BOuMwu7tLrqBpDq6NvfFmPpnmANWYyI/scuDu56pI+5XpdewtzqsgKOLh4+rZ
         /0tg3g0ZNr5LIMxuel+Io2iO0cVfkdsnvlfCnj7MWoPEK2ouma4ZJYpP3a5ltezLSiID
         Wdt3PVqNH+0N9vrv5aLb07tkZ3drj7hcnsvvJFCZvhqt8thMaqknFRTwHlHv9iFMGC/b
         QkEVlRpn/aOlGhQ6umuwky0o8Mshg2YCfbaAh44UJGr1Ze5FAdNdP6smWhf7iZ9Iq0YB
         tVig==
X-Gm-Message-State: AOJu0Ywa27vjEUMjYgGpirjBXXOyGSTIny5ch9WJjNvP1Te8dPMAKKJx
	ORh7+G7BD/44ssr0KzoPfU6Q0oumkbZmsUkW4gkBi9ABlabdI/wS2d69
X-Gm-Gg: Acq92OHL1uic2ldS1XvmwH3qxNWOITtN03PiGqzP4c5mrjAS8+X9h/69HfBl2FoV9Qd
	j+bLBhOYCugZOKEcrX5coLNqx/kJqJE0BTDXy64Ts7tTaZd4TIlgIHJozgVxUeliXWMwfN5+ozI
	u9FtCiSXCFVMQVjflu2Uthd4qsTpmGRQF9Jy9FQ1uPYxpkTH1us9/TX2Yu8vt9EPItk4ksWlNeO
	Z77LK+J9pzAiEqdOfBAPceqmzOMadEEI85YjKvu4fcwQy/2eO7gs3DN5c2kJKbxT0esSBWfcQjK
	Z5/ZScBF9jVBY+pqj3dR7CQnEDQyXjWuguV3AQ6z4U4XKzl+9h0JtRd5a1Q0Qn4KklpAGsk1657
	YkeIw8DQmwNh52OCEu3eQE226n9EZCMleSVj7avFk3JcY2O7aefTsgflmupCuRAvrmhhpxC++Gk
	oLsUvq07km5OClpOcdUbaIY4T2jERlt0MFtkLBM9X/wxCA9IFgYe9P9KuXS1H71AobykEYZhBCi
	R25WzMXewJGX6uu24NVeAosFUUh
X-Received: by 2002:a05:6a20:7d9d:b0:3aa:f9cb:d438 with SMTP id adf61e73a8af0-3b22e73d2dfmr26321921637.21.1779288311345;
        Wed, 20 May 2026 07:45:11 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.166.246.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb114a70sm25363425a12.22.2026.05.20.07.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:45:11 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Wed, 20 May 2026 22:45:04 +0800
Subject: [PATCH v2] PCI: eswin: Fix resource leak on dw_pcie_host_init()
 failure
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-eswin-v2-1-a221438a6317@gmail.com>
X-B4-Tracking: v=1; b=H4sIAO/IDWoC/0WMQQ6CMBAAv0L2bA3btGA9+Q/jYakLrBFKWkQTw
 t8FNfE4yczMkDgKJzhmM0SeJEnoV9C7DHxLfcNKriuDznWRW3SK01N65VxJh5ow18bC6g6Ra3l
 9PufLl9OjurEft3gz6hg6NbaR6f8zWPx+EypUZJzDUtvKejo1Hcl970MHy/IGyVVDB6YAAAA=
X-Change-ID: 20260519-eswin-997a8fa10245
To: Senchuan Zhang <zhangsenchuan@eswincomputing.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Yu Ning <ningyu@eswincomputing.com>, 
 Yanghui Ou <ouyanghui@eswincomputing.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779288307; l=2320;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=LQbm15rAKPz7MFzVtKlTkrfu5UxXb3siz4fc6NJeMKw=;
 b=G+RkdFqcfTqcBFzkTQhVlviALLkW5j91oDSyOVkEcniSwp5sA7l+GmlLKRPddRKQFNitxEE2F
 Q2eTVm6CNt1CBBo3us49NdOYq4zE8A6T6HvmrXjpt/axkSqJxOLPjXE
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

When dw_pcie_host_init() fails, the code jumps to err_init which
only calls pm_runtime_put() but skips the cleanup of port resources
allocated by eswin_pcie_parse_ports().

Additionally, the incorrect port cleanup code in
eswin_pcie_host_init() error path is removed since port resources
should be released in probe's error handler, not in host_init.

Fixes: b593c26d081a ("PCI: eswin: Add ESWIN PCIe Root Complex driver")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
   Changes in v2:
   - Fix Mani's comment.
   - Remove incorrect port cleanup code in eswin_pcie_host_init() error path.
   - Link to v1: https://lore.kernel.org/lkml/20260416-eswin-v1-1-a4991725b5ca@gmail.com/
---
 drivers/pci/controller/dwc/pcie-eswin.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-eswin.c b/drivers/pci/controller/dwc/pcie-eswin.c
index ce8d64f8a395..7a02ab91a190 100644
--- a/drivers/pci/controller/dwc/pcie-eswin.c
+++ b/drivers/pci/controller/dwc/pcie-eswin.c
@@ -182,7 +182,7 @@ static int eswin_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct eswin_pcie *pcie = to_eswin_pcie(pci);
-	struct eswin_pcie_port *port, *tmp;
+	struct eswin_pcie_port *port;
 	u32 val;
 	int ret;
 
@@ -252,10 +252,6 @@ static int eswin_pcie_host_init(struct dw_pcie_rp *pp)
 	reset_control_bulk_assert(ESWIN_NUM_RSTS, pcie->resets);
 err_deassert:
 	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
-	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
-		reset_control_put(port->perst);
-		list_del(&port->list);
-	}
 
 	return ret;
 }
@@ -347,18 +343,17 @@ static int eswin_pcie_probe(struct platform_device *pdev)
 	ret = dw_pcie_host_init(&pci->pp);
 	if (ret) {
 		dev_err(dev, "Failed to init host\n");
-		goto err_init;
+		goto err_pm_runtime_put;
 	}
 
 	return 0;
 
 err_pm_runtime_put:
+	pm_runtime_put(dev);
 	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
 		reset_control_put(port->perst);
 		list_del(&port->list);
 	}
-err_init:
-	pm_runtime_put(dev);
 
 	return ret;
 }

---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260519-eswin-997a8fa10245

Best regards,
--  
Felix Gu <ustc.gu@gmail.com>

