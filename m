Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB32348477
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 18:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774548295; cv=none; b=pnjNHBbo0A1KFHOlpbPcsJWnVwrJvEEFAq3FE4CDOxF60M91HGKybv2rocMTisPR++6/XnGclF9PNU8Nc7XGS3hbxlrNmb+M0RokljD7TMsPmKz7syC0DTV7/BOYCzzQDJZlTc3+3Jhr3ml5ihg4Dk08pdLklcGvcsUcKphCfIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774548295; c=relaxed/simple;
	bh=OEPIZk3rlUGMq397PpTGbFOpvA5h9JbnqiBuyhQBEoY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sWa6FtLmh1u0NtG2GjqUPYRPIp7fLZZL975tcD9sJCUse02kLHj9pgbJw1zjipzNcAmM7zZU0Uz2C2bUHCRkKa7HqkVg6LKCpgjbx/Gg6wC1AfVw8VooKJ0bcq7NOUhy7im2hGjlGXuZwLTV0o+PLBiv5XQCSWEGISens6AN0Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HndZ3hXH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KdJIOE8L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HndZ3hXH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KdJIOE8L"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QF9pGT790496
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 18:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tc8olBwv+N4J5aSYSwGihdfIDmQvkHQnOlnS5AzLX2o=; b=HndZ3hXHtaQPsiE5
	Ry6bCHuwfOLYOC+dDvkRPVljhoeqjkjJ1nrASVAIw2ry30Wm8uUFl8HxVOaVXa8B
	r090FStmucsoXhA7UITsmimiDBtSrBkqS3xbVIAWpCcowFlnfWPU1PztRHBr0z7y
	hNBRJ+SIyzSvByk71qyyG13dTGUCbqNEVOt3Es22Z3Tla5yO704GIUUV+O+59ezQ
	PYbIDLRrEQrgKtrC8wQuS/WIjK6I1w9YKAsoD6O+hPp0hY8+QGvPK2sa2BQ50Xv0
	gLmu63mT8E2nt0Ptjc9WKc3F7NmVIBeQBS/Fh1nhHMo1GOghEEYJ563E+2E8DQII
	BBJamw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d53eqhgbw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 18:04:51 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-354c44bf176so1649724a91.0
        for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 11:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774548291; x=1775153091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tc8olBwv+N4J5aSYSwGihdfIDmQvkHQnOlnS5AzLX2o=;
        b=KdJIOE8LH5E5Vv0BR7Yy5NXzr9x+MYS9sZmgqp0cKmRxKdIQh73CFpoFS+pZRPuSXJ
         a/THd5TtSvoAcHPc3nHmxU9sTTBzYsY6LL7cmQTtl+VVGuanj0RrbvLgVKJhWt1CU6gw
         d2FDhVupXhO6q8NPkCzIfQzNB5RLYzakgpxT2Zm12rLjRPf+7U6R+yPFK7WHn3+Df8Ye
         hXuOiBKqYTnBACy2jM3i3tm/G4Wb6J6M1FCWyea0KkkGtaiv9hNoXO101i1RPf4CdfK1
         RtbkXNzotLFhIdTbVXiU48T0ATgQsD0I6fz45de+fdJOvXNGr232nm5N6P8ybe1yRcYF
         k1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774548291; x=1775153091;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tc8olBwv+N4J5aSYSwGihdfIDmQvkHQnOlnS5AzLX2o=;
        b=sHjlT/h/e9JPG5mnLKAu8U3rCueics0WvwzdGxWfkzpvfvpp97dDmGalnkN5gapqQu
         W/Co5gwf/nSEiTxQi6CXAPFtnJv1b97Qg4Vl66AwiS9OzYrn9aFAwVy7BvuP44Z9moMn
         oLYtXF33k9Oyu7WFKl0XhTaXnIpk1lVJpWc7o4Db9lIAsjnzPOpM/grlX23nEvbamxbL
         Z4BD1/wm0ub/E4PMbtnfFI45PDcSX+EKpxh0tWfBxBcTBUPbaMcxBWfo1DOEzaITaPut
         WzyjnqZ1ELTs22nnsIjHBcrOvMgbTccFLiEVHkzclsdXih+nNYLQffi/IilK2YI7vjs7
         gc4w==
X-Forwarded-Encrypted: i=1; AJvYcCVxMahiy7Y6IJuWQpejZqFPl8Qq8QCHoPOG7gv+OUtzZV9X33Xwk1EtG4cqPBJd74vEgNmgHOGD5As=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyDfbucE5Pn4YQg+fA1aWPx/yPrx8Cnd0PxmRQ+2j8xMuxNqIC
	79IFuaWfTDe/CUDdojeh5rpcwM3/MLUyKazX3BJDPBE/8stkYNJWKen0cpJ2yTFl6VJOtZI0SwG
	lluNcVn3LnXf2JEsP5ClVqODesrml5bRf++ASByEh7BScJZwDBPqIOHmPAidJaVo=
