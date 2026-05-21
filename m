Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD28377555;
	Thu, 21 May 2026 09:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779356580; cv=none; b=cBga1j1ZQLU5CusnzyJcQiWU723SkpNNfe7g2ZbbNQSdBrw51cyGxBB8TKD+MnDCRbr2t0/Ow/LEaawl52CnhOqBRX3dCHEBRnSBG0x8kwHif8wCi9GpCufTkEYqHZkl3jTwMpaTve0+X5fq/XvtfXf7q1TEMRSpiIhKhtEBQAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779356580; c=relaxed/simple;
	bh=8pq6/n+Cp3VeNu2nAtA/xDVlF7EuqsdRr0HjZI1pXfA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HBV2+4ICbL1tIKUudj76UNulz6Q3VWplj2dSu2GeNy559h8MqMYfIeZ3r380ERQcHxqkfxSCXl2E7UVXsGW35rl3dM5aTG0DKUUjsJkPgolHVWiUF6l+44b7pHrT2GYbduK+li7+k58JeQ6TmvyuK+axZfJAzY9MDCBD+80Pp5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=HefKsc8n; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="HefKsc8n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1779356550;
	bh=N/LxuoK0gZOoQSTeBelDkwqChS+iq4NxmGzBGRItcUs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=HefKsc8nR17Ye7QmJ2HR9vzMylbzc23UyNV3xCisyZY1uM/g7pB4ijCaVMF4uZp+O
	 8ASJ6I32u8nedLhJ1olsPyq2xKjpEs+xhuQsNPEi9zEvxnQjLNeZX6u6LLsl2mtOIw
	 mEMtlAhijvqACmxWEbMYp/0dvcZmoq/bflj23kp0=
X-QQ-mid: zesmtpsz4t1779356534ted91138b
X-QQ-Originating-IP: fhBZRl85vHN0x1pUy3lGD5FyNzXu9hh4D94/NGcVGfg=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 May 2026 17:42:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 192467534549927609
EX-QQ-RecipientCnt: 4
From: Qiang Ma <maqianga@uniontech.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH] PCI/VPD: Disable VPD for Lenovo Realtek RTL8111xP devices
Date: Thu, 21 May 2026 17:41:38 +0800
Message-Id: <20260521094138.1634411-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Mom5ezI3X1cDh68psrThXmwg+n7pF/oPktkS4EIyJ5p0cOvWkodTFLHf
	EFJwJ24kVQIfbOXtIr798iPXQfWktvXnNaV1z2TZnFv9sQs3HHRr412mOrxGA5oFlV6JUCk
	zX43ENF1V6P/PUqeakoBqCX4BfU+cds6h76iyOgGAtUxtA46eL2gqn7ZtRrprmAREtQQcRN
	7ulVZt6FLHDxFUYCAEG4gaJtJbhRcbiiJJ9qHlH3RxjjkCigqfqPw01x8/3JyuxzkoORAOE
	89IPnNc0fOEzqT2eIY5l7btkM0Bye2FtSVDxi1tHSCdRB9UbqmUC0Lsg3W7LvlOsW0oS9gl
	NJSOWf+MCcxxwi1uLkCse2R5yyUURGC2n27L+7h92xNVtrw+Q7fMTQs70GHMrQUhyt0lGW/
	iTP/QdMp3S9fKpjRrro6fwzPbF00qzJWHCX1BkXr9b3yJ7ot91BhLMbqHBxsmACCVdK/9Vy
	+JWhGSBR8UPLyTQUavIz00dfyWhzN2/rk5awlKme1u3AtsnDuhsDeibbABr6bRCH3TNYriS
	Mg9K7jBPbi/upx+RpqhE69DL7rNsRPezNT+1yeAdy54Mcx6O86HuEEvnO2WViqDc+iaCBvR
	FfKdjWEXfm/v1za3u7s3t0tpdEwJEwvnyoY8L0KtPGh5WLUtENDY0riCEo33RRXCSjPtdkR
	Wy3n4zxnNVP+1RlA7VLxhSrLV2afme/sbSfXRqkOMrXaESiTPo5sHJRPwvKavAteweEap46
	yXHjYtFAnYtojvfPrQu5Imjd9V3JuohD3la4kNaA3uCUSufHiaymMoKZyD4jCqoBKA/Ip7Q
	3defiyzmzRMcmrXPKAbL3tCoDT8EcoSvCO/zJjxleNGBv68YJlOIBR5eysilnd8jSFedyr3
	/KrtCUC0sinwGWpdbIt2MMa59nGNNvg5DOu/6TzBpmmhS/hU1bVOMsO9KoG5k6jGaVax3/r
	XGJdH072HXyesAr5j5p4kcpki9FeikD8yqArjJAlOtLhYysnEhO8QfX7HhlACPa16aGXTTM
	PXG2ycisLT1mTMUizDc5r8SgSY4+LRdjfPIc2JNA==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

