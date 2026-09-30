Received: from mail-dl2-f26.google.com (mail-dl2-f26.google.com [74.125.229.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B049B4A2A45
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 11:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790768587; cv=none; b=KFJI9TzprSlb56iv+tQnjqptGzz1Iwc669LqzM0z98SpCeT5137hLAjYYn/3cEikiXqjy4fWlXX8ju7SVQyhW+YkUKlPa+w9XwsKNaxO/z77R5oB83wVmyEkvnugXVsGx5gH1b6jzChqYWYQDlwuT4kf8zRiaZ0Pk5jBHVsrxnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790768587; c=relaxed/simple;
	bh=9657krFh9AC6SPymVYaEyQddFx1gc9h9zcaZMHJ79nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RrpZW3tNxYFy7dgzs6cV4dk9/EOOkDE01CgyfPmbEFHmxfN8dvr6VtJDgNxLmXKUXrGEuPWv2OUYVFHUgzcJN8ES4D06vKzCWIe7bjdE+s4KpMPoj0B9EBvvy5/0Ne0fCRGqLYIy5QCskRwzrJPGn0oU0Cog3lICjl0GEtovf8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMOH2XOd; arc=none smtp.client-ip=74.125.229.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMOH2XOd"
Received: by mail-dl2-f26.google.com with SMTP id a92af1059eb24-144f47a9b57so4742312c88.2
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 04:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790768584; x=1791373384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8c0BJ0D8z5gH8AMDVEzCJUaQjDllcdyPshnOBMw13dA=;
        b=YMOH2XOdswHRKr1WX6TF5hQ4soj9oywWTRT2fG3N8hzvYhUM3iH5nWuVK5IMHqkQyf
         FPoK2JZCY02zFo6mmyOjbeBSAVkBjXNX+hR/hoN2/SuKSx8Tb82KV0yazOYoXQryidWP
         GxkwbiP+72pBwT3c+xF8Rgzup3YQyozsDeyllnPg4okrx3NZ4bp8To5MbmUEJwNpKNNx
         5OIzepUd4FQa/Tuex0xwd0nvaiHOQEFui96A4HY1L2PVTYNW8sN+acsOoLOsiY/ik78j
         CJJw/pRGIQJdztpuTxNthW62DU+3rcVDE+GKAAutZMklJGFaXsuRGDE8ZIBAeL739tVP
         al5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790768584; x=1791373384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8c0BJ0D8z5gH8AMDVEzCJUaQjDllcdyPshnOBMw13dA=;
        b=u93xP9WNBqedg1x0GRi/cdTDrXSOl0y+y54oYhEFfzUrdRHceZ3oej0As1bJdTnHw5
         NFBRPNOY4THiEx2GYt8Z4Tumaw1PyQgGXTgAesCxXPa3c7Sey7D21S7NBsNQIWD7QtpE
         XhauDnZ+T+7pZkWeatMfQi4jf61LthWMqxn9yryW5LHRPGOpkkW6sKoCC82VJ9WHchMD
         +cXInkqdpdOW+QZ7NYi+4K7Inm79LgTmW4KD8mKSIsZD2Hb1BTfYpI0YS5Ny+lnJ0kue
         vRAP7PILCk3Lbp2zv7I4fIEMF+sZEe8+ZUkPqEHykEvEkSLIn7HcUDaWYEWsfgqp//Hq
         ljSw==
X-Gm-Message-State: AFuF++kZtJtDyqEiAX9g/+XrM99SeD0oOPku4Ij99VKb3R8Qh821ltCv
	pJSoX3zJBsFk+Go6ei8VXKYuxKuApEWBsRXK9+w6cIEmvJPAS1EFg0mc
X-Gm-Gg: AYBFou2HF8k1YwNu5yVxHK+JlJb3RWfP4nOGeobjMpQXyzjXNwZYNlYhI72ie7bS0op
	k3pevutGB8ieXOXXpi/Y9mNFwV/nILERf+p4ILp77DiHw4JbmykJP597pDiC1vSAtrlTtesXyXy
	exUwVm3HWjZlWKNZj1sv8JxqSvcZr4tcIUjptVlpdy4u1fu7AjkZ2ugmQstM+cJR1xlKpbFAo2f
	WUtfQQ4MxRThKCW7jkDy9B/hM9gSPvvHoUO+amgHwQIhxcjXgFkmXVRTpZ4KFlAqA30LAR4ZrMc
	swzyTB8xUtPOVYwO5igOcETjyPk/fYSnkF2Ys/K3vuhyH/VeztHMmZsP6BXgIymoCK5U7xRTxr+
	Pb56iwetBJ+rzuvPgupbEc6QblufOF8ySM81wpsD9pxZjI7xakCD5HOwuATmZW8vXTk8BuQsbbz
	Ub8/Z20gW8nj+0nKDuIOvNkyxx9Vj/p71vlMIh5nd3jLChgUfMkpNaZWQCnWHgrpfJMc0rOfUDA
	WpdTTkm2FuUo+VUXBG8
X-Received: by 2002:a05:7022:ed02:b0:143:2701:9198 with SMTP id a92af1059eb24-14d33491b4amr1010932c88.36.1790768583379;
        Wed, 30 Sep 2026 04:43:03 -0700 (PDT)
Received: from localhost.localdomain ([103.178.205.97])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14d083fe71dsm4363940c88.4.2026.09.30.04.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 04:43:02 -0700 (PDT)
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
Subject: [PATCH v3] PCI: mediatek: Fix integer truncation and handle oversized resources
Date: Wed, 30 Sep 2026 11:42:18 +0000
Message-ID: <20260930114218.2655-1-sreekuttan2156239@gmail.com>
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
directly to fls(), which accepts an unsigned int, implicitly
truncates the upper 32 bits.

Furthermore, AHB2PCIE_SIZE() uses a 5-bit mask GENMASK(4, 0). If a
resource size exceeds 2 GiB (order > 31), the log2 size order
overflows the 5-bit mask. Clamping the value silently truncates the
hardware window while leaving the OS resource intact, causing bus
errors when accessing BARs in the unmapped upper region.

Fix this by using fls64(size - 1) to accurately calculate log2 size
orders without off-by-one errors and returning -EINVAL if the resource
size exceeds the maximum supported 31-bit window order.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/pci/controller/pcie-mediatek.c | 29 ++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index a60d1ae076f8..97d13c9d3369 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
@@ -686,6 +687,8 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 	const struct mtk_pcie_soc *soc = port->pcie->soc;
 	u32 val;
 	int err;
+	resource_size_t size;
+	int size_order;
 
 	entry = resource_list_first_type(&host->windows, IORESOURCE_MEM);
 	if (entry)
@@ -753,8 +756,18 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 		mtk_pcie_enable_msi(port);
 
 	/* Set AHB to PCIe translation windows */
+	size = resource_size(mem);
+	if (!size)
+		return -EINVAL;
+
+	size_order = fls64(size - 1);
+	if (size_order > 31) {
+		dev_err(port->dev, "Memory resource size too large: %pa\n", &size);
+		return -EINVAL;
+	}
+
 	val = lower_32_bits(mem->start) |
-	      AHB2PCIE_SIZE(fls(resource_size(mem)));
+	      AHB2PCIE_SIZE(size_order);
 	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
 
 	val = upper_32_bits(mem->start);
@@ -775,6 +788,8 @@ static int mtk_pcie_startup_port_en7528(struct mtk_pcie_port *port)
 	struct resource_entry *entry;
 	u32 val, link_mask;
 	int err;
+	resource_size_t size;
+	int size_order;
 
 	entry = resource_list_first_type(&host->windows, IORESOURCE_MEM);
 	if (entry)
@@ -829,8 +844,18 @@ static int mtk_pcie_startup_port_en7528(struct mtk_pcie_port *port)
 		mtk_pcie_enable_msi(port);
 
 	/* Set AHB to PCIe translation windows */
+	size = resource_size(mem);
+	if (!size)
+		return -EINVAL;
+
+	size_order = fls64(size - 1);
+	if (size_order > 31) {
+		dev_err(port->dev, "Memory resource size too large: %pa\n", &size);
+		return -EINVAL;
+	}
+
 	val = lower_32_bits(mem->start) |
-	      AHB2PCIE_SIZE(fls(resource_size(mem)));
+	      AHB2PCIE_SIZE(size_order);
 	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
 
 	val = upper_32_bits(mem->start);
-- 
2.55.0

