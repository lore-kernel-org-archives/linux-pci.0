Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795790464;
	b=TX779ocd3moGPRagS6agosYBnvEB+IltHSy95WT7u/4JfjOgwKR88a0PmIcQIIRa6XtZ
	 f+ArBMIp4faRiBpEM1Stfuvm+ucqFahNbuFxXHWSgrmAZZh+kkwybkR5sPDNseiBnB5zb
	 offX8bblK/aM1IfX6y+tuS6PUw3/HJnUolN4nC3ShtMQp5XwWKENvyJxTRNOHkxAJg3A5
	 Cp2YBuM6A/tXgwEQktsrTGxgqrkdEEpF9Pa2dsueW7aToW7Q37HXydfYVb7Nu6ESRHWJm
	 ExP8nSLkYGZR4CL9O3mD3VWKo+GkO+EABKvx7tyJ0URwQYqvYQcd0TcS5rAtYkrO1ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790464;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=SJHcj1ye4onm2ASg3L7GIHvM+mwNs4PYz45ZKyk2REM=;
	b=EKPBrIcFHL+p+vR1vuv4e4OdrSHDlBDYV0q7LQ+O9I2otVyQqqB04uhrHhP9fvuj14QO
	 uZaO00fb3TaVowVSXMkM2TkyL0mxGLzDOv9aPqzS5TW5J74U+Day4z3YryyT02cp/6gR3
	 HWx/kl3zodqaf0cjv3xLysOkBpASck1Thsj9rua62q/p1l5JadHA9eEHpMAywz3IHhxgl
	 xCq0w4baRs7UXahkc6Aiym4C+3kP0oZVjork64o4ktpK0YkpoWVtry2jvULkWsLaOFNIK
	 G61yeD4nU1wk+mK6DDD3f6zPAtHd6yox2UQyt8BsgzjSmyR+5z5p74kCKils/jXuUzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZfYYWJA+;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BnXszjpS;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66E5606A32A
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 14:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D66E5606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZfYYWJA+;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BnXszjpS
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE1LD41462579
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 14:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=SJHcj1ye4onm2ASg3L7GIH
	vM+mwNs4PYz45ZKyk2REM=; b=ZfYYWJA+vdAcFWrPAFNRo6SvLZWCqCpvXd+e9D
	vJxuZhpkpCAFLtAZs9glaQ//3Ma97B0u9CsQQTkpeSMKiSOFLQE0ycqK7kUC/aDK
	kaM/1tMbUJBEEZTxJlJk2VP/RddsyxnX7fcQ2qFtsBQsjO61ayhftpEyUmcjbd7F
	zQOB1+dBKkT3Q7dL2MuCsY98A7RhUx3/yU7ALe+Ia6tpTaWy4eWDxr5/nVT/91bD
	f8YwX4DItjQGcRbzcwMz6HXyg0U4YwXnxtN19F2Sf+VVgM4T26UZcgWDvAxYeyzt
	vN8Bw9acS5SXEs1YKuCunzebUjq2EyzhJBYkIywl3XjZzXJA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6pgqmdw1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 14:41:03 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-375bac6bd21so7951085eec.0
        for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 06:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795790462; x=1796395262; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SJHcj1ye4onm2ASg3L7GIHvM+mwNs4PYz45ZKyk2REM=;
        b=BnXszjpSGEHr+u/tfM9wFZHyINUNM0MAhhmTX1jsplEay3WW81EkpGD5lXB5p26Dz0
         hYxNvQyKHn3wF8E5WPyCbTniXybiTCSBoYWdkcMuBP2/Jxy6CCUWplL4SPDroWMBSA3M
         JZkmKfbL+9sxyc9sDILjXyyuf1QoJdxwcIrxiaSXWYKH/SWswWnN1yVHVwpJpzJNYhxb
         4RsibooCr/37JD2zCp2DCE1ZATD9StjQ8KgzQCOJ/kg8d1PhBo34fe5DFn15xcOLCKb5
         WS0Rx4PJ3U0qxiFTnw5tf0Y8iJ9xwkhecUoyn/DCcbkZAic/Oej9QLBdaE1prVM8O1zT
         2kJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795790462; x=1796395262;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SJHcj1ye4onm2ASg3L7GIHvM+mwNs4PYz45ZKyk2REM=;
        b=PANL5eXRnKYNmFP2jfIAgEeVylLjHTQY8Ufn/vr/pc1YLl3GyqDLqGqPQYO2FiDl8/
         tCJI30qSQhtdCHIqbOMMi4MtUVUxPwU02js3TocAt8mwyQ1yPTfe5B3FwQHCvK6rnonC
         kAFeyXcctwgoosjwNOO/XxC3DtQ0BP+1EIDp2LOyPAUD9p8dtCPSCL5AwLcvKDBUFcx7
         wN9VWyi8AX+PAK7TWdqsoYZmZTPk0WU6Dj1pFt1JiUQA9GeY0iJJRlgO7MIzB0HnltKB
         aKztJA9OsN5O1cxbfypNOacnae3Sj331rJi80bPrg56vxDQgizziYVcNtvSniVBxKjRe
         e3HA==
