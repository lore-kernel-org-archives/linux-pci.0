Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736E12E738D
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784907968; cv=none; b=oma8idlJw0qQeF/s+f7eb9XvZmcXMu+uvKR463Oa07Cmgg1vF/pUax4JI3MaXAIaQP70zIDJjFWNX8JcQAOK30Z3Q1CQ1cxMhDw9rSU6NhPFgHHplhh/2Xz3aoWqjvtJofK1fNoJSN4T/ck44T8EmTHmHm7VNF5fNxeoOpXAd+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784907968; c=relaxed/simple;
	bh=xg2fOM17p5UKoNPPdC7YofqahE+aPct91H9G3nVAEbI=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=YDfKjMrQa3r7KVnnyNEslGYx37VLH+kk+aR/XqyYyQ57nyLig1BP7yiZ+0nMccF51v2V991VF+Pv0OAz/yct9wsFOAaafiI4ntTit6t5opW6VvovWGvrN5Oj6NzvuoOe33s1bLTszkY+is6cD16UPLRP6/ef7hatJcXvJPe1QJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 4443935E;
	Fri, 24 Jul 2026 17:46:04 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3381D60CF04D; Fri, 24 Jul 2026 17:46:04 +0200 (CEST)
Message-ID: <3a5d1624d6912db1bc8c4e89e7a6a72ac510f4dc.1784905909.git.lukas@wunner.de>
In-Reply-To: <cover.1784905909.git.lukas@wunner.de>
References: <cover.1784905909.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 24 Jul 2026 17:24:03 +0200
Subject: [PATCH 3/6] PCI/AER: Deduplicate logging of Error Source
 Identification
To: Bjorn Helgaas <helgaas@kernel.org>, Yury Murashka <yurypm@arista.com>, "Matthew W Carlis" <mattc@purestorage.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>, Qingshun Wang <qingshun.wang@linux.intel.com>, Yicong Yang <yang.yicong@picoheart.com>, dio.sun@enflame-tech.com, linux-pci@vger.kernel.org
Cc: "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Terry Bowman <terry.bowman@amd.com>. Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Arjun Govindjee <agovindjee@purestorage.com>, Ashish Karkare <ashishk@purestorage.com>, Jasjeet Rangi <jrangi@purestorage.com>, Meeta Saggi <msaggi@purestorage.com>, rhan@purestorage.com, sconnor@purestorage.com, an.luo@enflame-tech.com, fernando.hu@enflame-tech.com, bill.wu@enflame-tech.com, xin.wang@enflame-tech.com
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

aer_print_source() already logs the Error Source Identification Register:

  AER: Multiple Correctable error message received from 0000:b7:02.0

However aer_print_error() subsequently identifies the Error Source once
more by emitting an "Error of this Agent is reported first" message.

The additional message was introduced by commit 0d465f23502e ("PCI: pcie,
aer: fix report of multiple errors") because it deemed the message emitted
by aer_print_source() confusing:  When the Multiple ERR_COR Received or
Multiple ERR_FATAL/NONFATAL Received bit in the Root Error Status Register
is set, it doesn't mean that all errors originated from the device in the
Error Source Identification Register.  Rather, the errors may have come
from multiple distinct devices.  The commit sought to make that clearer.

Achieve the commit's objective by rephrasing the message emitted by
aer_print_source() and drop the additional message logged by
aer_print_error() to reduce dmesg noisiness and simplify the code.

While modifying the log message anyway, fix minor grammatical issues:
Append a plural "s" to "message", add a missing closing brace to "(no
details found" and capitalize "Error" to match the spec.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pcie/aer.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 9cdac1c8c52e..c21139b9079b 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -875,12 +875,13 @@ static void aer_print_source(struct pci_dev *dev, struct aer_err_info *info,
 {
 	u16 source = info->id;
 
-	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d%s\n",
+	pci_info(dev, "%s%s Error message%s from %04x:%02x:%02x.%d%s\n",
 		 info->multi_error_valid ? "Multiple " : "",
 		 aer_error_severity_string[info->severity],
+		 info->multi_error_valid ? "s received, first one" : " received",
 		 pci_domain_nr(dev->bus), PCI_BUS_NUM(source),
 		 PCI_SLOT(source), PCI_FUNC(source),
-		 found ? "" : " (no details found");
+		 found ? "" : " (no details found)");
 }
 
 void aer_print_error(struct aer_err_info *info, int i)
@@ -888,13 +889,11 @@ void aer_print_error(struct aer_err_info *info, int i)
 	struct pci_dev *dev;
 	const char *level = info->level;
 	const char *bus_type = aer_err_bus(info);
-	int id;
 
 	if (WARN_ON_ONCE(i >= AER_MAX_MULTI_ERR_DEVICES))
 		return;
 
 	dev = info->dev[i];
-	id = pci_dev_id(dev);
 
 	pci_dev_aer_stats_incr(dev, info);
 	trace_aer_event(pci_name(dev), (info->status & ~info->mask),
@@ -906,7 +905,7 @@ void aer_print_error(struct aer_err_info *info, int i)
 	if (!info->status) {
 		pci_err(dev, "%s Bus Error: severity=%s (Inaccessible)\n",
 			bus_type, aer_error_severity_string[info->severity]);
-		goto out;
+		return;
 	}
 
 	aer_printk(level, dev, "%s Bus Error: severity=%s\n",
@@ -919,10 +918,6 @@ void aer_print_error(struct aer_err_info *info, int i)
 
 	if (info->tlp_header_valid)
 		pcie_print_tlp_log(dev, &info->tlp, level, dev_fmt("  "));
-
-out:
-	if (info->id && info->error_dev_num > 1 && info->id == id)
-		pci_err(dev, "  Error of this Agent is reported first\n");
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
-- 
2.53.0

