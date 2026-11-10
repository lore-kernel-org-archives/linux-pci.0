Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794305410;
	b=fGfpV/SfxrG901CL1mkLCINm0AJhiiN+20UucDXS7SUIDkROzV5cBs5q1NQoYctZO6PQ
	 PihCS7O5C9WA+blI0VlOyHUa5WE5WfD7+SG/zxp3zkNsZ9IDIgMCcLOkcoyw0TWz1GgJ+
	 3wkRX6uacfgvCe87uXwajYq+bGa2u0uA/bWbBP1qHyiS80daawsUrDhLdfXHJi7kt3WRe
	 iIMLCNaeoyQ0/90Nhg3DfWwTd+7qdYGOhEyVVoTafKNSlRQ3PWehb9hnxiiR4rG8lbuQ5
	 /q87QsmbdfLvL9utOF/2az445d8s6rszV3MZPJvST5hQXK5ptIOdlVIsrXK6iuRoiYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305410;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=p0b4HYMjqgMZb222DZNYKa+IKVop6pKB2asojuDpXTg=;
	b=CiiSoQXsu+ZXv2FzLuUwoHJtSuLYqH3yFkMZB8iVtsmPFhd0EeQPfMia7g4bQUyWdWNM
	 ipVWQGR+epDR35JJIB8dXhnXcWzaS3dwhdJhjEw4k5wByXCYtS/OjBXiwt2pkXmArmQuu
	 RQI6+9NiTeJAikPUIozmckefhSbjteM6TsRvnzyS8nmfzbKiOe4ktTkpcEdPh56oj/nLm
	 Kt3PncZ8cBNV0nxQoWV+6kaCKOQ27+NeBw5vYyCYUzsxI0UjlDguv3ps3C3CrrLnLFlRX
	 jfLC+kS7wB4F3Ima+94lhjfdnxWJzPxI1AU2JtPYd00oiEKgycdm2wz9Bs+cVhLp3hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=LK8zMZr0;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5D2606A335;
	Tue, 10 Nov 2026 10:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF5D2606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=LK8zMZr0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=LK8zMZr0XH3fzL01T74alwSck9G456YEc/RkYQ8QaHpilcTzVi66bOHmb3yWrhRmWsHMpTAnmIKIz
	 Zd1uQqP17pnAM4AaeLWKFDgoPZqZlR4hDGbRoKt/0jiyX0ehQZVnlIbZHMthGLj6Tbc2qGEb/Yijuh
	 57eMwoM2oJxpPL5U=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56af2ed778fb-cbe74;
	Tue, 10 Nov 2026 18:09:59 +0800 (CST)
X-RM-TRANSID:2ee56af2ed778fb-cbe74
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46af2ed74c04-b1a93;
	Tue, 10 Nov 2026 18:09:59 +0800 (CST)
X-RM-TRANSID:2ee46af2ed74c04-b1a93
From: zhaofeng2 <zhaofeng2@cmss.chinamobile.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Zhao Feng <zhaofeng2@cmss.chinamobile.com>,
	linux-pci@vger.kernel.org,
	Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] PCI: keystone: Fix device node leak in ks_pcie_am654_set_mode()
Date: Tue, 10 Nov 2026 18:09:54 +0800
Message-ID: <20261110100955.1046-4-zhaofeng2@cmss.chinamobile.com>
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

ks_pcie_am654_set_mode() resolves the "ti,syscon-pcie-mode" phandle
with of_parse_phandle_with_fixed_args() to obtain the mode register
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
@@ -1059,8 +1059,10 @@
 
 	/* Do not error out to maintain old DT compatibility */
 	ret = of_parse_phandle_with_fixed_args(np, "ti,syscon-pcie-mode", 1, 0, &args);
-	if (!ret)
+	if (!ret) {
 		offset = args.args[0];
+		of_node_put(args.np);
+	}
 
 	mask = AM654_PCIE_DEV_TYPE_MASK;
 


