Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794288874;
	b=he43W4jebFNEvdR5shBGOmiPF1FVpYEzR5cCvXmgkcDLopiumvMX1jXqHIe03u7fGvIn
	 F7cPGBl3z/Kb2GGImQipFU+DKJVufpIhYYoT/OINFP06q0Qf38A+HBtIJiRR7lxpyi8JZ
	 tQ4dv41kusAktLek0Eu63QJRPkZ9VqpF5r7P9XZLvyzeuTbin57vZqAG2hxW3DZsjedSH
	 Z8P/azT/4cOOFoAeMvZktk2vehx4z96zT6Z3f9an6v00dS1wn5dzj7KqqWnelAW8SFUPV
	 O6yuLTw+/faZ3zQKAYMibM7uJf8tuROg9ZrJdz6HxrmhH6qbtdI69zFvlNvqyuPG9TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794288874;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:DKIM-Signature;
	bh=f7/n/f9UXUaejwMytNPMqQV0ly0h4V3WGxtUB3qMWMA=;
	b=LMvnNzRpg5NUu+iNN0MIQMvgntYchTf4rzXdk7jUXVSU5zD2JxUsQJBfPHtLMW5TxqWo
	 MrZ7ULLDhmXgZ9Q6ZleEx2YOmGOAP6mGQHAnXAQ/MvCD7wE83GA21MWFHB7mK9EUUKB5W
	 b1aCIvmywPL/gcg7n+wToXceESMPqBDA5tfOouAhHe3UINmszfJIyAMaFHvZAZ3RTtwKV
	 Rt1P3DgR2ByS6/WJfmn45gFIOjP8v5q/82j3C1UvUquM9hRJZSBuI5bzko8YqOpezImc5
	 dsHtCgoLIsM4kL5jSvV6mYJDpJLWmIRh5E6vLVxP1gIwA7/Hk43LFa2gn/IVmf5aWWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=h6eejKv6;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 88EA360A382D;
	Tue, 10 Nov 2026 05:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88EA360A382D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=h6eejKv6
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] PCI/ACPI: Check the found handle in acpi_get_rc_resources()
Date: Tue, 10 Nov 2026 13:34:23 +0800
Message-ID: <20261110053423.2517-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc6.internal.baidu.com (172.31.3.16) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1794288871;
	bh=f7/n/f9UXUaejwMytNPMqQV0ly0h4V3WGxtUB3qMWMA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=h6eejKv6bMomcZ0987anHFKA1wXY9Qf7pDjh+8fAheU1rZDUr3QkKTSfF3+3EBpN7
	 tiuksQZphjd+jkiBYlYOrJhOw7Fp1aVtrAn6uTfWhDRFB8la3MiUgVWXtyBMbixNr4
	 sztogTJuidlZEN6Vn40Fehxd+AKBLPEIdoDHaTC1Zhxoars5soiC4h2mg1SrN/aCmH
	 cDxZK9dxxTIFG/98T1SAwYvc2oxoMZx5B1N8Kg1YYCnkrgPjPwTy3nZcS4Vp+kRyMJ
	 GmXvPar0Z8t0jem05WhKDY4+/6ZysPV4AflXoJrFu2msjmnNd7CPVH3Lxyq+hxY61v
	 v6zAvVmVRuqlQ==

From: Li RongQing <lirongqing@baidu.com>

acpi_get_devices() returns AE_OK even when the namespace walk finishes
without a match, in which case the return_value argument is not written.
The caller passes an uninitialized acpi_handle and hands it to
acpi_fetch_acpi_dev(), which dereferences it as an ACPI node.

Initialize the handle and reject a missing match.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/pci/pci-acpi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index e260089..e90e749 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -82,7 +82,7 @@ int acpi_get_rc_resources(struct device *dev, const char *hid, u16 segment,
 {
 	struct acpi_device *adev;
 	acpi_status status;
-	acpi_handle handle;
+	acpi_handle handle = NULL;
 	int ret;
 
 	status = acpi_get_devices(hid, acpi_match_rc, &segment, &handle);
@@ -92,6 +92,9 @@ int acpi_get_rc_resources(struct device *dev, const char *hid, u16 segment,
 		return -ENODEV;
 	}
 
+	if (!handle)
+		return -ENODEV;
+
 	adev = acpi_fetch_acpi_dev(handle);
 	if (!adev)
 		return -ENODEV;
-- 
2.9.4

