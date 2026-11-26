Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795671881;
	b=mclGgAMfZOS7JX3PLPH8jq85w57uyru2F4WCrm3+yGh/M8FklWOwLFfWWImX0hu82+MS
	 n3C56GphXD+8Fe4hbTlqCzu/7bc9hx+thmcDU1lciWqybrdzJ9wZHnukB3IYF8pIH2rbP
	 N8JyZoT3nzhFJzDKxifqrMAsGrCJ2UPTK4DDkbgG+9Yor31jUOTW2F4Ow1f1+/hnZ+IkL
	 BrL2M0ics19EoPrOSxdWXRbPrsghWdODKc2punR8/FuNwjsk67skYy4Nj4dNtHgXOCQ7p
	 Q7pQ/KgPhqs/8FiS23Na9/+gItqvbK41qTPweRgVRnVoMW/Cxs4vtca1S8dkixzoSQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795671881;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=VFb2pJiY8iJvPy2vop/0LNRFAle+KcEVjqNYuL16LLg=;
	b=luTJeGzFvZdnTxcY0U47l96VduBeBF8JyllNfG1r4V17pOoHzhHlLPTg9VALWt5UeT9Q
	 HzijLlZr+hZ/Iov8RtxaJGMbQhDXSBXZqKoUH5CXITufzzCt8o15uC1E18NsYMZhpO4w4
	 2QgQnRpUk9OtcVlHtx0AT0WHRXjYKlA+1W+AAlfqbCEoLcc4RGaGWMLhmZY1cca2U0Ab8
	 U2UHqx8FqR+6mLaXVS9pC1CJsZkGLYulP+hO3bT8v9NEbxT4zp/mOdL7VCUO+sjUp8R/4
	 MDzRAbp2cva3+6/o8xcQNs9MhutOa3JiY74REWjqEus5d/ZbyMYOk45T6H4aZgP23iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c8std5FK;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JEoVe76F;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3E5606A31C
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 05:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD3E5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c8std5FK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JEoVe76F
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ36NQs3022950
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 05:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=VFb2pJiY8iJvPy2vop/0LN
	RFAle+KcEVjqNYuL16LLg=; b=c8std5FKk24ssludg9uB4gpf3iseRkEHY5dG/h
	F1IioKRWcme9bMXRItiCrkSMoG04K5cuXkqt2krU2kWrnNTaBYfXReML3XMmd3RT
	URgUQVP32WZsksqKPVesCdiDFAq+z4eOhOi4gam7hwv0/cIR/1QaMuzwAlBlY07U
	EGOslgkuekgLqW305q36Tli5bWCQV5NXZGz0Ko2dkJAijTOV0HdjBRY175fyVHGH
	RDqpWhoZeCLsKzaLX4uPQVbVyVLOp5CZoB2XALYHfNQTbvgHFQ7ZzjdBdAsq+dPK
	5CWbCErPiEBOYiNQi0t6KFApv2cJCwIhWSHn3SoKLCxh4Kbg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j62vater9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 05:44:39 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-383ec96a7deso7123373eec.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 21:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795671879; x=1796276679; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VFb2pJiY8iJvPy2vop/0LNRFAle+KcEVjqNYuL16LLg=;
        b=JEoVe76FvnCgIQb75Jlzl38XvnqmaC08agMtp4ogv4Jh5Z+Q+b3F+t1QnB0fu8qNaB
         IDvBBdzEF4UiwrEqHksX08lyGoMUKwY8JMfhSnHb8q8YozsaXupDeM66L/IiKnyCRf7U
         6fMt7+c7rTVvaQiwW8U7jCRppVXA/E58FEzs+TXUvtGFnNBzd/5b5+FgMB7RtcjtPd1A
         zvFVVwdx875qj5cWv9atmPB5TvDfjdg4lTOuFNndSshTF4vs8NBthQa+ThBitLY95LgS
         ji4zbHBdf3mMxBuSSaSpg7Yu6PY5A/Kfflv7F2fPTmMN7jrxd8KCdKMGX0ScAlhGNOPW
         xrmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795671879; x=1796276679;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=VFb2pJiY8iJvPy2vop/0LNRFAle+KcEVjqNYuL16LLg=;
        b=EdV4kxTtXONHQzysSAlJvTcN/M8Y02EJdRhIbxQhULeoTng+cs0aNti8WzFE4Cq7pe
         2Ri9svnRwXQDdE3Xu4SSdzcBZNTAyr+JaXj8Mbz+hzm0uod0BhlumKBDczpYNBQ/b82i
         5mvq/HxcooeT7fuRQ7EdwYLdjQRYj/wweW5Sfid7bIyFbLeH/piSJZ3EYULxAma+D5gx
         Qlp0/YGaPFRhLOL4dYhrZ/zF7RD2ONR+3M2XvmYQ/7ISKt8ARgrsE+nRgSf9B/oez5cR
         iIUwoHrWn3/nw1wrx8AtJmiBfdmTRbnM9Elb5kWikvmnmIXK9Du4HbrVKt3gt5r3217M
         R7PA==
