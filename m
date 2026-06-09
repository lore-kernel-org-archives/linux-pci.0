Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879313A874B
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023301; cv=none; b=ZU+aQiX5Re2g4sPrbtjO1WW2+KV50pk8mufv9Nl5/O8ovHbeEKpgLG4BDq6SaaLslxmZSOJb+T5hDvChxWsuxqMNNfH8URKRp8/E+2bya+Uy41PYFBZL4MwLHdk6r1qK11U0YFou+wCHdsVpImJZ8cEKB7u3frVMpjfY/lEN0Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023301; c=relaxed/simple;
	bh=PtSL/53hiLe+6x/StNo6XiZ1RCWfyNT6fsHIkyB3ORA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LXzplOpL+uj40V9t4/7phEHukjo6Y5nhKd4jhU9YKO5Q1Yr3Qbq0ZT/AepNMl5KzysmxFoCIYCE23VbSHK2NNguQDtuh+LCEu9aHuxrAmleAYljMb5A04EXf6Oj8b8vw62cOrovMOgAwQLqOJQjg0Rmwv4bjyI0YMkZ3dhGToX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QBlLSGej; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UcwKT9Qs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QBlLSGej";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UcwKT9Qs"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659GOowt2785762
	for <linux-pci@vger.kernel.org>; Tue, 9 Jun 2026 16:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0+SJ1odAbeV0uTMzVMi5ad2jR+3gn11BCR39nm6EOKs=; b=QBlLSGej2K0E+f/T
	21hcAjzBrBx/5WrXDO1EWdVmXtHAKkw+lq3CxaKIsIKt+sxjRazrqvhJ6g3HcvXm
	rtyicrP11SYYMUmeCHltMUiUSzt9KjV3fixwRPY+hwH4ENjVLv32g2nFq8tTGQ82
	+oTjgne6bwvjdnui8flGxRH1Mdqp/OHow7tIxabFNlDVvZKJR0CsTYNWLn1cjKXA
	NIy0hWDtj+XoBarJd17JmXggrbGJ0Ajf0PTxHcJgGLhYT5qcy7qo3u6rxlZyFaKn
	pIUi6WlRB/7owAR1KtEf9lN/SgRRO0fLkRRLliK1hm3uMsBOP+dij5k81KNVpD2R
	Cy6wkw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3jt7aw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 16:41:39 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0b35fa876so70215695ad.1
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 09:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781023299; x=1781628099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+SJ1odAbeV0uTMzVMi5ad2jR+3gn11BCR39nm6EOKs=;
        b=UcwKT9Qs0sw7jAYKKfV4L/GISIykJGjXskEfvkpNa4SrPmr+IX9pzBrSKuQxipmIJp
         My4907mWv8Ub+1ryJLLOtQslqPI0Np49dayAsphdp0gBU/XUjbGYH8AMB3e8pD85VmYE
         2Q/KlHzx9jpuloEZ/cLH8pyVH4hRtCqlqPqHmlIvn3hcBKrybgPSfFkkPplhK2obf/Jl
         6Z8mhpZcOZqEBTMl/hPdHnLdu5rtBQCbl2atEqsEPKkGVZNDxFA2U2nV23d1Av42FTCN
         IJDJ8cxH0lVtxg6iyWUZ7B+m6Lfd916UAn7UpaIm44nflIrWGqReiXV+c4/4+AzEMd9n
         +Csw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781023299; x=1781628099;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0+SJ1odAbeV0uTMzVMi5ad2jR+3gn11BCR39nm6EOKs=;
        b=jTS4jAuK8HFGJ2fg875jBCktYHukepph07LgrLy6XU9Gk+TDn8P7dTO9qk0QA2zqU8
         d1gmvSMTrhC0fF9GiGaW1iuM7lHdKcEfHZcxlWAjgLCS5R2jK94iDt4KhMokYM1o4JHo
         SQw9DWmlRWrw6qUiKAEvolDa3tED6CFdAHbk6hzhuO/+Dp7fkylrhxIkfoXMXf5EgxSM
         OMhmYKUTN6ZgVhgouZLnGKUnNDUh0846J14PUCWmVrMXlbeRYSYHM3DCmZtQT0/F2KLt
         WXsgfCxp1jbpRUKaCPQ1Oon/f9W7sWrUu9HbNxvKdRHB6ljMPVT4d9t8h55CLPToHC0b
         7xSg==
X-Forwarded-Encrypted: i=1; AFNElJ+cCfh8O6rWpiIB93o2O9+43A96gxpe2BUzyO9gGTaVHLjys8+EBn5XoVrBnlVBqEwxfcJLRSzQ530=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+yYNxiRRyeaRKFSyqh1sT5k0ibuC5YQXBiA9dWPLBiwH78oVJ
	2iBw2i52GLcwSWhkTuH05gDcYyIAogKjB0FejjfAtYki1ah+CvOTMrwJw8owrmvHklZzbZrj4eg
	6ebuXgXq6LoU9ZyY8rziMojK1P9/qswND/yv00vXxi+97cyJqTd9o2FnRKXmD5Y0=
