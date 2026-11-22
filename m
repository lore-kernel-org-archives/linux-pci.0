Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795316216;
	b=JM1VYSJXwZf0tHtLtJNVuVPd65/YxhZvlp6J+8xGYgc8e8Ry0PZhU8IAMK+hNmwE6iZ3
	 UDrWZLBUhnmVdNTBgYQGq13JhCbsx6O26kSX8L1wBgVSVwevS4o6IaGC95fz8gYDj5SBl
	 XOiiU7+aMtgfo6O18Lzqa0HhQW/iIu11HdJBkev6Vev9Fqevb7wJpM8ujjWLrS6+TUJ8H
	 ibNrquTg8/jiSJPAC0woNDlcnbhcT10x4Aif1prV1bmpjES3S2XZClCMjlHy7B5Pgdj4Z
	 PeV8uCw01UzbxPqt30drzctXsuTlGLcFbxmwnXLe5Wmmv41Ogaxko3Jch5+7/5dYkYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795316216;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=hNOKzPAn7+pXWluGC2/bHKGOVozO2Ky26vVL4ckdzBo=;
	b=tr/8qpTmgXw/wQDjfIAHQNvjn6IpYMGfk65rjGgeDpe4AY5hcsEutrqpnHJ9ksi6+TnR
	 ebRHbbZPi5uSRHPW066xZ/puubWM5DvwT9a2O8a4C668f7eQnznEv8F2TQacIr5aMUHuU
	 WJtHS2UnFmMusk9B3fgMm9D9O/sXjv6+NsmLf9jUT0WipH+TKpN3uzZqo2833NKZoWC+A
	 ZZXnd0A4o1TrqixEk8YwAR09zS+82+9XXiX8pa1p1ghewhMtPSNC8p8/JxGLsuz167YXt
	 3kN2pbgAQiJNjRX3vHT/MrHf0LNbwYcN6eRCy6myv8+bEPgaObMhokwsva5l//lv4IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hqWur2w8;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O+MO6Cfz;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3BB606A338
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 02:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E3BB606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hqWur2w8;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O+MO6Cfz
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM08vVJ1649798
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 02:56:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hNOKzPAn7+pXWluGC2/bHKGOVozO2Ky26vVL4ckdzBo=; b=hqWur2w8W55NOte0
	25+pYAciUDWJ6ENxlF9RXINK4LY/WDrdolJH+Gf7l0EpY2OB+vvE4kH9G8WRejTp
	MKeNetcdLc65tshrOleXckPJbR95hqM8UtaQ22Wp3dCHPnwSUEKAH72qEPERq/lG
	0WPiM4EVzMxsBpvIpTGv5wUABviXAIzloOwdlQKs9xDuiyrTwzbSUyy/KedHYFFZ
	FnfltOlw7BEgQ03SBlkWiGCa604MP78dPZxWAEJ1j9AkbxUs4CSyHPfxzws7ccYd
	fDQXRW6mRmAnCtX8oRHL5jVeh8AxPVV90rYb3/KlFOLS3iE9sn1S1BzfI+piiZqK
	iZipBA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j32mgamfm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 02:56:54 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30bcb065bfdso2517929eec.0
        for <linux-pci@vger.kernel.org>; Sat, 21 Nov 2026 18:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795316213; x=1795921013; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hNOKzPAn7+pXWluGC2/bHKGOVozO2Ky26vVL4ckdzBo=;
        b=O+MO6CfzRd22Ejnb5oN/Mokz+T5twyuVLgaUGEhnxLY71B2c7V92agB8q2GlyQCLZj
         eHy1is3X4AIJes27bQy8G8+Tg923OYiJg8An27OHAIN3ge/EF8BvCHTWGbnRZyRAmJqA
         3B4Y4fYHvA0Ma+6dqZsvDK6lrw/8G6trtYQ46oHpcZs9ao20yBVftIkaZtGfzFMDOuby
         xOcCNytCGecsTZnmZ0Qjsb5fNZoQj8p4lRIViaLcUJqdfHQWjNbCeNo6NM9mP+IiESk6
         W9KYoYYNfqyJ1+u86eR4s/0hmlaV5+Dbmm2BWn+yu5Yi5J2TcgBvwfopxbX6WyT4jfZJ
         gUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795316213; x=1795921013;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hNOKzPAn7+pXWluGC2/bHKGOVozO2Ky26vVL4ckdzBo=;
        b=sgDVy4dLbGmh0ymR6cV7KsQbrrnf9d3YTnTdIAm7rwhtcnToOVa+ouKWuZRILbo+Fm
         OB4e9TvLLt2ayrlx80LDj79UqovRYafTG1OBqRMxqZx0r9lNJJlQM2rQCqvm1Ldocuww
         irslW/L+7YJZ/EW8AttJnw1SrjqULI50aKaWgAGc4QucTwc2OEItkq0oCqTfIznaeMsh
         px7BNPeaDyytoGJvjZcz8eAhQAfYdz89KgzvcZtRIMxmZp9FSZrt8dhIlgBYsqmxyS7g
         x2ojuhTs98IXgBH65QpuQstz93UicPCDf38IuBX/6eRWSPmRX6vwJsTyflDgvPXTR3WE
         l80g==
