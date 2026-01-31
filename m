Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0FB25B31D
	for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2026 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769824827; cv=none; b=vAcW3DnIxAm1mLnIC5XipgvU9VGvHP33sry7ZfhVSTK+v09qmsgM3V0GO2AWKsKdhYphQXLaelikIZrXWvk7C3Ca3cMB3xol55HiJ8Cc75CKZc815k5zJQOHf6FsmDMQuT8FJA9q4Edk17y7m2BsAC/anx/xFjlHQzhgZIu/LAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769824827; c=relaxed/simple;
	bh=9ZqB83FAbd1Adsme0MGZf1r4FtbsU6hXRh/jnbCOxcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YqGQ+TJt2nWHo5QqMuuJxzAuu7kjYseGMJEWH/tpsM+x4ADNLfG+TKlC58aF9VRZPhEk2wQUy6rFk7iV1BMi3P3nJdfzmRslOSV/DzzkWOxKJi5Ncm28lOybFFCYodGbVhgxbBKxSkDX4OCXVIMrjGjLKODTscDSRChz42Heowc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5/kyFy7; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5/kyFy7"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2b6b0500e06so4156174eec.1
        for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 18:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769824825; x=1770429625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mp49pu/98jCz79VjR9BIlt5YZaMqC2vyb84mYb0vpSA=;
        b=U5/kyFy7JUw5CR+NOezwdsi1TmRWXt2cA8pS4yH7U/dVnFPV/1inZbkBpOsu2Oxik+
         Z0ent84Q9cPp0hgH/6kBoFH2xawgsS4ksle+Xqt5ZILmyU6QVpRZ63VklBnb6t070s2/
         0yrU/8U/tmK5k3hEciloDMiZjIAlqdMLE+wPQ0QrBsYiO6ruRcvRJC2BRPofSIvNRxzW
         N/yuB1P788521haQNLGv6XZIVFO4X9MZyDila2WP2iC6Pv8lL9NIietVYfEwTzWhpr9n
         Qpkusngb40BnrUcUMdePkWzSz6vpCNIk9GfUeyp73EeM0k1g+daUDFNf12kflPx2afOr
         enQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769824825; x=1770429625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mp49pu/98jCz79VjR9BIlt5YZaMqC2vyb84mYb0vpSA=;
        b=LMyO16Ep2rLKLjnbFkf71eU4sLGe0khnVQMaTtWOWYWFyJjg5jMfBv/QMn11FiUd7H
         TUpUeqKJn+kU0iNf3u9k5ezFnyE9JlwtGBOq3Xn+uey0bcw7w1xUlbwfKJdG7AfHKF8k
         usmVauP7vMDyMJUQuQMDxd4pg/bpYMKoBbX/j0lgeM+hK0yzmJyoFrIXN2+QxGBPYGnb
         4aQKaqyqjAwRAdVpdg1WQ8LZ78g64MBahVdtfKn3kVuZKVZ08BBeaNDAGZgitw+oK69G
         kG//SXplYnbAEADuLkAeFU2Uw+1U8BB2nZo3kGjXyMeRiXCWrYQgkGDBLPBRRQtdISSi
         vdHA==
X-Forwarded-Encrypted: i=1; AJvYcCUTC4J/2d16ksVo4WcSjdeU2yvW5WVNPpALb4dDqWcYMkkxw903kc3nxop45Tk7nd2peiQpCTR2Q90=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZB00l+IdOIBtOQBUiHSmDet/XqybpNZL6GmaE3VjnQTmDfEzh
	HBwxNXq0s8t1DdS71A5Qcndrj+A5A4zCJ4AH48E1xcy3Kvhrw9Bk+Xdp
X-Gm-Gg: AZuq6aKz4yb0SKSPp5+R5QV5GAKlNxD2jqd/Nc1osUtIFPVT7i6MrWdK8E2GOHZxKzd
	sbg/S7cP2ypRFmlnNt82KPrjFkflOTl2LSszaGTQWcCa9XDd2H2OmtjgV97O3p4lzBlQNXIOdcS
	0ctkE+iKyLEXLbY0wJSUefQLWlAYxDgDMKR01Aewfw0/onDD9M/PVWdsWv5KqAL7682NgP9xH/m
	fzzRWNo4wqqIGbbISvK+WuaPRwIxDCmQ3YRXLvRkklnW5E4mmwCHex1I4lUy54QvQbuA3Hz3uUw
	OU9j3Ye2xsEDnU3UmzuaqA/ASQ+6sXn+m4ymuS67RBQvYJFSURWgM63t0CBPuJx+O32QawU1oi/
	NUJfccJrG0XrZOkTruLOwAqK9Giw3XpsNQZ5CDshU0xa4qJ235c0j3wdbyU3ABtqleVqTlDouoo
	rBJAELC/UMuyc5zIqVblkp75bJ3EEos3X26JDmlUOB427M2lkzQQGX6rz8WN/8HJmXLG2agl3iB
	J69tdY0OlmC/SSNKG6XN96Ty6FHsLgMr01nbMS4bUWEEjxbWGXPZKs3z09OQ7fHMXJml4/i0p8V
	5Woz
X-Received: by 2002:a05:693c:3944:b0:2b7:a4b8:6a00 with SMTP id 5a478bee46e88-2b7c88d8a1fmr2538493eec.21.1769824824911;
        Fri, 30 Jan 2026 18:00:24 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a17083dasm16754140eec.14.2026.01.30.18.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 18:00:24 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] pci: pci-hyperv-intf: remove unnecessary module_init/exit functions
Date: Fri, 30 Jan 2026 18:00:17 -0800
Message-ID: <20260131020017.45712-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pci-hyperv-intf driver has unnecessary empty module_init and
module_exit functions. Remove them. Note that if a module_init function
exists, a module_exit function must also exist; otherwise, the module
cannot be unloaded.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/pci/controller/pci-hyperv-intf.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv-intf.c b/drivers/pci/controller/pci-hyperv-intf.c
index 28b3e93d31c0..18acbda867f0 100644
--- a/drivers/pci/controller/pci-hyperv-intf.c
+++ b/drivers/pci/controller/pci-hyperv-intf.c
@@ -52,17 +52,5 @@ int hyperv_reg_block_invalidate(struct pci_dev *dev, void *context,
 }
 EXPORT_SYMBOL_GPL(hyperv_reg_block_invalidate);
 
-static void __exit exit_hv_pci_intf(void)
-{
-}
-
-static int __init init_hv_pci_intf(void)
-{
-	return 0;
-}
-
-module_init(init_hv_pci_intf);
-module_exit(exit_hv_pci_intf);
-
 MODULE_DESCRIPTION("Hyper-V PCI Interface");
 MODULE_LICENSE("GPL v2");
-- 
2.43.0

