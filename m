Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794830859;
	b=r2WuPwhbJp9QZ/fNxSRDHAP0xNdNNhwE6bb2VkuYTLS2h/R5YSo6y+3oHsMeIWZEPXxT
	 n8lQtSYp8Dte45xgTOa5CMG2jl9x/MQ9MmmkBcNQF8VQF1skpbWF5dKC9c4a7701ZbWvq
	 hc6yUgnU8xIXbOiiyF4A6aeStFxUz80SfHh6RaY7K64daHy0Ro/QHRRzSwFEs458pkrYi
	 tG9hgykFZLrf0sO0oQ1XN107P63KNQ0oL5tIIT2ho+tKFOZhqg0w9L3u5SVREzJ6urviT
	 o/ouGbjHqJHX+ET9GjJaMy79dzfNd7OyMHi8N/l7hru+ryhlIYIEozackeMqcin9gIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794830859;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:DKIM-Signature;
	bh=u3+ws6+oBL2MO28rxfaeUNegBa7EiMRJB9ifKxPjWMk=;
	b=r3P5hxXGCwuEPjVWQDjU5phOEpssmIV09NLUorzLtAeX6su9jspRQcvCYcD9GubalfLz
	 TulMU6239fG2Jk8jNIXn3Z+v4MlZ98ExiBb9EO3uldtu34l/xaPH1NP9w/wmlR/aD/QnC
	 d9mEBI1XHrnVU4uLcffH6GJW4wJD8O3+LhmQMf+V9ZzfnphMPuGS1zhmMZAAu8mQ4gAfY
	 toNh0m31GDjGdh9+2HBb4y5iwRUO5XL/W9hH4dbmZDqcmuS45YGL6ln70tql3pTRq+T7C
	 apQ0rtvfipU/i193mqBPmkSQ1IfwoaTZzcbXZEyTTGpAdnvlqbwiEhBIo//9hMBGLhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b="kPkCBXH/";
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id C7FEF606A329;
	Mon, 16 Nov 2026 12:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7FEF606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=kPkCBXH/
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH v3] PCI/ACPI: Initialize the handle in acpi_get_rc_resources()
Date: Mon, 16 Nov 2026 20:07:21 +0800
Message-ID: <20261116120721.1713-1-lirongqing@baidu.com>
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
	s=selector1; t=1794830854;
	bh=u3+ws6+oBL2MO28rxfaeUNegBa7EiMRJB9ifKxPjWMk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=kPkCBXH/aZossIOuX1XsLk2xoiN16ZysQ475tJcvlfvHAWwDJ0yY4Y1Q0FEbnVecf
	 dl4qmlGsQiYEkTSteYpm9AVIN4khf8kM+absb4rhpSZdbC6dF6qBYGwu0fWUIYyuxe
	 K2XBjNRAal1clzuDoLK22eXJgINEHeK9fzGlDZh8IHQsOe3nbnMAsBu9fFMQR8tgZL
	 QxkzUEg5SunHYrjcNzLGFHN7qelWRW8h9f0JpC1DmTw2ITvBF9mmmptlHaP05Upu4/
	 8ueYPiMdm6mrsNGlhybSVNBoZK4uwAVTZbX6dxTXBCMNw8SHGQhvssx/wLNLo/xIfZ
	 G88Ny0XvdXZeQ==

From: Li RongQing <lirongqing@baidu.com>

acpi_get_devices() returns AE_OK even when the namespace walk finishes
without a match; in that case its return_value argument is not written,
because it is only updated when a match terminates the walk early.  The
caller passes an uninitialized acpi_handle, so on the no-match path a
stale stack value is handed to acpi_fetch_acpi_dev(), which treats it as
an ACPI namespace node: acpi_get_data_full() rejects a NULL handle up
front, but the garbage value passes through and is dereferenced in
acpi_ns_validate_handle(), which may crash or yield a bogus acpi_device.

Initialize the handle to NULL.  A missing match then makes
acpi_fetch_acpi_dev() return NULL, and the existing NULL check on the
returned acpi_device turns it into -ENODEV as intended.

Fixes: 169de969c018 ("PCI/ACPI: Provide acpi_get_rc_resources() for ARM64 platform")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
Diff with v2: remove check if handle is NULL
Diff with v1: add fix tag
 drivers/pci/pci-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index e260089..f14f74d 100644
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
-- 
2.9.4

