Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4763B3783AE
	for <linux-pci@vger.kernel.org>; Sun, 31 May 2026 11:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780225663; cv=none; b=m+Z6Pqd+Jx9L83i1zFHLmlivIAm1r3jojozGqckMYOAZVEXGC1+WlautKup02ZF1vlu/t/IfBw9YAV30Bd0RpucQ0M+61wrxD+/rGFdGirC4KYS0/Tfv7DNHzCTc0s8kB6ZMaBhP19wN2t39De/kIj+sOCWWn2gKKP08lx8bR34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780225663; c=relaxed/simple;
	bh=/0ktdilly+GdNM45BFy1cmrSA8nae2pVCT/7CW2sqBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBw0v88K2SXaIQ9pKj4lZVQCOymFyM/tC5tbnkm9Djn3YJbFaqeUqaycEIoevW8/z1VcOw+zMGm3GsWOs0880Dm1sFjNz9bUuTkhQZSgYuCZ2UKyiU08cxpG7W4E1tLMYZ8ARyCMcNm+hsZQqRP8ObW7q09SQ5/77yQ8gcP7Czc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Oum3agTi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ClvdT+Xn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Oum3agTi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ClvdT+Xn"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64V4eBai642745
	for <linux-pci@vger.kernel.org>; Sun, 31 May 2026 11:07:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=RLbzLIct6+8d2XYhYF/y4mw/
	mldeTBEN6f9cogCloG8=; b=Oum3agTiGAlpPyv5fsV+NVqXyvjSXyD8onXEeR9Q
	bJ1tQsbH8yH1YUqzNG0ktdMYkXqIEQe9jYB1/RKTWfJeHduM9KrkRSaRMwRNWUg2
	27A1ORr1HFLfJevAJQJIKPRIJECUvwHUL1KfQ4NOP9VPJiVS3/cTd7DOx2qNbhFl
	wlgO3DzcbCagrw5IwMSPUtn161n4QlIJzq3F8BOVTj4BbmdBtEy/XM1ebbzDIJVB
	8NYnAf1q7+Y8RVuoUcSRd38pCzD8z2ObtHUh+7qeKAvIcPPhjTxMK8t/cW0B0BB/
	62NpVoACFBPo2X8Y3dFMIV2RUx13XNZRCgS7RV4wX6NIiA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efxy7tmd8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 31 May 2026 11:07:40 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-96395e5f46cso2510494241.2
        for <linux-pci@vger.kernel.org>; Sun, 31 May 2026 04:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780225659; x=1780830459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RLbzLIct6+8d2XYhYF/y4mw/mldeTBEN6f9cogCloG8=;
        b=ClvdT+XnKYsHILttjlV0b3/qHV9IacvGqFPoD+xC61IKuegrI04s4uMgSUz/jafO3P
         RSASwo6BZufcYdSeVIJNl0FhIdz5cps+ZmIO27Nm+CzvyBz8+THKMJfzRNxrE6MqS8lr
         S87t1hB+ZxsKYx3HVPgMmAFkNL9XEv5Uy/2z9pWUNQMS4vm/5BS/zkX/2Kk+fqncwlhv
         dzUpenHZboDkwpMIaUu5JuYhqSMPoSVP4lvGtVMKvY4JuVdRZB7I9ldGGitTu4Sarb9C
         PlTz8qTAPXWc+qUfc6Aa4sw0fPmLVE83HTB67utk5YBY2yQAtbZZy67j2ewzgaDt9Om0
         GEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780225659; x=1780830459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLbzLIct6+8d2XYhYF/y4mw/mldeTBEN6f9cogCloG8=;
        b=Dhyhxqr8mzo7zuzWxUPjg3TKLzRc9fAMdcp1JGJ0moUe7O70PhqIHiB+3nWefF8rLp
         n07irrW96y6ZekgzFbEzY0W+6C2SOfHKiNpGTy8lP41x5qXbv/Xl+hJbFOpKm6rx5vgt
         OPcVNU3gAmJhzSW+oJuJFBVsRbLWukD+3whWPDlITf66GKyGLMMTstbcXy3VWXA5XlB4
         sFyhNV2Yu9TfF2G6/hJJlQHOd/02FjtVjo6PgnMIJroeVTDXGOxx8ebbja2d6IvdJW23
         RQu2Jo3wEUvb7/zRXXujTMNgOJaQa2PgJ4+9immPk6px1g+92GgeVT82VHBCLPTHYnHp
         Aa0w==
X-Forwarded-Encrypted: i=1; AFNElJ9GDUMrFKnmNczLJcrvoL8mHHq98Fi7DH8JLRg7l6NbHv9tEzxHQwiUCp3sdsL8eUQ8jmu4tuLD/Vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA1bJQ3pQLDQ0ZRgZuRJazg4GQYKCoXzNOKnysQOq/M4bhKKnT
	7Tt2UxEadD95mTtMP7zR52znWtLiFLS+7B5KehX4WpN0W8ATUnvEvsnAktHyKaKoUwjmzqPYcY/
	0NI5kWEgVR5aca+mcKRtQe/G02UPjgl5wsJIYNX9eBpREt9VXBxFvrXm70aMLpJOjdQDw0rh24Q
	==
