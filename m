Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B713E44E7
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 07:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786691133; cv=none; b=l9WxYh0HidVub29dxx+SLvK0esGH6TLcUniLUYxsVfpuNQ7OKkHxQbGTzUNJyzL1WG9e1VSKjztDaqJiT3Kjg7tN+7hbg1ypQGlMkxsDjAgfv/ko5tz8eMuKEuqhl+ZQVsuM5XtvsCPj0oW5cvJKC93CyP7mQxvgNQhWtD4eXXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786691133; c=relaxed/simple;
	bh=oZyRiXqqeMDYmTmjczcdTg9sK/rT2YaFn9SKHHQuOsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/sdEgkBE/qUHccTUgxabAwWRnnVn2/oNvIltJ1Yq5tgrkd/V/FXMBTlCpeObbl5gj550VaOGwaDOiKhYWI7/+np6R/oWGlIjeLzooov7z4BmvXIrEr74gHIUvLcx+54K4xOUkXUelZDkFF+IGF8jaXeaBF1u9apZAr26t08fBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKrHaLSr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKrHaLSr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533971F00A3D;
	Fri, 14 Aug 2026 07:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786691128;
	bh=ywGTcbUJtl71t1g+VJG3/C0HlRVXyefGgiLRI0/MVD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CKrHaLSrZ0MD5q/frnDsbs0u1hv+l+gNQnGMW+uEkLa2ObbCge32jdpsFWVBSSdp3
	 mRSNKXUpYCG5/UglIj7YyiWZmmF+BE1Nj/ujDlultDu+VokA3bm34+Xx86beTyjgk+
	 V/vUtUTHrCoSAoRu3c1BaZ6z3mMibBSKr828Opyat15xiyG1qF3FHOajQgJPz+nyrd
	 X5FDtHosWK7wqeVGBdWtNjgWUeo7UfXHdLRE8z6qVErHV69kqiq5lzidCSEyb3fWyb
	 /x4ZlzMv6FUDi8Zdgqipqlgw63yn/m7rrI2SO8UsemivNO+5s4gAoNFgNaLnedWymD
	 zxdIxiZFy2SYw==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Narendra K <Narendra_K@Dell.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/4] PCI/sysfs: Decouple acpi_index from the optional device name element
Date: Fri, 14 Aug 2026 07:05:20 +0000
Message-ID: <20260814070522.2327975-3-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814070522.2327975-1-kwilczynski@kernel.org>
References: <20260814070522.2327975-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, dsm_get_label() validates both elements of the Device Name
_DSM result in a single conditional.  The _DSM returns an ACPI package
of two elements, the instance number and the device name, where the
instance number is mandatory and the name is optional.  Firmware that
implements no name must return a NULL string for it.

Reads of "acpi_index" therefore fail whenever the name element is
malformed.  That attribute exports only the instance number, and the
two elements do not depend on each other.

Thus, validate each element only for the attribute that exports it.
So "acpi_index" now depends on the instance number alone, and "label"
reads fail with -EIO when the name element is neither a string nor a
buffer.  The package elements pointer is read only after the object
type has been checked.

On platforms with a valid instance number and a malformed name element
the "acpi_index" attribute starts returning data.  Because udev derives
the onboard interface name from "acpi_index", an interface on such a
platform may be renamed once, on the first boot after this change.
That is the attribute assuming the value the firmware always
provided.

Link: https://github.com/pciutils/pciutils/issues/175
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-label.c | 55 +++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
index 255e0ecffb09..5b08f50653a3 100644
--- a/drivers/pci/pci-label.c
+++ b/drivers/pci/pci-label.c
@@ -157,7 +157,7 @@ static int dsm_get_label(struct device *dev, char *buf,
 {
 	acpi_handle handle = ACPI_HANDLE(dev);
 	union acpi_object *obj, *tmp;
-	int len = 0;
+	int len;
 
 	if (!handle)
 		return -ENODEV;
@@ -167,30 +167,43 @@ static int dsm_get_label(struct device *dev, char *buf,
 	if (!obj)
 		return -EIO;
 
-	tmp = obj->package.elements;
-	if (obj->type == ACPI_TYPE_PACKAGE && obj->package.count == 2 &&
-	    tmp[0].type == ACPI_TYPE_INTEGER &&
-	    (tmp[1].type == ACPI_TYPE_STRING ||
-	     tmp[1].type == ACPI_TYPE_BUFFER)) {
-		/*
-		 * The second string element is optional even when
-		 * this _DSM is implemented; when not implemented,
-		 * this entry must return a null string.
-		 */
-		if (attr == ACPI_ATTR_INDEX_SHOW) {
-			len = sysfs_emit(buf, "%llu\n", tmp->integer.value);
-		} else if (attr == ACPI_ATTR_LABEL_SHOW) {
-			if (tmp[1].type == ACPI_TYPE_STRING)
-				len = sysfs_emit(buf, "%s\n",
-						 tmp[1].string.pointer);
-			else if (tmp[1].type == ACPI_TYPE_BUFFER)
-				len = dsm_label_utf16s_to_utf8s(tmp + 1, buf);
-		}
+	if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count != 2) {
+		len = -EIO;
+		goto out;
 	}
 
+	tmp = obj->package.elements;
+	if (tmp[0].type != ACPI_TYPE_INTEGER) {
+		len = -EIO;
+		goto out;
+	}
+
+	if (attr == ACPI_ATTR_INDEX_SHOW) {
+		len = sysfs_emit(buf, "%llu\n", tmp[0].integer.value);
+		goto out;
+	}
+
+	/*
+	 * Per PCI Firmware r3.3, sec 4.6.7, the device name is optional
+	 * even when this _DSM is implemented. When not implemented, this
+	 * entry must return a NULL string.
+	 */
+	switch (tmp[1].type) {
+	case ACPI_TYPE_STRING:
+		len = sysfs_emit(buf, "%s\n", tmp[1].string.pointer);
+		break;
+	case ACPI_TYPE_BUFFER:
+		len = dsm_label_utf16s_to_utf8s(&tmp[1], buf);
+		break;
+	default:
+		len = -EIO;
+		break;
+	}
+
+out:
 	ACPI_FREE(obj);
 
-	return len > 0 ? len : -EIO;
+	return len;
 }
 
 static ssize_t label_show(struct device *dev, struct device_attribute *attr,
-- 
2.55.0

