Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685B741DDF0
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 12:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792155451; cv=none; b=THPpfrCciBaryS1fy9Ufa29D6uOqsgG7R+bB4SNhKb6mPIRH21kIO+4TEMTHDEeyC4Nk4eDFKHZHfp4FIcXpEZOUk+/nubqXvFVmgodIhWHUj6tB8JopyQZLXpLXJAs9ZS2369x5z+ZDnxVS+pR5hqoEN4z2GShMpMHE5taqEd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792155451; c=relaxed/simple;
	bh=pKclAMQYB/v18ngVe/czYmvn5PFYR6ejrYTG9zzbeig=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qlfpo3Qp+QQmdnxzaiRJHninrSskJGoFZYFkFPxeaff1xv8c2Xl6w+2MDtEBbL4Y5fcIRl/ku75CMv9N6kPChJ4F2G9PDwtifBhvGezUT/qV1LtN2lGKNt9MQWlkK+cDmWSzdAM+RLHpDcfOSx7NUqIgbyeMvi50HkjoaldQ2gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fvjvpZuw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cunn+8Xp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fvjvpZuw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cunn+8Xp"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAAFjO1793595
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 12:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=AfoerRn0REWgpCuITXt5ET
	krXKHPoMZaTZoSkWCdSOs=; b=fvjvpZuwIDuk8p2/SeHKQ+SKCfYaUYDxriVJyM
	iWZ0NxDZm3mtQ59uN4IS0JkEVVJ7Y51HgOy2oqac8pgn3koaUR7S81bJxjmo4YbE
	9fhtp7zuD7ZRCd36JXj5JbHyg+zpOwsRQxIIG3eIrf4dvb5sPSl4jUS4YWrmxx44
	FfyxBGdx3eNv2Eog3T//gbBGAMx94V6j3G2rmOn3jD1m5WpKqf0PFNaGyQbjJHCU
	+2yJBnTRSljuhSFV8MVSnGX5w+F+M9MUvfpN3BDvL5EumG57NLP0mtDWJp5E6LpG
	7TQw0gDgFYhR/ET+Sc7kYULbfp+g5YRyPh7SWa+1nCz0FYmQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3seus81-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 12:57:27 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3510d0baf63so9243623eec.1
        for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 05:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792155446; x=1792760246; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AfoerRn0REWgpCuITXt5ETkrXKHPoMZaTZoSkWCdSOs=;
        b=cunn+8XpaXEb/kAR2HC9WDRB3+EgEjNmALB57ququC4MvYEeKZaZy8st+1HSFmyl63
         wWkuUKZbDfYVuwG9K9atPMP5hnm8rKzJJrJhF5EDVbKVkOOnHMDKekjb0GI00y3VffMy
         WbQ3btU0XecWfhNka0MGx80us7VSu6Su1DPHTzpoLPFPtdP4Fz60AYJfHAfyT/5pkmXR
         yfM2aKJXi34eUmhnD0QoVvgCqr6/7gUJEvWuCaLgL1zIN8YfdbvdbF3U4br7ygnp0yj7
         Sf6W7buoxItW4FrqFKjz2p9lRspFj1xc0sOxvvOtQrCw1GaKqUJQpMnCN/4oPFiAajn2
         sgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792155446; x=1792760246;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AfoerRn0REWgpCuITXt5ETkrXKHPoMZaTZoSkWCdSOs=;
        b=Xf6H+cwQ5KIWuWnMDFY2wGDi8t1jcySGh/BOwhjGTAFbnGHH5co4bkuC9vciFn8kZx
         SLYPqfQwHo18Z1RqEBW4ss+PT1FwO1Gx145+Xzs2YsPKTXsCemIGB8h5H4zrZSytFet6
         GRdwHtSA65mbqU0h9HAJC5kEha3caUpRiPLzcS4CZGqopYLoh869igfEC6v5YqYwgIsU
         Ibrs/jeM/r4Lm+sPGmHRk8aXBulM0U2Li9jTCucAXDYSA4VI433HixXDHaa7v7bfHpc0
         6krAXgO3wYRRlnwNK8URVjBihBR3le4ObqzY48Vm9rQJNLPi3FraN6BEvz4w25RpmEME
         k9sg==
X-Gm-Message-State: AFq9FYLuMfny9DUULlZHcFCJTMqstw4TgXBU6e+9ySNXbr1CP/pIFvfN
	0pIdogg1QNPdMGlGcnMj17jegBK1MCiVdhMoEoGB18z3aax8q4u9PoRlW5VmjoCikBWZw7+GoQ7
	PYOp3utJJB+jTRygsfTEzjPTTFkvrgsVlKE/9aEtQhrT7beWo/Y9k77QHNEyFYe0=
