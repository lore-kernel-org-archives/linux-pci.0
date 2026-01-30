Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8BD313287
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 08:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769760460; cv=none; b=JHXJRF3ttATXoiB87FZQLAWmJ2Ug9QSPMiDDximbSUt+X7rn1LZEqIAj3PLmvJEtNXTlyWoWJO+g0U4JNGIlQ2jFgwFMGxWLGRYVNyVmMVE+tfxtfPvQng4HpVFMSX/DT1TenWAfjFRhZ9ORw1qTNCXlWc4n9oV2Nu0OrxEaPMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769760460; c=relaxed/simple;
	bh=RNfbckMfLN65I1h6+KO6IPOMfzoMiuZpWuqY4IflXa0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XPw8PcVj+r0Cf+bsqgs5nbiUxC2n92Rm6YXlQshUOoMEmBDerS40FKhE9mYgJ1N7tdSO246Q/gdfngbclxADCbdgDvpxyB8MDmVBTtwytw7x1hKMSuKpN/yqidx5Odmjh5M8ip0OAInssC8jr0NBgadD/7ycdGnRnSmRzJqilU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cMnPxr97; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cMnPxr97"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769760455; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=qfGdlqz8H5Q1uzYtA8Pi6jqH8ssXq4MEHuNxWttHn10=;
	b=cMnPxr97rehd6btXc4d7ruNZDaRWEFFu00miG3wBkwJrifoS0Z9j9Uv7lps6/9L47IYRWfNqMGMM7Z4NYJWQlcSVGghDKocbj9DMuzUnTQikh6XPYsUoiFk9x52Tnxe7vkFUovo0BcG8hAR2tp+lGNHBfjaFCs93SkynI153L6A=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WyA5ABs_1769760450 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 30 Jan 2026 16:07:35 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org,
	Xunlei Pang <xlpang@linux.alibaba.com>,
	oliver.yang@linux.alibaba.com
Subject: [PATCH v11 0/2] PCI: Fix crash when access broken ROM
Date: Fri, 30 Jan 2026 16:07:27 +0800
Message-Id: <20260130080729.96152-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v10 -> v11:
- Change 'pci rom' to 'PCI ROM' of the tittle of the first patch.
- Add Andy Shevchenko's rb tag in the first patch, thanks. 

v9 -> v10:
- Reorder the header files, and not touch kernel.h
- Change PCI_ROM_IMAGE_LEN_UNIT_BYTES to PCI_ROM_IMAGE_SECTOR_SIZE.
- Add a comment for PCI_ROM_DATA_STRUCT_SIGNATURE.

v8 -> v9:
- Supplemental explanation for the commit body of the first patch.
- Change PCI_ROM_IMAGE_LEN_UNIT_SZ_512 to PCI_ROM_IMAGE_LEN_UNIT_BYTES,
and change it's definition to SZ_512.
- Use u16 and u32 for signature val instead of unsigned short/int.

v7 -> v8:
- Ordered header files alphabetically.
- Convert the literals too in the firt patch.
- Use local val to save signature instead of reading twice.

v6 -> v7:
- Put all named defines to a separate patch.
- Change PCI_ROM_IMAGE_LEN_UNIT_BYTES to PCI_ROM_IMAGE_LEN_UNIT_SZ_512.
- Named BIT(7) to PCI_ROM_LAST_IMAGE_INDICATOR_BIT.
- Fix all other comments from Ilpo, such as including header files,
and alignment fault, Thanks.

v5 -> v6:
- Convert some magic number to named defines, suggested by
Ilpo, thanks.

v4 -> v5:
- Add Andy Shevchenko's rb tag, thanks.
- Change u64 to unsigned long.
- Change pci_rom_header_valid() to pci_rom_is_header_valid() and
change pci_rom_data_struct_valid() to pci_rom_is_data_struct_valid().
- Change rom_end from rom+size to rom+size-1 for more readble,
and also change header_end >= rom_end to header_end > rom_end, same
as data structure end.
- Change if(!last_image) to if (last_image)..
- Use U16_MAX instead of 0xffff.
- Split check_add_overflow() from data_len checking.
- Remove !!() when reading last_image, and Use BIT(7) instead of 0x80.

v3 -> v4:
- Use "u64" instead of "uintptr_t".
- Invert the if statement to avoid excessive indentation.
- Add comment for alignment checking.
- Change last_image's type from int to bool.

v2 -> v3:
- Add pci_rom_header_valid() helper for checking image addr and signature.
- Add pci_rom_data_struct_valid() helper for checking data struct add
and signature.
- Handle overflow issue when adding addr with size.
- Handle alignment fault when running on arm64.

v1 -> v2:
- Fix commit body problems, such as blank line in "Call Trace" both sides,
  thanks, (Andy Shevchenko).
- Remove every step checking, just check the addr is in header or data
struct.
- Add Suggested-by: Guanghui Feng <guanghuifeng@linux.alibaba.com> tag.

Guixin Liu (2):
  PCI: Introduce named defines for PCI ROM
  PCI: Check ROM header and data structure addr before accessing

 drivers/pci/rom.c | 137 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 115 insertions(+), 22 deletions(-)

-- 
2.32.0.3.g01195cf9f

