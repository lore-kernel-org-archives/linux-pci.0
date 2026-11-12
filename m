Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450291;
	b=2VOEhQt/tmWtl4UhxzXUPsYG9KOp4OiZHGEG1v2YZEIvDX3zZILv69WIEHwNk6OFhVNv
	 OVUiC7MX2wmruU3M6X7vS8tZTGN8IkdOB03RUwGLyeGmy1/DQNwBf4+8HRmU+WSaVG2Cr
	 wXJ2ZunzwGdy7rsFoxz+QdRyrvoAGUE0Bpzm/U5nyZ91qOpPpGErgDb9DVCV0jwI8LADH
	 AQAFLg9emiRED3+SNWnhuL96igKXNEMuO9rzLmm9nVPjY7OAqU1Bm7/3XFFDU3B1cZOTP
	 bdIg6nahklfZbpMJkgQDtmb6ukHoQ6+bhYDerUtOpM/qlv2DxLpiF0RG4cKaEWD9fxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450291;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=B75XeCji0Hq4KB2ucqYdo8KpN0Fb8I/YrmcRagsu6Ms=;
	b=Kyr1P3RQmaq+1D/gphAxfM10dd4P0CyVSXQU8msNW32AwvmoAvuHlurbmPYCtzIPZny3
	 dbnrQtoUg7rnXpar2SkOC/TnPwe0JDJ1RQS/Kk2KWq2RDi7KDwRVes4qJmc6zPdphB60V
	 KrhSsbEiDGaoN9jDrxsx4nLfF4EzKNpsTeSFjRZJNkbIkfXqMDM+OFO6y26rKRJaRnlWx
	 kE0EKCtwjiKSfkQd9tdQdawFkJG+ZgzeKktjKTNydxDW5jurv/WinOPythBHSkX/X3zLc
	 HfqylVCvQzTwG1M8JAsv/+DbnNNPsxLYmOhbQZfG6qRojIPp0y1puvGpkrIr1uFh/QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=aEY7Yzpg;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76742606A33A;
	Thu, 12 Nov 2026 02:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76742606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=aEY7Yzpg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=B7
	5XeCji0Hq4KB2ucqYdo8KpN0Fb8I/YrmcRagsu6Ms=; b=aEY7YzpgLMktlL9Ka/
	rDcyD/NJMczXVnAL4o54+U1RCtEVcRQ+kEyos8gax9Kpcukr5MZh96R5XLZXo+lh
	lGicryKbtxanOAfe7sbYcm5lrPuvXu05XSTfr1TAOOIlWBrsZxlt/AYtuKUdv87L
	MaW5Zk2bkCFfrvobKQWKLNFu0=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXj+5GI_VqPgXEGg--.53291S6;
	Thu, 12 Nov 2026 10:24:13 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	thierry.reding@kernel.org,
	ryder.lee@mediatek.com,
	jonathanh@nvidia.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v3 4/5] PCI: mediatek: Use pcie_get_link_speed()
Date: Thu, 12 Nov 2026 10:24:04 +0800
Message-ID: <20261112022405.1230200-5-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112022405.1230200-1-18255117159@163.com>
References: <20261112022405.1230200-1-18255117159@163.com>
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
X-CM-TRANSID:_____wDXj+5GI_VqPgXEGg--.53291S6
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFWxGF4kKF17urW3uw43GFg_yoWfKFbE9w
	nrtF4UJr4UGryfGw1YyFyFvr9ava4fWr10vayFqF1aya48u3s5Zr9agFWqqF9rGr4xXFy2
	yr90kF4xCFyUCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRihL05UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6w3zl2r1I00gPAAA3v

MediaTek was added after pcie_get_link_speed() was introduced and still
indexes pcie_link_speed[] directly.  Convert it to the helper so it does
not depend on the array being exported and cannot go out of bounds on
invalid speed values.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/pcie-mediatek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 3a3e91cd0c21..ffde365c987f 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -888,7 +888,7 @@ static int mtk_pcie_retrain(struct device *dev, struct pci_host_bridge *host)
 		speed = lnksta & PCI_EXP_LNKSTA_CLS;
 
 		pci_info(rp, "link retrained, speed %s\n",
-			 pci_speed_string(pcie_link_speed[speed]));
+			 pci_speed_string(pcie_get_link_speed(speed)));
 
 	}
 
-- 
2.43.0

