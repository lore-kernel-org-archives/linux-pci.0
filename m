Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBC73B388D
	for <linux-pci@vger.kernel.org>; Tue,  7 Apr 2026 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775565892; cv=none; b=DlrQtfuR11Rs46fn8dhQqFD1dJOqHTzgf3ijuBxstjSSr4LirDKya8vUJkWROU+yfbYVJX6heOOJcoOtlBezCJ1pyE9+0MmLrfAb6LMHk9/a4Ki8D6+U6LCS5w+kCXgWi1cdH60lHz/MvagIJNZOCusdMuNzvaNE9QwGY36U9SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775565892; c=relaxed/simple;
	bh=6vOJo8cFxGIBGsgdZ72PCKdeMVx3dnSGChMlP1LRF/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kik5qnBMqLKRJQM5LCnBTPTklcI/nPVWfrwJsISlKg6eMnMnspsAGGqcwAqtchArH82bvOJJ/9sjKXE1RpN4lwRMqMGa4Pspl8UVXDwezx3P4t6gfxhXAvBPSboOnsz0lOVX0KwD6vFsi2O1R+pmg+A3Tkndt8eCxbcTOyaPxbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CBBMQ8Yx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A1NYGiD7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CBBMQ8Yx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A1NYGiD7"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637BbFrK1584596
	for <linux-pci@vger.kernel.org>; Tue, 7 Apr 2026 12:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+McTs62jXEi
	G+U6yhLRFrie/mtKMh+Q9ylHrEG5OPXc=; b=CBBMQ8YxfOv+T/jzRRSo2B18sd1
	m9Wb5pVeCQi6kxLETjsFqcZHFe/DR6BbDk+nLiHhG9LlQ3wPL5w/4nGNGgpo9gWz
	hv1UeTtbJaoLSZlDCnyQRYSmBRejyqumEgPjHYVHXNOETM+/UdBLsWCg3EonNT1Y
	0Imt7UuvQC6MNkcgnoBHxWpr7ybgPCgPYFuIax4tNUqJBcPMXyvqeZcTR9EEaUA5
	3HJZ/wMbYetGZ1lUNvs67RVr8Vm9cOXWs0syyhsJCuYUBzxsfjMpX8jNWZD4LfPP
	yEE1EGrkJZazM35Hw9omJJHdLPPoebNt5SPPmGaniBvGL7q5WmZ4/Z7jVkA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmr9trdt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 07 Apr 2026 12:44:50 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82d02942266so6232864b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 07 Apr 2026 05:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775565890; x=1776170690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+McTs62jXEiG+U6yhLRFrie/mtKMh+Q9ylHrEG5OPXc=;
        b=A1NYGiD7KmLmZBApR6f1cTYl+8XH3f1PtW5JwJkKBTysVZOPjkjDdQKB87/Yb+cBEz
         7GKKKq7JQkWF7gOU+sTmOah0XT2LU8T3VXWyJ3v1Qv4f0Bww6s8JDueo1cTnbyPmpPTo
         TotlStST8QdG26wT0PHFY34FIPxEDlhSXhOhQWtdVxt+LoP+oKrLBnOP7zhWER2JWGP/
         AN8DtMTSv7IOPSDGbaCE2Q51rIXyQDhGELFxOS50TqQvNe1Tex2QilQpMlh5tYC7bE3F
         iarzaQ8fzUg6DP+BO9STCrbO6TzLdMmvtSxkaVbKmYOTCvjtWiaedLUD/01+EumN7ga+
         g5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775565890; x=1776170690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+McTs62jXEiG+U6yhLRFrie/mtKMh+Q9ylHrEG5OPXc=;
        b=D+8ajvpZ0bPMpOYony3zchooSPhe6ox5skxnW+4JDz/CMBuFHVELgTxxJU+IKbnyIz
         CTlQrEOHqZr6PlitEykUud0DmsmNhDHyIZfQ4NqxpXl4ciiMTBzV0BEMpdTYuSLhELnn
         iosVaXQK7Gjv7ViIw34cXrM/QxCHZkzoHiJ1yRhlZ9r9ETj2zV4d7OytNLrmAQo0Wtma
         xfKTpOqluszQVLh6HaJcQyl8FvE8tD/XyswFEjMCzmq8cL+eJLnggi4bmeDLz2ZoXob7
         NE0JvYmyiujaLBT6B0onpi6zQOQuA7o8CSiJziOH9fO83W1cfrwBjnUYw3/ylBV+EZ+c
         ONZw==
X-Forwarded-Encrypted: i=1; AJvYcCXT8QpRLmGXVjNfAnb9SrCdazj62Ixt8eCVrmf3qtwWUQg+ulJn8cyzUpChPYng+p4B9sC4vy8tlg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqrSyBjEU3Jx3u1XVXG/f4otwwJJV15b/Rv14/tgQvYfkpngk5
	Fl83fpz5Ph0FuGmNOMjblFC5aMlU9bhH0W238hIErmoqbyhzOcoWGPTCbmVv1oNkSO459LTXJJN
	aJkG7qFtcjZveaAnSdl/51uaS4iN4RLhsDerRQaBbh8V32rGcxHExldApqhULgjs=
