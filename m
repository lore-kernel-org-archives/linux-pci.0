Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794305408;
	b=ErLcUaDxzWyY138vQZERYbg/JQr5v0lLm3kLvqaQjJ3WIabWrcKVSG+3eDJ6vzHqKFdG
	 E1Y/r9Xc53WIsg9eeqvelbeByhHkP7f4oMRWTxkyZRm/mFM6uoJMlccRNaGbr6lGQ3VOv
	 vVUWC10ym5leQdlK/Y2+4h2ZjFossoP/Y7iuCG2sYsT9IAYwgYIV267zKE1IbaRjIt6f7
	 VVnu+qv3v03ni1G8Wk5cFColuek24oDKVLE7Vn5l9mfEdQRysyJL0DJVpVlZAMzd8ZpNe
	 8rE0R8ZUWmS0ua0/VeS9fvGWKfU85G3lF4U8XxNHh1j1s2sGZnfNaAvrwJijJ5RqT7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305408;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=T6mSc4xP4/GI3fNHx41iiNfcLoi2dRiPvJIIFv07GyM=;
	b=jvANotpmC1m+7Sxv5pYb4PFz3TBX+QG5doTShcFd1ur6il7ICjOK85QMNTUYGTnobuvb
	 GvzWd2nzGmBjasDEi80roFk4ATS7B4cnLduTjuVktAX5l30LrVUnUxX5fhC4gBps7ayb3
	 0XsNWtgcPAiMqRnZftKQuhC8x7TD07F3iHqmfynL3JjRbo0fIccTbFjnrMB4Gka1EiveO
	 Pu5Zno494xpIB22Tf3RM99jMfYWglJTHvZHxw8fMx2Ldi7eHhdkiuPu9rVdAIjQ/gt/QC
	 g8bsVt7kNidKyi5TjW+4ilfIXdwL3MzHCgh1opIw2EtuumJiJmEGlnm6SUUnfVqn5wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=EIujV3JT;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDCC606A333;
	Tue, 10 Nov 2026 10:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CDCC606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=EIujV3JT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=EIujV3JTkca10Ug3aUmNCInR8qh8vlz4eK+fbYepe2BPsz0e4eaYoDJBE6gsF5tLtILsR5QpVbdpC
	 6o3Asfh/N/V5BKDePctZXnVWOb7KD3Z8VgIBR9lJWBK/mK17YclTW3vQEfI1KPqC5uLLF2CygyYyY/
	 YN5q2gdHb0n4zTFM=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86af2ed6e518-6e616;
	Tue, 10 Nov 2026 18:09:58 +0800 (CST)
X-RM-TRANSID:2ee86af2ed6e518-6e616
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46af2ed74c04-b1a8e;
	Tue, 10 Nov 2026 18:09:58 +0800 (CST)
X-RM-TRANSID:2ee46af2ed74c04-b1a8e
From: zhaofeng2 <zhaofeng2@cmss.chinamobile.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Zhao Feng <zhaofeng2@cmss.chinamobile.com>,
	linux-pci@vger.kernel.org,
	Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] PCI: keystone: Fix device node leak in ks_pcie_init_id()
Date: Tue, 10 Nov 2026 18:09:52 +0800
Message-ID: <20261110100955.1046-2-zhaofeng2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261110100955.1046-1-zhaofeng2@cmss.chinamobile.com>
References: <20261110100955.1046-1-zhaofeng2@cmss.chinamobile.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>

ks_pcie_init_id() resolves the "ti,syscon-pcie-id" phandle with
of_parse_phandle_with_fixed_args() to obtain the device-id register
offset, which takes a reference on the syscon device node, but the
reference is never dropped after the offset has been read from
args.args[0], so the syscon node is leaked on every probe.

Drop the reference with of_node_put() once the offset argument has
been consumed.

Fixes: 7dcf07ac8867 ("PCI: keystone: Use phandle argument from "ti,syscon-pcie-id"/"ti,syscon-pcie-mode"")
Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -795,8 +795,10 @@
 
 	/* Do not error out to maintain old DT compatibility */
 	ret = of_parse_phandle_with_fixed_args(np, "ti,syscon-pcie-id", 1, 0, &args);
-	if (!ret)
+	if (!ret) {
 		offset = args.args[0];
+		of_node_put(args.np);
+	}
 
 	ret = regmap_read(devctrl_regs, offset, &id);
 	if (ret)


