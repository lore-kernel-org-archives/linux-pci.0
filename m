Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2B748CD5D
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332091; cv=none; b=HRZRqkiFPkQZkYn1PVCcvI8G85ZW4fiL/k+0xwfoBhRHO9OTkl1r6MH+4dJDd1/j9/z6lDNTvUsXPpZF3kZLS8PfHMn+nn5p816+s0tbrNZGiSYVD/pv6Y6FzkSJuqMdzF4NpYz/6kMG1thQQX12bOdpS32mKK/pgcD3nc6ZCtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332091; c=relaxed/simple;
	bh=xay7E5FzVAX2MilwYn2DHPXbgjXgEXMTV2sbUTxj3HI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y23TW2TiJpzE/EHYrz5+eYPacpQj05cQSji+9T115HRBiRecl0bQeZXQ7a8VCR3Y+jHz8tQeB0DtZV5tavReM3H4Dxqr3sYrEa+wlyL2HwCYBp/MDgOeObMMsd3PBpi23bIJXil+P3ASYtI6CrGTb2sj7gf2we0AGUXN0P6S03c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J6P7GcHq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hrlHoU09; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J6P7GcHq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hrlHoU09"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TD8IRa2130147
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 13:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9dFednurd5l9x3VKFUOU6M
	WgEmaHu4Lzln1QXjQCV60=; b=J6P7GcHq9jV14EvVHEg2En+bpkD5b6O0p7Uy/K
	FdH0/4aM5T3RdIVXhXPM2vBC6a4utGO1/f3IFlw+6m/u8EXE6zDjE/MH7XjSSQ1y
	1g8IxNn5gI5tUIXbaK7HGCTdmnMn70tTpS3vyC+Rysxf6AgdSayGb+EvxoKsSXjX
	qUy9qV1bRAH0JlPX/0TtO/a6L6css86o6p1QybiwamuGIjDudohcN7l9gdTJUGfG
	PizBOHiFGTTDtVnTZVi+QnN7llTPkqu4z4EImecDWKqRmFJFcU2DIiqJ1yOvrh1Y
	gneQxhnA/xIAtdDlvdCA5aOxJkSeE884nmU6PwAF/gvDSe+Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqgr68fqn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 13:34:45 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1d30035dso8616371cf.2
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 06:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785332085; x=1785936885; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9dFednurd5l9x3VKFUOU6MWgEmaHu4Lzln1QXjQCV60=;
        b=hrlHoU09OtorCYaOMOcqmzsMD9mYjLuqid686oRPXndzBcB1LeRJIKl6Ch7Ju/ePyE
         2UlU8QU20wLXQewUoRpOSlb+PmUMpBJ+uPSd0g1qu9Ss5x43sDilr/ptpDprCXpdwmmQ
         BQEMUd1BtcXFFKnwsEfHEfvDgMHHaoDkX8US3w3DIs5m7YzBlBxuaWOyHkQ/Gk54uv2I
         IsX6Q866jFVQhIXqX3KVA6H+2bxb7I8R3nqyMHupOBg8DiZiqkI6ThoqYpfIk65NS2+N
         E3uw3vplU2jOYy9qP8+kmZE6605MN3EYEtgF1oHFWTEoPaN67y5fxZbYl7UpkCDI/eIV
         ZmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785332085; x=1785936885;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9dFednurd5l9x3VKFUOU6MWgEmaHu4Lzln1QXjQCV60=;
        b=X4OZydDNP7m6BkSCk+mif3vBDPH1iHvYLWZ0Xd5J315Q1jnrlU0f/CN+ldH88Daa7q
         CjxQx3eswHYa/4RgNShb7XrlcHeNvsFi18lBItJkIHDN184CDEi3OmnteoSE5TZZGgX4
         5WNy7Wr614eB2TJh3ywa3qFkGIFYWhh33UBQg0uRoWAnorPjIQb/pUwjdOuMGFktcN7v
         TL19pvWpu+cPM/8fPdMWQjhALCMLBCI1wPR2uPd0F0ZD4n24OTzdHN6MnWvABYtTEKQq
         tYyiHMdKHpHtZvZSBH30Bpj4btxRZrE981Bpwho7qOatAat5XIKixcE6YFOw+ny5rlFm
         WpYg==
X-Forwarded-Encrypted: i=1; AHgh+RplZ1xW0HAIlJUpHjfIHizuZRPTTXB6/SVFMeNaVCTZDgieUVSUPY4ssBl9Dc5HATJvl+y1FUDkWwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKdqQwBpaKpIwnft3NR6/I/xTakGZANNNV14mTFdW49E0X/O6+
	SsR6cCcNQwcllvJoXGQv16+hQD8x65LHFWlQaiOVTHzg1rl/jFTVi3gaAFrvJj5xk6yvpiWKXgO
	YQz58HGZJ8wEKc9AEAnSlz/Gx2sHKGMf8awNS1IT/nYLNAo2DhKeOaEW1P3xT9OY=
