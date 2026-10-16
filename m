Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB6239794A
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792155464; cv=none; b=qxs1jHCDpIvl/ytXVTq9jhRoxtpU7JMduiEKjua7xh5Qdhll7ZFrRRiRRN6xFrphxH6RS6XpijCCAi9Y4x4cFE5Zf7u0Ci0jiT1fpjzOpj86J0vvHl9IGh1LanoKGVKe/QZo/DFl5dg8g1i+PEu3Dj7aJybg8hiJDuPzRcbaPcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792155464; c=relaxed/simple;
	bh=cLOybjYHCQvvw5wwBKe6pH7jh6gVXSd5dIMqBdQIGhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u4B22Mr84ADZe/HJjh6oUDhKP+nA1xJIO7RP2gPaKrIZGSjLxhr+XB75DiCSr/1QT1FmN/LBkk73aWV1tN4cVs28MulGOru2qU+QluhYPxAbEpQa38hnpO/J6YTx99CUyy3AVKm3kP7oMfPYUZqNtKwRw6zFSM/ayJsq8OgsO2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IoaqLazv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ibMNow6s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IoaqLazv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ibMNow6s"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAAE6v1983359
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 12:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4BRKa4/qcmK5eNR5mJGC0017NtZsgVMDiU1xJ7wXN10=; b=IoaqLazvSatn5KXX
	jztR9O3qiCmUC9ThsRLZE2+JjTESQMwvAaF7EpoWqXNWFvu/L4P990T5WLC5n0IT
	pX1bp4A1oKFeNCWZR9BipKNK5bF26jSCCucNr73nEkvoqgWGpE+edlkQvXx0Ozx1
	OPJwkmItu8tavAXmjuvrGxXKpEKBmg135etRNz5GlVubB9azll5+8nbUDloz3Qqw
	LcKnIrg7E0c2xmgLTnX4VyS/3+s/p9LdNbjJIkVxNV5op1c6NH0MjNi1wWPKIu3O
	ayj2NOqCKdu68JaW1xqS5RTceCsr6OEZ9TtuAKl0dW12mG+S/ldD10y0n/zo/dhQ
	coGoEQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb8a8aphq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 12:57:43 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-17188d538c7so11728497c88.0
        for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 05:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792155463; x=1792760263; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4BRKa4/qcmK5eNR5mJGC0017NtZsgVMDiU1xJ7wXN10=;
        b=ibMNow6serKrRhwL4LMOHhez015PAEUARs4SpM+wiD7O1BQVWwRhkCpj1fYhcVAk7S
         PSBgNHJJfAYUP2c1fugFyGOMcQSD39VU4qmzlhk9K4lCzBzGRNwL0u8ZFZQyUoSMJfSF
         3VKS0ZDdjBXNKfcwpI2Z5gabL5/oDuGcwKd7mFFndNbzc62kwomFgSca33CFD0jG6oA2
         p8MGzk8RM8azrldyb3hsXYsBnfW7sJfRApaTGxTyXcdgm+ly3wqPFndsgTmLFHJstINK
         3Z7lFHHWa8mfeq598jYoDNj4h2dm8TJ2IdTvoahXq/W8JyD7FBWJ4cBWnnReIICk/K+p
         EVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792155463; x=1792760263;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4BRKa4/qcmK5eNR5mJGC0017NtZsgVMDiU1xJ7wXN10=;
        b=lRC2SuZqT8QgleSyTBkPPkst5JiZVo+uCJ04i13baScSwKyxa5j9L/oZBQpUkj4wG/
         pf9NhMhsWGD9d/23UsnabfPF5jg90iICSsdzkj5O25BAQSKpbN6Ls9w/MVN0Qjq+d5Wa
         saUj2jRCqXeu/Eqa+7cBjpRbTAKjMMIeR6NsjNYXlHyMVXzvPBO+zgFVJFoFwaa/EUrd
         VrFdH4K7xmrPEd1+/Xr3uLfXboD6tfwnWN2+VdQvBIuvvrzrqGINlJRrNhwsceWnc9fk
         Q+TgcS3ROEsNb6VQQSt3TUhMaazk2gaLq0Q31G4/5A1E6mIgjpjeVnbaUizTUsoAWFSh
         e+xQ==
X-Gm-Message-State: AFq9FYJsDblesa4y1H80k0He6kuo4nr9Wcow5l4BC24Fyw5oDKczjWx+
	i6a50IDKLlXQXN5liA78d5XZs7DrhKDlK9/muRC7nmPnA5YNhx3PFnJv8oykPSbmfZ/6UZbJB2V
	YBN9zwqwr9pPTZQ/Um6eBJgjsA4Qpb5UHUgD/t1X7mZsWCtu+zrza+7MEiQfft6Q=
X-Gm-Gg: AYBFou1DHd1e+t9uqOtTMxDJW+3NxYifuWV4MHgdit6Vlnm+G9Awfi+Jq9DWbb2q5bE
	p6+KWnHGKNDsY6l+LCy71DJiryhiPfspzT7UKVzZUp1x5PY63Wx+ruiHGZ7kNnP7D8Sr/sRA6er
	bVcSn5WvBWk7Om7dHh/oKClVlQFlzMrwIErqc9Mm5t8D73K5ygOr5tTZmhE/iqnqxpJJTjc18p7
	O9nBbHI637S+Fq2goEjxJwYbxh0XDCtuC0mjMVKj3pDireKjNKnOQMwBZw/kzkjZTGgVCscOtxn
	DoDaMR1LTALpKBuqtRH98zOXoOJVU48/474xv/QcnnAvkvLmhnDDwkoI57FAJzVe7/aulwGqKHZ
	uQ1b0dAr37wpFdjmSvikRP+Cnf0X6nJTt/w==
