Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059AF44BCAA;
	Thu, 30 Apr 2026 16:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777565631; cv=none; b=D8BJXWsicwa1WTXnvx0jZifcCdlTYfcNTlKAjluITntup35L0ooJGV8np2Dj+XZB7GQllOWLCSmLV6vMQ5d0Jc0l/NGyv4rEhCQ0UXcLill3pWZ0xGcNxOaWEm18ulx4CEu6VhPxa3gPyoAL+CAC0HWnq7ICdvPZ8BcxdOWlNDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777565631; c=relaxed/simple;
	bh=PWQa6kmZuv3zdHViw4antbtQC4IL6oOR4srb64P6UUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c0e7OZPlxPPoLaSwMjwvRiLppJr94zq0G5XDTaaoYLaoHRdOrQJ/T1myTyG19DgPoccVHjikO1EQpHHZyjeYynrPC1C9sgeKpooboolPkYcZWhPJGpYz9dPmXvTTeNLi+hYIvC9Vp/Et+0l0OBqHHQNUYPoCujOBmjicX1sULW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qRoA8vKh; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qRoA8vKh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Dn
	+bcvrZaMvrCdXQIg31n1Ub72ehyce3TBLdKzywkAM=; b=qRoA8vKhnpFU0xUWHG
	x0K+PRWCwbHkTbjf9+Ht/oyw4Yj4dkXr69FDMnNMSnTISAVipXge6TcnI9CUonvN
	rZD2WXrMKCNANOd/Mu8KRWu28JMAOzUh1pabwDFsC7tm6LdxoFtJjS/egX43vTIe
	Jx4zyzkAvOee1zTRMkIQ6Xpls=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnbymkf_NpTNe+Cg--.31297S3;
	Fri, 01 May 2026 00:13:25 +0800 (CST)
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
Subject: [PATCH 01/16] PCI: Use FIELD_MODIFY()
Date: Fri,  1 May 2026 00:12:39 +0800
Message-Id: <20260430161254.40278-2-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430161254.40278-1-18255117159@163.com>
References: <20260430161254.40278-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnbymkf_NpTNe+Cg--.31297S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrur17tw4fAr17Aw4rWF1UGFg_yoW3GFg_ur
	1rAr4xCrWjyr17Ca42kw18Jr9YkayxXr4kuFy0yFySyr17J34YgFykXFy8JFW5ur43JryU
	C3srWryUuryxZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_5rcDUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AZgBGnzf6bzpAAA3a

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