X-Gm-Gg: ATEYQzzGE4AEJhfOFLQ0rihidsoqfuCHAbgthgwk4mENPESv94IjYxmxrB/FzLLmPPU
	q6sS9RFMxkw5Sy7YRb65ro0eYqz4n4/5O9Dr4vImmBDiwEgbqp/i01Ldvmx9h+9G/IbM9TIuODz
	w5Di2W2ULZp05zqRSC6Wr6CfI2W1npOSHundwJ5KUX9ObqDUxuWfYF71e+tXddhzI2bxQuOqrZ5
	ff86wYp0X2+KfIrGzwcPQ3AhQ9lV7yUfCrBbpB1VgVFu0cqHSdryw2fUfaB87cJivVoIchyDxA+
	IK4Pzv4nit5eqFCPE9x6GswRGjziss6olJAMYcjIVO+fF2tGvYSuJOnTa+dWepdUOt9+sBKcUR1
	9KlS/XbaibgOqX9zo+d3NfLw=
X-Received: by 2002:a17:90b:3dc4:b0:35b:9c97:3d18 with SMTP id 98e67ed59e1d1-35c0dcac4b4mr7549346a91.12.1774548290781;
        Thu, 26 Mar 2026 11:04:50 -0700 (PDT)
X-Received: by 2002:a17:90b:3dc4:b0:35b:9c97:3d18 with SMTP id 98e67ed59e1d1-35c0dcac4b4mr7549317a91.12.1774548290258;
        Thu, 26 Mar 2026 11:04:50 -0700 (PDT)
Received: from [192.168.1.102] ([117.213.101.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22b9fc96sm2123849a91.7.2026.03.26.11.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:04:49 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260314-hotplug-v1-1-96ac87d93867@oss.qualcomm.com>
References: <20260314-hotplug-v1-1-96ac87d93867@oss.qualcomm.com>
Subject: Re: [PATCH] PCI: qcom: Advertise hotplug with no command
 completion support
Message-Id: <177454828672.465511.13212183361634149952.b4-ty@b4>
Date: Thu, 26 Mar 2026 23:34:46 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEyOSBTYWx0ZWRfXwBEYi2dfFK8b
 dz8Lnp/InZnG6f4pALLSs0iExmue6RjPxjgegpFeJIqB5MupUgBu7JmcQYD/6Go9HEf0OO90xMc
 eHphJkfDrafC10fs/kLvxcHuQCUKN5c1cTfj683zC56O9B4gtWcxT4mnsCxanVUXTQ7TaVl0VO/
 w6pE96moWhjE71ZDRHRWmcKVwtQqm6pj1RoRZaa1pINDxDomSc1DdxeXfTOXMiH1SLbG9eFjrq2
 7YhgsBp6suMXpA8H6OF0f7dwDXXFulm3sHoZKL/8HJBPODl4UZ1higVOsw+XqXRsGWsJGTOFVI4
 OsI531Mps1plfFZfFyldFky+64u85ft99rpJWjpPtNmZpSVejk1a/U6qT0eNfCJ0tviX/pKVr1+
 n11/1vzQakvXSYMWaEDzJPUei3RXxLdET9IGYqNaZlXiHFGvaBNcl2qooqE0bsG83osbr2p/6kF
 5oZHoqu0kV7GYOf+29A==
X-Proofpoint-GUID: OugpjgyJj8gTiBs1nZX-ygylXZKL3pBs
X-Authority-Analysis: v=2.4 cv=S4bUAYsP c=1 sm=1 tr=0 ts=69c57543 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=pjPfvbXasfe8cMZvnaMi6g==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=xtLazmnn-CEJS8-SaToA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: OugpjgyJj8gTiBs1nZX-ygylXZKL3pBs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260129


On Sat, 14 Mar 2026 07:26:34 +0530, Krishna Chaitanya Chundru wrote:
> QCOM PCIe controller advertise hotplug capability in hardware but do not
> support hotplug command completion. As a result, the PCI core registers
> the pciehp service and issues hotplug commands that never gets completions,
> leading to repeated timeout warnings and multi-second delays during boot
> and suspend/resume.
> 
> Commit a54db86ddc153 ("PCI: qcom: Do not advertise hotplug capability for
> IPs v2.7.0 and v1.9.0") avoided these timeouts by clearing the Hot-Plug
> Capability bit entirely, which also disabled all hotplug functionality.
> 
> [...]

Applied, thanks!

[1/1] PCI: qcom: Advertise hotplug with no command completion support
      commit: 33a76fc3c3e61386524479b99f35423bd3d9a895

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