X-Received: by 2002:a05:7022:29b:b0:15a:9834:73f2 with SMTP id a92af1059eb24-16a5fe7c16fmr32012655c88.38.1792155462605;
        Fri, 16 Oct 2026 05:57:42 -0700 (PDT)
X-Received: by 2002:a05:7022:29b:b0:15a:9834:73f2 with SMTP id a92af1059eb24-16a5fe7c16fmr32012229c88.38.1792155454681;
        Fri, 16 Oct 2026 05:57:34 -0700 (PDT)
Received: from hu-msarkar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831996071csm6188285c88.9.2026.10.16.05.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 05:57:34 -0700 (PDT)
From: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 18:27:20 +0530
Subject: [PATCH 2/2] PCI: qcom: Reinitialize MSI on resume for
 firmware-managed controllers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-pcie-controller-reset-v1-2-51779736cf12@oss.qualcomm.com>
References: <20261016-pcie-controller-reset-v1-0-51779736cf12@oss.qualcomm.com>
In-Reply-To: <20261016-pcie-controller-reset-v1-0-51779736cf12@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792155441; l=1653;
 i=mrinmay.sarkar@oss.qualcomm.com; s=20250423; h=from:subject:message-id;
 bh=cLOybjYHCQvvw5wwBKe6pH7jh6gVXSd5dIMqBdQIGhA=;
 b=u6CYb1nS3ZIWANu/Ndou484Xr1UDbc8DADXKWudJjpdWVOUhWgmB3rhPXIvoMs2A3PzL9pQ4q
 Llg1CZWl39cCsoODoA+EY9zMbsPAsjJBqd2HsBLmJnP5LC4TcStaH4k
X-Developer-Key: i=mrinmay.sarkar@oss.qualcomm.com; a=ed25519;
 pk=5D8s0BEkJAotPyAnJ6/qmJBFhCjti/zUi2OMYoferv4=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1MSBTYWx0ZWRfX5juMMk7p0W4O
 3AbuUAw9k5MDoZ4ez2tda/mjyhV1AZgezX1Mcf3IHkrmhas3g+Uh2UKZ2lQswp2n2ExBJPXNtfA
 13ZHlbapcvYlSTJlFPGXNUi+tcDr+io=
X-Proofpoint-ORIG-GUID: gUgc2O8xmazog21HEUVm4KAau3JuK7sF
X-Authority-Analysis: v=2.4 cv=GJadgeNK c=1 sm=1 tr=0 ts=6ad21f47 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=VdY5-eERFFFFdNr3g4sA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1MSBTYWx0ZWRfX64q5HgNuDm/2
 7amMQZk3xhcrZ0WdjD23tSRNCVjeCdsgbzc6DHt8H9gdiasg3LC22ygFXwqSRSpsMwpjmddZsJH
 k6ujfVFK5JYMyRj3NY/TYEKMBow+9QaravIZ1OB+AMjeaKQxPHp8AyAsCMaKPNyMjeHICY30THl
 DwVeYi2CtgXAIj5eZjyd8XqITerRver4YOunNRCr993vFt3XXPC7kwtv8KO3oAkR+jxu1hiXAYV
 2eNMwgE95VXW/P019hwqHeEI1eOl/xaUQpxr21uzfX9oaH8rIrS7PapliYtosqOYozYg4e/7cqP
 gMeitqnLyl0dPBayklw3c6Z2iKToUJ6IBChEsUDFY2cFukVKxw/M810UGMuhFYtDg6zlq/e4eqt
 Ttl9RQH2vO3sZjkrMFlcX1fLcLMBJ4LKJfFh8NJao4vluPO30baqltYgB9WWHQznMVc3c9f+Cb1
 vnGOW/PjOBDr8DSIhyQ==
X-Proofpoint-GUID: gUgc2O8xmazog21HEUVm4KAau3JuK7sF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160051

On firmware-managed PCIe controllers, hardware context is lost across
system suspend. While firmware reinitializes the controller through the
power domain framework during resume, the DesignWare MSI registers are
not preserved across the power cycle and must be reprogrammed by the
driver.

Retrieve the DesignWare PCIe context and reinitialize MSI state during
the resume path for firmware-managed controllers to restore MSI
functionality after resume.

Signed-off-by: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 744455ae90d4..116622843d2a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -2324,6 +2324,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		bridge->ops = (struct pci_ops *)&pci_qcom_ecam_ops.pci_ops;
 		bridge->msi_domain = true;
 		bridge->reset_root_port = qcom_pcie_fw_reset_root_port;
+		dev_set_drvdata(dev, cfg);
 
 		ret = pci_host_probe(bridge);
 		if (ret)
@@ -2551,8 +2552,14 @@ static int qcom_pcie_resume_noirq(struct device *dev)
 	int ret;
 	const struct qcom_pcie_cfg *pcie_cfg = of_device_get_match_data(dev);
 
-	if (pcie_cfg && pcie_cfg->firmware_managed)
+	if (pcie_cfg && pcie_cfg->firmware_managed) {
+		struct pci_config_window *cfg = dev_get_drvdata(dev);
+
+		if (cfg && cfg->priv)
+			dw_pcie_msi_init(cfg->priv);
+
 		return 0;
+	}
 
 	pcie = dev_get_drvdata(dev);
 	if (!pcie)

-- 
2.43.0