X-Gm-Gg: AYBFou24QiHgC1onNJ4TQ5/PGmDGeDLUuqjpSQIYAS2fQJUY3+iTkt0CBCc/7VgVU0u
	NvhFhAbiU9wdw8bhgXEwshoruP218oy0oh/Bjk1U78Q4IQv6qLSrM2VkBJIVrru7HNgIOKP7yD0
	0P1ul4dlqUXcbib/yzq8fyACt6dRLSMgtEseUf+ij3zgtnFeCP+6DwepQ5v2JWVTL8Saq9tb5ug
	k5G3qjDGVRYthyLdRPpVxO4D1HTF7pkKOHc3bIefSeH+mE4pmBcJKbmCMLp/Or4ZqChh8iVMk4M
	yeh+I90p6Na9ysE5jPlo/FdNWJrKZCfKZ9YHLmQy1fIuQ0wpFr1EtFUs+LPAVXfeo0dPDYLHwqe
	UjznMp49DPZ3huEIiRDoiofY9BcqgacePSg==
X-Received: by 2002:a05:701b:241a:b0:169:bef5:f445 with SMTP id a92af1059eb24-16a56ab0bf6mr31231587c88.4.1792155446205;
        Fri, 16 Oct 2026 05:57:26 -0700 (PDT)
X-Received: by 2002:a05:701b:241a:b0:169:bef5:f445 with SMTP id a92af1059eb24-16a56ab0bf6mr31231544c88.4.1792155445641;
        Fri, 16 Oct 2026 05:57:25 -0700 (PDT)
Received: from hu-msarkar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831996071csm6188285c88.9.2026.10.16.05.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 05:57:25 -0700 (PDT)
From: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Subject: [PATCH 0/2] PCI: qcom: Add support for firmware-managed PCIe
 controller recovery
Date: Fri, 16 Oct 2026 18:27:18 +0530
Message-Id: <20261016-pcie-controller-reset-v1-0-51779736cf12@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC4f0moC/yXMQQrCMBBG4auUWTuQtBKqVxEX7firIyUpk1SE0
 rs36vJbvLdShikynZuVDG/NmmKFPzQkzyE+wHqrpta1wTsfeBYFS4rF0jTB2JBRuD91PY7jIC4
 4qu1suOvn971c/87L+IKU74y2bQfuyN/EeQAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792155441; l=1074;
 i=mrinmay.sarkar@oss.qualcomm.com; s=20250423; h=from:subject:message-id;
 bh=pKclAMQYB/v18ngVe/czYmvn5PFYR6ejrYTG9zzbeig=;
 b=9EbEs/CtkcVFQGYMfHdcu1yyky8kNrC3UxZN6fm4hr8HYpVkzaTT/+ogFqpjjhr3OfANfkcPa
 R52+9aIX3URA+8FNHy3GEqLFNghTh/cwesS7hxtXKgeVvuCGWv2sewI
X-Developer-Key: i=mrinmay.sarkar@oss.qualcomm.com; a=ed25519;
 pk=5D8s0BEkJAotPyAnJ6/qmJBFhCjti/zUi2OMYoferv4=
X-Proofpoint-ORIG-GUID: Z7kP8FF6Pvo_COy5B-8wG8OV9tyaz2G8
X-Proofpoint-GUID: Z7kP8FF6Pvo_COy5B-8wG8OV9tyaz2G8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1MSBTYWx0ZWRfX2NWKDAskWFVu
 EGZuoJQESmAmfD2hC3h9DguCOnGEPj4MbMXu8RCS2YF0tzyUjc1AmFH8CzYyCZ8awGFHr7MgO11
 6KOnJBJRRHVuXzRM+3vskEDAiGHnRp0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1MSBTYWx0ZWRfX4Sbr1rPXAoJw
 2wuUsiVJ8IJxQt/4qxS0cktyiaoE8LsAv9Wm99bgxmXFuW3drRTpkRpCxNznjSyb79TztpzKzU8
 dmPOGbf2e2JoIkEqYf1PSWcRfNekLbX60NY1S/8qkCbXkZowWrRs/ghNvJS7EPXbviT7HQrrS4V
 miiyW1QjR0za6byGyQ8IVUipNaTFnOb/uNTmCE2qpbVpvSoPAPELNoaD5xnUSsTms18pRrJmiQP
 NMkVU0ZgHiQO1qZ9qW/HGVbDqAp7MRJ5TKhAJ73sWnxawsKVDsqT0ruzgpSGQybTV2ZThEU+QGO
 pQcJcBmrKixKULPqpfW77lUwuwhePGEphk8HOKp/6VmY6zPk4q0Uy0i9P0INWWRPi+naxoCpaSJ
 A1v/ZBdH2oaupDjq/bhcxzL9MCg8RzLr3pY/re5Oi2M1HxUk5wC7SL8YoT1C6YyRSO+Sby+f9X9
 yymVy3Y/Kg9/RCVWpqw==
X-Authority-Analysis: v=2.4 cv=Se1i5fRu c=1 sm=1 tr=0 ts=6ad21f37 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Vo1K_PxMkAQpuwCxzZIA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160051

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
Mrinmay Sarkar (2):
      PCI: qcom: Implement .reset_root_port() for firmware-managed controllers
      PCI: qcom: Reinitialize MSI on resume for firmware-managed controllers

 drivers/pci/controller/dwc/pcie-qcom.c | 41 +++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)
---
base-commit: b810335a0699d1810683796b0e3ffe8827ddfe6c
change-id: 20261016-pcie-controller-reset-8938e4bac060

Best regards,
--  
Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>

