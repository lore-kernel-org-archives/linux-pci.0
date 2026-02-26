Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94015315D21
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 10:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772100645; cv=none; b=NXlfPfL2jA+3q9vIUrfwMcNLHRdzWf3bLAC3w0HqFQwf/J/bWkpVefudfrxaPPIZTEj/LXcMsdexFflCHmLraSTzs/68BmJ7y7wFmqFVCo7zwaGynasOjRcxQ5dZeRfjsH2qyzkv2L8A5IQylzLmnTN/UMmm8pER1VLNyvbLTXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772100645; c=relaxed/simple;
	bh=3za+9Wscjj9X4753DaqenO/9w5i0rU6kCn2wHFUYg4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZVOaTR6jVdfQ+NxaL35aaAWdoKltU9oEf0fbRDcREk4YTtL/StWIXhB1hYds3Wp1Nx6YXkH3AGzVflAhCPjOgGHzY08edOT3bLA+64qMod9BwqS7eD/vezAl9wnKXdHXQf6NZb/gGRE6qGDwO6Ig0R2PbqeZQCVixNswjBccwDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmEhoDZO; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmEhoDZO"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8230c33f477so361225b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 02:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772100644; x=1772705444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gkELXJ9KhXHMT5a1efTvXnueLkeN4tzHP27QeEGUl9c=;
        b=hmEhoDZO3B30JDZCR05x123b1VebLZlTGwjEulDGhHjh7oFDa6ehvqFeNFz6sq1odW
         3YUMU4tbMRVIBEWDKNJ6LFLmC7f/yb89e01aoqVLgfHbbDHt2X428cjOWQu9ZehrnSYv
         52PWzfwj5MF1xRkNS6JgaQrc9bjsI3FQ/2+YJwKXA6ls+zV202oXSzDnSjuGZThOetft
         HxbjBBQIldhTEqkCkRN3FAoWXl/dbUGgp0MPeb7dfSJ3woF8xAF66j+yPJQ2k57yk9KE
         yLypCX3QqdH2Qp1udVbEikqimbWf9+qwOU01aEkoC3HSzS66Bg26nwGZNT8ZtvD5+PGd
         0Bqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772100644; x=1772705444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkELXJ9KhXHMT5a1efTvXnueLkeN4tzHP27QeEGUl9c=;
        b=r/d2pwt+bbbEV34px9MlVZeaEaeOVtx2DGZWvQp4QchuZts4xb04uFoKYpVpSvw31P
         Twl25RERFdI3oAahnBhRG/q5YObtrCO8iB8RlfLrVLBHtKPhDYN5wV+U1uPq5uPkw4Hk
         QaUfJQ23iFcQchffTpsX4SxaxbxUw1vZB2m+D0LVEw3CuOUYeHkQGKMun3+77PgKZ7wS
         Iicttn9treWSzYcacPFPKEMN5c0TjrSBFSVO1arKYbXAxy0hcNvmnE6Iy7CMP6L6LDk3
         E10J+oY/GTuE7L/SwTemFI+MCfhK9A/IiKQUqUM+q7PRwG5VXUZ2PVNFm1zTPXXhXu9p
         w3SA==
X-Forwarded-Encrypted: i=1; AJvYcCV/chP12n39pVSWsYRLa6dZLRaIjJX7cFi09sEFX7Ha4l/sYiUWoJBfSarqE8nT+0XQn4ghXPTaaaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT+uC02zXoxtZDHkYRSQPTkCdtACG4FapPrMjmWVNR4SoTYF75
	hgG4B73PsmFQ6171sSd+GJ5IqDwyUxOw5AX9wZhMqxE0ghqkZG7hDS/O
X-Gm-Gg: ATEYQzzfCfuIEGIX1z6arupGHTOb6859EDH3keqU7bYfejkpcRZchtk80Y1o6Sko+SY
	CaCQlmM+fFW2BaDzaVlqoKlX/HjMcMdTkusJTb0NpXfmVExC81vnlULVasbjBgjqDJN09wdTwx5
	+OAddjAi7duDLJ42nnK3f+EsTGwaqbG2fiOy62w/gpeevNv9bYNOhnItXP2RvWauABsVeBSBXOx
	jSPdEvlp0adTcJ+8IPVrgXqVQldxxwgxEqS5IWcbhyWlDw5lD0IEi3HRfoCocDmsIGQ7wbRQhje
	P7b8nuty/UeYjmlSPWXeLTuy2U3a9qX51lHbzfkrS1VuHwJECU06JnmpDeVzHclUpUFrJR/ZeIr
	9vYl6mmsCMv5kxCM6feRLEgVxWujAXf3/uicRhxtPjPpBDujtozQ+Xl17KFeSNq+Xw+6Vea9BQ3
	pBgZ65FKDbL6RiWYtsHag=
X-Received: by 2002:a05:6a00:748d:b0:81f:4943:b853 with SMTP id d2e1a72fcca58-826daa0cdc6mr13672752b3a.38.1772100643876;
        Thu, 26 Feb 2026 02:10:43 -0800 (PST)
Received: from rockpi-5b ([45.112.0.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739dabd43sm2252704b3a.25.2026.02.26.02.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 02:10:43 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Niklas Cassel <cassel@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Hans Zhang <18255117159@163.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Grimmauld <grimmauld@grimmauld.de>
Subject: [PATCH v3] PCI: dw-rockchip: Enable async probe by default
Date: Thu, 26 Feb 2026 15:40:23 +0530
Message-ID: <20260226101032.1042-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rockchip DWC PCIe driver currently performs synchronous link training for
combo PHYs (PCIe 3.0/2.0 and SATA 3.0) during boot. This process waits for
the link to be fully established, adding several milliseconds to the boot
sequence. To optimize boot time, this change enables asynchronous probing,
allowing link establishment to proceed in the background while the kernel
continues probing other devices.

Cc: Grimmauld <grimmauld@grimmauld.de>
Cc: Niklas Cassel <cassel@kernel.org>
Tested-by: Grimmauld <grimmauld@grimmauld.de>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3: update the commit message to describe the changs.
    added tested by Grimmauld.
    https://lore.kernel.org/all/20240809073610.2517-1-linux.amoon@gmail.com/
v2: update the commit message to describe the changs.
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 5b17da63151d5..c31e0e9848327 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -746,6 +746,7 @@ static struct platform_driver rockchip_pcie_driver = {
 		.name	= "rockchip-dw-pcie",
 		.of_match_table = rockchip_pcie_of_match,
 		.suppress_bind_attrs = true,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = rockchip_pcie_probe,
 };

base-commit: f4d0ec0aa20d49f09dc01d82894ce80d72de0560
-- 
2.50.1

