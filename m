Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9642B25EF9C;
	Fri,  8 May 2026 02:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778207442; cv=none; b=Xqfn0ezz6wA3kcBlJ7hTVc9ap8XyG/fSycTuCvCvUSxwYlJQzkGH6sTZcmwgrQTgQDxIiJCTl/NfNj0c8xd692Qkjs1N+tW6oLSL/foABXd3hJYefIkNFe7nplnQ88lslwIbFcmFNGCA+zftBRnUY4ZWfUodKeUebTnMXyass8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778207442; c=relaxed/simple;
	bh=WC6LMQRZutvMp4+rOz/rxA5nw2k6m36AhCkbgWF7FNE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cftbHZ3OghOdqqvyoM8B8gcql3VkZHTuF/rMquw0PNvYTPLizX7eeL/f2JVwIWH8X8b9fPbDexbrix2OCA4DOnfHTTkbZVvbee8cMTVUyj8YV+Dou4YeOesUII9EtFZc29y6bKcR8XkoI+oFYdpGU9MX9bcHiG3KaujRn4oWP/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EtQG+plS; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EtQG+plS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=7B
	5YmdhsPTr9kgveNaOVT76xotG1xNZ/FdtGkSa6Rlo=; b=EtQG+plSqJkqR5gQQ0
	G3Ibev+t65HFhxf2QWo3WCoWv4oV20FiVry4sboXG3/EVVC1wSwDDWRZ2dYrjh65
	chXsMbj8plBsh5kCYMqmeC/VDhHtguSgSa0ZdDkJCAa6pf+6KD/htrTMH/e1EUQ8
	KvU5FwsJripaDfVcz9yebbh8Y=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDXX7OwSv1pzzt3AA--.21205S2;
	Fri, 08 May 2026 10:30:09 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	mani@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH] MAINTAINERS: update Hans Zhang's email address
Date: Fri,  8 May 2026 10:30:06 +0800
Message-Id: <20260508023006.1787674-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXX7OwSv1pzzt3AA--.21205S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZr4fZr1rXr1ktFWUWryxuFg_yoWxZFb_ua
	1xXFWxXrW5CF9aka1FkFZ2qr1avw4xGrs3uasxt3ZrA3yUJryUKF9Ykw1Yk3W5Cr4fWr17
	X3s3tFykKF1aqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRR1CJ7UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwxGYPGn9SrFingAA3l

Update my email address as my work email account is no longer in use.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 882214b0e7db..288f9e3a735c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20354,7 +20354,7 @@ F:	Documentation/devicetree/bindings/pci/cdns,*
 F:	drivers/pci/controller/cadence/*cadence*
 
 PCI DRIVER FOR CIX Sky1
-M:	Hans Zhang <hans.zhang@cixtech.com>
+M:	Hans Zhang <18255117159@163.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/cix,sky1-pcie-*.yaml
-- 
2.34.1

