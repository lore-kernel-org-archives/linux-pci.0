Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEA04EA36F
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 13:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565894; cv=none; b=OyVH+O9EmByswu9sBLNUBb2ZHVtQu81JBPn9tgheHLK1ljS5TEANbYPBe9su+ChbkdEjuwTBtIbuoC1Gj/upnZvSK1VdZ7Mne6+++phJ47EGM3Ebmve4WVdFfbDsWE7Mcnr7Kj+jvtETnZu79Y3G8AHboNGyA53F1pSxQjMnKAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565894; c=relaxed/simple;
	bh=dli4thVl0/lxjrbuWQYG1n75DsupJDZPWr0t/4D8kHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oyb7Y68qFyfo9oO7Ibe+oAeA41v+WBMepTNEqRhI052nehAiz6BadqYQjuLEWxJCI2LA7HzpOJ3waOqBuvEDPEACXZHGKOkSn1smWQ+tHJ8ZCgN/UbCA/HlXIhRJ4NaXGEEY+L8Gn/K896M3S4+qV5czE/rmgyuLIqg+fBv+cGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dNlAvkQW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KIhfP3rP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dNlAvkQW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KIhfP3rP"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GDJls52283870
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 13:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t+yROzQlRt7LgNDY92+8DzprGrYcUOrZaiKl227u+Jc=; b=dNlAvkQWB40U0DnK
	N06gp19Onp4iXOxLmBey8HgViZ33AnXPvyh+y+CI0xQndwQcRE6GKx4KtqoJzK9V
	EldxvBcEbEiLoqBLRZ+NXDFH1I64391HQouqFLm4xabFFt3kA1J1y6nDtKmmDU8q
	FdeFx3MgdwVr3xtv5f14i5U2U4zXcB20m6lxVime6wdc1CZuHt2w5IonvjxlTSNp
	lkbG9pbLjLViKr4qj4Eupm45YbUfQPiZO+/mmaEdBc0bV7x84zSlXrRDgGLadnQL
	vi39DLxo4rmTsudhQ+zlG7XCHwWpgOgwJPBItawy+KX9w6VRwaFjfnewF3/9ymEr
	zntgGQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gquwb028s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 13:37:51 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc73f47bdcso75630085ad.3
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 06:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789565871; x=1790170671; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t+yROzQlRt7LgNDY92+8DzprGrYcUOrZaiKl227u+Jc=;
        b=KIhfP3rPRFKh3UX6/GnHZa9snqrt1q/zjOuSfA7u9x4JSng7Y74aKmyHWAOHUYpsRa
         oXSMiNKsGuZD09Ie/UNRqzhcvo7E2yNE9/MUTvPyAg4iFgWbqFRO1eo/wXtyyTHQOaqD
         UASXzvGPQO1c/5IZqs4tCajeHy0E/6IGPdDNUsgiEBhV0NfWC/V8jkCSsl0x8siyc5CA
         lQAdtw1Ut1JfGTHInLZVRkEfkvqP24T0RKZfiV/I5hP+RGrVR0Wvbqb1M6Gh63QBGhJ2
         oWmqdKJEZ6tFuNnkAHXYBBsfjbbc0H/0UqgFIi6QPP+y/Y9cjN0/ts7qeQLWBtJyaK8s
         4z/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789565871; x=1790170671;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t+yROzQlRt7LgNDY92+8DzprGrYcUOrZaiKl227u+Jc=;
        b=zaPe+bUS5OCqn4UEJ8k0+6Q7rPTBnPeO+xiAXEMmt918wynemN5J/+AHujNC3+yCm5
         q2GnK+QwJwNXVJbcdGMeJc7mfrA914bc0EZMhCW4Hp2Afodqr98dNOuT4OWbMfi1/GGg
         P8ZHP8MqsCKVe5l6fgRZWUADnXzAX5N1p9hZcWnXJCakThBs88D6aHjefZwMFYk0Dtj8
         RoQ5sSZ4lvpyHE9XVnpivWg9PN8p2jcn2/qwkmWS7ucMIFSizlHOQBSF6//+VSxJtx7h
         PU0ep8wxM2AJcESDTAmpBgePTIg47yZlqhFAQ44wvwEgiJWAk051Qv1pA/TX9SkI8ym0
         pUcg==
X-Forwarded-Encrypted: i=1; AKwUvBxZ0tdb4igjoyY/sCt76rXKh7SY0nPIwL5FNa2CfQDVDLY6Xd/OEmSi/oF5z7fY/LJhwgYPfUTQsTs=@vger.kernel.org
X-Gm-Message-State: AFuF++lhIPGlDawePju0lgKnTOaB5I9yosEoiBFGAoa1tqKkLZLOVo0l
	qkCKCnVM/PAPr2fna9SR+TFBAl5DAtG4Vh2zQomQOgF4haJZ0qnHudz+BHIbBYvYcvxtQ9gxtmM
	KgODaP4A1hlgqzRbBAl0ZuvYQCmGa5C/qjn43z8G5+h/Jw2T4b0sP08i0MDfq/mk=