X-Forwarded-Encrypted: i=1; AL+hErG1wUEGVvJuu+dBfb0DTE8rsPVMVtuhQxM7PuPR40A59bFiExHk+ixiUuIP4C6xjgq3VicajHvzk8Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/MIqTIdyIE0kg55CklMMhR0o9Ti5iaR1yyab9Nr0ZSMyUPBR/x
	316fXU7Lsx/py6Pt9RoCF915aTmImMr1vzyHuNgGeZ64R2uSeX5Cdf8D/Y1X/tjgqkiiQ+rv4CR
	E0wiRXoihb8nesnaf/kl16Uu/W6F45B1kbI+lqflHNG2UZU5VguFOXaLXw7tQRQo=
X-Gm-Gg: AZFdTZd0DQsBWxqwo1v9jesA1bKeAxMgJshwjP0hndytRd3uQApU0cmKp/HDrn3bO2S
	CXfDkN95nOhOngBjqAw3ILqtO6Wi33RgRD/p+kfGcSEJ83YAoEszySFNlTJ2OSa22zKmVac/yyW
	zWrGLY5Yl8HUUHO121Bx+SD8dCDzv01itPjiYsQMgclCNbFsQ7RYCulsPPpURovrRFLUz/UN3f1
	EB5nQrMP9Gv5PWbONLOJs9q0JXXGa/M1JPmZPhbu4V49WFBqWaG8aj00RAtzHKZ0DZipn6+7PY9
	qFrsgwXhG/v5BfHsgyIDLOQh3t4OJ8AU8HvhZF3eSAeG4S9NhiAQpxSmqjk2cMnV6JrG2aB5zUZ
	hgq2yPL76k2DVGhogh8iTWhYzNMabuxqvPXCt59OxDXOfxP/snX+o0R+PI8f9Yd6qQ+knWnH3Kw
	JHYiLpBtas
X-Received: by 2002:a05:7300:e9ce:10b0:385:2564:c509 with SMTP id 5a478bee46e88-385700541a6mr9071454eec.24.1795316213184;
        Sat, 21 Nov 2026 18:56:53 -0800 (PST)
X-Received: by 2002:a05:7300:e9ce:10b0:385:2564:c509 with SMTP id 5a478bee46e88-385700541a6mr9071403eec.24.1795316212484;
        Sat, 21 Nov 2026 18:56:52 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aaae4960sm312044eec.18.2026.11.21.18.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 18:56:52 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sun, 22 Nov 2026 08:26:16 +0530
