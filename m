Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3B23D7D7B
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036671; cv=none; b=YmIYgr61t8jVPDPP+60BcZKtjUPR3cSwJl2O8MMQ6VISBGzMOaN/3byWRuim2AmSrhmzcu30s/DLojdkQ/QPnmjrHfB+omkH14sgXUc/Qp/BUclxQMZiYFA/X9UxybttBiXVyV8O0A5L2PPvzx0YYuv+5zDDTsgoImlFsjajj5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036671; c=relaxed/simple;
	bh=eVbPfZFjsM6dn53MMNkr1xAQjcP37kbNubwSGE/bvBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GVy2EIL/epFryhou9gJ+Djk88GXd3hJju9lZgSlU02f8ObJtMcCyOu+fIIFxPTxD1UtSo5nwub0bqQkUOf+UiHseAB2KbEE8XBoYSUJbNW4dIAvrT65Jlb7KDphI1+fkE+f4/cW6NpdIqQiwhn+e5fOj/3stEZe7qeWsZlQ0dQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HeIi0UYL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ERYdpvYD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HeIi0UYL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ERYdpvYD"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61P9SIkL1363560
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 16:24:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=lqJPkq57cn1
	TyWk4V1DgUzt2+tE6UWMkjdqzLPn1F5Y=; b=HeIi0UYLyZRS/0rwpwj9lSgJl0m
	ziZ0oj5hZF0guWBNjAIeDx8JmXRRjYzI6+UEUeOfr2y/TpIv/5A3fxARqzDPOEWB
	wyB1r39UBQuUy1GgqIcXLaEUblBUD45NhqyVjoWr9km0xU97AAEUcw45sgk2szY/
	kA6ftwuk2Ieb627S/xxkjnfHG+CbIhCKdYdLnA3KrfaxS4zZSoN2Vx/1gXFEJDb2
	4NioxDPgk7Ekp+RDWKPXnWOwc3UgoKSEkgoMNfr2psIbCsOmejFuOfOyaNh0F39q
	efyPK1tjRgbCkv6eQL0WMRIF0p6hPlFoA1MTh7qzq9wyXf1wLVfl1ZHH//g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chp15apk6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 16:24:27 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c70e94017ceso585704a12.3
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 08:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772036667; x=1772641467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqJPkq57cn1TyWk4V1DgUzt2+tE6UWMkjdqzLPn1F5Y=;
        b=ERYdpvYDokv53zRDQ4LVP5KtQ0KfYIoiIu6NksJgHy9bjVtBbS5fkuXvy2yRFNmwez
         ApzkY+hacXy4vkXSSsJ3HjZbAdfkExmRBTZiRKm53kweQSskveJ0QyqcgUwggPv66kRw
         sNNg9nvNJFM89MO6mIHZYxC+Wg5fdkszUbxiJnma/5hMS91UTbli2xNl5AvbiPrflN+l
         KHG8e1A+oOmUmclimmnYzh4QbVTroVhvv6l6Qe9NB/90HfO2AXx7eQ5sOfM0ZF6a2CSF
         Kfur7Uvf2vq/tINxmhZ1b07fF3VZVOHuiC8vjBiktbXm+P4gATkiLUhSGM0ryKQ0FSv/
         3byg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772036667; x=1772641467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lqJPkq57cn1TyWk4V1DgUzt2+tE6UWMkjdqzLPn1F5Y=;
        b=u0vF1DKKA8WVasfEEhbcwGYbscRtBovynpTvr2rtNNQbc7JmRt/lSkkG3YB+3nnnog
         klmnwJIk5ZihTizgFPhNBeKu4o/BDoA/8nCj0bRfMHeEQfG0xil0P2u710hwCGsUYvfw
         ihXMrP9LObAwkFuYJEU66S4M+j27ldaw6lh16vUaVMbnQLxF+clZMi1A/hK0IqX1RgZt
         ta1UppE2JTMx/oL72mnsxkE0mHeFYzsZ4yJttixyNIc08bYlIcUc26DIDF9gouMAJXeB
         toQvQKjS6rL3y8jGAVLBIr2YfABXSeOnpMxA2tRbvnEvTGvKNS8HVsDXBtaiJ3oWTGsc
         p+EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVYcUwNyUEcd2LE481ZRVZBKsn6qBKgP9KBajMJlMG+I03u/R+GZSNjcoaj9nnUZ00FH8EgkfUGxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBDYZJSI47KgYVMS2sjaKIMNm4KNEdeh8EzpMXIHuzsO0mB92n
	Fcyz25/eDK9+fTmD7Hs6tI5pNZ9QknjZXNSsPhUvhqxfZ7hhYmydgdOv0Tbkj+NoR4yGDsNywIX
	BI5noh3G0tSWrCipVSU3zJtqQBuMq8fWEJz8xIRdFu0mSsaiSvWiMteIVKvRVMEw=
