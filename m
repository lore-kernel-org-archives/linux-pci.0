Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92F046AF0F;
	Thu, 30 Apr 2026 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777565640; cv=none; b=SM6S0EZbPdS1PZm4SuHY3HxnPlch+/DKMYMTrb3geQ+uwDyfXstv0Foo1MvgVX7lN+A8oiQoeOMt07htWd1JFnHbQeKPhFU6TaLyZGatpWvbqWs4ymq1Y2Exk+qB879Zm2UWlgnDlhNHLQX60E1b06jqVjlDCuIxIJ4LfMOoeCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777565640; c=relaxed/simple;
	bh=BH20/sZFBY5SJOCp+kiWdmJX7w80ygTDJBjP+F2Pzb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fXqknbw6n51gqqhiM//20r4caBD2NRmixpZGpVyN8cNkYMKUzIr7jYB19KUEZSc9UnUxjJU6yo3qpAlZLxtW7Fb5GMXXLCX8Ko1mEMKT1v/gGDxMMwab0eLiH5MVhgH0HY+oVh0PP4VJPcD0Jnjws558YXPdB27lqv8WvjcIbR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=I91tr3Dn; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="I91tr3Dn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=S2
	sAL3YnLBb8rVf9/WlGtBa/nywRSHxKsLjvU4T4r2Q=; b=I91tr3DndFooEJAV51
	y/mkqdw1Kvlg87pvT7FOjfCxAOb8jDrFVj7CzjgPgrFxjCX1PIWww5TILhzye52R
	0nucLwF+dVrZ3maHpwlNhJrSjKHi9rcjw6QHL1aV37xKPFxL/rZcsJGsmsssq9S/
	np1jad8jft3tI6UAHGRg+mAuE=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnbymkf_NpTNe+Cg--.31297S6;
	Fri, 01 May 2026 00:13:27 +0800 (CST)
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
Subject: [PATCH 04/16] PCI/IOV: Use FIELD_MODIFY()
Date: Fri,  1 May 2026 00:12:42 +0800
Message-Id: <20260430161254.40278-5-18255117159@163.com>
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
X-CM-TRANSID:_____wDnbymkf_NpTNe+Cg--.31297S6
X-Coremail-Antispam: 1Uf129KBjvdXoWrur17tw47Wr45Gr43Cw4UJwb_yoWfCFb_Wr
	18G34xGr1UAr1UGw4Fkr1Svr9Y9ws0qa1v9a40ga45u3s5Xrn8Wryvv3yvkF48uw43CrW3
	A3yUXr15u3yIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRiznQUUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AdgBGnzf6fz6AAA3W

Use FIELD_MODIFY() to remove open-coded bit manipulation.
No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/iov.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 91ac4e37ecb9..fdae70abe804 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -946,8 +946,7 @@ static void sriov_restore_vf_rebar_state(struct pci_dev *dev)
 		pci_read_config_dword(dev, pos + PCI_VF_REBAR_CTRL, &ctrl);
 		bar_idx = FIELD_GET(PCI_VF_REBAR_CTRL_BAR_IDX, ctrl);
 		size = pci_rebar_bytes_to_size(dev->sriov->barsz[bar_idx]);
-		ctrl &= ~PCI_VF_REBAR_CTRL_BAR_SIZE;
-		ctrl |= FIELD_PREP(PCI_VF_REBAR_CTRL_BAR_SIZE, size);
+		FIELD_MODIFY(PCI_VF_REBAR_CTRL_BAR_SIZE, &ctrl, size);
 		pci_write_config_dword(dev, pos + PCI_VF_REBAR_CTRL, ctrl);
 	}
 }
-- 
2.34.1

