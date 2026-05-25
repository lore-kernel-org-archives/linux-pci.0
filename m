Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3832848A1;
	Mon, 25 May 2026 02:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779677649; cv=none; b=OFMTWy2RM8uwgda+RYfUxa6fSzNsdrMaL1FoXbEUx1TPxy8VzQbMXHpixijJMGrai90gC5ibaniqETt13mVhnJqmjA/1doeUmuyXA4Z/f9Lk1Gba63urxxOYfwSkFOsBIOiV2/OMMTgJ+NKIz/cRP+3oeVqQJnsnphjvbTPkmP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779677649; c=relaxed/simple;
	bh=5pkXHUEhzK1uq597fhMY/9IEK3yR1OmMtaOCvXbm92s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L95ElbKTjmzCerJj1JlSMztZdFQCjPRV/MIRmhn4NWS+C/H44U/CsyTUcfHQTb6yHv9i0LEp5dNmYtuxs4lIInjvKqPQ5U6peGseJAkCxC3paimxf55u7BIeS3qOOkdibnwv1cnAJp94Y5z0WXIBgf/EfLQdlxPF/6v4PR5iGAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=lmrMj/8O; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="lmrMj/8O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1779677625;
	bh=bMmyvRm6TcDzRwnpCgh10phtG7R5VtbCcu2eQw3SwUI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=lmrMj/8OgQ4STRCcUb5+FNw9cDCw123aKIXmj4EHWa0wZrwUc5sfTDoAsuS32Z2OE
	 wKtSbluTnyiCWvs6y/2nSmdpZciULnZFmcav7ycMuxnwZKsPB0DPD21SEqCPR10qKD
	 bT4dAn4ZctnfXRjPGtfErN33DQHCz4jIlzcFBhxA=
X-QQ-mid: zesmtpgz6t1779677609t7974353b
X-QQ-Originating-IP: Bwc6LoIbQL6XH5MfddbBHavaRxx0ZYNt9Oh/nxVpFGc=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 25 May 2026 10:53:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5262096833021168387
EX-QQ-RecipientCnt: 4
From: Qiang Ma <maqianga@uniontech.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH v2] PCI/VPD: Disable VPD for Realtek RTL8111xP on Lenovo platforms
Date: Mon, 25 May 2026 10:53:12 +0800
Message-Id: <20260525025312.4187292-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MQPu5pFEJFN4kjgNDERQYJ4VoQu/hZaucDIB2AuQZI8xvM3KIrHqRVSn
	cLDc0S0RE3mEPRUT/21mRrFnlwAFjs2y7Ycrp+az0lkLYMdxnazPnhkQ7JT8BqDfHEttEAv
	YP4hRmuIMlipq4EuUmW1Kkp4TzR9GcqaeYdrNsu5eb77cQBseINQZ9wpFv/jShNjb8FCMfQ
	wrAqaflRsdPaWT78h08IK6h4iNHJHPt1WO8ert/uApoeVAxKL5AdQvclULthVvpR6OsAzjK
	3jW8AFDROACNIt0i5K0nNF+46UNKbYqL39bYGdYk4V/zTdcapMjJOe0nE2zpHtajqD31ZXn
	G/rul4K/iacag5HwcfbLpmJCxpQ8V9IyICcwd+Rq8xNBva1PeWlcqnfrjS7u3LgvwadA+5Z
	Q647ZuMKKrfbAcGtgM8qJ3V011Jzs7fZHbBuOTZom2h+tbBigMd4gapQeDfO/OuJiIpLlBp
	oB2Cm42SMLQaDAKpdVgPbXWJUgiuOlAGLNw/gwgEdbEgyIlgSiUf/AfCuXdcBb47F9P85ge
	zycsFVtLFwQjB8+KowInVdP6wNqGJJ+OxuQ5mCGitdMgJZPs7Ec+eztaRjLlXfhKW0JYifx
	qFPuvF6mX8ubOCexYflGptS714QzxTn3GN/WLR5su77JZ3zfS74IRUdJl/IJV3Ucejndugi
	sAI0btbO/KMq/JCkY5g+62mZIe8cGJtGZZYC32BOjQLP94TB4ftOJdALXLOzjKJv352NsA/
	9obgY7rbS1cGmj2kGuqR0b9A8AdY0T5ivjGEPITIrB2JMkpibSUmJawY3HjMT9kB0VcbJ8y
	9w+GKupTLY4QsKdPXRSpTo/XTuhWaI/S3bj2bjk/baj4KCXcdCc0SiUwukRbsE4VMzwuXTl
	/DHvwi6IQPpPXOoo+aqm1gHShlj+dc8E25BOYWkq6XBH3QlKISSDbIMsDmGcrFr5OC3Uynj
	37r3k9GsGinY3RmnT88Y3OMJ95C+uLNGascB6d0hnxMqGFHBAagHBMrfgDejbAWLZHT+VHJ
	EcsCa8fJc0+dgCPavI
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

When integrated into some Lenovo systems, the Realtek RTL8111xP
multi-function device advertises invalid VPD Capabilities. Function 0
returns an invalid first tag and functions 1-4 never complete VPD
transactions.

This produces noisy dmesg output when userspace reads the VPD sysfs
attribute, including:

  r8169 0000:02:00.0: invalid VPD tag 0x00 (size 0) at offset 0; assume missing optional EEPROM
  serial 0000:02:00.1: VPD access failed.  This is likely a firmware bug on this device.  Contact the card vendor for a firmware update

VPD is optional.  Disable VPD for this exact subsystem and revision so
the PCI core does not expose a broken VPD sysfs file that cannot be read.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 drivers/pci/vpd.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 153394a652d3..4eb307c1f07c 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -597,6 +597,33 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID, quirk_blacklist_vpd
 DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031,
 			       PCI_CLASS_BRIDGE_PCI, 8, quirk_blacklist_vpd);
 
+/*
+ * On some Lenovo platforms, the Realtek RTL8111xP multi-function device
+ * advertises VPD on all functions, but the VPD data is not usable.
+ * Function 0 returns an invalid first tag and functions 1-4 never complete
+ * VPD accesses.
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

