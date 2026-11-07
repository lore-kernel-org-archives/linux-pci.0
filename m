Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794015941;
	b=kWevbktJUfalwJSabRHwWcE+N3CoJ1B/W2hrzPLPw9SEyCXI26mO+MaRjeeUumu/Kv4U
	 TooOEs+3SNe0A9jNo+pPrv/N6cY0DZAjXNGC10StXv18Kko7ZBObQCxH8vVNS17ClNnDc
	 UDXs2lZYyh9Uko/i08PHRKxEheY4OAkyd4piNGsOQcukN5iM4rHGx2eknQ0z9/qofcUAG
	 nHcUmJcqll3kgB4+38+nG13twci/pn3KmMm8DcSEQWT+bAG9n47A2TvH0RUIXnK2y129/
	 8tY59b3cE98eMoy4sMmA6JNlSt4q3vPsv16/SFL+8EBV3lV0s9euFLixBBPN0jE6TbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794015941;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/09Q5KhSRrrCofDw1VcjmaDROSjjFhbLxlpFhzMt0Fo=;
	b=bt6r8Wwlzn1siAAEZBKyjb0Sn7z/KbmBgx3lrVLtAOJqVQ5G8lRh96BoKXoJhUSuZpxc
	 5sKYOIKZ40/Y1ZDJ9dU/0pqzpTPm4exvh+VtzLpAsrpypWu2beO/t9UFtZjsLB5cGm88C
	 qoy5oMibTJd3ZBkgScAfZhtI0X7awqW0FVOfwXgW1bNyC6pW0tc6GJdghryAC8cQHOfVi
	 cSamup7CHKUS7zQFGlIeGEcmUMtOJQhuZJNbZUQ4Ms+V46xBLh0hh7rK44gIF2cRnkV4L
	 Voy0vTw7XXjOzO5sR25RqC6ma9a0ZHTrlP21AXFZR4ONZ5KZ4mdgdwn+ns9RoTcNX1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JrwrALLO;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eWui0vDl;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86488606D824
	for <linux-pci@vger.kernel.org>; Sat,  7 Nov 2026 01:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86488606D824
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JrwrALLO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eWui0vDl
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6MoIdO3696812
	for <linux-pci@vger.kernel.org>; Sat, 7 Nov 2026 01:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/09Q5KhSRrrCofDw1Vcjma
	DROSjjFhbLxlpFhzMt0Fo=; b=JrwrALLOlGNDv9hH88egMc/04XN1Gzf7T9ZDNT
	QConkTEm+cQZUDw6FLKPuMyaebMlT8oRqxNQLAczKzg1yq8Lj2uDRBoUiTqX7aOV
	f6ck5mRbZbMb4OLdrwQPmUSumTEnHJHjtABN98Rhbr8Vb1J+cvqI12IA250c0Xdo
	H8RZC19qEn+SuwJt71wQzF3FgMGqK2BzndbQ1JnY4X1EO6YEvw44R6NNUgLcrxFb
	ggd9x2D2wJF0SquodvIFt1DDD+Mez53pvejOB7CqCxm45XzJlpTz1hFFHbtaMamy
	+DnEhzjPvHd0Qxqa0zJ49rQYwnvq9BvLswiX7soO4SOJxORA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsmyqs20u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 07 Nov 2026 01:45:39 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36ecd5db581so3964208eec.0
        for <linux-pci@vger.kernel.org>; Fri, 06 Nov 2026 17:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794015939; x=1794620739; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/09Q5KhSRrrCofDw1VcjmaDROSjjFhbLxlpFhzMt0Fo=;
        b=eWui0vDlDxEK8F2WxvmvnlbkK49XE0HTEMaqaRujan5ax66+3fDRNq/b8SD3tlG3ZE
         NdNJma2jAs/424maVj8IVGxXEtYBVHwLIfppD9A1YMIfYAV3noyYpY/XEIRC+wg6I0zL
         X8XQ0vUMkVKckSZsztHKr8/h1DV+dSI2FALRJi5VeI2m2BjfmOmPQ7JOLymMpdFYv1aM
         m3pyBMNm72MBA68+9iq6u0715MNppValqtqp55UntQe8q+FLLVoH+lsaxVz5mICsQ+70
         vXjE7wUcucmrHon9FyoHDy/jLCkkwMDgtgjf9uwhv0VGiLPQdiBDVoEvO0ucrXNt6XFv
         b65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794015939; x=1794620739;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/09Q5KhSRrrCofDw1VcjmaDROSjjFhbLxlpFhzMt0Fo=;
        b=dQ6nffBvvkwC3WWtORIWG1lGHrvfm5eNwfxVSmTFZe5jJgE1P7pcZiMG0SsIaEZEH7
         6cjimX7/zIs7ExqSD7Vpg6Ayt6f5SowNmU9zhi6GCPAg//+K4V6yjvIrm3R3PD88ncMX
         HUUqAdpeqV00lFQ//eHQCuIvNuSi4m1VswOfoVo8ZA1NJJh78xO9uRBBpXnbdisT0K/u
         VL5v0ZAujeijF6mLtGPEWTjfryfT5C2ZkP9/IazNnHDdAPCZ57D6x7Kp35xfOVenkHoH
         tJz0OjhSWqQ5P9o2SHFHdANhUssYJTiEyvi4abHmntmeNAR9aYV9BeTOWP+JPVcukcpS
         jUdw==
