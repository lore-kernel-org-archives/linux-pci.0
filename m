Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8CD23D7DE;
	Wed, 11 Feb 2026 07:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770793698; cv=none; b=TrMo5h5i0WCle8OEm8q8CPsBTkfPya0Vu06GIyaBCbbz++VVwyPxgs2Y34ok/q4gHZyo9EJgWHC2oZV9ic3q3Pyb9/fUC78mjXsGg2zme0t2sQyXWn07FAUew0+zDMasOr2jD/po6ABGlqq1iXu4X1UNpjKUbZ6ycqZv+JOvCvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770793698; c=relaxed/simple;
	bh=jB5D08cjrQR9mUiBn/Oeq3wnXs2VK+KWZhbOplypElM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TxeZImEEe4nonms3MFF7wdmKpnGS68TJzKIo0y0Ab71mL/Vn76TFlJJOneo7eouTjT/bciJi/j33T8LceoVB2C3Z1Mmk8WBqA28rK0dcVMbHDKwbXJErUTyUU2kuNw3auuPo3n3LmPor1tRp7EbxwnM8Yr3xCa+KdhxEwjqz7tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEi5I/0u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEi5I/0u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00D7C4CEF7;
	Wed, 11 Feb 2026 07:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770793697;
	bh=jB5D08cjrQR9mUiBn/Oeq3wnXs2VK+KWZhbOplypElM=;
	h=From:To:Cc:Subject:Date:From;
	b=pEi5I/0uMo2IpD58x9mtSnu5PBQELZXZyYj/R9QbWY4lyqftUubJ9CeqSa2Yd1bnv
	 HAEaHzY2F+bcm88zzJ8j8IDLM9MfkkgfxBKtwX5+Meh5vECmkda/MYcvx+aaT7K6qZ
	 u7EKGPDSuf8UOW2pjvIVnHFm4v6C7tg+uXG0DWrvLvgz0Ft+xCA4lHIYT0Sdw+0+J4
	 Dbo5h3Ssv+XQWhsLdPnYNOeVjnxGQvj15grB4Q2J+B4cYbqkpmoUGb22YbHJfF7sZd
	 Vs3vRNj/aOMUIOPFgINSTg3cqxSa+rV7nlJWGT9/Bfr4xyBDC/mY0VBDHTi+qGVR9p
	 P3OBoiAgyfVPA==
From: Arnd Bergmann <arnd@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: endpoint: pci-epf-test: select configfs
Date: Wed, 11 Feb 2026 08:07:40 +0100
Message-Id: <20260211070812.4087119-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Like some of the other endpoint modules, this one now also
uses configfs, but is missing an indication in Kconfig:

arm-linux-gnueabi-ld: drivers/pci/endpoint/functions/pci-epf-test.o: in function `pci_epf_test_add_cfs':
pci-epf-test.c:(.text.pci_epf_test_add_cfs+0x2c): undefined reference to `config_group_init_type_name'

Select the symbol as needed.

Fixes: ffcc4850a161 ("PCI: endpoint: pci-epf-test: Allow overriding default BAR sizes")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/endpoint/functions/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
index 0c9cea0698d7..bb5a23994288 100644
--- a/drivers/pci/endpoint/functions/Kconfig
+++ b/drivers/pci/endpoint/functions/Kconfig
@@ -6,6 +6,7 @@
 config PCI_EPF_TEST
 	tristate "PCI Endpoint Test driver"
 	depends on PCI_ENDPOINT
+	select CONFIGFS_FS
 	select CRC32
 	help
 	   Enable this configuration option to enable the test driver
-- 
2.39.5

