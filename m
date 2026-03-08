Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD732580F3;
	Sun,  8 Mar 2026 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772980038; cv=none; b=b4gRIW9cetWicH1VgWK23FP9+sy3gPOJur576HAHXJ9TpZ9zn0Ecink2jYBI8a9MmA/HKglW3GTQtuiQmK5YHi7clRMRS1lPZoJP91bleTcn5NpxHBUYnwLZND9NNZt6CbJUIrNhGUQTwWcO1gl4vthFK/TjZ4BNzQXN9LJyoXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772980038; c=relaxed/simple;
	bh=EYWYXA0SXXfVzCOjkcvBIDORYtYJe09tW0gS4xoEX4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MfQCy2yL1C5hFipDTT5ujZIIIII0oqALRNbEOc8uSRWvXu/rT5uOUiXrEfUMnpX5+kG5Wyhk0thTly/vz3DxF2iG4a92fUxh6sgT+6Uqqj5mix0o7R0hLHLWiOAVr783DgzrUVdwTasEraKfE2IojuxADcUpYplB7H7Ar1LZz1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hIXgxyi2; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hIXgxyi2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=rB
	leMrXi8hZa9aBMs2y7k7+RNM9OGf3NCnDwQWJr1zM=; b=hIXgxyi2u08na9xjgP
	y05r/RV/jZALwg0tdKd/gGnQ8EbogpGG2d3AsjkIQX67YnnpTSW4xCE5KW4zlOqG
	0s4jRY8ziTOqloN2MAbKZsf8WRshegkBDekJtIUvIWcaYRZr6T3V/XhOM5FzEMf8
	pumZC+AkoSd4hCkg3NLmPtS88=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBXlAEXh61pUWlUOw--.24999S3;
	Sun, 08 Mar 2026 22:26:32 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	jingoohan1@gmail.com,
	mani@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	helgaas@kernel.org
Cc: robh@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v7 1/2] PCI: of: Remove max-link-speed generation validation
Date: Sun,  8 Mar 2026 22:26:28 +0800
Message-Id: <20260308142629.75392-2-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260308142629.75392-1-18255117159@163.com>
References: <20260308142629.75392-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXlAEXh61pUWlUOw--.24999S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr43tw43CryDXw1DGr4UJwb_yoW8Xr1fpF
	W7Cr1F9r1UJF45Xr4UXFs5Za4YgFn3WrWDKryrGwn7uF43JrZIqFyavF1aqF9a9F9rZF17
	X3WagF4UCFWjyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRcBM_UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwxitUWmthxgzSgAA3F

The of_pci_get_max_link_speed() function currently validates the
"max-link-speed" DT property to be in the range 1..4 (Gen1..Gen4).
This imposes a maintenance burden because each new PCIe generation
would require updating this validation.

Remove the range check so the function returns the raw property value
(or a negative error code if the property is missing or malformed).
Callers must now validate the returned speed against the range they
support.  A subsequent patch adds such validation to the DWC driver,
which is the primary user of this function.

This change allows future PCIe generations to be supported without
modifying drivers/pci/of.c.

Signed-off-by: Hans Zhang <18255117159@163.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/pci/of.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 9f8eb5df279e..cff5fd337c2b 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -889,10 +889,11 @@ EXPORT_SYMBOL_GPL(of_pci_supply_present);
 int of_pci_get_max_link_speed(struct device_node *node)
 {
 	u32 max_link_speed;
+	int ret;
 
-	if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
-	    max_link_speed == 0 || max_link_speed > 4)
-		return -EINVAL;
+	ret = of_property_read_u32(node, "max-link-speed", &max_link_speed);
+	if (ret)
+		return ret;
 
 	return max_link_speed;
 }
-- 
2.34.1