X-Gm-Gg: AeBDieu/1dxTzodhyaC6UlRubCadL8lTgTJQZips3LWLUxivA7nva4iaI/bKmPx7lsB
	e7gfeyGm3EIVtJ/WjtPIKgv3I+Q+CXEWMPzHIdh5AjuEfGGw3gbdwhBkL6FAlblX4MZ8favJAUk
	7wPFULp0pyJxA+Nk+jlX0Gfw0Ve10KRgdVii/cF1gfXHdDITApTnzuvi15tBn20zhbcUbTdVCl6
	zR9bpNpLkbwYKHK7kquw264RJqxN6R7wVJ6d+9cMgjXxrip7OUtcz35k1HOhh2iKxHGrAzVBjvf
	cUuYETCSe6+2CCkDqljL5DYZ9PwSngDmc5LdXWBRu7F/5Pn4ER8JIL8DZCNxgk6QGYefIhWgIsM
	9wJ2Gtw==
X-Received: by 2002:a05:6a00:451b:b0:829:9c5d:4342 with SMTP id d2e1a72fcca58-82d0dbdeb04mr16110997b3a.54.1775565890140;
        Tue, 07 Apr 2026 05:44:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:451b:b0:829:9c5d:4342 with SMTP id d2e1a72fcca58-82d0dbdeb04mr16110973b3a.54.1775565889440;
        Tue, 07 Apr 2026 05:44:49 -0700 (PDT)
Received: from work ([120.60.133.76])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c3ce13sm18262551b3a.38.2026.04.07.05.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 05:44:48 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
        bhelgaas@google.com
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        ntb@lists.linux.dev, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, den@valinux.co.jp, Frank.li@nxp.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH 2/2] PCI: endpoint: pci-epf-ntb: Add check to detect 'db_count' value of 0
Date: Tue,  7 Apr 2026 18:14:21 +0530
Message-ID: <20260407124421.282766-3-mani@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260407124421.282766-1-mani@kernel.org>
References: <20260407124421.282766-1-mani@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SMdykuvH c=1 sm=1 tr=0 ts=69d4fc42 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=yDxY/ZQAnAaCL67VaoekCQ==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=PxpW6Q19wR3HJFGb5M4A:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDExOSBTYWx0ZWRfX2IMu1H1CX5cS
 +DfCCGEbYwvYDxr5EpNmxMx/LN4uJeVWLg/zwfZosp4onqGg3HUVyX2VJ5tORaMruiLuhZS2wT7
 3K9H+8yf9htFVcWlV72EOkZkURk/+tntQVc6rOD+3MneqXWr9U0X6KHdAKi0I9GUdHwGd4sfiAz
 DZ82SOZJqea7SxV6fcFG5MI2b8aJU6FOgr7AS9E8YcmfZj9SRe7joYFVf2D7ib0bdSMp2QvScd6
 QlPabOWJTy0VUed0CQmbOfC5TJ06V3Zr47eOSOJG4kE5Rfk6RyJPsr2/OOQNf3o6Jm77ToCG3Nm
 G+i8RRtp2YARReypVI8//KInQKWVmkYt4RrG0JawZxHs1wqpeEqzZsmeGkbwan9ppubmWQxJFNm
 bRSbipCRDGactr1JaHHGneFjMyhrOoiTpb6icuBEDLQFtB60tTwg4qukN4s5vImb9Kw2Sg+6pvk
 uy8e4+WLhtUtcG8xwIw==
X-Proofpoint-GUID: AOJkM8b9iUDITD0gkh9a4E8Tw76YGhoO
X-Proofpoint-ORIG-GUID: AOJkM8b9iUDITD0gkh9a4E8Tw76YGhoO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070119

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

epf_ntb::db_count value should be within 1 to MAX_DB_COUNT. Current code
only checks for the upper bound, while the lower bound is unchecked. This
can cause a lot of issues in the driver if the user passes 'db_count' as 0.

So add a check for 0 also. While at it, remove the redundant 'db_count'
assignment.

Fixes: 8b821cf76150 ("PCI: endpoint: Add EP function driver to provide NTB functionality")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/endpoint/functions/pci-epf-ntb.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index 2bdcc35b652c..7edd177f861f 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -559,12 +559,15 @@ static int epf_ntb_configure_db(struct epf_ntb *ntb,
 	struct pci_epc *epc;
 	int ret;
 
-	if (db_count > MAX_DB_COUNT)
-		return -EINVAL;
-
 	ntb_epc = ntb->epc[type];
 	epc = ntb_epc->epc;
 
+	if (!db_count || db_count > MAX_DB_COUNT) {
+		dev_err(&epc->dev, "DB count %d out of range (1 - %d)\n",
+			db_count, MAX_DB_COUNT);
+		return -EINVAL;
+	}
+
 	if (msix)
 		ret = epf_ntb_configure_msix(ntb, type, db_count);
 	else
@@ -1297,12 +1300,12 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb,
 	vfunc_no = ntb_epc->vfunc_no;
 
 	db_count = ntb->db_count;
-	if (db_count > MAX_DB_COUNT) {
-		dev_err(dev, "DB count cannot be more than %d\n", MAX_DB_COUNT);
+	if (!db_count || db_count > MAX_DB_COUNT) {
+		dev_err(dev, "DB count %d out of range (1 - %d)\n",
+			db_count, MAX_DB_COUNT);
 		return -EINVAL;
 	}
 
-	ntb->db_count = db_count;
 	epc = ntb_epc->epc;
 
 	if (msi_capable) {
-- 
2.51.0

