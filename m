Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5378147F2E7
	for <linux-pci@vger.kernel.org>; Wed, 21 Jan 2026 09:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768987293; cv=none; b=g6B9DdJeUJrddjKRTtZ2ANoX90SvFOqVOGk5ex+njrK+42PyKrJJ8VflQ/vUTfP2lH17R4mevsf1xO12LnfzrsO55b9gpl8UiVjra9SiYR492ERRHK5riL31pKN3D2vd+lDBp/v2j46D2k8LYaZ84O4WiO377X9QVe1MvnMhXuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768987293; c=relaxed/simple;
	bh=WYPlexRusfWojb3OPyvMykLnaWRiqhldQUVCUlB9mJk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CEPrjiD9IoCuYTiMQXi0BNh1VTmi6c6TuZyKbgF4GPp7TVcYlbfekSHZDSkgJs2zIugTYElQELmT0aoRpzgls0r6nXGzv98b4B8K5g4PtTKR6hmI9x4KIZoaXnrQ881huhyahPO21MO5lQLxVccmShwHUG9IjaF3IUgNmt/M198=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K7zEDBh7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eBA4fEMh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K7zEDBh7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eBA4fEMh"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L2XgPR825361
	for <linux-pci@vger.kernel.org>; Wed, 21 Jan 2026 09:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tj5ud+JVrhxABvmCSxZNYyE158uL1/voNQYCxejj3Cg=; b=K7zEDBh7mSjRrIB3
	89HULcGQHH9wtGer7h+NoUyIGBcUNbLuLjvyApfeIqgmmWimEhAin3m5BpNLQQui
	HJv4bm5NbNrGXjvSAwxpBB5ZmbQLaGLyasCy97WKqwDqcoGcp2A8+OrzsyneZPBf
	ZDHP5JUztawbCEX5nCu92Tph0aLXnZGNu1Uy97x81YmL21ms14w95FW0JflLR5O0
	BhR4kUS6SheE38A8X/OKQ2o0cLnAG0gyWYfUln+678GKLsxAEXKGWyaHwHLBvbTm
	NG6BoS+i1A8Niskeu1/Ry3SQgNN62ha0J3nyzTyLLTWqKLrm0Y5SXwrf1DFNQrrF
	iebQfg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bte5e33nd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 21 Jan 2026 09:21:31 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c5659f40515so10315836a12.2
        for <linux-pci@vger.kernel.org>; Wed, 21 Jan 2026 01:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768987290; x=1769592090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tj5ud+JVrhxABvmCSxZNYyE158uL1/voNQYCxejj3Cg=;
        b=eBA4fEMhVDme/jST4i8r0qZz4tZk8EgsEgYdcXe8mhZY/8TanF3LMeMAB3i2qKW3FR
         PsAi94hkGXUKL9cc4YuI2Z9oFFsmbez6qp7KX+S8cleTD096gWbya+Ag8wtgQfGKkugD
         a+g5pNFUTIdGqZ8CFA28mXe2g6X5KwKbj7GIfaHrUi4YsgHEsePPTkyIKqn/UDDQN8kn
         mF11d5yC5sf+lWt0SEOGfKvM88D4lHw3A7tDKSIByorwLgy7dx7rcYXbcDZdlHkIZXYI
         fv89f2XIxVOBeahqqrym4k4LNXvNfLpzK1U4DPqvXMqc49cR+OtSHSqm+s2ma6S/pMqf
         DN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768987290; x=1769592090;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tj5ud+JVrhxABvmCSxZNYyE158uL1/voNQYCxejj3Cg=;
        b=ETruA3bjU6O9ho3/lX+TM1aO5J6QbddFa0UIehO4jP9/6M4ro4cOumLFMBowb2JS/g
         j19viF4EY8LMeI55J6kF85kcV39/WcXKgu3E13qAG5TWO5DQH/uL5uLiV3JVmSWMknHN
         wEWO4lkW+jPYnQ0AjnPS6hHxetFhHI4DnOFMOWkYeQMrp3uEMdVuc31FTvS6W4n7Ijv8
         QQK+HmgCqgrAPs63ra1rCUAmeQHdey6jZ71we2y2LcHQOBWUJxtEmVkzx9Xe5JVqKjvG
         CWoCr0xpTARMhv0xR/X5X4X5+22HgpxakF2lcf71DZTZ5AgDMpKbj5rPKRX7GhJk2/IG
         w66A==
X-Gm-Message-State: AOJu0Yw1gGBRllHknEMxE5AfQOTjs42+ec0Etx9Wv+AG5EpbkInYNj4r
	uJ1yXgpMERhzI+OG6huyfL5iYPxGcI6bvp8nn7DfGEXsv1dXnthqpT1VkLojrNIGRRWL76lprCI
	FVpV1OZgSfk1N4lGpQobQcDCxX5q57tJqeRXq3CVIlhVNlHTEKLGf4af0SoyQqgg=