X-Forwarded-Encrypted: i=1; AL+hErFlA9I7cLIDjluWnHzx3mq+wb00G7KiB1Bom5srVmDRPT6o1uw7oT3BJaXGIwnEWfsP5p9Lwjt7kAc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+VktF8ypJheyxwRGNmiKuEw0NB4knVb8DWcFNrPNugzIVyChk3
	sSLHC6MDcOZKSxD/0z3tBwDK76PontSenVUd/MTrWTJ4GEAaxZdmqn4uzAwrS5TeMjaWdZl5JhQ
	M/TmTxebAGG+L1WGmyNHd8zLXAhphpszJ3LsLe5tI70k6idRvuBwHFmvAfcP7s+c=
X-Gm-Gg: AZFdTZcU6OsilJ8Uim4dePIyp9HdvsyB1qRjpenT157L45zMKDJ6bRBo6ZEC9Jp+TXB
	TFcMH7V7xWNQBTFXyHgC17ljGIGJ8IBZuAP3cc+PntC57qImzUplHN6IcSaY2UrH/uXVsiPcR6v
	uZD1mPNdphsRobIAcBzfHDwEVQOrnbO2//a+fju8DyxwrUddk1AJPIsvnDdEu447ozg1HYGlbLd
	hVYIX0fq3XL5TcWulH0NVtrC9BTIn8BvgJOYqhoXqc1vFyrQBaDNxYz4PMHQ6cyjR1MbU2qjzlt
	9fehBoZfd5cEIvwUrhJnYPjlzTGJO+/gUi8Ij+9VPcHxlwduP9VjkYo+Q8qQSmXHM0wsF/K1xjN
	HCpvF1rGSUXSKq/wZrxI30FwxXnnUkDNgfqsuuZ09j3z7pUhm14kv+zDYYF4Dn/xTFzakMLkkwo
	nAmD6mvxew
X-Received: by 2002:a05:7300:881a:b0:385:8aea:11bf with SMTP id 5a478bee46e88-3858aea13eamr23856390eec.41.1795671879291;
        Wed, 25 Nov 2026 21:44:39 -0800 (PST)
X-Received: by 2002:a05:7300:881a:b0:385:8aea:11bf with SMTP id 5a478bee46e88-3858aea13eamr23856368eec.41.1795671878754;
        Wed, 25 Nov 2026 21:44:38 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3866f299d0bsm50629223eec.19.2026.11.25.21.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:44:38 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 11:14:34 +0530
Subject: [PATCH] PCI: qcom: Skip ASPM enablement walk on resume
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
Message-Id: <20261126-qcom-aspm-resume-v1-1-a34625656e92@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAEHHB2sC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQyMz3cLk/FzdxOKCXN2i1OLS3FRdCwtDAyA0sUw0SFQCaisoSk3LrAA
 bGR0L4ReXJmWlJpeAzFGqrQUATxA+rHQAAAA=
