Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622316;
	b=EFQC50ac1KoY+vVaiSvxcTAfgZzZ09f2RG5NyIVHa23iGZHRAJIcpkYWAnpbxNLOrTpM
	 4yqANI11EPdC6Fxyz4WvXaYyX1/Neolhi02LwkVAbsxVByqW7eB/wSji2t6FKN74zY5aX
	 vWPBIFTHqIAb55yOUoM7lr348YR3mH2Hpxqk2y1EbesFgAtSCTRZ9H9IiuqUbKHtZD22n
	 nYleLUVGtKhz+luMKJ/vhALRx7+m2hGqiUvdACQLnaUY1qPh32EDoCSjoeptTNIdZ2dsb
	 g7f/h5rVomSPe0kLwpDGKy9m9smO+//eAgJ9Zl8Fhx6fdO+5bPJsac4EGCD5jz0em5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622316;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BldQONQu8Khpnz8c0z8F/NImC/I493A1NgkX8+AwsPY=;
	b=28Bja6MpdKbw+oNofL6xhAG7niTOgKE+FDyvQG5fdQw1v+m9nzacu++gHMMqfYuTcTAn
	 1SppO9vxDkmzBXWzneKsI7MzomDTbAQpcfQbahzciuv6ONiskLldMW+8a0ZG3mQf3KhG6
	 a5cNFsRMeU35tQZgXN42xmVPr8AVsrmzjO8Cgz+UM2a/uaYhyMk0JdEBDl7O8wya8g8rq
	 35jjfgnZispO3ww3kpBO75qDVuZk8xsBOnZSis1XW0szoyesL5wxJG2eDsrcQ2tFr6aSa
	 zGiOs/GDpYRWfXa/H49bpTYNgKWj+MLTIv7Jtnc9YVDzPuyFQzIVbMJmmhFIZTNuR8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=chxQAQZT;
	arc=none smtp.remote-ip=115.124.30.132
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A9F60A2606;
	Wed, 25 Nov 2026 15:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72A9F60A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=chxQAQZT
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795622311; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=BldQONQu8Khpnz8c0z8F/NImC/I493A1NgkX8+AwsPY=;
	b=chxQAQZTUIt3YocTp1r2kQupuy/gnqP4wy4X7Oc0W4pvJgyxH99YjxLdH3zP4BYA3s8taShQfSoqLGDVPaV+QietFFDv0+WS2XiM15wXtrTNaBcXj0/SP08q4dhAtoJ09vlFrBkE/rmVezpCZYXnDb5QpycC/Z6MwnUSFIo0V9I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=feng.tang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0XFS3Ez._1795622310;
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0XFS3Ez._1795622310 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Nov 2026 23:58:30 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Anju Zheng <zaj01616726@alibaba-inc.com>
Subject: [PATCH RFC] PCI: Add warning about possible danger for pcie_bus_perf mode
Date: Wed, 25 Nov 2026 23:58:29 +0800
Message-Id: <20261125155829.77269-1-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

During stability test, there was a bug that running 'mount' on a type
of commercial NVME disk failed on an arm64 server and raised PCIe RAS
error and panic the kernel later, when using "pci=pcie_bus_perf" kernel
cmdline parameter.

The NVME device has MPS(Max Payload Size) capability of 256 bytes while
its corresponding root port is capable of 512 bytes. When enabling
PCIE_BUS_PERFORMANCE mode, its MPS and MRRS(Max Read Request Size) are
both set to 256, while the root port's are both set to 512. But the
NVME device doesn't comply with PCIe spec (v6.3), Section 7.5.3.4:

"
Max_Read_Request_Size - This field sets the maximum Read Request size
for the Function as a Requester. The Function must not generate Read
Requests with a size exceeding the set value
"

that it sends out Memory Read request with length of 512 bytes, and
when root port replies CplD packet with 512 bytes payload which exceeds
device's MPS, PCIe RAS error is issued.

The problem can be reproduced on some arm64 server and Intel server.

This caused some data damage, and there were quite a few NVME cards of
the same type damaged (though we are not sure these are directly related).

In this case, the kernel is innocent as it does make sure a device's MRRS
setting is no larger than its MPS setting, while the device breaks PCIe
spec. It could still be meaningful to warn about the possible danger.

Reported-by: Anju Zheng <zaj01616726@alibaba-inc.com>
Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
 include/linux/pci.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index d31a8d107b1e..e115aa2e962a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1192,6 +1192,18 @@ static inline int pci_has_flag(int flag) { return pci_flags & flag; }
 
 void pcie_bus_configure_settings(struct pci_bus *bus);
 
+/*
+ * Note: For PCIE_BUS_PERFORMANCE mode, it could be dangerous for a device
+ * that doesn't completely comply with PCIe spec about MPS and MRRS setting,
+ * as it allows the device and its corresponding root port to have different
+ * MPS settings.
+ *
+ * Kernel already makes sure a device's MRRS setting is no larger than its
+ * MPS setting. But there is real world case that some commercial NVME device
+ * sends out Memory Read request with length bigger than its MRRS (equals to
+ * its MPS),  and root port replies CplD packet with that bigger length, which
+ * triggers RAS/MCE errors on arm64 and x86 servers, causing data damage.
+ */
 enum pcie_bus_config_types {
 	PCIE_BUS_TUNE_OFF,	/* Don't touch MPS at all */
 	PCIE_BUS_DEFAULT,	/* Ensure MPS matches upstream bridge */
-- 
2.39.5 (Apple Git-154)

