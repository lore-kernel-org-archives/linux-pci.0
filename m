Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794130877;
	b=hztHaH0FREQmQOQ570MAqXZSCi1UvnLTpGb3OSe/uT7Uf7h4IPp2of8t2PHEa6zVWq2k
	 J6GNDSzKx93GHhKO4MpP8O0Nu/dFzdM/qhdXrAql5KlDOvG14uSXnbml9vDSFNCzPDwxb
	 yfI+LRlF/x7q0XiNVkYUScnEJ+k3o6W55RQxsRwBZS8WEAWqAsmWPkv7a46XpQS2QJhJv
	 RZyeZOnSayC6KZaZDwF7bu6g8c3BpEG50gCl2TOspEE/q36yo3868YP0txVj6FQ600qod
	 CnyKnQ8iLyHx3zJCBKcgZQTVbwqcMxRmzhT31fQtGDPvjt4h3gWXPsqgN5cfX2vP6ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794130877;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=B75XeCji0Hq4KB2ucqYdo8KpN0Fb8I/YrmcRagsu6Ms=;
	b=pibP/BAoqes2xLLfP/NaJMoY9GB0kS0aQyMZ2lf4P2GwHzWftooYgewTFQdC8yVpQocf
	 iQAlZNQCwqtQdQa1H4uQefyaw5BbjJSZY0Fn/56k4+xAquxje4tOzxON1MxTlZXflEgu+
	 W1/rPqh/A1VRXbReC/zPsP3wrLh08zv8aptaXCWimA9STbGZcTf4IAfvE1YfVn42Gmiql
	 Hl40S5R+qrNSXlGhSOYKJSeWJTtuPTByQFCoz6uN5b5Kb+eGMNyw371FdKLeLWyohG1kE
	 jrsmyVRgbghT5CMVOTmdRCCvhOjUcq7ELx0+YNWBeT0ooCWdKFZ11NHfumRLxKICuUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=kSPLI+7Y;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6CA606A31C;
	Sun,  8 Nov 2026 09:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE6CA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=kSPLI+7Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=B7
	5XeCji0Hq4KB2ucqYdo8KpN0Fb8I/YrmcRagsu6Ms=; b=kSPLI+7YOYwBuz6uYY
	zO6GC48R063o5uemX7MMzmyVWAh8ICOVqZwHeGjFK0ZQk0r+6SSV41cSXPMAjkXf
	oTkufeiZedFrCOXqKX+FDrqqNJ1pTFrIQ1O2GKC+KGg/3+eDXeMyEgNulmG1lwUr
	OWj3V9JNBJiEBAHHpgkZbroSw=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCXz8OTQ_BquUg4GA--.62891S6;
	Sun, 08 Nov 2026 17:40:41 +0800 (CST)
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
Subject: [PATCH v2 4/5] PCI: mediatek: Use pcie_get_link_speed()
Date: Sun,  8 Nov 2026 17:40:33 +0800
Message-ID: <20261108094034.679945-5-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108094034.679945-1-18255117159@163.com>
References: <20261108094034.679945-1-18255117159@163.com>
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
X-CM-TRANSID:_____wCXz8OTQ_BquUg4GA--.62891S6
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFWxGF4kKF17urW3uw43GFg_yoWfKFbE9w
	nrtF4UJr4UGryfGw1YyFyFvr9ava4fWr10vayFqF1aya48u3s5Zr9agFWqqF9rGr4xXFy2
	yr90kF4xCFyUCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRihL05UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BrNcWrwQ5r4rAAA3d

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