X-Gm-Gg: AR+sD10FDQzHRdQ1HXBZSrmOP7Ty1BeCPS1jVHSenGmdf/6Wc5sgAtWRMd7Ri1Ekr7r
	QH9K6NUn8l2iPdnX5ZCapSVI2n50Efs/T6IEflbcWxqz+uxiLOzu2paIZD8Jm6Rehwh+mi9jJES
	86GLid6z2+hSXolwZadlVf5eDOPtOQQPH3/34W1g3SAy1nfXpwQXnTlIITtvz6j5ZZzZGA/xKuk
	DVPx7wiL3maj7I2aIVGARx9KNQ9mfTQDedR+RIREPfOa+Zc/AS4Ia+Y7UYA4UI75Rhar9vYZ3Pl
	RvvmxNfUbFVVAhfDQP2JyxrtmzUL1VibB5KrmOyjb2ckvj+N/Mjl1C3S21p+0kFc7XhAXZY8Gda
	RzfdgLVa8SHmqtLc=
X-Received: by 2002:ac8:7e82:0:b0:51c:7b12:600b with SMTP id d75a77b69052e-529d7198c31mr53756941cf.87.1785332084751;
        Wed, 29 Jul 2026 06:34:44 -0700 (PDT)
X-Received: by 2002:ac8:7e82:0:b0:51c:7b12:600b with SMTP id d75a77b69052e-529d7198c31mr53756571cf.87.1785332084201;
        Wed, 29 Jul 2026 06:34:44 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f8401a6cesm116270566b.58.2026.07.29.06.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 06:34:43 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH 0/2] Rely on regmap APIs in tc9563 PCI/pwrctrl driver
Date: Wed, 29 Jul 2026 15:34:24 +0200
Message-Id: <20260729-pci-pwrctrl-tc956x-regmap-v1-0-20ce61a3ce12@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avErBtQocSuEi3MphroR8aoILp70
 vJbvPdAImFK0BQPCJ2ceN8ydFlAmP02EfKQDUaZWlnjMAbGeEk4ZMEjuKq+UWhafUSnveorT1a
 PFnIfhUa+/3fbve8HauqRd2sAAAA=
X-Change-ID: 20260729-pci-pwrctrl-tc956x-regmap-91a0b5ae71f7
To: Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, linux-pci@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDExMiBTYWx0ZWRfX0oEQgvbcbz8k
 q/Mk6VQeylAmUBDSqyf5hJ+7EPdVAprNeVFUSsCIIfxgW+NiiQDdnRQFmPKsFi+XLFCkIQPHVr+
 BYb7J6rYjZtaYhxq/3FhyW6TJFoRnXqGehNAWBgAwR569acG76kuK6ZAt59z4mRqC3nXKE0x8V9
 yjYLRX1a/WzC3ZwQasNf0FctB4eDN/E6vWlzd0u5pFXmBTsv73tmQkboRI2Jc2Fh5CA//JQM2En
 8AvmagK2m3aa/IDmnCKI57byS1aR+KKm2peQac3MwLiuwdvkzxXD8MMwd/OxEQYeMgoIPXfCaq4
 JoYKtFR/4Vw+D7BBYjwSXnjnI/BiJR9j/pqD0RCI+CXImGNfa6+y+V6X5QScYuHPJ0kYX2YT/NP
 lgh/OroT294ICPeF/Uhg6tk+btypUnYOCDkjjHjYifnVGO1IyvcyAUMQc2d/SolzyPRbN8xgrDb
 ZJQWUAwfZIGNH7DaSyQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDExMiBTYWx0ZWRfX1vmN3w0bSvXX
 L5zIiRbY/POkjnLb6EeX7gtCuKVAgnyJrF+JTPALPzNKzGTJ9GgtJfI06W2LAS5xmtl+FE6HVhH
 cmy3AZfPb1Ms7OfOnP6HxIt7xT07RpM=
X-Authority-Analysis: v=2.4 cv=Cv2PtH4D c=1 sm=1 tr=0 ts=6a6a0175 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=upx0wVSKAZD-uM3ogM0A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: oEqqQx7WXfgnFjtAP3_RlKJzaQVT3_dA
X-Proofpoint-GUID: oEqqQx7WXfgnFjtAP3_RlKJzaQVT3_dA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_05,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1011 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290112


---
Lorenzo Bianconi (2):
      PCI/pwrctrl: tc9563: rely on regmap APIs
      PCI/pwrctrl: tc9563: use devm-managed I2C dummy device allocation

 drivers/pci/pwrctrl/Kconfig              |   1 +
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 164 +++++++++----------------------
 2 files changed, 48 insertions(+), 117 deletions(-)
---
base-commit: b9851611bad7cb227c93c1401dca48995a815d94
change-id: 20260729-pci-pwrctrl-tc956x-regmap-91a0b5ae71f7

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