X-Gm-Gg: Acq92OENddX2s0h0UKH1V8PbD5p1B+OM0Ldf/t6BnBsO8axeKE1XS3e5OzzKgCAEcTk
	lcBFFQWlQYdC8KIZGlU6YY3gE0lxYfgSSPwanaNw8DjNLSd9GztNWLazfvrwfR1PWa21BpCQrSc
	MI/qQ3u1WF0DcWPCA+sJIztt7PzZ3dqjKHs1Qzm3Uq4ESxkEGJxvxWz7Btuu2jD/s2YgqzXe9ho
	TWNMITAR6afaCyXnDkZC0vqRdpB9Aeh0AtLHp7yAXxE/ofxIuOvk2hhWNDhBXkDXcAySCU7772S
	YngqXhPmSzjgIk4ASf1KeJ9UgoP4PzE3GHNKcCVuYXgcLLqjQIAmkM7wxpQvUezw7wWOO6eyXaX
	TgnNSzLZr/6RjtO28EInZV0nOGDLd9OE=
X-Received: by 2002:a17:903:4407:b0:2c1:d49c:8398 with SMTP id d9443c01a7336-2c1e78df934mr243154205ad.8.1781023298980;
        Tue, 09 Jun 2026 09:41:38 -0700 (PDT)
X-Received: by 2002:a17:903:4407:b0:2c1:d49c:8398 with SMTP id d9443c01a7336-2c1e78df934mr243153835ad.8.1781023298472;
        Tue, 09 Jun 2026 09:41:38 -0700 (PDT)
Received: from [192.168.1.11] ([120.56.203.186])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609df63sm215177165ad.40.2026.06.09.09.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:41:37 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Yue Wang <yue.wang@Amlogic.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Shuvam Pandey <shuvampandey1@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Fan Ni <fan.ni@samsung.com>, Shradha Todi <shradha.t@samsung.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>, linux-pci@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <1a0c86ab264cdc1c79c917e984b90991af51d827.1779123847.git.shuvampandey1@gmail.com>
References: <0f97352506d8d813f70f441de4d63fcd5b7d1c3e.1779123847.git.shuvampandey1@gmail.com>
 <1a0c86ab264cdc1c79c917e984b90991af51d827.1779123847.git.shuvampandey1@gmail.com>
Subject: Re: (subset) [PATCH 2/2] PCI: meson: Add missing remove callback
Message-Id: <178102329225.12739.7391385656856361501.b4-ty@kernel.org>
Date: Tue, 09 Jun 2026 22:11:32 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: LLRO8D8Y19uzcVS5CNTyxmLsUz5N5JsR
X-Authority-Analysis: v=2.4 cv=aa9RWxot c=1 sm=1 tr=0 ts=6a284243 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=eDurORsI8St+1bJHqsJewQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=Mn0DOdAkTdazpQ9XZsUA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE1OCBTYWx0ZWRfX/3nqztIeZcnC
 S/4R9U6z0EeqDSQNdSjkcP9EHB0fMEzKRUc3hBGiDa2fQ1/+j9yuZyOcuy6JPyP/jTuEmZiG2e5
 HZEJN8tQneA/9u+CrFnz3s7zUVl/+e9GNMpJ1RPVFH3zW5l3wE9wjfYZmIoG80lEZWQ/eouJfSu
 dqXMOYWiO4q1YFZaMascGJvRnAUrrmbTaqqxEYv8e5oP1eBQPd//QIrC7o7tw7vOMDExBQCs2Hu
 d13/lUSybOE6U0si85yChlb1ky7M9DAm7YcV75afbL0I2xLgRPESx6OjFZ/4ROxVkHRvpKBOFSZ
 y26+hgPGpl2sMUg+s1MDVkNeLj5aQ2W4xQzadiFdX52QtbBUltQs6vrgF0tKoRhGCENchpZz5Dk
 bnFP/Ejr21vt7hcmHcddzQlXedtdIRB+R6dwxwFjEZnDaJSfgAd3RxhFosbLLx0+/iK97JOZGKY
 T1gGYWyJr9qDK5EZQ8g==
X-Proofpoint-ORIG-GUID: LLRO8D8Y19uzcVS5CNTyxmLsUz5N5JsR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090158


On Mon, 18 May 2026 22:44:18 +0545, Shuvam Pandey wrote:
> meson_pcie_probe() powers on the PHY and registers the DesignWare host
> bridge with dw_pcie_host_init(), but the driver has no remove callback.
> On driver unbind or module unload, the driver core therefore proceeds to
> devres cleanup without first unregistering the host bridge or powering off
> the PHY.
> 
> Add a remove callback that deinitializes the DesignWare host bridge and
> powers off the PHY while device-managed resources are still valid.
> 
> [...]

Applied, thanks!

[2/2] PCI: meson: Add missing remove callback
      commit: 4b0dc84b293984f75598881809fb2d3daf54a2a8

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