The Lenovo 17aa:507e RTL8111xP multi-function device exposes a VPD
capability on all functions, but the VPD storage is not usable.
Function 0 returns an invalid first tag and functions 1-4 never complete
VPD transactions.

This produces noisy dmesg output when userspace reads the VPD sysfs
attribute, including:

[   16.654155] r8169 0000:02:00.0: invalid VPD tag 0x00 (size 0) at offset 0; assume missing optional EEPROM
[   16.790913] serial 0000:02:00.1: VPD access failed.  This is likely a firmware bug on this device.  Contact the card vendor for a firmware update
[   16.931963] serial 0000:02:00.2: VPD access failed.  This is likely a firmware bug on this device.  Contact the card vendor for a firmware update
[   17.071445] pci 0000:02:00.3: VPD access failed.  This is likely a firmware bug on this device.  Contact the card vendor for a firmware update
[   17.210910] ehci-pci 0000:02:00.4: VPD access failed.  This is likely a firmware bug on this device.  Contact the card vendor for a firmware update

VPD is optional. Disable VPD for this exact subsystem and revision so the
PCI core does not expose a broken VPD sysfs file that cannot be read.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 drivers/pci/vpd.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 153394a652d3..492e0d669ea8 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -597,6 +597,32 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID, quirk_blacklist_vpd
 DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031,
 			       PCI_CLASS_BRIDGE_PCI, 8, quirk_blacklist_vpd);
 
+/*
+ * The Lenovo 17aa:507e RTL8111xP multi-function device advertises VPD
+ * on all functions, but the VPD data is not usable.  Function 0 returns
+ * an invalid first tag and functions 1-4 never complete VPD accesses.
+ */
+static void quirk_lenovo_realtek_rtl8111xp_no_vpd(struct pci_dev *dev)
+{
+	if (dev->revision != 0x0e ||
+	    dev->subsystem_vendor != PCI_VENDOR_ID_LENOVO ||
+	    dev->subsystem_device != 0x507e)
+		return;
+
+	dev->vpd.len = PCI_VPD_SZ_INVALID;
+	pci_warn(dev, FW_BUG "disabling VPD access (can't determine size of non-standard VPD format)\n");
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_REALTEK, 0x8168,
+			 quirk_lenovo_realtek_rtl8111xp_no_vpd);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_REALTEK, 0x816a,
+			 quirk_lenovo_realtek_rtl8111xp_no_vpd);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_REALTEK, 0x816b,
+			 quirk_lenovo_realtek_rtl8111xp_no_vpd);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_REALTEK, 0x816c,
+			 quirk_lenovo_realtek_rtl8111xp_no_vpd);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_REALTEK, 0x816d,
+			 quirk_lenovo_realtek_rtl8111xp_no_vpd);
+
 static void quirk_chelsio_extend_vpd(struct pci_dev *dev)
 {
 	int chip = (dev->device & 0xf000) >> 12;
-- 
2.20.1

