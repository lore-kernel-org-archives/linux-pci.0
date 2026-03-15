Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB4E371CEA;
	Sun, 15 Mar 2026 15:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773590086; cv=none; b=alPO3pnKE4kWWjVoNI3xZh/cn42Qxcc60i/qeTWibq7kjwhGQbLx/Nh5hmwPJUyl47v8w2HV8Unkj9ePmWQSggum+lTbfChDsQPk6dwrpczFG8/4zPAwwl0LWKGGclFaau+lYqeKTpF4JQUaACxAg0RVqu5aYZnVQyCFr3/fCM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773590086; c=relaxed/simple;
	bh=0WZkByzJQdTSodoO3juu9heATriCgD3UnKCrGIjpwMs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DGpa9kgpJjskXlnHjcDnGs7rx+qkirK+BS5zbFAjjaOhU9bg3utCDHy/uoJPY+fPd+an9YWLAu0Q2YicHUzHqCctQMHXHDuVi1gbHEIwpIISpJ9DSOBtoBerRUbWETyGbgfhOL3Uy+HwXw5KK6SJWEFhtvBdWhq+v3KxHzKx2kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NVi2rBtj; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NVi2rBtj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=R0
	jO5iSaQ9fsPJFaChfx8QcUVPPEtFpZ0J6+vOLDPZE=; b=NVi2rBtjVPvdWFMtz0
	ag0SkuEUwbUFc/cJjWpebf6MbXCSs0d4pjUUXzOqGLiUykIL8SzcDoa6voDDFvy3
	N4VDjwiPg8PS2EcGP9QnhwiNx0OgGhwG7GaWucd6KhEow2NBzSCiVV2JHf8f1naX
	rztqlDMTvdyYH39v7VR8mquUU=
Received: from zhb.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAnj6wS1rZpMqyrSQ--.56952S2;
	Sun, 15 Mar 2026 23:53:56 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	hans.zhang@cixtech.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH] PCI: sky1: Use boolean true for is_rc field
Date: Sun, 15 Mar 2026 23:53:51 +0800
Message-Id: <20260315155351.127078-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAnj6wS1rZpMqyrSQ--.56952S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw4UtFW7Wr48tw4kXw18Krg_yoWDJrb_uw
	1kWF4Iyr4ag34Sk3WayrWrAr9FyayS93Wagan3tF1xZFyfWr18ZFykZryDAa4DWF4rJFW5
	Zw1qv3WxC3srJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRM0PfDUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xTCZmm21hS2qwAA3b

The is_rc field in struct cdns_pcie is of type bool. Replace the
integer assignment (1) with the boolean literal true to improve
code clarity and maintain consistency with the type definition.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/cadence/pci-sky1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pci-sky1.c b/drivers/pci/controller/cadence/pci-sky1.c
index d8c216dc120d..f327480c8615 100644
--- a/drivers/pci/controller/cadence/pci-sky1.c
+++ b/drivers/pci/controller/cadence/pci-sky1.c
@@ -173,7 +173,7 @@ static int sky1_pcie_probe(struct platform_device *pdev)
 	cdns_pcie->ops = &sky1_pcie_ops;
 	cdns_pcie->reg_base = pcie->reg_base;
 	cdns_pcie->msg_res = pcie->msg_res;
-	cdns_pcie->is_rc = 1;
+	cdns_pcie->is_rc = true;
 
 	reg_off = devm_kzalloc(dev, sizeof(*reg_off), GFP_KERNEL);
 	if (!reg_off)
-- 
2.34.1

