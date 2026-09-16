Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFFD4EC64C
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789562316; cv=none; b=DjZSplE0kC1C3oxrQlZWyZGVFoNW+YSVZmlUTrbSVck3xSufdNiTziJoGyyqu0ja/t9negoIYJ+BL4+KODiIwlw7o8gptBZ8Kw2c31n1OUiWMO+ely6Pt3xWsu2sEakfprKPJUCaLpR6SyVfaMMe8CfWx7tD0jEiJ5rCUgiMYT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789562316; c=relaxed/simple;
	bh=ENSLaQYmLKSt2CR91JHHQSxjLlYkRtC5DM1E85fuaJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DbdwfG0kOtZCYZE9mEuVilT78EoWJCeZYpVG9LMWDRDELdM4gK9/Uf/AeIyuVVisXPQPAA99TW5ozQH6ZaKNngW1gM+/B0IAqoCHUwL1H+vhCf3sNk5LpF9Cx8sy12r4l9gJaeEKqi2ULxGHQfihWC/zL332SECe74Bb32MwRnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oFopsi6s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OpSgxp8V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oFopsi6s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OpSgxp8V"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GCYe3e2691949
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 12:38:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Tig36/2iNLMxXARCJw580q
	lc05W5id1IhnieCfc12wI=; b=oFopsi6smm7aJXG+TzlcemthzC+W3Dz84nFPc7
	oHW99rQn5CHYRWHg8/V2ryyYT0R+kNKTiRh/3EqBR6Qj1pw1pye2TqC+EH/7ofcc
	qpTUyhNc00jwtpBZkQutH9yCGu/xjxUC2ssrgmRzMDyo3JlBp65nFINMjjurHNYk
	UtVgaVnlmGOYkcfBWdLHNuiNdDfhZzemR1RMW9riBnNDU+EcMWSOuAgvalF25azA
	t+BLIg6hMULe0Ljr4a59F6dZWRXKPYr913GG7AQcaFa+xzWUXDsGd9itrgZkJ9w6
	9sLYx+IEgyXWOqbLmGjBdPdVQZqo7vVY5NNNfjtxAlokKOPQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqah9vajs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 12:38:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93102454272so129285085a.1
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 05:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789562313; x=1790167113; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Tig36/2iNLMxXARCJw580qlc05W5id1IhnieCfc12wI=;
        b=OpSgxp8VQqLRQH0q+B87TjBRQzWNmGZuO8qdr8oYpSqIfOxHfP2v+QHwzqoF7lhR35
         O06iNzwENsLLvD80nL/Mb7DFGvFMl31ZrFeNrvg01WHC2j1n2U+TrdDM8HZy+6AaHBUh
         kXFJvnRVhreXUTkycSAOcDXyK4Yz3iBm9Hi9GfvCe4aaxNoMabBUNvURKLCxeztUXIgE
         QzrywbT+50NI93Q3x0C7maYKAsApDJ60VpSU8bpJt3+gVt+1mMNymPAUI6PDvY8GozPK
         vkTkC1ObGNERn7Z7G1IPjJPeze1Z6ze1k7dv+qesHc9WlFdOkxDhtBUckltFOYZqmbhO
         wNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789562313; x=1790167113;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Tig36/2iNLMxXARCJw580qlc05W5id1IhnieCfc12wI=;
        b=rcTY99+hu1LgZ0gOC+gdTBmaBWLakeqZ4cwD0UgvEBi/QgurAZTNKb8ah7ddd46GML
         obxmXe6dMOdEXZ8Lvd0kLpRsiea77xD17fexKcd+UJL3bSaNLHgzL7o3FrJxDjZPSqRV
         hh5WSylw9p0eW8291iuPFLAmCTYGMVAt6nuzB+nwThmetl40xqIhF0dbQNejGB/2GfZy
         xbaKaU82UAFUaCiA4objmooI59XsP1ZC1qFysLQVPhZhA6NMUP+df8QWkn7AVtEqIMUT
         n6bxYuMpctv1WHF+Iu6trJuRwnIliKgriyhaSn+f1EHCGN/+SW6vMpoPyRDXH9bS50GW
         Mssw==
X-Forwarded-Encrypted: i=1; AKwUvBxus+ADOqBCF33qyKrDpUyAK5hKQCih+lqjdGhgUd1V7OpO1Ku0EFizuQyll0GTU7nCfDG00nS6f6E=@vger.kernel.org
X-Gm-Message-State: AFuF++kPQvVeOQ/XYepvQ5iNm52W0l+DlsgQxZXmxKWj/pxkH5ulawAZ
	oLaOgDXc2EF+ggCBgayfg4OGxMdaqjp99ZV4sq47+rFWXcBKc6J8bcxvardJPRcAZXjbFSJd1u+
	Mhp/84z4eftelUIaY8xKeizDvmytb1KGWXD2gFfHN6x4JtDOlTWbwI6RL8EfXN3A=
X-Gm-Gg: AYBFou0zaT5rheaD+3mn/k8v4257uQ3nLQGms91GbOyZ0B9sWFtvw/uUQFsNqP1Ze82
	fauIku1DodkFBxCVHXvs4purtzaOYHef9pBMlC/YyDJDqBvBvImd+LgG2dvQO0g63dJ8gxVx1Rh
	w4LcVws1P3KX+3+P6nGGYwC9qh2sVWzM66tviB5yOlI91hxG8pO4a8GMw7KXn72/LhVynx4KI05
	6PPtsNp5fwfRvYO4XrMKBg1RGjOTmrGK0HMRgB6FAArUHxpL8Z8+f+yQSSxFvtZo7GnnIWDARXZ
	sdXjrp3Ty6j6zxDYnFYx7tQhhEWNZgdS5LrTieFRa81dcmNzF6MkotjKj5ZLq0X0suadqHi2DBZ
	8pLHpFpLFTa9KFbX8yReMoJXlpi0JeNI=
