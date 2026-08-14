Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C632F3DF003
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 07:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786691137; cv=none; b=nzLgaBCgWoVGuMOPKyvBGV5ClbLBV4caGYw+suz///8P79KFZ/dpQfJ7oDLWM3PsEADWWgdJTmkudMcTlwVyTADWmiS3c5Duc0BmEoaOZUAIF41VcSSIv5LCVQZ7M0uTjCTsD1Bo/mtoShhBbgtdFMr1lmWvH2mCg98Fp805/Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786691137; c=relaxed/simple;
	bh=F+AWt7g0j78EqPTTP22LTLa0EQfGJ4opJ0kpVtsnlic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kUsZiMKMVK9W0+JHCujiZ5vgFyDS5ADkuBUgeWd0kteXvYeJpXywddxqoDuN1B+KJBkfnQuB+2Sor4vaRrNcxJ+xY5J8cZHi93vDLUFI/QPUQWp5+imFoLx0DWsRm6JwxwLWYpBpkcK95HgD5fRF1UVIbDg4ADQ+KNNdPDXcuTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhWqQdfY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhWqQdfY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6132F1F00ADB;
	Fri, 14 Aug 2026 07:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786691131;
	bh=ocbE9l+NGyM1SzKVHqivawVOmCZnDb/7wamzZIvjdAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OhWqQdfYG5a5+ZZeWqsPnuAa/JDnx7etFXM4ksAhq/D7boDUsObL5mifDRzH66YO8
	 Eey9fqjRj+X6ktELmMr3+4iZfPF3DqLBipS+qAdoQk1CkdpSsEtFzxeaJP+L75HssG
	 RmrbDQQTdQF8zyjPbZNja7x1M5UQPtdkfAapuRmwiVj2rPG/lXahTEx5P0NDy+7P68
	 cWIG6IGjU0gXJmliRwh7//TvhI3Di8MRgt8lingeGUu7urmPmNnIDHz5pp9YXY9TMH
	 9pWqz2tunwoqE6H9StjP2zyVE48j9Xxd0Wl5Xde9WPmq6W4IqK/lloArSnBXje0nK5
	 T+YkWJ56xH10g==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Narendra K <Narendra_K@Dell.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 4/4] PCI/sysfs: Pass the device name length in UTF-16 code units
Date: Fri, 14 Aug 2026 07:05:22 +0000
Message-ID: <20260814070522.2327975-5-kwilczynski@kernel.org>
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

Currently, dsm_label_utf16s_to_utf8s() passes the ACPI buffer
length to utf16s_to_utf8s() unchanged.  The Device Name _DSM may
return the device name as a buffer holding a UTF-16 string, and
the ACPI length counts bytes while the converter counts wchar_t
elements.  The converter therefore receives a count twice the
number of code units the buffer holds, and that count is its only
bound on the input.

A NUL code unit ends the conversion early, so a name that carries
one is converted correctly and the error stays hidden.  ACPICA
zeroes the entire result allocation, and the padding placed after
the buffer supplies that NUL for most lengths.  Lengths that leave
no padding, or a single byte of it, do not, and the conversion
then runs up to its own length in bytes past the end of the
allocation.  The bytes beyond the allocation are decoded into the
"label" attribute, which is world readable.

Thus, divide the buffer length by the size of wchar_t so that the
converter receives a count of code units.  The division truncates,
so the converter is never told to read more bytes than the buffer
holds, including for an odd length.

Reaching the out of bounds read needs firmware that returns the
name as a buffer and omits the terminator.

Fixes: 6058989bad05 ("PCI: Export ACPI _DSM provided firmware instance number and string name to sysfs")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-label.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
index abb941530c56..08c461f1142d 100644
--- a/drivers/pci/pci-label.c
+++ b/drivers/pci/pci-label.c
@@ -144,7 +144,7 @@ static int dsm_label_utf16s_to_utf8s(union acpi_object *obj, char *buf)
 	int len;
 
 	len = utf16s_to_utf8s((const wchar_t *)obj->buffer.pointer,
-			      obj->buffer.length,
+			      obj->buffer.length / sizeof(wchar_t),
 			      UTF16_LITTLE_ENDIAN,
 			      buf, PAGE_SIZE - 1);
 	buf[len++] = '\n';
-- 
2.55.0