Subject: [PATCH 03/11] PCI: epf-mhi: Add MSI-X support
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261122-nord_ep-v1-3-6d8839ffa9aa@oss.qualcomm.com>
References: <20261122-nord_ep-v1-0-6d8839ffa9aa@oss.qualcomm.com>
In-Reply-To: <20261122-nord_ep-v1-0-6d8839ffa9aa@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <cassel@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Anvita T <anvita.t@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795316183; l=5864;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=7QjmuTlVRoKXrIZssiDHzu7/1X+z/zLg7WzPuVHICII=;
 b=A+SSmX+nlmQiS0zohEwoQRgbuhdqSdqltmeiJRJ4cuV6hvQdHXPdssILPJFHnDIKWCA7pMPvW
 lmYm2D9QhSWB0lAbIJnkZ+p401ZCAT36i2ymGTzuXi+p2JBNrfdJLcM
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDAxMSBTYWx0ZWRfX641cZm9oCChV
 BLlqoRG/CCHcCWRAkwnc8Rl9y4P9/p0aM/ZNpkdUHwfYtEEqaYbnMxAJmXP9iMCdzWjXlgkQT+f
 h+PWUKq9BPyBFENFXj04n9Cb59pr5RpSP+FwFaMAK+kA1XFBihJwhoZAgfrp6i+X0fwvly5PAta
 a5XAqsoKfsGANY+U9qMa0xVVqGYW7ilt+M0wbhYr3kN0F4wS8cARYK8PQtV2VFyRR2fqPX8rIUc
 n7n4o8YvuinAj9U+WN51/BFU42GHnU8ljVEgXVAjJT18ZDdB8v4uSLFsC9Ot9+zahMQdf7qLLto
 zBpuk7x8rRn8/+yeS4CuS8d7XgadFBXfwk0xJDeATFC1r6HXRuho4R3agNuqYDl3SZHAl25ZXcr
 CoCa/6/8keHLqx3MiPMnZvicYlbVLQ6D0NI+teXNOwT6kMaDfrg3qtCikQpr1JaFCBoNti/tGkD
 It8nDYp9yNQfnL/GF2g==
X-Authority-Analysis: v=2.4 cv=OM+yTiaB c=1 sm=1 tr=0 ts=6b0259f6 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=aWPhZf5PStJQkATrKZ4A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDAxMSBTYWx0ZWRfX8KcNrSXqpgqc
 OFlC0GebsXzce2m+/ju9deBdsA2jXIoVTTI00/WJjOfWPnbqSXYKk4yDUzHDHMLCLmOEaDWfoLk
 3uHPugmlJ68hr0nj+xqGwPQBw/mVftE=
X-Proofpoint-GUID: HIX4jKVx3YbNOqxF7K77J6PZJr_6wD9I
X-Proofpoint-ORIG-GUID: HIX4jKVx3YbNOqxF7K77J6PZJr_6wD9I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-21_06,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611220011

From: Anvita T <anvita.t@oss.qualcomm.com>

Allow the MHI endpoint function to signal interrupts using MSI-X when the
endpoint controller supports it. On controllers whose epc_features
advertise msix_capable, set up a dedicated MSI-X BAR (BAR_0) from a
"msix" memory region supplied by the platform and program the MSI-X
configuration.

The "msix" resource is optional and only looked up during bind; it is
required only when the controller reports MSI-X capability. At interrupt
time, select PCI_IRQ_MSIX over PCI_IRQ_MSI based on whether MSI-X has
been enabled by the host.

Fetch epc_features earlier in epc_init() so the MSI-X capability can be
checked before setting up the BARs.

Signed-off-by: Anvita T <anvita.t@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 54 +++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 52cfffcfd5ca..a8765beffe06 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -148,6 +148,7 @@ struct pci_epf_mhi {
 	struct mutex lock;
 	void __iomem *mmio;
 	resource_size_t mmio_phys;
+	resource_size_t msix_phys;
 	struct dma_chan *dma_chan_tx;
 	struct dma_chan *dma_chan_rx;
 	struct workqueue_struct *dma_wq;
@@ -155,6 +156,7 @@ struct pci_epf_mhi {
 	struct list_head dma_list;
 	spinlock_t list_lock;
 	u32 mmio_size;
+	u32 msix_size;
 	int irq;
 };
 
@@ -230,12 +232,16 @@ static void pci_epf_mhi_raise_irq(struct mhi_ep_cntrl *mhi_cntrl, u32 vector)
 	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
 	struct pci_epf *epf = epf_mhi->epf;
 	struct pci_epc *epc = epf->epc;
+	unsigned int type = PCI_IRQ_MSI;
+
+	if (pci_epc_get_msix(epc, epf->func_no, epf->vfunc_no) > 0)
+		type = PCI_IRQ_MSIX;
 
 	/*
 	 * MHI supplies 0 based MSI vectors but the API expects the vector
 	 * number to start from 1, so we need to increment the vector by 1.
 	 */
-	pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no, PCI_IRQ_MSI,
+	pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no, type,
 			  vector + 1);
 }
 
