Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793156867;
	b=hdm34wVPp90gSp2zPKN8IZZDy82ZWKo4e/aDZyIC9ZzL+icObwSMH0W+RBpyXvQOxPV/
	 1ZCa4o/T9+BBv3GMPsnOUFv4VKMN5wNIwrf5lMIc+zcXoF1IFRPC6eIZxqf+Cgrrxj8Mp
	 pxN0tyeMbDFk4IWvp3fYvrvLbIU687yKh48vk6qn9+02+SnAm2c5DbPOGb6APRyVZixFt
	 X0hIKQ5v8IQCNGuWrMAWGlFbFp4VwYC/ehWgXUnYagQtrc6qmC2uGFTXO88lF1oaAgHyv
	 tOJgIKoqr8hPnT5M3krzQ5oimUuxdkWRddeeIkKhMETecTL0+V3BLtimLs64JfWfjpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156867;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=GeE1WcyeYWP2mSPHN7XEqyR08PBMAZMQypM2d1RF7uc=;
	b=p9XssUaG2e+Y3VE0nXF+T48MqbTHpHzdc5IyCSla/FvWsXquvr/bN4y5GDi758II17t6
	 BPPd/rXRoM/yCSQ+utFKYnN0U+0lovIqs7NHxS3RfeJyux18ovuco3ZLP+H0Qgc8SxRIK
	 Yij3Y3osbJxVgq4TypXKcpV6PSG2kmmmSfYXn94jvavpN/9R44LgLDCizaDCEk2cI3BGT
	 fKxJi4G06eXvbzg0/qVg9mqAlhfHdutptuxKFJ85yQyd3DSOPyPV1MbeYPx8kBodrPPHq
	 r7pQfuN+Ksfa7Q7kuJj3UP1qElcRK7dKjQHYQBqz4E92VBvXTmbUPkHApSXEFe0SH3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=g+ics2jL;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0011060A382B;
	Wed, 28 Oct 2026 03:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0011060A382B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=g+ics2jL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ge
	E1WcyeYWP2mSPHN7XEqyR08PBMAZMQypM2d1RF7uc=; b=g+ics2jLEMoWNTcWou
	3zuuHVannuRGZ/4ausRW5qQudn+/+QPForLoRvvdrurb1Y5Rxg1ADvE8/7V5tX+i
	p4ShFBZhHusGdXKLBIuFdMKDGHdHepwSNela/TocacSGAl/Kxq/kWHvHuXqCEwzq
	LwiYCPKMHjcKfvCvRUusynt28=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDnVwncZuFqLzE4DA--.33198S7;
	Wed, 28 Oct 2026 11:07:14 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	jingoohan1@gmail.com
Cc: imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v5 13/16] PCI: dwc: spacemit-k1: Use cached PCIe capability offset
Date: Wed, 28 Oct 2026 11:06:49 +0800
Message-ID: <20261028030652.2917756-14-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028030652.2917756-1-18255117159@163.com>
References: <20261028030652.2917756-1-18255117159@163.com>
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
X-CM-TRANSID:_____wDnVwncZuFqLzE4DA--.33198S7
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr1fWryrZrW5XrWkXry8uFg_yoWfWFXE9r
	9xGanrArWUGF9Ikan2y3WfXF90y3y7Za1jgayftF98Z3Z2qw1FqryDZFWvyF1UWr4DJF93
	K34qvF1rAFWUGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRMb18tUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6wLkiGrhZuLHqAAA3l

k1_pcie_disable_aspm_l1() runs from the .init callback with the
controller already enabled. Replace the capability search with
dw_pcie_get_pcie_cap().

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
index 92a71ea90ac31..3369592b28608 100644
--- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
+++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
@@ -116,7 +116,7 @@ static void k1_pcie_disable_aspm_l1(struct k1_pcie *k1)
 	u8 offset;
 	u32 val;
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	offset = dw_pcie_get_pcie_cap(pci);
 	offset += PCI_EXP_LNKCAP;
 
 	dw_pcie_dbi_ro_wr_en(pci);
-- 
2.43.0

