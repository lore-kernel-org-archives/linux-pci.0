Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF10746AF2D;
	Thu, 30 Apr 2026 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566303; cv=none; b=q1Kschvf9RC4hTb1aQZBH8xeAnCC6pRWyzrJe+HCbMOPspGWLbe1DXbqPb1YZtHn3zkOFDGQ1ks/a99uL3jDmlNYnSoxeC+qaPTy1PoA5Ao85gql2O/JhgDmYtbjxjVhCSOgG5sk7LnHHDTAGtVCMEqeXJpwWeZsTyGyL+T/iPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566303; c=relaxed/simple;
	bh=BH20/sZFBY5SJOCp+kiWdmJX7w80ygTDJBjP+F2Pzb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dngBg6g8bCIQOFGkuMKuFhuKoT/Jjr15vnDJfm6Xb9nRuC7r0Wz1rfCSoSNTj1HAJPRPb/2fQ3PJF6K0Z58po4MBzuaT6ZzPgc43tlxAD4PsQSuHOlqZI2/+IzaT3uvnTcGP+VG+6ftoSvZ6wntvkjlZ/zkclJ6qZFWgmzpJNMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZNnwYHNq; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZNnwYHNq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=S2
	sAL3YnLBb8rVf9/WlGtBa/nywRSHxKsLjvU4T4r2Q=; b=ZNnwYHNq56TEl5fSYS
	XFIzOw8ApoKpgsNxyynit7WzbHB4DbuTKWYXlnA1bCH4Ujv8zAWQNRx2J5sIev1D
	uznG//qPUUaGKm9dVZmZopCWT1yq+SlqNskDYlKazt7hHCR7lxTyYCJGu4diFKsb
	2hPMPc+Ag0KfVKJ8jqEveTIL0=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAHJXM2gvNpY8PXCg--.48992S6;
	Fri, 01 May 2026 00:24:25 +0800 (CST)
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
Subject: [RESEND PATCH 04/16] PCI/IOV: Use FIELD_MODIFY()
Date: Fri,  1 May 2026 00:24:08 +0800
Message-Id: <20260430162420.42839-5-18255117159@163.com>
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
X-CM-TRANSID:_____wAHJXM2gvNpY8PXCg--.48992S6
X-Coremail-Antispam: 1Uf129KBjvdXoWrur17tw47Wr45Gr43Cw4UJwb_yoWfCFb_Wr
	18G34xGr1UAr1UGw4Fkr1Svr9Y9ws0qa1v9a40ga45u3s5Xrn8Wryvv3yvkF48uw43CrW3
	A3yUXr15u3yIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRiDUUUUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwxoGqWnzgjpN6QAA3w

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