X-Gm-Gg: ATEYQzzsih2+YFRTbpOf+GhFInUgTtiEOD6ttBGok9ZURf1xIYYHoYW2mq4jmXZ/kSz
	K3oa3dAVd0Sm/wAgWq/Ez0gTWdqrVDcVBiKXZaYRPzbtOPPH0CmOJZwj9JTJVzH7g0X+FOi077B
	Joi8PEpiSr5lapwx4f62Xfyj27FD8aw55LCFtpax9jf9aQLlbS4OS3cwqBRIOHm5SbDOXxT5e4W
	gBO6rvuL7iZmYD0NctqONiNiGlOoPKVEEad3Ofltotp3EI3gRa6QSfCsI0bwMli8uWo2kRT3bip
	38MtY3/GT7YLE+zBidvRRh1tI1jPCXNU4/55TFQ2EuXoRr1TXjWiYuDWvGos7TOGgrIWrAl2FSM
	myxnwpavAwyFBbXkc3AEm9A7G5m3gLWvmijd+wofMeg==
X-Received: by 2002:a05:6a20:6f91:b0:38d:efcb:2e84 with SMTP id adf61e73a8af0-395ad0f10b1mr821277637.32.1772036666601;
        Wed, 25 Feb 2026 08:24:26 -0800 (PST)
X-Received: by 2002:a05:6a20:6f91:b0:38d:efcb:2e84 with SMTP id adf61e73a8af0-395ad0f10b1mr821250637.32.1772036666055;
        Wed, 25 Feb 2026 08:24:26 -0800 (PST)
Received: from work ([2401:4900:8fe5:3076:4038:f293:b188:d52d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b71a735csm12822380a12.12.2026.02.25.08.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 08:24:25 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
        kwilczynski@kernel.org, bhelgaas@google.com
Cc: robh@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        cassel@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH 2/2] PCI: dwc: ep: Add MSI-X Enable checks before raising MSI-X to the host
Date: Wed, 25 Feb 2026 21:53:59 +0530
Message-ID: <20260225162359.116000-3-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225162359.116000-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20260225162359.116000-1-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE1NyBTYWx0ZWRfX0uEINQT6DGbL
 LnjI/oMKfMGM4K0JkQTlPN7jeWVjoTANe63Tw1brKGuqoDy86JnZEBBVvgjsHAP/AD6rNrdXKyF
 WgiZfguW6IamaZHYdmpr54JE/l3G1wdJ2hnepf3m3S+IHKlQu7pdnDUyVcW2VGyKLp4lJ7DOBZW
 pouf92NcTtJQPeaUr3zQfa95mfq+xoMHZzJPKaUlkn5YuCmU+7saXCVOGehqulpicv+tBq2zRDo
 D2OI0h4LQfVOB46Jswnjeow8UYPz7eg8FZ5eyX2GTDlfMY/T7i/Ms+AWN5MiN/VGo4E6ZezRGNq
 SVf0mjesbyzNG69EZDdPDCQdeewGEokUZAMIWp7i6bAMFk361gDKyAwGLdn8EomKdaJ7uN/FGpL
 7861WEZCH4DLt7bmV4ICZTVkZCqPd7zwh0Oryw7lgjd5ATTdEtpv7eMsAYY7IdDEif74gzvsL6R
 tAnxMiYda1TYoBkTmoA==
X-Proofpoint-GUID: vpZ8CA47mCsWo4q3W6a3pKTmaFHTHt9O
X-Proofpoint-ORIG-GUID: vpZ8CA47mCsWo4q3W6a3pKTmaFHTHt9O
X-Authority-Analysis: v=2.4 cv=etXSD4pX c=1 sm=1 tr=0 ts=699f223b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=pe7Y6ikbsv-OezTykHIA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_02,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250157

PCIe spec r7, sec 7.7.2.2 mandates that a Function should raise MSI-X only
if the MSI-X Enable bit is set and MSI enable bit is clear.

Hence, add those checks to be spec compliant.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index fcbd648e049e..47bc33346342 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -1018,6 +1018,15 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 	if (!ep_func || !ep_func->msix_cap)
 		return -EINVAL;
 
+	/*
+	 * PCIe spec r7, sec 7.7.2.2 mandates that a Function should raise MSI-X
+	 * only if the MSI-X Enable bit is set and MSI Enable bit is clear.
+	 */
+	if (!dw_pcie_ep_msix_enabled(ep, ep_func, func_no) ||
+	    (dw_pcie_ep_msix_enabled(ep, ep_func, func_no) &&
+	     dw_pcie_ep_msi_enabled(ep, ep_func, func_no)))
+		return -EOPNOTSUPP;
+
 	reg = ep_func->msix_cap + PCI_MSIX_TABLE;
 	tbl_offset = dw_pcie_ep_readl_dbi(ep, func_no, reg);
 	bir = FIELD_GET(PCI_MSIX_TABLE_BIR, tbl_offset);
-- 
2.51.0