X-Gm-Message-State: APuU4Z+AzUUIK1SL+hrVRwfdh3IMhyIZ4kbA5VOEDrEaTKRWvN1tomfP
	Z0KMaanfkCXhMJ0MS7onfiBMPgHti/VwkfkrjYbWoShs/szaxK7FKirBvcOIDf1DYIP9e2unXbX
	kQhhSnFq0BvuXVeJlt1kqqEIw8C3+dBVBN6MxLcjBsxQ/lAh9YcySqVJx7/ca4OsOvjsqzs0=
X-Gm-Gg: AZFdTZcHhpPWUVpQkjNPYFYANsbmhC+0NS1xzllL2v0nTrxNImPQt7a7XtyRRIy2bqY
	WMAuG2cbqQElHoekoSdtSv2Ks1qYOSL0kNt8njwZmxGBUBQGUc6hjABgo0dK3dwbMk4lJ19LzuQ
	eZlwXEl9KbT8sL+/8IG6Ytt+L/c90JK2lSbOpMWnHm78pL1tJwXnhqad8b6xgrokcZLnEl4CDD9
	l9ijLPTnBHCf2uHBO37B/wiqoKEnmg0oEyzOH1ELj/xJzghX4Vs5rjWpnU5mF9BPgOFkErFs+W1
	NCcd0T/Y2iSgLh0Frk0vLKt9MpYnVtLAN6c1BCUptmJ7l3EyIO91K/tgv5+JGhqpHTJGCkRyuk7
	vBQc/V0AdKKPjjbwgsYKAz3PeofgfP9TLAL+PbtzrgdvePtuzJIr1qqlIVTCuZC11+gp5nnNiO5
	QcMvTKrg==
X-Received: by 2002:a05:7301:b8c:b0:36a:2f6c:490e with SMTP id 5a478bee46e88-384b3986ef2mr28026548eec.6.1795790462350;
        Fri, 27 Nov 2026 06:41:02 -0800 (PST)
X-Received: by 2002:a05:7301:b8c:b0:36a:2f6c:490e with SMTP id 5a478bee46e88-384b3986ef2mr28026516eec.6.1795790461861;
        Fri, 27 Nov 2026 06:41:01 -0800 (PST)
Received: from hu-msarkar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567cafec4sm82970809eec.26.2026.11.27.06.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 06:41:01 -0800 (PST)
From: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Subject: [PATCH v2 0/2] PCI: qcom: Add support for firmware-managed PCIe
 controller recovery
Date: Fri, 27 Nov 2026 20:10:48 +0530
Message-Id: <20261127-pcie-controller-reset-v2-0-17467b64f5f5@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAHCWCWsC/4WNQQ6CMBBFr2JmbUlbtIAr72FYQB2kBijOFKIh3
 N2CB3Dzk5f8/98CjOSQ4XJYgHB27PwQQR8PYNtqeKBw98igpTZKKiNG61BYPwTyXYckCBmDyIs
 0x1NdWWkkxO1I2Lj3/nsrf8xT/UQbtrOt0ToOnj67eFZb759jVkKKs8qyIkuNbZS+eubkNVWd9
 X2fxIByXdcvt1kPoNMAAAA=