X-Gm-Gg: Acq92OHhAV+CP9+D+orFDDo0fhLQXmWjEdJO+04bHhBU5uan5EdK95Y4utoeI86pTYA
	b1oXIy4eiKo5gvNJ+6Jmh/JkIbiCsb8ahmciNsd3fgCrkfob7qk3dVd21wEX7wy662RTEqoswhN
	TFLJlmbKIgCDf8NJJoD42fj1jCZUiBRXeTNU9CarjtaRYzUWVPzrL6Xnj7SSWyZsVtkmgST7bcL
	s9NM6RYpoOtv/eUdcm9XUlivi4BjOVe88i+0fAquC811fWXgomxM7z9eWYf4P7cip6O/LWsUk+b
	pSei8wNHjyk21qKm8207oEMYbXoCThrfAwVlGS3PbeJBd9INg/u2ECNZFLpXmCsUPELnv6GYBWj
	slDCvLLHeg+5/YoU1UOKP/eDw3QmSgzyETl+SxW/Eo8rBTRY4ijh9ns4FPXY0IVR+CztvxScliK
	xk+b45QY3ddAegwikj/f6mmhqJvHnPTruOa8Z78expEoCKCw==
X-Received: by 2002:a05:6102:3f92:b0:631:28c1:154e with SMTP id ada2fe7eead31-6c693fe947cmr2443254137.16.1780225659557;
        Sun, 31 May 2026 04:07:39 -0700 (PDT)
X-Received: by 2002:a05:6102:3f92:b0:631:28c1:154e with SMTP id ada2fe7eead31-6c693fe947cmr2443246137.16.1780225659172;
        Sun, 31 May 2026 04:07:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa5b59678dsm1497814e87.52.2026.05.31.04.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 04:07:38 -0700 (PDT)
Date: Sun, 31 May 2026 14:07:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH] PCI: qcom: Handle mixed PERST#/PHY DT configuration
Message-ID: <gieaybsg2ckxpctvqj77nlwu7utama2yeyvebkonmexsxrra3v@v3fobqasxnmy>
References: <20260508-mix_perst_phy_dts-v1-1-9eff6ee9b51a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508-mix_perst_phy_dts-v1-1-9eff6ee9b51a@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=POg/P/qC c=1 sm=1 tr=0 ts=6a1c167c cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=-t_lwamo1oFYt4rwp_wA:9 a=CjuIK1q_8ugA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMxMDEyMyBTYWx0ZWRfX0X7dD4oOwiUl
 CjZ40M+fckdYGMnWePr7d0uHaLjS9ydpbVTHLRUsdCMMi3exlqoit3Ay8QhlaXCHHten9NMw5hE
 PNWB5QITVgcpHT/qL9QSt4jhmrOHLL/PsqsXqSDOMO/BjWVgQdyQdpTS4WVeKiMxX8xdBdyR3GD
 NvZTf6lVwitJ+DqbmLrbGjd5x3zpQOp7XP3pAEa0syC32DwOE7BmJP6MRjlsQ85HAhrZ+wWGBCb
 Pcbg8jTbCWBWo8Xvnbh450GbqDHpZIN+RmynF/SseJ/sTOUGROdaaSLh8ozMj0ArWwwK5Z1/pS4
 49OOJnbN0x/zfQQR+mq2QpfnioWretPES1s9jzC6v/Y4Xj8IQvkcV5iDpm1QIjsm4PmWMIxjbkG
 XAM4w8WEK1NHK1Y3GFSGBHig6of8YkEKF1+0dV5/8jxZwMO28XoEZhn/7IUm1+LmwdL3G2V6u29
 ER1JDIrO2vOnvHICk1Q==
X-Proofpoint-ORIG-GUID: N73FgagO9clP0uXczdnofBe4AiwOc643
X-Proofpoint-GUID: N73FgagO9clP0uXczdnofBe4AiwOc643
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-31_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605310123

On Fri, May 08, 2026 at 02:54:19AM -0700, Qiang Yu wrote:
> The driver currently supports two PERST# and PHY DT configuration. In one
> case, PHY, PERST#, are described in the RC node. In the other case, they
> are described in the RP node.
> 
> A mixed setup is not supported. One common example is PHY on the RP node
> while PERST# remains on the RC node. In that case the driver goes through
> the RP parse path, does not find PERST# on RP, and does not report an
> error because PERST# is optional. Probe can then succeed silently while
> PERST# is left uncontrolled, and PCIe endpoints fails to work later. This
> silent probe success makes debugging difficult.
> 
> Handle this mixed case in the RP parse path by checking whether PERST# is
> present on RC and, if so, using the RC PERST# GPIO for RP ports while
> keeping RP parsing for PHY. Emit a warning to indicate mixed DT content so
> it can be fixed.
> 
> This keeps mixed systems functional and makes the configuration issue
> visible instead of failing later at endpoint bring-up.
> 
> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> @@ -1778,6 +1785,14 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
>  	struct device *dev = pcie->pci->dev;
>  	int ret = -ENODEV;
>  
> +	if (of_find_property(dev->of_node, "perst-gpios", NULL)) {
> +		pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
> +		if (IS_ERR(pcie->reset))
> +			return PTR_ERR(pcie->reset);
> +
> +		dev_warn(dev, "Reusing PERST# from Root Complex node. DT needs to be fixed!\n");

This patch breaks legacy DTs (I stumbled on it on SM8350 HDK), because
now devm_gpiod_get_optional() in qcom_pcie_parse_legacy_binding()
returns -EBUSY (as the GPIO is already requested here). I'll send a
patch fixing the issue, but it's sad to see existing platforms being
broken for the sake of undeclared "mixed" case.


-- 
With best wishes
Dmitry