@@ -714,11 +720,40 @@ static int pci_epf_mhi_epc_init(struct pci_epf *epf)
 {
 	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
 	const struct pci_epf_mhi_ep_info *info = epf_mhi->info;
+	struct pci_epf_bar *msix_bar = &epf->bar[BAR_0];
 	struct pci_epf_bar *epf_bar = &epf->bar[info->bar_num];
 	struct pci_epc *epc = epf->epc;
 	struct device *dev = &epf->dev;
 	int ret;
 
+	epf_mhi->epc_features = pci_epc_get_features(epc, epf->func_no, epf->vfunc_no);
+	if (!epf_mhi->epc_features)
+		return -ENODATA;
+
+	if (epf_mhi->epc_features->msix_capable) {
+		if (!epf_mhi->msix_phys) {
+			dev_err(dev, "MSI-X BAR address not configured in DT\n");
+			return -EINVAL;
+		}
+
+		msix_bar->phys_addr = epf_mhi->msix_phys;
+		msix_bar->size = epf_mhi->msix_size;
+		msix_bar->barno = BAR_0;
+		msix_bar->flags = info->epf_flags;
+		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, msix_bar);
+		if (ret) {
+			dev_err(dev, "Failed to set MSI-X BAR: %d\n", ret);
+			return ret;
+		}
+
+		ret = pci_epc_set_msix(epc, epf->func_no, epf->vfunc_no,
+				       info->msi_count, BAR_0, 0);
+		if (ret) {
+			dev_err(dev, "Failed to set MSI-X configuration: %d\n", ret);
+			return ret;
+		}
+	}
+
 	epf_bar->phys_addr = epf_mhi->mmio_phys;
 	epf_bar->size = epf_mhi->mmio_size;
 	epf_bar->barno = info->bar_num;
@@ -743,10 +778,6 @@ static int pci_epf_mhi_epc_init(struct pci_epf *epf)
 		return ret;
 	}
 
-	epf_mhi->epc_features = pci_epc_get_features(epc, epf->func_no, epf->vfunc_no);
-	if (!epf_mhi->epc_features)
-		return -ENODATA;
-
 	if (info->flags & MHI_EPF_USE_DMA) {
 		ret = pci_epf_mhi_dma_init(epf_mhi);
 		if (ret) {
@@ -763,6 +794,7 @@ static void pci_epf_mhi_epc_deinit(struct pci_epf *epf)
 	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
 	const struct pci_epf_mhi_ep_info *info = epf_mhi->info;
 	struct pci_epf_bar *epf_bar = &epf->bar[info->bar_num];
+	struct pci_epf_bar *msix_bar = &epf->bar[BAR_0];
 	struct mhi_ep_cntrl *mhi_cntrl = &epf_mhi->mhi_cntrl;
 	struct pci_epc *epc = epf->epc;
 
@@ -773,6 +805,8 @@ static void pci_epf_mhi_epc_deinit(struct pci_epf *epf)
 		mhi_ep_unregister_controller(mhi_cntrl);
 	}
 
+	if (epf_mhi->epc_features && epf_mhi->epc_features->msix_capable)
+		pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no, msix_bar);
 	pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no, epf_bar);
 }
 
@@ -880,6 +914,13 @@ static int pci_epf_mhi_bind(struct pci_epf *epf)
 	if (!epf_mhi->mmio)
 		return -ENOMEM;
 
+	/* MSI-X BAR address is optional; only present on EPCs that support MSI-X */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "msix");
+	if (res) {
+		epf_mhi->msix_phys = res->start;
+		epf_mhi->msix_size = resource_size(res);
+	}
+
 	ret = platform_get_irq_byname(pdev, "doorbell");
 	if (ret < 0) {
 		iounmap(epf_mhi->mmio);
@@ -896,6 +937,7 @@ static void pci_epf_mhi_unbind(struct pci_epf *epf)
 	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
 	const struct pci_epf_mhi_ep_info *info = epf_mhi->info;
 	struct pci_epf_bar *epf_bar = &epf->bar[info->bar_num];
+	struct pci_epf_bar *msix_bar = &epf->bar[BAR_0];
 	struct mhi_ep_cntrl *mhi_cntrl = &epf_mhi->mhi_cntrl;
 	struct pci_epc *epc = epf->epc;
 
@@ -912,6 +954,8 @@ static void pci_epf_mhi_unbind(struct pci_epf *epf)
 	}
 
 	iounmap(epf_mhi->mmio);
+	if (epf_mhi->epc_features && epf_mhi->epc_features->msix_capable)
+		pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no, msix_bar);
 	pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no, epf_bar);
 }
 

-- 
2.34.1