X-Change-ID: 20261016-pcie-controller-reset-8938e4bac060
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rama Krishna <rama.krishna@oss.qualcomm.com>,
        Nitesh Gupta <nitesh.gupta@oss.qualcomm.com>,
        Ayiluri Naga Rashmi <ayiluri.rashmi@oss.qualcomm.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Shazad Hussain <shazad.hussain@oss.qualcomm.com>,
        Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795790457; l=1308;
 i=mrinmay.sarkar@oss.qualcomm.com; s=20250423; h=from:subject:message-id;
 bh=SRZ1ZNlotCXW9YcejmmVtLhSxwznrrgBDa/mll2wXts=;
 b=HmTIIGhR2oznB39LmlcDi1JIhmJ6ElcnC8fA6ISPHTamLiYXPDzyXm5qGtwrPpEvR+BeppXdk
 hBZ8dFDvef9DGx/rE7zwoTvL68z2Q+sG9eMICouI/n7CThA0ASIk2bT
X-Developer-Key: i=mrinmay.sarkar@oss.qualcomm.com; a=ed25519;
 pk=5D8s0BEkJAotPyAnJ6/qmJBFhCjti/zUi2OMYoferv4=
X-Proofpoint-GUID: JBA0WbU0495WDfu7YuYPQHAZjesXecBp
X-Proofpoint-ORIG-GUID: JBA0WbU0495WDfu7YuYPQHAZjesXecBp
X-Authority-Analysis: v=2.4 cv=A7H5rKWG c=1 sm=1 tr=0 ts=6b09967f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=Vo1K_PxMkAQpuwCxzZIA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX5CfCm4dSh416
 tuNM6kIRLESkXb6zpkwAQColfGEJwvqYc6cqoZv0xatVVaCWPTw0OxMpmjP5IV90RwquRT3qT9r
 FjKazpX7BvQP5lZGQ1QgefmvqqgaM3U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX2ctuQWkc0ImE
 ug0paaVsp6rk+GeSBAvmL3A+O9LfdI4DDwk4C3ZMC4RaNxCySKhPg/6Q7OyAEVPC/x6pJSRrtbg
 63wlHmkl2Ya7Tp0I8jq1GRD1gYH1SFeUCy0EgTrNB0/brVOqZBCPOc08A9PfJZ+2Qhc20MydFIP
 +/RQWMCZBWiArMDPnHlwfJyYbJ2mDXHByPmwyjyy00Neukad3uBGgBP6iMJs/pGalbyHqmk3q9A
 kwAq9ycsjbnITAKF2lwg9jOrMMju0aAjhHITEoBIYDZdwz0yCrrY7mYzQ4ajeKCZ1VppGEUDkBm
 1DRqkc+yhJ8MSLYQwiVZt1AlISgWQiwe2b+UBS0fBOMx/9nYdjOVuYAlryttAl0y0BT68/vg8SX
 UKr35SQwQfW7cD7lBs9FaR1bjAaLoSOZYgPlFd5IZwuFOhI6K+X+yQDtkMsZm5lMQybSqmCzA7F
 DhBhsKFu7L+A/jb+WVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270058

This series adds recovery support for firmware-managed Qualcomm PCIe
controllers.

For these controllers, firmware manages resources such as PHY, clocks,
resets and LTSSM through the power-domain framework.

Patch 1 adds Root Port reset support by power-cycling the controller
through Runtime PM, allowing firmware to reset and reinitialize the
hardware.

Patch 2 restores the DesignWare MSI configuration after resume, as MSI
register contents are lost across the controller power cycle.

Signed-off-by: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
---
Changes in v2:
- Guard reset_root_port() registration with CONFIG_PM_SLEEP and mention
  the same in commit text too.
- Link to v1: https://patch.msgid.link/20261016-pcie-controller-reset-v1-0-51779736cf12@oss.qualcomm.com

---
Mrinmay Sarkar (2):
      PCI: qcom: Implement .reset_root_port() for firmware-managed controllers
      PCI: qcom: Reinitialize MSI on resume for firmware-managed controllers

 drivers/pci/controller/dwc/pcie-qcom.c | 42 +++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)
---
base-commit: b810335a0699d1810683796b0e3ffe8827ddfe6c
change-id: 20261016-pcie-controller-reset-8938e4bac060

Best regards,
--  
Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>