X-Forwarded-Encrypted: i=1; AL+hErFjJwwz9bEbRioEGSCDHxeWClriWJKBkjFM/ePacSu7w6r69AbkWTtAc/p3z0XihGKNdzffxKUfYO8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/t5i+DEsHsCLa4i3UimkpljUdEaTqSOJv1YjrQ0DIO0qeq43j1
	RnpUFfpHZN7XdpkYrc+bIpoatYkRA5s/fELevGN1JV3H4SRpE5EambekOwBJc2RKGiKJIC05vOT
	3/Is7jhRuPov544Zi1Ml/jMQ7xEe+YYhw8M/Ks0nQ9onUemgxri+bTe/bSWK7+Qk=
X-Gm-Gg: AYBFou3HlyaIYgPO27SSy8Z5wfRPKi+fmtp9w5bZzqwEPuFbR7Bg7kbwjD5v7YSO2hh
	WcXOTEY7IGK1Tr+j8gpVIeK1FTiebFNREwiNyDgC6sBXOTWEiIZmVCZI1tphIBGt9unSub64ynT
	dDoAepuUUzNo2181ylpR8zIOSvutosVL/CECUG9ANLDm9zeITCVwlQZrQOI2ufNzQQVYXXjwDGx
	LILVVO3QSo2j5uhd2x0P+yKmv6wkkpGMgUlrnwTxV4cvazjzZemqvHtJ69HqmzDx8CPwt3i9Fl6
	Hdyp5dHPxlbZSbzX8EiMYHVVQ6tgwmka00w86DHwjhVTjob0CYQzHQD9VxKH/Js4+XUUc52tUkn
	Q5H+d+n5FDUxFmAN5iEdS9xfKz4Y3nNJlexOmywn8wDxOXLE4zkECP2CNvt8byLTvG1mCv+OkRL
	bGCTkXPmc=
X-Received: by 2002:a05:7301:6498:b0:369:f3b8:2c48 with SMTP id 5a478bee46e88-36f7700ab25mr5219295eec.34.1794015938526;
        Fri, 06 Nov 2026 17:45:38 -0800 (PST)
X-Received: by 2002:a05:7301:6498:b0:369:f3b8:2c48 with SMTP id 5a478bee46e88-36f7700ab25mr5219245eec.34.1794015937818;
        Fri, 06 Nov 2026 17:45:37 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa651e6b1sm22861123eec.3.2026.11.06.17.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 17:45:37 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v8 0/4] PCI: qcom: Implement shutdown() to avoid SMMU/NoC
 errors on reboot
