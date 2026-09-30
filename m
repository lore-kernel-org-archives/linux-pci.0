Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB193EDE4D
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 09:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790761839; cv=none; b=ZsOnNj2wR4bgqrb+Xx44hFv2fuYNzoj42A8Dh5W7zmJEncT2w+kZ/VG6kFpSU0H5QeyHjxN54toHV2kKWZBchRies32e7Nnl07TOHFUkul/G0xwpJl2iqjeE5mQuXvQuBqwCoRBddUkPvptbUJO9z0kOyCejT9i6y6VLE9OriBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790761839; c=relaxed/simple;
	bh=uG4KbnlMHq1Uj4vZAB3VXab51g1tewuUnxWaMdpS2PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IzA5Rr4yUyF3KyqrpyeeU791VDSKJoqY8GHpv+L5mHDzr805KcgMkOwIDMOlohkcjwGfIUxdKPHCgk8cH5HU8nDtC+0RxnLC5hJ+LIzAoLQTws5zLGHzYnCrafaOMK6eA0Xna5Ifwmwr1Y3K7+XPw4SgqNqsgKxnvNZng2HI6OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONgI/01j; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONgI/01j"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-340f56c44b0so2086119eec.1
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 02:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790761834; x=1791366634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LLtGDvHzD6CrNoA94RNqXZ25K72u4Lfc7xmaaJ1VbZc=;
        b=ONgI/01jGmTvqgUyL5VdmT/0QJCVlKeM23FvXOut2H/nQcu84D80e41G+cY4Jc0QVG
         nFkntICfo4BY0VWn1n+iU/ud0VhTYL9MYcavVelxFDhxt/MXOog6o9/C2YfdgVCex6ud
         96gmm6xmV9xXoBuBi5wm+ZKyGOnJdikLj4ai3V2zUSwNSXUX/+Kd0wUr4QY/rHNWFRIT
         SoPFMFkhuBIoF2+OnEo7p3cx8yDu2Tcj+47bU4qBj84kKoG7yA5qUIpGGbj2XjW4JgX9
         gnPhIe1yr010wBredzE/YK/7uzNblJyvZv8qrg21bl2BOPNZCj+covI8LRok29p24hPE
         +g8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790761834; x=1791366634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LLtGDvHzD6CrNoA94RNqXZ25K72u4Lfc7xmaaJ1VbZc=;
        b=gt29iZwVFFXYYwTtlVsAxPzttpifgSRMbQrH2MBvkmnhSkPy9P55xCnwEasvBiD1Rc
         1rgH6afECaUWJHVNMOaf6FrPrqvGrbUH+XDdWzAdkiyOn3mskNStKA/TxvFApNgImeCk
         7dZJpy0j29qM6+4WGNDYXfAw7Q4+edLe9VqczBjw1L3NFkjpPKv4miVjvK8ple5N/o1T
         RhEEv4QVlVi3Ge++McSCRoOC0h0FbV3YbPANYGtd8CCb5YjZ+2tGojwcrR+AzvDZ31Kx
         K8ps5gTj6Jt7fgVfvzP40ED/++qdYx5KdLm0DwN5v8F5RMb81A4tuG+Xj1FoizAZuSXN
         duog==
X-Gm-Message-State: AFq9FYIhhXBnKyJy+2BHXfQOn3D48dV89GPVNsRauGJVFx6xuNo4aBc+
	NDGcmtGrsASsO82Qu4pqqy7+1NpAnArDnIo89BY9Q0/0QOTlBfnuk0RN
X-Gm-Gg: AYBFou07kiXSfWuw/ymm35pcGo1MKpybYCpgbz0u3UkYjEp5eSB3qvhr0aWM7Ba1gwk
	Hd21pw/v2qUmaHfxJEiBYWavn6rZiRGUA30Z3HR8/R7+KmWVKsUFP1BGBw9NOfwqWidOzIofPx8
	2LTAXVkiP+SRMS6StxvcEHuMwhq6enGg0doQPwBDXhTi2vd1Gns8lieZIwc8OEIaTz9vm4k9Pzt
	cG3X0+qWP89peH6q12zNO/mgDsA45mPMGGEgWfHfVsNseKoTCVlHuGOaQgZ7x3cfzZKpjSTZK+5
	CEZ5ORdeCM3fUUwfMh7BwaGtf+hZrY8cBfwEhnrD5yFhGL2qD3qmSMr8P3IdXaE6nOfJMOOn4ex
	6VGRE4kGvfdr1Da00BBW0srW7o3bzYFnq5OP+MRZcPZMfP6inuWBjHgi6Khs3NFkGKoXjxp8npM
	lBEoVDxuyQZCzcluP/Z8HJNQfgcBbeIdPR3qCZJ3X+paAWmFqZfoEhA5QOsulfTrVqE0zZ3CBHk
	3tdIdR95YlYBpVN0EyN
X-Received: by 2002:a05:7300:fa07:b0:33c:3134:f45 with SMTP id 5a478bee46e88-34cd907665bmr1266990eec.5.1790761833122;
        Wed, 30 Sep 2026 02:50:33 -0700 (PDT)
Received: from localhost.localdomain ([103.178.205.97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf50553f8sm4934658eec.14.2026.09.30.02.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 02:50:32 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C3=85=E2=80=9Eski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH] PCI: mediatek: Fix integer truncation in fls() for resource size
Date: Wed, 30 Sep 2026 09:49:12 +0000
Message-ID: <20260930094912.3069-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

resource_size() returns a resource_size_t, which is 64-bit on 64-bit
architectures or 32-bit systems with LPAE/PAE enabled. Passing this
directly to fls(), which accepts an unsigned int, implicitly truncates
the upper 32 bits.

If a memory resource window of 4 GiB or larger is passed, the size
truncates to 0, resulting in invalid AHB-to-PCIe translation window
sizes.

Fix this by using fls64() to safely handle 64-bit resource sizes.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/pci/controller/pcie-mediatek.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index a60d1ae076f8..61591d0176bc 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
@@ -754,7 +755,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 
 	/* Set AHB to PCIe translation windows */
 	val = lower_32_bits(mem->start) |
-	      AHB2PCIE_SIZE(fls(resource_size(mem)));
+	      AHB2PCIE_SIZE(fls64(resource_size(mem)));
 	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
 
 	val = upper_32_bits(mem->start);
@@ -830,7 +831,7 @@ static int mtk_pcie_startup_port_en7528(struct mtk_pcie_port *port)
 
 	/* Set AHB to PCIe translation windows */
 	val = lower_32_bits(mem->start) |
-	      AHB2PCIE_SIZE(fls(resource_size(mem)));
+	      AHB2PCIE_SIZE(fls64(resource_size(mem)));
 	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
 
 	val = upper_32_bits(mem->start);
-- 
2.55.0

