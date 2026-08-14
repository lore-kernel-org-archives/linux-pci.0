Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0783335C6B7
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 07:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786691134; cv=none; b=XGdZNsxnm8VKuY26jvfcQqrE0P6Kc92WzyBIMcrrqPhgtdYmv428pIIK7Olg95UmIjCZddkKcFEqYvcpyuhcltxua0/QzYJAiaa/jqYIJx+ldlGxuw9SvZs2mkbli/vGBLQZmQUiEyLojTwDTWIPK5Sux4GpsOjnVnsx8TKwFak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786691134; c=relaxed/simple;
	bh=BjVLKYF/0FlM0IddyhA9BJmBDaAw+iHH/C0wib89uuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YVZ1O8CeKTGkXoqM40J0VuZUUMgsfVvu0gf58uHWVKZRbBuskYm5nYIjrgASq68n2uolwe9SMExggNMRQb5pqMnxMfd56OGWgtGzLlCpqLVK0JMgaNYaXvPb8SArI64OJMd9POPEgUWLk+YMrx+ZxiyaLldqmLPswhegWmAnCZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmLq7RMP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmLq7RMP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A6D1F00ACA;
	Fri, 14 Aug 2026 07:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786691130;
	bh=5iKY6w/LKomNQKvpWIUjBpybARG4NTreTfnOktnFLeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OmLq7RMPuQ/e81wOXwM5JxNvN7sj6ydp7l8wQ8VRNtUOpxyRiNYjGQES7WajnXdcS
	 e9yllzOJaDlhevi+W3R/xBDL4BphKHexhoDJRtVeRfz5Una+cwo636ZWyNpfIGWCss
	 uOgV7kAeiE7WVONNreQydWw9WlHADYUfDFor7JvlMw0IRLK7ypfZLsG9VtBkqBov53
	 N0CzNGa5zkbgkQHe5IQpJM+XrPwE2fQcowK8YIzAq1Ll5GPPdAEKU2ZFsnzTXRpYRp
	 RUrPHm1/XzkV5lqGxZDo9V17invqcci7kq+a4gy1jvt/YIdWeQKpWiOXszc2U8/8qR
	 ZyNM+pOjjo27w==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Narendra K <Narendra_K@Dell.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 3/4] PCI/sysfs: Handle a malformed _DSM result in acpi_attr_is_visible()
Date: Fri, 14 Aug 2026 07:05:21 +0000
Message-ID: <20260814070522.2327975-4-kwilczynski@kernel.org>
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

Currently, the "label" and "acpi_index" attributes are created
whenever the _DSM function 0 bitmap advertises the Device Name
function, without evaluating that function.  The documented ABI
states that each attribute is created only if the firmware has
given a name or an instance number to the PCI device.

The bitmap says nothing about the object the function returns.
Firmware that advertises the function but returns an object that
cannot be parsed therefore produces attributes that exist and fail
every read, as in the report below.

Thus, evaluate the Device Name _DSM when deciding attribute visibility
and create each attribute only when the element it exports has a type
the read path accepts, mirroring the checks performed at read time.
The SMBIOS attribute group already follows this pattern by performing
the DMI lookup in its is_visible() callback.  The read side checks
remain in place since the two evaluations happen at different times.

This restores the behaviour from before commit 2fc59fe2ecdc ("PCI /
pci-label: treat PCI label with index 0 as valid label"), which
switched visibility from evaluating the function to checking only
the function 0 bitmap.  The check is now made for each attribute,
not once for both.

Fixes: 2fc59fe2ecdc ("PCI / pci-label: treat PCI label with index 0 as valid label")
Closes: https://github.com/pciutils/pciutils/issues/175
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-pci | 14 ++++++++---
 drivers/pci/pci-label.c                 | 33 ++++++++++++++++++++++++-
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index b767db2c52cb..e857b14c8faf 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -244,10 +244,16 @@ Contact:	Narendra K <narendra_k@dell.com>, linux-bugs@dell.com
 Description:
 		Reading this attribute will provide the firmware
 		given name (SMBIOS type 41 string or ACPI _DSM string) of
-		the PCI device.	The attribute will be created only
-		if the firmware	has given a name to the PCI device.
-		ACPI _DSM string name will be given priority if the
-		system firmware provides SMBIOS type 41 string also.
+		the PCI device. The attribute will be created only if the
+		firmware naming mechanism is implemented for the device:
+		a SMBIOS type 41 record with a non-empty reference
+		designation, or a Device Name _DSM that returns the name
+		as a string or a buffer. The value read is empty when the
+		firmware implements the _DSM but gives the device no name,
+		which per PCI Firmware r3.3, sec 4.6.7 the firmware reports
+		as a NULL string. ACPI _DSM string name will be given
+		priority if the system firmware provides SMBIOS type 41
+		string also.
 Users:
 		Userspace applications interested in knowing the
 		firmware assigned name of the PCI device.
diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
index 5b08f50653a3..abb941530c56 100644
--- a/drivers/pci/pci-label.c
+++ b/drivers/pci/pci-label.c
@@ -230,11 +230,42 @@ static umode_t acpi_attr_is_visible(struct kobject *kobj, struct attribute *a,
 				    int n)
 {
 	struct device *dev = kobj_to_dev(kobj);
+	union acpi_object *obj, *tmp;
+	umode_t mode = 0;
 
 	if (!device_has_acpi_name(dev))
 		return 0;
 
-	return a->mode;
+	/*
+	 * The bitmap from _DSM function 0 only advertises function 7,
+	 * and whether the returned object can be parsed is a separate
+	 * question. Evaluate it and expose each attribute only if the
+	 * element it exports has one of the types the read path
+	 * accepts, mirroring the checks in dsm_get_label().
+	 */
+	obj = acpi_evaluate_dsm(ACPI_HANDLE(dev), &pci_acpi_dsm_guid, 0x2,
+				DSM_PCI_DEVICE_NAME, NULL);
+	if (!obj)
+		return 0;
+
+	if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count != 2)
+		goto out;
+
+	tmp = obj->package.elements;
+	if (tmp[0].type != ACPI_TYPE_INTEGER)
+		goto out;
+
+	if (a == &dev_attr_acpi_index.attr)
+		mode = a->mode;
+	else if (a == &dev_attr_label.attr &&
+		 (tmp[1].type == ACPI_TYPE_STRING ||
+		  tmp[1].type == ACPI_TYPE_BUFFER))
+		mode = a->mode;
+
+out:
+	ACPI_FREE(obj);
+
+	return mode;
 }
 
 const struct attribute_group pci_dev_acpi_attr_group = {
-- 
2.55.0

