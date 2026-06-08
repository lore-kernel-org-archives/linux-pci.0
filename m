Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E48399372
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 08:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780906488; cv=none; b=pVOIfGy3qcQ+XxOF/oRGGRFbV7pK0+Q83jgdVDO8ocX1FEN8Aqmy66KABj8wxHCfHHCSZfzgM5Jbu3oF1VM4rCBxmncxGrjWAc2gxQCGI1k8kfBN28bJWgr3L56g0qRpAnJCwoROThfkQ0KXDfshecMP1goeRta9hDscelKcugw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780906488; c=relaxed/simple;
	bh=cTz+CEmaNf4eHDQpnwOU3c1JCvIbyzwOrTtHWyDNG/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y+Po1Z2NmCd4zw+FljnlmlsnbDH1DA4JRF2Yh9eu9UVF6bsVxWhANRnrgd6fw7hW+azTmi4nTxfqhjTWXewcYgrux6O4JpJBbMbz5STfL29p4vaBphKmTreHWl1Ae6izMIpJ8gHBNYYfl+7DpcMXSV3UePa68tzfcaQAEpX4NEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AhzRjdpm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZCdm78Bz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AhzRjdpm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZCdm78Bz"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586OeAD2385869
	for <linux-pci@vger.kernel.org>; Mon, 8 Jun 2026 08:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lRRLoMyY3I4u7nHJezOej3HGDZ30vhH6pQAsB8UUioc=; b=AhzRjdpmxx6GwFrr
	gzvq2hVtpTAsgTqU90UZ3SdOn7IJaz7+BEa0Yt51bE+aTxSvoBT0PlUOYJ+PKS7c
	LdDQo2a9q9FmQHtbYDHPc54Qh1WQG8VTsxUjaoILeR3fp+0X7f4Ed92RjOMcfU+D
	VtKWA9cNcolPPHRORcwOfR/QEU8NFCHDIQ/UrZ/VmZlPug3bwrJjf7qoo1dWYOsj
	7eCglthF/uvJkbhPwiNgyR5yYEHy8XYcQaSfAoaNGByZ6g48HS5Yn3suX7LADWEO
	GIiGLpVfQRknKwG7T8Deokxbctks52CAwQHYShFF03TeMwa1veyGsXDokqyndG9E
	3vrdaw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcu8xgwb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 08:14:45 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-517b75c1ee3so11910771cf.3
        for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 01:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780906485; x=1781511285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRRLoMyY3I4u7nHJezOej3HGDZ30vhH6pQAsB8UUioc=;
        b=ZCdm78BzWLcv4+ToYGLypi1GBdWEQDbkP7SVmRyyMsLYBvgdXyo+9xcIrxZB/7w0ZE
         cXRmePiiknzwneNo4LyrUOTXSZgLnPpUDXQupjjkFYkc5Oy6tP0UEZ98j9Yq7lxiy9d+
         m2P6ItJWlXBDp/IDL7xrSskS5JoK60ifcGZ+wUa7HOOZjnsDT6DhzXaRcUYtTyDsgQCI
         cHi7Y3TAC+LgiSgqdIc335Gx6+Uo6elqECnE+mbkPqiSKJ0CPpuLyDtr8YNaxz2pANy8
         2HZgHrF1X56iYFwv2kgUM7qpPSS12l3vmcXkYaQ9SAnwBtOMz+Oa8ibV7G+beRhaGMY2
         3YJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780906485; x=1781511285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lRRLoMyY3I4u7nHJezOej3HGDZ30vhH6pQAsB8UUioc=;
        b=cabc/NGTC9TE5XvM9HF3PEaDbrEToqkrhBejT3i9k8a5QHhTFpGdFDTCaFug1dVXRE
         jK1NvAUe/eMhG/Nt2h319HpX9Jv6sP0kyjrip1PCewZ02wF5sYtZTvd6pzXOC/AA5G46
         Ph3cvw9tR9qxqhvfhrp9BHQkPA4E+RqtHONt03O5PoA5uV+XRKP9CP4nwqqfn9ONm+g0
         6Q1uyH959pI+oG18ak/X6uks/ekBkIbo2oIVFdX1ENtq2twa1uywA0U6GPn6ELbsKEas
         JQ4QRZ61ZJro134JY70w0NlwIuDSuronD6mv9M8ZzDJ6xUrgUAFw+z6sv7C1q/3Sb344
         wVEA==
X-Forwarded-Encrypted: i=1; AFNElJ/bVePSJJycnAP4uJ46Xtg2kX9DjgbDRnMambKkB2Xb/1B1zNUGnHrcJfhUj5D5UsDO76BLdA59+1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQZN2KK0B0Us39v47geZgd4zAOCIDEPryx9qNr6plabpXFSktK
	eC9iB1AfXvUR+FsjW8xYH5DXFSjUc4O2d34VmPEqo9ec240BYiJvCqCLJNpdzJuiEy4vE6sW10h
	jq2QJX2RKistKXWktUvVXDzZsxFvbQQURKWahZVHNvY51wPi4cwKoKcib1CvVBh0WZnzRQDosgQ
	==