X-Gm-Gg: AZuq6aKxh/sjHbbKWylNNjTHvE0r5AWC0+une3veSb+CoZmMMNcOpnpFGAQX1dqyimY
	YHlt3YXFR95Pv/cjd8rCsg77uOgOVEbAzpdILUomFOmIR96KjFhLhZsxpvLkKgvonLYN/Nru/vQ
	n0hd8W+KCJcuroQNz3G4DsehQt0arRoTvY71XVj6uUm1MVcpZ46Ijy2PjWnb4btQoGmz3ejIEpY
	01c+q++1M9XLmtl8xt+pAqFGyErco36HFmWCRYj/7J4M+ZR1Y+WqCH6rSC6H4pbGQyM2t2BxMyp
	HC1CdXyyuroQD2TvswXQud40rJDQx2uC9TzxoGvs2wrwn9c/e1yOE07wXSXhcehjpf1LDiod4nU
	UEzp37YAg
X-Received: by 2002:a05:6a21:a92:b0:34f:28f7:ed75 with SMTP id adf61e73a8af0-38e45d08641mr4378470637.8.1768987290119;
        Wed, 21 Jan 2026 01:21:30 -0800 (PST)
X-Received: by 2002:a05:6a21:a92:b0:34f:28f7:ed75 with SMTP id adf61e73a8af0-38e45d08641mr4378432637.8.1768987289557;
        Wed, 21 Jan 2026 01:21:29 -0800 (PST)
Received: from [192.168.1.102] ([120.56.201.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf32d175sm13946763a12.23.2026.01.21.01.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:21:29 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Niklas Cassel <cassel@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>
In-Reply-To: <20260120-pci-dwc-suspend-rework-v4-0-2f32d5082549@oss.qualcomm.com>
References: <20260120-pci-dwc-suspend-rework-v4-0-2f32d5082549@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/5] PCI: dwc: Rework the error handling of
 dw_pcie_wait_for_link() API
Message-Id: <176898728392.8683.2121219301314088757.b4-ty@kernel.org>
Date: Wed, 21 Jan 2026 14:51:23 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=BKa+bVQG c=1 sm=1 tr=0 ts=69709a9b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=o3iIPP6MwdQAWb28Nvg98Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=l0eKoVHDl_Uzooj90OMA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: BGU2w-2vF4BTd5D4zV9LyCy-K6qghuTz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA3OCBTYWx0ZWRfXzs5A8S7l+V7s
 tcmVXyuikOdR8LRCiynNvLvbzpsMNBl/8Is3nN0IX8XxNZwUCgtVN9kiIed7XfayHchuwWEH/na
 cCU7jZ8qwdVPkTATsH2rYeU7NtT+Lygo76VRJNVckNYtUQAce/9Ll/HQqRYoeaNRzeRrxF3E18V
 HkO78+7t8QiTbKuEpk2uTQ3/xQvSMqKbZv/A45I+jocekrefa+/AJzCfeJ6In7MqUjRouQy1UPc
 jqPUQ4dFEO2iOqIeNypBjTcJ0j4w9N5O/H3IPd+z2ZekKt3/IS15I1yoNANZg5JcQBT5XHR4BPn
 o9GFZuryYZSDpDF+jnlv5LO2fpWrxbyzM6JOM9K29qaEUnP7UKhWff7v5ROOyDvU06Sp697/ab/
 lGPi54uC5+7u85Z3tgzd9XDq2kSad7eH0w5aKAWNLkfhi2fR9ZnyO1ha8nGYPEtQ2E8iYvbJStj
 KuFUAUhtwPUj+05Sw8A==
X-Proofpoint-GUID: BGU2w-2vF4BTd5D4zV9LyCy-K6qghuTz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210078


On Tue, 20 Jan 2026 23:17:39 +0530, Manivannan Sadhasivam wrote:
> This series reworks the dw_pcie_wait_for_link() API to allow the callers to
> detect the absence of the device on the bus and skip the failure.
> 
> Compared to v2, I've reworked the patch 2 to improve the API further and
> dropped the patch 1 that got applied (hence changed the subject). I've also
> modified the error code based on the feedback in v2 to return -ENODEV if device
> is not detected on the bus, -EIO if the device is found but not active and
> -ETIMEDOUT otherwise. This allows the callers to skip the failure as needed.
> 
> [...]

Applied, thanks!

[1/5] PCI: dwc: Return -ENODEV from dw_pcie_wait_for_link() if device is not found
      commit: 1bcf245c837bc66fdaddea222bab9eb5c978a9d7
[2/5] PCI: dwc: Return -EIO from dw_pcie_wait_for_link() if device is not active
      commit: 01d16b8afb7afcc17f999f8b4a9b9cfe6c6fae71
[3/5] PCI: dwc: Rename and move ltssm_status_string() to pcie-designware.c
      commit: 36dd677f7d76ddec96d50cf57f543ba7d612087c
[4/5] PCI: dwc: Rework the error print of dw_pcie_wait_for_link()
      commit: d266f63b385a3bad5fd6f23797b6de57de998677
[5/5] PCI: dwc: Fail dw_pcie_host_init() if dw_pcie_wait_for_link() returns -ETIMEDOUT
      commit: 86cbb7a81068434fdc1d5afb96d91ab971fb279e

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

