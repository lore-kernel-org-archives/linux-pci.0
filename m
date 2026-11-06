Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982199;
	b=4Q187nuqTG6KWB55wqFm9Dlb4YmDhue0FtdxyHMC3cNa+vFoOu2iZmUM3MvXWR1PP/SH
	 4PgDP1Khm0JGdi3TbkDkWwPEqn59VnU2+Bwtdb3dO5ckzR2HRNDJR8tPbsFmZWjesL8yL
	 Gi+8oxgKM05R1QsW8wnBGAflIFBNaB6H0QCV/SWmtBA1yuzPsBLlxRx1IotQMQTawk8IT
	 h3+nKq06+gi+LSVEx7s3BWNbTF7o8lS7JXwflEGx+8ecurelSqqx0hTkoeOowaezeagQW
	 SY4xbUSd0ffMUd8HGLFEKy9CizOkpVRGnBePbdGFMei+w2PshFoXajg7r/i4KaiuipQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982199;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=kXAOR6se/pqcsh5/GAqHm2HRrBHwlbIaTBy+HYedDXg=;
	b=OkOTkSCitHoQ/uyQep9B74y3FDqtNcFEEsZ1JWDF/EDmTaluknmlz+oTx7S7W4LI5Gdb
	 cXCxnG+pS+6pT3Ouwof9CvQKxtzIkaQJUbkUMk/Rs4hjUiB1vNRifIL8/UpNU7gglfvss
	 MpsuAKjiXnPDaez2xhEgsgtA29735WrvqMIwRjtkgcc5GuQ6FPKElIFdnkwpc9kCjpIg/
	 S3MkBuLqGbV8Hfcfru/hs/dwi/zrmmKFVJNY68lezCZRU4n5xSHBkdyo2Z1pZ5y1pxffz
	 Px2GL5tm5QtxnXR1eqCjZcTGDSupbvjsTXLx7MrNcAb80E0oJR/BWxpow3h5mD+qvRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0F0606A332;
	Fri,  6 Nov 2026 16:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C0F0606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jLkxd6KvCz57DCh;
	Sat, 07 Nov 2026 00:23:17 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6A6GN8V8011575;
	Sat, 7 Nov 2026 00:23:08 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 7 Nov 2026 00:23:12 +0800 (CST)
X-Zmail-TransId: 2afb6aedfef03a8-bb31a
X-Mailer: Zmail v1.0
Message-ID: <20261107002312620Z7lacH3F0n6uQa_ciNuzi@zte.com.cn>
In-Reply-To: <20261107002305850zuBaVsGBz3wbco2Ae4ScR@zte.com.cn>
References: 20261107002305850zuBaVsGBz3wbco2Ae4ScR@zte.com.cn
Date: Sat, 7 Nov 2026 00:23:12 +0800 (CST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Cc: <mani@kernel.org>, <kwilczynski@kernel.org>, <lpieralisi@kernel.org>,
        <kishon@kernel.org>, <Frank.Li@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDIvNV0gUENJOiBvZjogQm91bmQgbnVtX2xhbmVzIGluIG9mX3BjaV9nZXRfZXF1YWxpemF0aW9uX3ByZXNldHMoKQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A6GN8V8011575
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 07 Nov 2026 00:23:17 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEDFEF5.000/4jLkxd6KvCz57DCh

From: Shao Mingyin <shao.mingyin@zte.com.cn>

of_pci_get_equalization_presets() copies num_lanes entries into
presets->eq_presets_8gts[] and presets->eq_presets_Ngts[i][], which are
both sized MAX_NR_LANES (16).  The only in-tree caller,
dw_pcie_host_init(), passes pci->num_lanes, which comes from the
"num-lanes" DT property or from the Link Capabilities MLW field (up to 63
for PCIe r6.0), so a device advertising more than 16 lanes makes
of_property_read_*_array() write past the end of those arrays.
Return -EINVAL when num_lanes exceeds MAX_NR_LANES instead of overflowing
the output arrays.  Callers below the 16-lane limit are unaffected.

Fixes: 57a4591df709 ("PCI: of: Add of_pci_get_equalization_presets() API")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest, KASAN) with a synthetic
device-tree node carrying 32-entry "eq-presets-*" properties, passed to
of_pci_get_equalization_presets().  No PCIe controller hardware is needed:
a TEST-ONLY hook (applied to both kernels) builds the node and calls the
function once at boot with num_lanes=32.

Calling the function with num_lanes=32 copies 32 entries into the
MAX_NR_LANES (16) eq_presets output arrays:

  unpatched                            patched
  BUG: KASAN: stack-out-of-bounds      no KASAN report, ret=-EINVAL
  in of_property_read_variable_u8_     (num_lanes > 16 rejected up front)
  array, of_pci_get_equalization_
  presets+0x181, ret=0

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index a51dff91b196..85737043294e 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -1062,6 +1062,9 @@ int of_pci_get_equalization_presets(struct device *dev,
 	char name[20];
 	int ret;
 
+	if (num_lanes > MAX_NR_LANES)
+		return -EINVAL;
+
 	presets->eq_presets_8gts[0] = PCI_EQ_RESV;
 	ret = of_property_read_u16_array(dev->of_node, "eq-presets-8gts",
 					 presets->eq_presets_8gts, num_lanes);
