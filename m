Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794982711;
	b=34TSejITFuaXP6ngRYJpUwtMQDv22lB6D88OtWgVkqvb57+nIdzFJawGQuLsW3nwcykL
	 H7V/cBu8W0E+LHuasa1apqa6lZ8S9hMUu5x9PKVsVfG/OnMITir8qjgKC9aFSC0OEnxbI
	 kbvzSzM4WVyFuWaCzYciyfoNjMq/umx5CgjMkqFLrtobpSpDzci5/8S6pm9ruWgJsS2Ha
	 P7pMlUai9vqlPf6qXIjKGx0mxwGDj+SHzZ5Xqo9Npv8E88TPBiLFfDe/T2Ld7K++dft9A
	 1GhfMFZ7qC6kAw1M/L251sU3cT8jlgT/TCYuEUTnpGOPEApW3hAJKBKNLnDBrn23NcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794982711;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:DKIM-Signature;
	bh=uEnmGGl3sStC4ImWMaSe2Cwf+nQEkrs9yJ4nIOWSnLc=;
	b=EfmMbMMABdxRnHATK+HBUGuqwXotFuaF+CxxIrIKyyLfqxG1MEgx1h0q+fFt0/KpfpoD
	 QsXJfw6tRz8a0SwKniEopd8cUo4sYc2BA8LEyRVHa1xA8jIb+lIwsha1Gid636uC0YW3H
	 qEk8JSPvvABxxjKF05QhwBfzCe+6XcYVCmXAi4131+C+TtGNWcK7ThWtFkC9kQL0xg+qk
	 CT25rQPvOWzaTf5g2I+EJH4PwIzYCHTI6giSMolmU06X0X9cGQ7vgnQyHnjcZG9/zgQZ4
	 erhwTFcHBB4y2gPpHyxXr1QaQF/hlallCJyql/Q0HOfq4XW+wKh6N2fvYj66vTFuQPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=YsVQNZh+;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 14FFE606A32F;
	Wed, 18 Nov 2026 06:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14FFE606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=YsVQNZh+
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Philipp Stanner
	<pstanner@redhat.com>, =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH v2] PCI: Fix pcim_iomap_regions() error path rollback and leak
Date: Wed, 18 Nov 2026 14:18:09 +0800
Message-ID: <20261118061809.2327-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc13.internal.baidu.com (172.31.4.11) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1794982699;
	bh=uEnmGGl3sStC4ImWMaSe2Cwf+nQEkrs9yJ4nIOWSnLc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=YsVQNZh+fvpdg4iF+IfpczmuazA729tum4HACgKQaJ1SkMOdDpWgGgMDE22mr/pC2
	 8Pck755bo5bhkL8QtUL2jUKk5uEzXKhjU33w5bqb2iyFVVpbAzfjBccGHh0N3nTUbs
	 lrf4y5Pi7jQJL8zYuHTB91OyXX8ofKVOw8C8rgb0+r+QZ6T4DZvEivPfNeTatLdDvf
	 f3ROqF3W6WReuxiixjWqIi85cueHxHNa5339A3j7P7GMmfO9wwPYcd+6eU/mz5s0Bc
	 mgbzGPopxn0BBCaaYPHQPv+mUGyqc8IRHY12cgJxvAs/RRmBzz7cql7QsEdzEm7pS5
	 8OAc1uCDHvJhQ==

From: Li RongQing <lirongqing@baidu.com>

pcim_iomap_regions() has two problems in its error path.

First, the rollback loop walks every BAR index below the failing one
and unmaps it, regardless of whether that BAR is in the mask this call
was asked to map. pcim_iounmap_region() matches devres entries by
(type, bar) only, so it can release a mapping that an earlier
pcim_iomap_region()/pcim_iomap_regions() call made. The driver is then
left with an __iomem pointer that has been unmapped and a legacy table
entry cleared. Restrict the rollback to bars in mask.

Second, when pcim_add_mapping_to_legacy_table() fails, the current
bar's mapping is not released: the rollback loop starts at --bar, so
the failing BAR itself is skipped, and the mapping stays registered
until the driver detaches. Release it on this path as well.

Fixes: bbaff68bf4a4 ("PCI: Add managed partial-BAR request and map infrastructure")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
Diff with v1: s/bar/BAR/

 drivers/pci/devres.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index f075e78..9bdb4de 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -689,14 +689,18 @@ int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name)
 			goto err;
 		}
 		ret = pcim_add_mapping_to_legacy_table(pdev, mapping, bar);
-		if (ret != 0)
+		if (ret != 0) {
+			pcim_iounmap_region(pdev, bar);
 			goto err;
+		}
 	}
 
 	return 0;
 
 err:
 	while (--bar >= 0) {
+		if (!mask_contains_bar(mask, bar))
+			continue;
 		pcim_iounmap_region(pdev, bar);
 		pcim_remove_bar_from_legacy_table(pdev, bar);
 	}
-- 
2.9.4