X-Gm-Gg: Acq92OFB2nYZHBgHdPyGhZ39Wz9ifRULdAAyrm3LPbIFq27ScUuegnUabMM51XwAzmG
	+hPXj+6ioyI8OGmnen9r1as43oRjibdxJdpNQTfJpYUblxwreAZ/nORjKZ6o/Ll2rUaZAAP8dog
	jWlEGRzMuj1fHv86gJ8ra6/nnwwXecwgVf312Y1WlyWad5pbh57xEAf9CyQLvyDCDu+LBAUEtTt
	0bLjxVX5otexCMYq6ZCizJ5ciZif+Vl6b6EPDVXNdIutRqsMvvhTX7YjzctE4UF8vS3oI5Cyfun
	2RmTVUfltacXavNb9KYK1ZgHPElWB794iYbNYeMAX73a27zFzrqtaSVfqgZIIQXRsL5QxFy1Re/
	naljCERW5cbhMAjsGpbdb+CMlMPhPtJOZIIWjD7naR8y85EU81RCnK/P9FCY=
X-Received: by 2002:a05:622a:1b10:b0:517:760d:48d5 with SMTP id d75a77b69052e-51795b1545emr206567511cf.23.1780906484769;
        Mon, 08 Jun 2026 01:14:44 -0700 (PDT)
X-Received: by 2002:a05:622a:1b10:b0:517:760d:48d5 with SMTP id d75a77b69052e-51795b1545emr206567321cf.23.1780906484402;
        Mon, 08 Jun 2026 01:14:44 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:4904:8660:26f:8b6a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3446aesm54904623f8f.24.2026.06.08.01.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:14:43 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, Wei Deng <wei.deng@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v3 0/9] Fixes/improvements for the PCI M.2 power sequencing driver
Date: Mon,  8 Jun 2026 10:14:42 +0200
Message-ID: <178090645194.42922.8536349476896784920.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260519-pwrseq-m2-bt-v3-0-b39dc2ae3966@oss.qualcomm.com>
References: <20260519-pwrseq-m2-bt-v3-0-b39dc2ae3966@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: dgE248DIKgnWtrliJp59axugEnZ5ULT1
X-Authority-Analysis: v=2.4 cv=deGwG3Xe c=1 sm=1 tr=0 ts=6a2679f5 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=vezmLmUXWD6nqp7YAy0A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3NCBTYWx0ZWRfX4jPjWNlocsIK
 r9ARYI4485d65NJfFR8jT2gjgci0SyLxiKesNb6OZ19LYLk8gbBdmOcpEvLmQ1ff/UOfqIB3WfW
 F1dkOjeHPUM0IKreb8Ye+gNvspTRfFN+Ue+EzePif41+XIDzP6is4ggggCNl5FeaZKUEGmqTAxX
 D8yysYvOWHCRFjSqOESMCddVQ5ixQDCIwjwkBYEZZxXqkyqzIvLKZY8WNuHZy8NJ1MqYm/ocL0r
 SWpUBtTxAlgLznhCIawBTM8CKmZoe96bfe3CKh65bo4wVWwGA02mO4UP9ZAlzIEW9Ep82gDXt/Z
 xFEybAPHWE1RNH+MFh15zNYUsoUiP0Rl4yqU6y3k3p2qqv9XuGX0DWtyyQmN3bRnZIWFSDeVYQ8
 jtQT5OIjkxIICFPn/8g1qF2dnhcS/kA7emzSU7Y6iVK7ZOY/zAdJ2u6wsfCf2PX0VtdE7akGJlB
 8nxf8uQeQvusv6u2y0Q==
X-Proofpoint-GUID: dgE248DIKgnWtrliJp59axugEnZ5ULT1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080074


On Tue, 19 May 2026 14:25:55 +0530, Manivannan Sadhasivam wrote:
> This series has several key improvements and fixes to the M.2 power sequencing
> driver and also the BT HCI_QCA driver. Notably, this series allows the M.2 power
> sequencing driver to work with more M.2 cards, not just WCN7850. It also allows
> the BT HCI_QCA driver to detect whether it can control BT_EN (or W_DISABLE2#)
> signal on the connector and set the HCI_QUIRK_NON_PERSISTENT_SETUP quirk.
> 
> Testing
> =======
> 
> [...]

To make Mani's work easier next cycle, I'm queuing the power sequencing changes
for v7.2 now.

[1/9] power: sequencing: pcie-m2: Fix inconsistent function prefixes
      https://git.kernel.org/brgl/c/da35b212f8cfd2fb2b7beaf46f4ae758f29c4ea7
[2/9] power: sequencing: pcie-m2: Allow creating serdev for multiple PCI devices
      https://git.kernel.org/brgl/c/0822425512762d492d7d1500a38d8d519a2b96fe
[3/9] power: sequencing: pcie-m2: Improve PCI device ID check
      https://git.kernel.org/brgl/c/8ababf888685c3167f49c77bcfae6f82bf661be6
[4/9] power: sequencing: pcie-m2: Create serdev for PCI devices present before probe
      https://git.kernel.org/brgl/c/c4be520907a42981fd32736b6eec18aaaee738c8
[5/9] power: sequencing: pcie-m2: Create BT node based on the pci_device_id[] table
      https://git.kernel.org/brgl/c/f2aeaa6d47d3e94285b6ff648b929f3eeb5ce600
[6/9] power: sequencing: Add an API to return the pwrseq device's 'dev' pointer
      https://git.kernel.org/brgl/c/9085f71285375485c86c06071a13111606b404d7

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
