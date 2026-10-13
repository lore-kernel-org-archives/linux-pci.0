Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93374563292
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 22:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791930980; cv=none; b=oGF7YrXDKfvyNtxrFFuLdVdMFq7qz65n6NURLL52LQG396v1PaaogRXRhTQdG7GwwkTS4/KCdBbxkrbcHZB/dJoiKJwfeUzESmR6rb2DY9mqD07xFs9GrwrIYejg9Ofwv/DuqQ/oE8Q2n6+YkzR7HLd4v2nvVIFH3ZnHXKmQRQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791930980; c=relaxed/simple;
	bh=V+bRtjH+RJYsjqhZpGOpoCtpHx/8JeTS0N+HL8IwZ2I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oVeusnB0W4oUqDk+2yK9mBx+1vgl0YbPJRp81jZLDRuk1pfrTDKaUBSlMtKHdEumVoQ/g4+VxQZ+sVCYoqxOeVN9ULKmdCVo4ERjENzLH1tAIVudHLm1RbXJhbYTXhNQe2OXziMSyxAsyY2R5WuwBRkbcKbAmyzWoyKt22A1GH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=BhLvAeaO; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="BhLvAeaO"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DKWlRn1625157
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 15:36:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=/p1VXRvPs
	dzpyNaMEVuZe4zu8qtnztrsEYEyfTDBzQc=; b=BhLvAeaOps4E1nARaARTQJD/J
	3Q6PwSPs4NCSngoBTQY6Gi6lyXhiDHIZoR3hIM0qAgP56RWgvlqEoa+kBBy0mIjK
	PZP5RpU8ZzPjcs5QxdUFvbRrKV3FdBF3vRZhG9DLsOnMs7w3dOaC+IsQx9+CNVgR
	29bY2yHUTuPIjQS5mDdq4Ct2U33F0HlBzQ1iLNidpe/jE/MohndOKR++VawsI/Dn
	a1aB2pSnjRhDSBydq+gyF6LDaqGJxfldiNnllqI3Li7hOtoQXIoTF5UgDwbJSK34
	5sExcFPsOUepKDrgFSf73bxLi5Qw3Ke1UmsOo9rKdvohnZhyzOfvqdguaYjpQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4h9hc46f0v-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 15:36:13 -0700 (PDT)
Received: from twshared134145.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Tue, 13 Oct 2026 22:36:12 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 6417A2D52CB77; Tue, 13 Oct 2026 15:35:53 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <changfengnan@bytedance.com>, <linux-pci@vger.kernel.org>,
        <tglx@kernel.org>, <namjain@linux.microsoft.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [RFC PATCH 0/3] nvme-pci: dynamic interrupt moderation
Date: Tue, 13 Oct 2026 15:35:40 -0700
Message-ID: <20261013223543.395054-1-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=L86I0OT8 c=1 sm=1 tr=0 ts=6aceb25d cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=crHB47gyY4rKiduisYu9:22 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=968KyxNXAAAA:8
 a=czqYIZ0shksRg8RT8RcA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA4OSBTYWx0ZWRfX/uCwChPQ3EJb
 XWQBOwA/zmtCkbCuvf63N1WVcQY5CMNY4mlx8I04IFV6+lRJYijKC5mIHM0paDD0dqbZcptPFfi
 MeO3V+rUKFRPZAp+HUKftgp935Wj6w0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA4OSBTYWx0ZWRfXzf6HFTBZnnht
 HkKNyypF5d7DzlgpxdihDV20c1Iipwpnw+JiEBsYV7VayaFRS7JdPwPanwXOj1m+JD6gDYRiDDt
 +25bAZ62fPHg14YUfT9B+g4SnIsh3zu0ZOYtUA9W6jLFAh/XPZpHFf/lF+r+dCZHvKgA81Ecl7R
 uv7Fur14K+6SVWZDKJeclYFnqNmk4k+O1n9FTUZL1ZxjNVkK/rIi97NFAQH5u7mxPs7gft/VzYc
 kv1O04SPlOPPBuid2nPsckQHbrXKAVSZQ1gAJrs1Hd2+buwSXE8nF4ZWfhtOJ2A+5bgZibfBapN
 1swSC+iV0CXAUTZkx6WuUlrZKVTmhIpW9IDsOvaQFEFP2/EAbqu8irExI9I2AeB+2X1iF3ebnbe
 PNAP1OsjX4YiVxYfq9MOVvVOVVZpzR3A0IuvJ1/hJG3ni3WygT8nu7tLKcIWl0bfoP2UntHinU8
 bopdDuXh269WvXO8CjQ==
X-Proofpoint-ORIG-GUID: Zs8Ch6cEftD_BGnAEBJn9tZSL3ZGBWIQ
X-Proofpoint-GUID: Zs8Ch6cEftD_BGnAEBJn9tZSL3ZGBWIQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Just adding another nvme hybrid interrupt and polling mechanism to the
lists. There's some recent alternatives mentioned in the links below,
but I'm trying one last time to leverage the DIM framework. Performance
wise, this at least doesn't seem any worse than anything else proposed,
though I've only been able to test on mid-level hardware so far.

This one here as some irq prep patches that help some when transitioning
from irq to polling for MSI-x enabled NVMe completions. These should be
generally applicable, so isn't necessarily tied to how it gets used in
the last patch if someone else finds it useful too.

Links:

  [1] https://lore.kernel.org/linux-nvme/20261009050556.2817978-1-namjain=
@linux.microsoft.com/

  [2] https://lore.kernel.org/linux-nvme/20260818033846.53790-1-changfeng=
nan@bytedance.com/

Keith Busch (3):
  genirq: Add disable_irq_nowait()
  PCI/MSI: Implement irq_mask_nowait() for MSI-X
  nvme-pci: hybrid irq+polling

 drivers/irqchip/irq-msi-lib.c |   1 +
 drivers/nvme/host/Kconfig     |   2 +
 drivers/nvme/host/pci.c       | 624 ++++++++++++++++++++++++++++++++--
 drivers/nvme/host/trace.c     |   1 +
 drivers/nvme/host/trace.h     |  26 ++
 drivers/pci/msi/irqdomain.c   |   6 +
 drivers/pci/msi/msi.h         |   8 +-
 include/linux/interrupt.h     |   1 +
 include/linux/irq.h           |   4 +
 kernel/irq/chip.c             |  31 ++
 kernel/irq/internals.h        |   1 +
 kernel/irq/manage.c           |  21 ++
 12 files changed, 698 insertions(+), 28 deletions(-)

--=20
2.52.0

