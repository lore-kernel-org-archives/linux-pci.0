Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBE237FF61
	for <linux-pci@vger.kernel.org>; Wed,  4 Mar 2026 06:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772605610; cv=none; b=ncVWYpLoE96HEbjOfQf4UH7egOfZaJ0/9LsFrspOclq2k9BW/XKA34w/YlnKHJx8MG2V+PJ/DgGESWniYplIm2P01/IXuFewBXYepQlkmHF9oxs5EcutRo+PnvdCkMtOJofFzQbnBZ/fB7WpvdIvXdTRGTOB13Fl7V0rruGQoqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772605610; c=relaxed/simple;
	bh=h+mTLN6n6mBPr7PqYqmQSCCs2jhafXeB0NRdyOd/a60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2vaqy8mNBkMZkKYjlorIJzncLb8MDSbKvipvXIB8EaonJTq+M/mxz/ONnIgx5475odWAr7FwvP60T23b6Rg+ZHiCxcvUQsknG0JJ7YSPyY3mrOhlG0l89vY3uImOg/KpfakQxWbrv3ZOlU5RECVERPzmKhcHLuWejIdKhNi4ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DF3PXUcm; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DF3PXUcm"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-827270d50d4so6875225b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 03 Mar 2026 22:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772605608; x=1773210408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNQTswAIlkxtACM2d1rPkaE1OkOxjlH5iieRYDqA/Dk=;
        b=DF3PXUcmwq1QXhhXy6OADy9cp8wt2DPYOeTzubiRlQWtQ+uQotZQEqOqPIC6GuEd1b
         aKoNV8rxmW4/zSXS9mHjItZEQhUfHvVNeYlbzmeFR8Zt8fBqvtBSyzIDf9zpriyRCwmQ
         6fEYLL0Pslpyr80rRtA5P2zlW6RgbiCT6bFJaiMtKVKwIylWm87L3llLHWRm2PcvAZwT
         RxbsgHZa3ga8NyhTAS70ByN+rGn1FgY1M4dtabTc/1AivRqE6DIvmk4Yb5+umtY1lBHc
         2Uw2VVF/JNVA3n43P95xlN26J3JXMr3hriomPAC7bZke2CuCO2FcCCtt+vfbAVn2vyLt
         s0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772605608; x=1773210408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UNQTswAIlkxtACM2d1rPkaE1OkOxjlH5iieRYDqA/Dk=;
        b=Qpa0FpR3l3U+52zCheAMr1n/JWr4GWSQw0k5wuiXaG2FfO8N/Sw+T1RCPSPXYBD74v
         fENY4L8wZBEsiZj31y+sGtxUlzwfvyZkRsI/pCquGrD6+jMil09If/xP+wuK/s4BuOyu
         dDIZ81WEA46FoXyySB2QlIPzdcdAgVXFKBEvRhblwnxQ8AMlCM/+4ejlPEbswRV69+Dc
         XmJcOr0qWavUGNRoLHZ0qqdsX9CsBRuRm1WbPK83+Cr058yVg3MFJa9+yFD6/ck1A5Xn
         TKXhWtvDrgvJUgWM3zb/r7MeEJQG8LoAJQr+T+Z7kmq4b1C3aWSYJJqwvxHXrFif1whs
         hUJw==
X-Gm-Message-State: AOJu0YwhfJv8cqViRVFopKc61GtAZlZfft57eNKS46aPq8cowVYcnTF2
	U7ZiHCtTw84ymiZkCakBQUKeOn4rmMfXc9bRLLkuFy2egWo/kqinQt9N
X-Gm-Gg: ATEYQzwp/+fhsG9TdjHXceMcnsZYFZB8dXnFczrKN7gB2LEm8yvJHDM53IB5EZusAMh
	eAhMReLrDEarRb+mP+j6VNW4lHGd/FGrHPPo53FFfFQHUct0VdCB9m1/qBKdmI8z9LgkWdy+5Bn
	ZtjCtRyur3fWerzH5P+kesx4EMlS2ESinTj6Irgi6KxXctJYYXa1Bf2AhB0n/d8vksdiWmW34o2
	mkGaufdXZWymUjAiVtyZHIUsgjEK9MWwiqzWfShQ907NEF4GCehx4lCqg+pAbsoB8sCMfojZR20
	CximUH3mFgpMZtdTtZ9YaEsdPz15ko5vZIEEIS6p+gAXS0M4xQnW2xiSeJ0Mx43S8w5U0aDIvk6
	8JV+1oo+XshpCueqbExERD943dwLjOkAnUyP2U4mBPNyelLqdMOakzvDyE4G5ydIENg7s05NvF3
	vT1BS6L60a86imYAWnm1u6JtibJF6op2kIAxVNhAlZYjMMIG/k7Dnzkw==
X-Received: by 2002:a05:6a00:340a:b0:81c:4a92:25a2 with SMTP id d2e1a72fcca58-82972c8324dmr849629b3a.46.1772605607659;
        Tue, 03 Mar 2026 22:26:47 -0800 (PST)
Received: from ZC-202510311500 ([61.185.217.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d544ffsm17933355b3a.12.2026.03.03.22.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 22:26:47 -0800 (PST)
From: hechushiguitu666@gmail.com
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"haoyu.lu" <hechushiguitu666@gmail.com>
Subject: [PATCH v2] PCI: probe: Use helper macros and constants
Date: Wed,  4 Mar 2026 14:26:38 +0800
Message-ID: <20260304062638.1782-1-hechushiguitu666@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <20260303073655.2047-1-hechushiguitu666@gmail.com>
References: <20260303073655.2047-1-hechushiguitu666@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "haoyu.lu" <hechushiguitu666@gmail.com>

Replace direct resource array access with the pci_resource_n() helper
macro and use MSEC_PER_SEC instead of the bare number 1000.

Changes in v2:
- Use pci_resource_n() for resource array access (Bjorn)
- Use MSEC_PER_SEC (Bjorn)

Signed-off-by: haoyu.lu <hechushiguitu666@gmail.com>
---
 drivers/pci/probe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bccc7a4bdd79..d5b27d03355c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -119,7 +119,7 @@ static u64 pci_size(u64 base, u64 maxbase, u64 mask)
 	 * Get the lowest of them to find the decode size, and from that
 	 * the extent.
 	 */
-	size = size & ~(size-1);
+	size = size & ~(size - 1);
 
 	/*
 	 * base == maxbase can be valid only if the BAR has already been
@@ -594,7 +594,7 @@ void pci_read_bridge_bases(struct pci_bus *child)
 
 	pci_bus_remove_resources(child);
 	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++)
-		child->resource[i] = &dev->resource[PCI_BRIDGE_RESOURCES+i];
+		child->resource[i] = pci_resource_n(dev, PCI_BRIDGE_RESOURCES + i);
 
 	pci_read_bridge_io(child->self,
 			   child->resource[PCI_BUS_BRIDGE_IO_WINDOW], false);
@@ -2600,7 +2600,7 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
 	struct pci_dev *dev;
 	u32 l;
 
-	if (!pci_bus_read_dev_vendor_id(bus, devfn, &l, 60*1000))
+	if (!pci_bus_read_dev_vendor_id(bus, devfn, &l, 60 * MSEC_PER_SEC))
 		return NULL;
 
 	dev = pci_alloc_dev(bus);
-- 
2.53.0.windows.1