X-Received: by 2002:a05:620a:3181:b0:93a:2bc8:61ba with SMTP id af79cd13be357-93bb76a0dcfmr309273185a.1.1789562312970;
        Wed, 16 Sep 2026 05:38:32 -0700 (PDT)
X-Received: by 2002:a05:620a:3181:b0:93a:2bc8:61ba with SMTP id af79cd13be357-93bb76a0dcfmr309266785a.1.1789562312365;
        Wed, 16 Sep 2026 05:38:32 -0700 (PDT)
Received: from KDYBCIO.eu.qualcomm.com ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa1cf66150sm1721927a12.0.2026.09.16.05.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 05:38:31 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 14:37:49 +0200
Subject: [PATCH] PCI: qcom: Ignore -ENODEV after Root Port reset
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-topic-pcie_portrec_enodev-v1-1-5dc7bde39552@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJyNqmoC/x3MQQqAIBBG4avErBNKyLCrRERMfzUblTEiiO6et
 PwW7z2UoYJMQ/WQ4pIsMRS0dUV8LGGHkbWYbGNd41tnzpiETWLBnKKeCp4R4orLMHe9w+Jtv3k
 qfVJscv/vcXrfD6kzVq5rAAAA
X-Change-ID: 20260916-topic-pcie_portrec_enodev-cc576ea927f9
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789562310; l=1358;
 i=konrad.dybcio@oss.qualcomm.com; s=20260604; h=from:subject:message-id;
 bh=ENSLaQYmLKSt2CR91JHHQSxjLlYkRtC5DM1E85fuaJY=;
 b=6hGGHRk483be4L9I30WqoeL5rfwSDR++wPTM33RJN/wRcpaMBAyhNhzfqZjfkqG1792lAEydk
 rtCEHw/KdycC0Ho2Tj0n6iprYZP3CVpqgJJrU+AQ0U2X5eueuN2numt
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=SGRRMmlLTuP/lGKdQ0f4KPvxn8VVsXtXaTpdGc8i82c=
X-Authority-Analysis: v=2.4 cv=BtkIUoX5 c=1 sm=1 tr=0 ts=6aaa8dc9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=ESyKS8onHQUTpFuCZioA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: pGfax6EIFJBsMZWkaL2FvhacK_05iUWC
X-Proofpoint-GUID: pGfax6EIFJBsMZWkaL2FvhacK_05iUWC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE2NyBTYWx0ZWRfX4rw0eSFHFZ2+
 UACZ4/uewVC7Ej1AEDB5VeYEDSnOXRSyohL2oy5tIMm9eQ89QGTShmlBAaoX+GFWonNhxcLyQam
 dY4Rm34qjLWdl/zrKFR1XnxTSg8gqKNTPNI49F2QgVrHJb9XtEQDJ0NvZobr43LmQQ3JbWXJoxx
 gJjP6cbrKUmYEIzAGGtCTjEh/8Su9koMODBpZLdRakN/d6OEJ1NYVenS5PpxLgAEFgek+KuUl4D
 Ws3DF+ne3oL8riD1IARYkvOVmRsgmxS5Ss1Zcpm22sSxvPuDvsisoTMrwzCBAEVD0LLbwk68GP3
 +69zBGUpqH1PQzqg98+XM+fDXZJ0vh4fj7G4iIg1P9IP1fwvuTtTy7Nfbm08iG/yad42Gof87It
 WLnWAQQlU4lHtWO6//DEugzZTkGy5UU+SqdJNXrxE8xJoeZN/x2rWlNT0u20a8+LpbrwR9P0LH/
 zplmfGdBpxwqMOXEgKg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE2NyBTYWx0ZWRfXzSfAdjwvC/qi
 Opa6NEJOY1s8bN8KQo9caDW+XTC4E4ZLI7boXV8GE4lWStRCzBGGcFn6U3T0yDmUsTayJRhPQtZ
 4XL+bgvVgv0ioMBoKHMMVD3he3hNOQo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_02,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160167

Root Port recovery may race with a device hot-unplug. In that case,
dw_pcie_wait_for_link() returns -ENODEV because no device is detected
after the controller has been successfully reset.

This is a valid outcome and should not cause Root Port recovery to
fail. Ignore -ENODEV while continuing to propagate other link-training
errors.

Assisted-by: LLM
Fixes: 4d88cb82a6d9 ("PCI: qcom: Implement .reset_root_port() and use for link down")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index ee63a6ec99de4d07c16b8d6cb68df0d92f822cd8..3d3be9bf798b7c247d69969d6570385b8648123f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1880,6 +1880,9 @@ static int qcom_pcie_reset_root_port(struct pci_host_bridge *bridge,
 	qcom_pcie_start_link(pci);
 
 	ret = dw_pcie_wait_for_link(pci);
+	/* This linkdown might have been a hot-unplug */
+	if (ret == -ENODEV)
+		ret = 0;
 	if (ret)
 		return ret;
 

---
base-commit: e6e35979777d646fe3c7c94dca7dd32fb25d45f4
change-id: 20260916-topic-pcie_portrec_enodev-cc576ea927f9

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