Date: Sat, 07 Nov 2026 07:15:18 +0530
Message-Id: <20261107-shutdown-v8-0-bf607c6429b0@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAK6C7moC/3XQTW7DIBAF4KtErOsIhj+TVe9RZTEYqKka0xrba
 RX57sWp1LKIN0hPet8biRvJfow+k9PhRka/xBzTUEL7dCBdj8Orb6IrmQAFRVuAJvfz5NJ1aIJ
 vGTcuBLCalPrH6EP8uk+9nH9znu2b76bNb40+5imN3/dbC2y9B7MLNLSRQFG1gVmB8jnlfPyc8
 b1Ll8uxPGRbX3jtReV58S3rmLBWI8Ow40XtVeVF8d7K4I0TUqDf8fLfGyorL4sPtFMWAzIn9u6
 r2pvKq+JV+VPrGHDgasfrP88o1F4Xz4PTqBUqY9gDv67rDxGlkV/5AQAA
X-Change-ID: 20260822-shutdown-fe8139dff2b7
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: konrad.dybcio@oss.qualcomm.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794015933; l=4333;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=c6iEBbfphtbKnKMP7IQEkEsozy1ReFye288PSugCR9g=;
 b=SveFzLDGrnN6Sh47Yj8flHdZnaWFoWDBk8MIopfFuqrGecd0YqYxlInFQBv7EjB7++FQ6FJ7X
 fMhImGSRlN4D3zr6o317Bj2TwvnTb7tp3PAcACpPCHNYq9/hQ1D046P
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: Qq3YUNickdGltYsiTst0WbvwHiciF6VO
X-Authority-Analysis: v=2.4 cv=aNZlOr9m c=1 sm=1 tr=0 ts=6aee82c3 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=oBmXpkfWcQESfIqoYmwA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDAwNiBTYWx0ZWRfXyTKu38nVKupo
 uEAFzlKbFDHYASAbMNzc9fBBXD+RqsxebhD3IVHxBnhpaHOixAeB4bDIlrBnYQva0ZbCR2YcRB6
 f/vl6UDnFOneSVAWo+8Vnz3774LdTe4=
X-Proofpoint-GUID: Qq3YUNickdGltYsiTst0WbvwHiciF6VO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDAwNiBTYWx0ZWRfXyY6qXD0vErbJ
 5roh9hfaHnwfRCtfB2NZjX5bzrjk7s6CVXSmiLCr8/35naznWQxCGXt5O105QIJo3yqksrVURTW
 ASb0uIhi0VExxZ7vr+qOAy+ECA69lskUh9V87GdxZkWB0ZH/pzfrLaWq4ISJwC+jWC+Y9wIaoiT
 WNQOM9ZaXai1aNOzwDBSMDnrWfNmrAnJmabXyqD5Pn0NA6e7Cw5TY6RRtTstDEuU4TAF4/NKwrn
 0Y5NJ4ta9zlXZyrEsARcXZpuuKHxmTki9vXOvT+9DhZ9pMbg9qF4EN/vsYSeQQdY2IV1L1z5NT/
 m/Hg8Zj5iqNw6vzqWw2PZLScrJBvyxkWG2WEp+sY3PFBT9coFfizNCr1AxJQ2zKLYZYPtPFbbJ/
 J1VsQEs7RTz6ii0aWH8DSbnCCIzSEhSnsfn1wFa7E1idgGeuWy/mnTLs2xxpL3H+vI2PjHds8UU
 CvZLoI6snqwy/Ynu38A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611070006

During system shutdown/reboot, power/clocks to the PCIe controller get
removed regardless of link state. If the link is still up when that
happens, it can trigger SMMU or NoC errors.

This series adds a shutdown() callback to the Qualcomm PCIe host driver
that forces the link into L2/D3cold before shutdown proceeds, reusing
the existing suspend_noirq() path.

Patch 1 fixes pci_host_common_d3cold_possible()'s underlying bus walk,
which aborts as soon as it finds a device outside D3hot and can
therefore miss a later PME-capable device -- something that becomes
common once patch 3 starts forcing D3cold entry during shutdown while
endpoints may still be in D0.

