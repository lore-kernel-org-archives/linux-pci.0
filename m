Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A06441C2F9;
	Thu, 30 Apr 2026 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566292; cv=none; b=loe6aPOTQ1uesC+E9skZ7fhaibaW4b+DJs8J63dfGJpQ4uQH9zBfklGR2CyP0qiCsGwq0G8RKBVGakGa3UHiiojBKqlBYWW8tvipvDmgbmbeUo21fpCwPBv9w4Xm01tcELMpXoPbIAtB3DDVj+uMx+3m6/hkEoIC03jVlpGqT9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566292; c=relaxed/simple;
	bh=PWQa6kmZuv3zdHViw4antbtQC4IL6oOR4srb64P6UUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ovqyfZDf6FUB5tXzXFnsfKYVHV1VxyNaz+zZK5+XQf7k1nHC44uTtT6yV5am55zWkNIEtN7iM1ffYTAq8F9gKeA6q0wue5tKUH/Ro9MrWu1XpVN0Yi0OdGuVDsT7r8cgQidw1BOxLu5d6NUVG2b34UFZzjtZwjCmm0xSNykJSYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=POEfnhmA; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="POEfnhmA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Dn
	+bcvrZaMvrCdXQIg31n1Ub72ehyce3TBLdKzywkAM=; b=POEfnhmA4AMGUZ+cJm
	fV8fyGpwlHHRiObsq2NGgr21j9FWMQR3GSxUF6IK07djOBbc9tl6dAF3/p9sHwek
	5aqyw6tyFcZuKdqMP2VrD3sIWHnR9iAkzSRKzwmJvGrcBIXMssd0eOIK9JvrUD1K
	m4e1whB9itMXMcDjj0SqoSGZg=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAHJXM2gvNpY8PXCg--.48992S3;
	Fri, 01 May 2026 00:24:24 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	jingoohan1@gmail.com
Cc: robh@kernel.org,
	s32@nxp.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [RESEND PATCH 01/16] PCI: Use FIELD_MODIFY()
Date: Fri,  1 May 2026 00:24:05 +0800
Message-Id: <20260430162420.42839-2-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430162420.42839-1-18255117159@163.com>
References: <20260430162420.42839-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHJXM2gvNpY8PXCg--.48992S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrur17tw4fAr17Aw4rWF1UGFg_yoW3GFg_ur
	1rAr4xCrWjyr17Ca42kw18Jr9YkayxXr4kuFy0yFySyr17J34YgFykXFy8JFW5ur43JryU
	C3srWryUuryxZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_a0P7UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BgGqWnzgjhMdgAA3B

Use FIELD_MODIFY() to remove open-coded bit manipulation.
No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8f7cfcc00090..942f70f6a441 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5771,8 +5771,7 @@ int pcix_set_mmrbc(struct pci_dev *dev, int mmrbc)
 		if (v > o && (dev->bus->bus_flags & PCI_BUS_FLAGS_NO_MMRBC))
 			return -EIO;
 
-		cmd &= ~PCI_X_CMD_MAX_READ;
-		cmd |= FIELD_PREP(PCI_X_CMD_MAX_READ, v);
+		FIELD_MODIFY(PCI_X_CMD_MAX_READ, &cmd, v);
 		if (pci_write_config_word(dev, cap + PCI_X_CMD, cmd))
 			return -EIO;
 	}
-- 
2.34.1

