Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73FE3FF1AD;
	Fri, 15 May 2026 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859435; cv=none; b=M8ABdh5Cz0EM2Ceg+uzHqeDY5in3iwFDPraDOX7YjF8heh4EGtbS9j7NV+6TIhBefnYnG8/kvoASnv3+VE24dYynOcg0C0VDuRlG1/OIerGPbRpxbg23ZIXh8UU5ueva+UqwHtqjwCHJTgs3wNGcXOHDBrZeShgdjpCVuwGDkgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859435; c=relaxed/simple;
	bh=37AK71DnSW7gmjuvw3SFklOkeJjHxFEWy+miqk91bGY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S0dkB0Aqjp3InxdeWPz8aeI869tZADCcLKWekNs5U3GmDKWPsKixAEEACekoFANDrDrs4QiOXF0kXFME4h84gjkzKSfKLe+oJipMg3xOh7uNg4wT2M1oxaqv/yJ7FDVdX7UmPs9zYlH0OVUPr+pKjrn4q3MFy8STNS9+nlq15Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cU5rJ3oP; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cU5rJ3oP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=yZ
	EM/z3Ytg1ApbnIMKeC+6PyJ3FnTIOMTbeYSCB5PQ8=; b=cU5rJ3oPOgHfFuqlgX
	40zx1/2+mkM6jI8DwNUPNtit/9LDtzbGN5MBdiKovRnBvnV4hk6yU2T2ibi1rFTX
	mHTVRyAxFD1189z5trF+8aLY04TNOmHUQDSj+cTfL/UelGm468K4t803PEg7i6nN
	JBLWMp53LDkoUIk/shqRhY/xY=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3z9KEPQdqL74mBg--.53735S2;
	Fri, 15 May 2026 23:36:37 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	mani@kernel.org
Cc: ryder.lee@mediatek.com,
	linux-mediatek@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH] MAINTAINERS: Remove invalid email for Jianjun Wang
Date: Fri, 15 May 2026 23:36:35 +0800
Message-Id: <20260515153635.136054-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3z9KEPQdqL74mBg--.53735S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF1fCFyfJrW3ZrykZr13Arb_yoW8Xw17p3
	93Krn5ArWDJr47JF48Wa13t3WfX3yvgFyUKwsFg340qr15Zrn0qa40934Ut3ykCry8C34Y
	yryIgr1kuFyUAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_xR6UUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxAXMcGoHPYW3OQAA3m

Email to Jianjun Wang <jianjun.wang@mediatek.com> bounces with error:
"550 Relaying mail to jianjun.wang@mediatek.com is not allowed".
Remove the address to avoid sending future kernel maintenance queries
to an unreachable destination.

The MediaTek PCIe driver remains supported by Ryder Lee.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Hi Bjorn and Mani,

Recently, when replying to emails in the Linux community, I kept
encountering that Jianjun Wang's emails were being returned. The
detailed information is as follows:

"""
Dear user 18255117159@163.com:
Sorry to inform you that your email (send to jianjun.wang@mediatek.com) has been returned. The details are as follows: 

 ------- Original Mail Information -------
Time:2026-05-15 23:04:39
Subject:Re: [PATCH v2 6/8] PCI: aardvark: Add 100 ms delay after link training
To:jianjun.wang@mediatek.com
Relpy Code:
SMTP error, RCPT TO: Host mediatek.com(1.203.163.78) RCPT TO said 550 Relaying mail to jianjun.wang@mediatek.com is not allowed 
"""
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6aa3fe2ee1bb..b2609dc33c62 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20745,7 +20745,6 @@ F:	drivers/pci/controller/dwc/pcie-intel-gw.c
 
 PCIE DRIVER FOR MEDIATEK
 M:	Ryder Lee <ryder.lee@mediatek.com>
-M:	Jianjun Wang <jianjun.wang@mediatek.com>
 L:	linux-pci@vger.kernel.org
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
-- 
2.34.1