X-Gm-Gg: AYBFou2hs3T0o/xc3dnpqqL09vafTkh3av2D5QROkhqbFddJrHzJcfOViUH6U4wlJ8J
	8ZQrGDLUEgiBhn5zoR+WzKhIAztM94xDAWeXISUgrZrt+DRP07Lt+vPMW6DnYH2X14LV/IWQzwt
	bXuqgYll8ngVE61dIebNUBUnHVQ3YwdVeFxcZ1ZClH9BO9PYELzjHxMeYG3vEmTUKotBKmxTzvS
	yTAaNFFnNmdAjKr/ZEjswCm4KXFyD1hnu/b+hgULgQ1riuCItshRYlG6CQtDme6Ir4cK1cJa86P
	X9Spj+5cR3j+RY5//mVxo1PiUqayABDF9VJTaVNxg51YLmVuVdf2VNPgfzZqOxdbGyz+6KaHYEn
	ZNPE/kF2/9VamfzZFk7Vu8JwJFgwc8njt
X-Received: by 2002:a17:902:ec81:b0:2cf:8131:75e8 with SMTP id d9443c01a7336-2dd8e400f70mr59986375ad.13.1789565870672;
        Wed, 16 Sep 2026 06:37:50 -0700 (PDT)
X-Received: by 2002:a17:902:ec81:b0:2cf:8131:75e8 with SMTP id d9443c01a7336-2dd8e400f70mr59985535ad.13.1789565870074;
        Wed, 16 Sep 2026 06:37:50 -0700 (PDT)
Received: from [10.92.206.34] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89d905f8sm12020575ad.2.2026.09.16.06.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 06:37:48 -0700 (PDT)
Message-ID: <88b7e836-4dcd-4e69-950a-c844e88ae7ec@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 19:07:43 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Ignore -ENODEV after Root Port reset
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
References: <20260916-topic-pcie_portrec_enodev-v1-1-5dc7bde39552@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20260916-topic-pcie_portrec_enodev-v1-1-5dc7bde39552@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H4JOUOYi c=1 sm=1 tr=0 ts=6aaa9baf cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=U-vv52QimnA-Lxqxps4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: nJ-afAx2xP8lxdoJnuPJ0Nn0NUlByBxJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE4MiBTYWx0ZWRfX8w90Ay9yUknk
 0G2lCrU2K7/tUv8hNicALG37ljLxXLncWpTsIIZZUC+Zu0yztzgkxsUOBfHiMDvtYqH2DFQJsr4
 ILB+ppJuLUBecYdEdQ9Z+3XuEQPMEHyK4g2alOkeCDabe3CPv847mknvJiyPICoqaeGLj3JsTJZ
 J3qP8+d4+3HycZ7PMqInTLogIcwGSqofBrxGO8zKNlkXJaS6lE5mgX09ZfuXBesQAhNq8tNsz/f
 iqf9jjWYn8ECN4ZN/G8iyT2hl5n7hZ9l2RiJiDUKHhurgiXKHdvJbxDb74lP/NUSS6HtVEDuBVF
 z6eTLcLXF+mHKRRZ1DSEJSIv4R6gfI8gBPvVjbRXhK/Vxogc2vVzm9GDOnWH/5t3B1aqqlxUzqb
 XgSR7evBYaACI9dZd8kQ+D98q01RPW6x6ZpFPC9FH7phQenJoij9MGTMlZ8s6fBuPgHKELy38S7
 +dwjGx4uPr7iB4F1UdQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE4MiBTYWx0ZWRfXwFHkkmOYr0C5
 V3plwpWrB+TCx1bF7yCM8CncPntVqxFr1Zr/ehCGEk7ZzeOsZN2byM5OI0SX5+YSD5oyL/ok/aG
 jLLJCL+rRrFL4fMwJyZbGXet8rWURqQ=
X-Proofpoint-ORIG-GUID: nJ-afAx2xP8lxdoJnuPJ0Nn0NUlByBxJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_02,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160182



On 9/16/2026 6:07 PM, Konrad Dybcio wrote:
> Root Port recovery may race with a device hot-unplug. In that case,
> dw_pcie_wait_for_link() returns -ENODEV because no device is detected
> after the controller has been successfully reset.
>
> This is a valid outcome and should not cause Root Port recovery to
> fail. Ignore -ENODEV while continuing to propagate other link-training
> errors.
>
> Assisted-by: LLM
> Fixes: 4d88cb82a6d9 ("PCI: qcom: Implement .reset_root_port() and use for link down")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

- Krishna Chaitanya.

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index ee63a6ec99de4d07c16b8d6cb68df0d92f822cd8..3d3be9bf798b7c247d69969d6570385b8648123f 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1880,6 +1880,9 @@ static int qcom_pcie_reset_root_port(struct pci_host_bridge *bridge,
>  	qcom_pcie_start_link(pci);
>  
>  	ret = dw_pcie_wait_for_link(pci);
> +	/* This linkdown might have been a hot-unplug */
> +	if (ret == -ENODEV)
> +		ret = 0;
>  	if (ret)
>  		return ret;
>  
>
> ---
> base-commit: e6e35979777d646fe3c7c94dca7dd32fb25d45f4
> change-id: 20260916-topic-pcie_portrec_enodev-cc576ea927f9
>
> Best regards,