Patch 2 adds a force parameter to  dw_pcie_suspend_noirq() so that callers can
set to make dw_pcie_suspend_noirq() force L2 entry during shutdown/
reboot, skipping the D3cold capability check that can otherwise leave
the link up if any endpoint hasn't suspended yet.

Patch 3 adds qcom_pcie_shutdown() and wires it up as .shutdown.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v8:
- initialize 'pcie' to NULL to fix uninitialized
  use in firmware-managed mode (reported by kernel test robot & Sashiko).
- Added new patch "PCI: dwc: Add dw_pcie_mask_msi()" providing the helper
  used above.
- use new dw_pcie_mask_msi() instead of dw_pcie_free_msi() so the
  MSI IRQ domain and downstream MSI mappings are not torn down while
  PCI devices are still present (Sashiko).
- skip dw_pcie_suspend_noirq() when the controller is already suspended (Sashiko).
- Link to v7: https://patch.msgid.link/20261029-shutdown-v7-0-3fd7a76a6991@oss.qualcomm.com

Changes in v7:
- rebased on pci.
- Link to v6: https://patch.msgid.link/20260909-shutdown-v6-0-62b7bd123236@oss.qualcomm.com

Changes in v6:
- remove return 0 in d3cold_possible() (konrad)
- use force as a paramter instead of the element (Mani)
- couple of nits (Konrad)
- call pm_runtime calls for firmware managed one also as we are enabling
  pm_runtime_enable and get for that also.
- Link to v5: https://patch.msgid.link/20260905-shutdown-v5-0-f0c6bafa1d4f@oss.qualcomm.com

Changes in v5:
- use a flag/parameter Instead of poking the system states (Mani)
- Fix pme_wakeup issue by walking through entire bus (Sashiko)
- Fix Irq free issue by using dwc free msi API (Sashiko)
- Link to v4: https://patch.msgid.link/20260826-shutdown-v4-0-eb5fe9d454ae@oss.qualcomm.com

Changes in v4:
- removed goto d3cold, (Konrad & Sashiko for PME error)
- Disabling MSI IRQ's (Sashiko)
- Link to v3: https://patch.msgid.link/20260824-shutdown-v3-0-81c14bb7a1af@oss.qualcomm.com

Changes in v3:
- Added null point check and use pm_runtime_put_sync (Sashiko).
- Link to v2: https://patch.msgid.link/20260822-shutdown-v2-0-520a68f1b4a5@oss.qualcomm.com

Changes in v2:
1) don't remove the endpoint pci dev's only keep link in D3cold.
Link to v1: https://lore.kernel.org/all/20250401-shutdown-v1-1-f699859403ae@oss.qualcomm.com/

---
Krishna Chaitanya Chundru (3):
      PCI: host-common: Fix early bus-walk exit in d3cold_possible()
      PCI: dwc: Force L2 link entry on shutdown/reboot without D3cold check
      PCI: dwc: Add dw_pcie_mask_msi() to mask chained MSI without freeing domain

Manivannan Sadhasivam (1):
      PCI: qcom: Implement shutdown() callback

 drivers/pci/controller/dwc/pci-imx6.c             |  2 +-
 drivers/pci/controller/dwc/pci-layerscape.c       |  2 +-
 drivers/pci/controller/dwc/pcie-designware-host.c | 31 +++++++++++++---
 drivers/pci/controller/dwc/pcie-designware.h      |  8 +++--
 drivers/pci/controller/dwc/pcie-eswin.c           |  2 +-
 drivers/pci/controller/dwc/pcie-nxp-s32g.c        |  2 +-
 drivers/pci/controller/dwc/pcie-qcom.c            | 43 ++++++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c       |  2 +-
 drivers/pci/controller/dwc/pcie-stm32.c           |  2 +-
 drivers/pci/controller/dwc/pcie-ultrarisc.c       |  2 +-
 drivers/pci/controller/pci-host-common.c          | 13 +++----
 11 files changed, 85 insertions(+), 24 deletions(-)
---
base-commit: 21e09cde4165aa86de15da9d14b28e3317abe59a
change-id: 20260822-shutdown-fe8139dff2b7

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

