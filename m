Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450280;
	b=kYfoNCHRvJZCZoF/xrUyqEz5cn4eB392mw8MKGrAul/vNJAp/YwpKdiiEteIVdzv+PMS
	 77w6Z4pZGGVvTxqjKbDv39/rZjCBIl/g/LoxQOOeEvXJlVkt17C9kkfOiyka3/qHclx7B
	 NksVbGs9Jnw0aWFQobDMLAy9AOZsGvMSqv+sV7QBehhb7AI4Lvs8u7aDB/pTcfXVFeSok
	 HjehPAXjmhGcJfohWfZXk8jLVq7OnLjk1Q/q5IPQOMrIPOH0bpsHDEBpEY2yU8TzcGbBn
	 wYfKiZ0dqWz0/Zwhl4Ou+7SoR9O0kbj/p/S9hsRSEWTUWtaXXWIiAUtxMly8YcSak7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450280;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=kVpUQkMwZfIP9qRjz990+OsHZvfaXMOvnj2vL1S7urw=;
	b=LJHUHhUdt2pZ9sJ51UHoEFe07yrqZJKvSiwnAKmsqCaPahmK8O+daWzNuGzja0Rxpy0e
	 pO5Aep+WU8Gki0Q52vcgSLZxicR0JDTS9p6n6D3dK3hbNgMP5qQDANJmN7OYTbn8xW29O
	 xIFKequgrhh3yChQzQddXRA+oDmd2l1UXBMI8A8vP4pQd5jxqcm+SDiFoaZoFMW1jvOfI
	 JIlcV/6Ajzs4hNsvZn2ORUqkadXWtQ6DyUztTzOWmUhEQe9jPI/lLZ+HQisXqjMuQ3HHc
	 m14EcQaltw45o04Yxlki2TmlBUf3rUYaTpuvpD0VgwRZV8H8aa7KXXels2OSxA49omQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=IcvOhHkq;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C461E606A321;
	Thu, 12 Nov 2026 02:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C461E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=IcvOhHkq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=kV
	pUQkMwZfIP9qRjz990+OsHZvfaXMOvnj2vL1S7urw=; b=IcvOhHkqrN6BsABjtt
	AiAtewhOKiwYtdsc4HfeG9WBfT5gNdX1MlGDmXpc67mnZkaNmzZKmgSFzqCZf1hx
	zT+xm4SW5I+OG4BTn8tNAtcdtdqeKa4Tabi57Sr0vZNQ/Ie2bphq/ipVbIp0sl7s
	laQlfKs6c84CNEEpl+6StvDuM=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXj+5GI_VqPgXEGg--.53291S5;
	Thu, 12 Nov 2026 10:24:12 +0800 (CST)
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
Subject: [PATCH v3 3/5] PCI: tegra264: Use pcie_get_link_speed()
Date: Thu, 12 Nov 2026 10:24:03 +0800
Message-ID: <20261112022405.1230200-4-18255117159@163.com>
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
X-CM-TRANSID:_____wDXj+5GI_VqPgXEGg--.53291S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw4UCF4ftF1xtF1kuw1kAFb_yoW8Gr4kpF
	W3J3yIyF48XrW5uFW7Wa15Z3WYvFn8AFWUJ3sIg3s7ZF9rJrWDWa4YyrWftFWakwsFvr15
	JF1YqF1Fka1avrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zKFAl9UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6wzzl2r1I0wf-gAA3S

Tegra264 was added after pcie_get_link_speed() was introduced and still
indexes pcie_link_speed[] directly.  Convert it to the helper so it does
not depend on the array being exported and cannot go out of bounds on
invalid speed values.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/pcie-tegra264.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-tegra264.c b/drivers/pci/controller/pcie-tegra264.c
index c97576ab4a31..711b66287681 100644
--- a/drivers/pci/controller/pcie-tegra264.c
+++ b/drivers/pci/controller/pcie-tegra264.c
@@ -126,7 +126,7 @@ static void tegra264_pcie_icc_set(struct tegra264_pcie *pcie)
 		width = FIELD_GET(PCI_EXP_LNKCAP_MLW, value);
 	}
 
-	value = Mbps_to_icc(width * PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]));
+	value = Mbps_to_icc(width * PCIE_SPEED2MBS_ENC(pcie_get_link_speed(speed)));
 
 	/*
 	 * We don't want to error out here because a boot-critical device
@@ -266,8 +266,8 @@ static bool tegra264_pcie_link_up(struct tegra264_pcie *pcie,
 
 	if (value & PCI_EXP_LNKSTA_DLLLA) {
 		if (speed)
-			*speed = pcie_link_speed[FIELD_GET(PCI_EXP_LNKSTA_CLS,
-							   value)];
+			*speed = pcie_get_link_speed(FIELD_GET(PCI_EXP_LNKSTA_CLS,
+							       value));
 
 		return true;
 	}
-- 
2.43.0