X-Change-ID: 20261126-qcom-aspm-resume-881010149a0a
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795671875; l=1969;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=qJc5dAwf+4nEm79Hn0JT1EAcYLvIUNn0CgyoUbmmUIw=;
 b=KZKQe6mZ+/o6KQhYDSrra9vXGpsBHnF+2+4hQqG/qtHFez5T+ebgYZlGe7VwbcFDkvrh37vCZ
 qUMufJpK8T5AoyJLxlKsOV6HrGOyTCDYGNRS1TupdfGc1GGMD+qoPD6
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyMSBTYWx0ZWRfXyE8bVFrIkwCG
 ldqB9HQ/nfBJSv0YB/mtrgLUlK/u7yh651igKmuArizkGi/f/bu1y/jT8bVribWX9Y42N5T+2Kp
 ZLhFkgmSiUudBfiKlrovV9tgOrCU0M8=
X-Proofpoint-ORIG-GUID: NBK1sqmkE09vBmWHII4AUBgGBU9fq4P_
X-Proofpoint-GUID: NBK1sqmkE09vBmWHII4AUBgGBU9fq4P_
X-Authority-Analysis: v=2.4 cv=QZPzLcbv c=1 sm=1 tr=0 ts=6b07c748 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Py5lcOcq67Lbq8UMOfUA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyMSBTYWx0ZWRfX2WMPgtfqSNsM
 LDi/YaFywAKsPdrykBgg3Y88DbKZRLOZr/aCG7Vt99euntjDwVnlpgnLl9N/7Yx5R1PfVOW889R
 38Io3oPFYi1drBYsVWMLLz/6MG7j/XrQ4y8J5QTZuSoeOhpzUlD3CLLDHIV/UUQ/b6E2RcSo+Ty
 xEX/l5BvKs+j69vmNizdXEeE0eHuFhhlRVN1PS1813+2G1vJfWQTE/79/UwPwxDTcus8ysd/8es
 sdi0E0iF73vMVijyIrtFcr6nP3rVJUzuLyDdbsBcPqrZrh45SlDqIPsOks9jSmsYWno9V7ePwU5
 nA1OHcly/VYyiQrbbMb25Y1vFLzAZ56L7f51a2jTNVP4XgNULM+Ly0D3boFxGLYa41rOzEOQQFv
 SJHmXJatMZyQUS9sRVZV0aHqkCms3x0uFundtSyHj8dUgdGMLGHNo3SQBBx8sjqiqamJL00qaKg
 EXVzJQULebekntK2SsQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260021

qcom_pcie_host_post_init_2_7_0() walks the bus and calls
pci_set_power_state(D0) and pci_enable_link_state() on every downstream
device. It runs from pp->ops->post_init(), which dw_pcie_resume_noirq()
invokes on the resume path in addition to the initial host init.

On resume, the PCI core has not yet restored the downstream devices
saved config space, so the config accesses performed by the walk fail.
With a PCIe switch in the topology this is easily hit, producing errors
such as:

pcieport 0000:02:01.0: Unable to change power state from D3hot to D0, device inaccessible
ath12k_wifi7_pci 0000:03:00.0: Unable to change power state from D3hot to D0, device inaccessible
pcieport 0000:02:02.0: Unable to change power state from D3hot to D0, device inaccessible
pci 0000:05:00.0: Unable to change power state from unknown to D0, device inaccessible

The walk is also redundant on resume: the ASPM link state is restored by
the PCI core as part of the config space save/restore. Skip the walk when
the controller is resuming, which is the case while pci->suspended is
still set at post_init() time.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index a6a0e3ecd921..bd1ffbf5c21a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1174,6 +1174,9 @@ static void qcom_pcie_host_post_init_2_7_0(struct qcom_pcie *pcie)
 {
 	struct dw_pcie_rp *pp = &pcie->pci->pp;
 
+	if (pcie->pci->suspended)
+		return;
+
 	pci_walk_bus(pp->bridge->bus, qcom_pcie_enable_aspm, NULL);
 }
 

---
base-commit: 647e1e846730c6aad27e9b858df292f5d4377f63
change-id: 20261126-qcom-aspm-resume-881010149a0a

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

