Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B176335675A
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 10:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778582043; cv=none; b=S4Qd3rH7wJzg2Dd2HvhwoR71INuFE54bwYQMAVeK1DDbaCu8iuS7iwlrG57yNS88UWcBjL9MMmiqerSdQRewVBDEvUiCBskQrf25ClCP6NtDkotez2LYHZu04BMITB6rHhiDVAyd2fFo9Q8XtXX9NcntFREyRfVuqpIfxPROjpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778582043; c=relaxed/simple;
	bh=46xjUdMKQocrxJlc5+IRfEvfu9q7FwYQ3DXrDmQIn8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lfaipPHGBIM6N/G46IPqUhuPjIBLyoQn+lz89fuodlP0P6ZVogHDp2ST9vvfMM2m2xzKudJz9YGk0Ox1m9TVDxzEHqTLmvcCqVXXBkgM8tp/D1PnxaxYofhxQy2/HCo0PQ8AqKXHuzsF6KSP8gUW0UGxc36DeKXVj7J3F7LFqxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y99L9Yl8; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y99L9Yl8"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2aaed195901so26047905ad.0
        for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 03:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778582041; x=1779186841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XuGkJpO8zbwPjFwZbzuJaMrl051lxnUzmCTtle9Ojzg=;
        b=Y99L9Yl81dk6FQjAYshJkFcJ/hLaIve+5OiO7Hbca8YGc+RcD+s4fAbA//aMpLZJLv
         QycOA8oApxaMRzmID9HNpWlNILxZbe4q/+JVm03MvtLD3P/+/mzJDgbXhGYhn02em4Fr
         x/ms93+Qb9m+np/kZGNFUW8FSlRtErEZ3S3C0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778582041; x=1779186841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuGkJpO8zbwPjFwZbzuJaMrl051lxnUzmCTtle9Ojzg=;
        b=sKS+TlvdUXa1w8F1trR7Ts1ZFRjm5XZzUxiKsDrpMppakiu79VFxFKA0GxfGK55C1c
         467ZbtXAiyg4yxd5rILHcrRZJyS67W0HuibuhATJ2El7aGUTPKENoRis481UL1JakUlE
         NI5MdOuRCrXxBdXN5nQ92y60rsbLfPB1ak+ibx5HM+hoJ5L/Rm7h3hpR6sq3dmbuXVVH
         OGLANqwAt8293A3vGH3/PZ4BJheqzx4ZeFN59NYggnP+JBt6iguJlatptPl6NnZ6OJic
         CfO72pmUNeM2pjbQiDZ2Dsq0g9hzXRbIPy8f8i0MYy0dKZQA+NcyQ3ThwCHLVcjxxnLR
         PCdQ==
X-Forwarded-Encrypted: i=1; AFNElJ9KGvhfol15xQ+iKwgLAK8Dr8tqAIbkMaDxxQLlv6GxWpV5TizTgPhTt/7/VHYy0xcVWxLRnrBzWjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzV1evapupPM+ByjBIc2wYjrG2q1wryTnh+HvU3tnHb5N7AP7+
	ZMC0lGhI/rJlTA5Sjgt/S1w2V/YcohKjS5vogZBr7sAeQFuAki2Uohc/uaTepfG0xQ==
X-Gm-Gg: Acq92OFhXGdGwOOGZZv5/hpbPEtLwICmEiBI0ZL1n5vCtoHI9rudafRg9zhlDHBCB5v
	oMluHfOnjcppcw+HkmmW6zuAQ+qG3MboU30B9A37Qesd5rJlw6t+jVjtq5XFanUvm6QYv5KxYcX
	zxmYFwgXTyVXZagu6om623OnV8YpsSlHSnDeCsfkFXq84nvJ7V2avnnB6Nz7F2u5klMcMmPOPIE
	q8Yy/+2PvHTROC/4AFUUSzaJcJyrYnMidy80y6GXtMcx+0EZ/01zgiPUFz011viSl6Ka41PIW6M
	8SEC42515qxOupxOR4v1eLpsBpf4z5jx2rdDyRNK6utDjtNYprEqNaSHh242SddGGT0XIdG1/rS
	njhlvp2xrnj2H7hcEHF6zCv4h48kyYQ6UeuGVzs5NAQKX/EB9Zw3CykGJbfeHw4CAeNGViQKmpl
	/UNlBWwotBQTtNUVzci2WEZljuK9XjIsH2Ve5+SLzVdP/mNvJfBazjxcVBZXXcsiExLT/QjV8B3
	mWNvb1scQeVAe9ZfZXRKsY00djTfQ==
X-Received: by 2002:a17:902:f650:b0:2bd:1905:e8b7 with SMTP id d9443c01a7336-2bd1905e9ccmr1997075ad.13.1778582041152;
        Tue, 12 May 2026 03:34:01 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:6606:2bd2:159a:55e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1eafa62sm141597605ad.74.2026.05.12.03.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 03:34:00 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH] PCI: mediatek-gen3: fix incorrectly skipped pwrctrl error message
Date: Tue, 12 May 2026 18:33:45 +0800
Message-ID: <20260512103347.1751080-1-wenst@chromium.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When pwrctrl integration was added, the error message for when
pci_pwrctrl_create_devices() fails was incorrectly put after the error
goto statement, causing it to be skipped.

Move the goto statement after the dev_err_probe() call so that the
error message actually gets printed (or saved if probe is deferred).

Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/all/adjNaKB5KGpl6qIp@stanley.mountain/
Fixes: 1a152e21940a ("PCI: mediatek-gen3: Integrate new pwrctrl API")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 6f0ae946d501..ef64778bbf8b 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -1221,8 +1221,8 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 
 	err = pci_pwrctrl_create_devices(pcie->dev);
 	if (err) {
-		goto err_tear_down_irq;
 		dev_err_probe(dev, err, "failed to create pwrctrl devices\n");
+		goto err_tear_down_irq;
 	}
 
 	err = mtk_pcie_setup(pcie);
-- 
2.54.0.563.g4f69b47b94-goog

