Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C572D3E0724
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 07:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786691132; cv=none; b=QfyqccIylPjadMyO1iMqE/QaXmj5Gi44Z9TQosk2accatPjkFK8EnyyhDLxhEivF1czn3CIC+QcZ03A614A97X2GiWdZIaFABnAI3sATObcoXSNLTobVunIV7oJHQqKi8QvcX8Cq1d0uBQSV84q0m3tm/eQmQVu0c8YqLBjMObs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786691132; c=relaxed/simple;
	bh=02nlSrqU4pGt5kWyA71im4Cstzjad/spivQipb2XnI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TIOHnesnumyEvh+8FbzUCoyEkYsu3hkA7XjPUCNOLsoEFZphRvoj0eG4zITk34QaGi836WWu4p+we8wd1WLUzao/8uGkktsmKpmFW+KJIY3EwgYvOx4NxLcmfpE5MAmu0zfAGEFgdoGkg+KwpzdqSpjM94VZVyPg/G/8SjFiG5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTmy65dX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTmy65dX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62F41F00A3A;
	Fri, 14 Aug 2026 07:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786691127;
	bh=uoT0vcEMsySXtn4Fgf4b4dyRs3/autwjCBUGceosK0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DTmy65dX5L7xzAMxTt22pitDKeCovm1dhaRmYe+tIJuJzqw1Mr5mAsKqD73PSBStW
	 82MCngx4XvMrKG4qrlONzxwNdNa8CfZHhYxbTmECytiR3slwwiAQlAeIWaQ7ddGfWV
	 WvowIMbMEKjZsm8EjHFtehM/hnPBsJOSqIKGc3RZ7v28xg/vnYHqztBMpWsY29n+5b
	 VcE48M0D4jGSp+0M9kwvbRwWgK066L4mwdqYJ/KCioWPd++L3MKwMvjPB+298CnWaH
	 5+IefncWhtngWgZtHLkytkOscfF6Ih9GTRGfJNizdyaZI+6HiFuQtpHFE1nIE05FVk
	 O5YD0wh1JvqOw==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Narendra K <Narendra_K@Dell.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 1/4] PCI/sysfs: Stop reporting _DSM failures as -EPERM
Date: Fri, 14 Aug 2026 07:05:19 +0000
Message-ID: <20260814070522.2327975-2-kwilczynski@kernel.org>
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

Currently, dsm_get_label() returns the literal -1 on every failure
path.  The sysfs read path passes that value to userspace as
-EPERM.  Reading the "label" or "acpi_index" attribute on a platform
where the Device Name _DSM returns a malformed result then fails
with:

  $ cat /sys/bus/pci/devices/0000:00:08.3/label
  cat: /sys/bus/pci/devices/0000:00:08.3/label: Operation not permitted

Nothing in that path performs a permission check, and the read
fails the same way for a privileged reader.  The error code points
at a cause that does not exist, and tools such as lspci report it
on every invocation.

Thus, return -ENODEV when the device has no ACPI companion, and
-EIO when the _DSM evaluation fails or returns an object that
cannot be parsed.  Other _DSM users in the tree report such
failures the same way.

The set of reads that succeed, and the bytes they return, stay
the same.  Only the error code of reads that already fail differs.

Link: https://github.com/pciutils/pciutils/issues/175
Fixes: 6058989bad05 ("PCI: Export ACPI _DSM provided firmware instance number and string name to sysfs")
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-label.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
index 0c6446519640..255e0ecffb09 100644
--- a/drivers/pci/pci-label.c
+++ b/drivers/pci/pci-label.c
@@ -160,12 +160,12 @@ static int dsm_get_label(struct device *dev, char *buf,
 	int len = 0;
 
 	if (!handle)
-		return -1;
+		return -ENODEV;
 
 	obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 0x2,
 				DSM_PCI_DEVICE_NAME, NULL);
 	if (!obj)
-		return -1;
+		return -EIO;
 
 	tmp = obj->package.elements;
 	if (obj->type == ACPI_TYPE_PACKAGE && obj->package.count == 2 &&
@@ -190,7 +190,7 @@ static int dsm_get_label(struct device *dev, char *buf,
 
 	ACPI_FREE(obj);
 
-	return len > 0 ? len : -1;
+	return len > 0 ? len : -EIO;
 }
 
 static ssize_t label_show(struct device *dev, struct device_attribute *attr,
-- 
2.55.0

