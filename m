Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612712D6E72
	for <linux-pci@vger.kernel.org>; Mon,  9 Feb 2026 05:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770613594; cv=none; b=mgkYvvxVWLt8ZCBIkPH5WkMQlYUCCRpIU5bO7R4UDakliuYCv7cRt6J4NCAv87A7+Hub2gjaxI5eeb9twucmXXMvdorACqbtPd84LcJRFXbVA/2dlHyA3ZvcALaowCQC2btbzw6wkZYEk1088cy5xVZSX3g+Oe2ZIFDk6+fZbRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770613594; c=relaxed/simple;
	bh=m6mtiPXFLsLf5e+10JiUf4tZFNL6MFDEnTDYOBrewCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f2XR/pERPkC0MAorj2JYeZ5m3PYGuIFCUtKjbsnlq8VR3DAvzUxfP+sYA7pE+PpfpXgRIlDmAEbZ3TKr+hkTyr/qQ8yjDVtIW1Ae9wMOcsR9rd/tUfo7kRyv2fsYPSG9v79aDwHbyaN/L6i8xn1Urh3VJs/kMj+9u4Uftk7T/9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ig68K88K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XYKgX9kf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ig68K88K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XYKgX9kf"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 618NSNbq3111687
	for <linux-pci@vger.kernel.org>; Mon, 9 Feb 2026 05:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3E7UICCtHoEft9ePbt/AmDo6Ki/Hkw8JTeF+RItunsE=; b=Ig68K88KIREo8V0x
	dFtUOuorUJBDlr7CknJlLDN22z5MBAGDCRxUgPxneoo6C0WfIeU/79xq4a961rXr
	7X2JO/d1rn4EM8oYkLhWfcWeUP8PGIHmDxicqKo3DvxhK/4gWDqn1siuHooixzrR
	prrTOwrnf/xRI3sNHrLIRz9FPUrDq2hf6+IPv3ZsOVZvxAjCqZvBAT6WQZ2Lz610
	Iiq9xa8sA7xlZ2RkuFaU2b4G8PCq6ckpuav1fQvUFz9YOvKzxqpaz+DCvWoW/H7J
	AW3pc78NKl0laXPDb4WQtDoCkGv+ClwbiA3C3qNCSgwTeSMi0nChROyr0AbVl8fV
	3NLhKw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c6g65a1c1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 09 Feb 2026 05:06:33 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c6de2c762aaso1831514a12.3
        for <linux-pci@vger.kernel.org>; Sun, 08 Feb 2026 21:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770613589; x=1771218389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3E7UICCtHoEft9ePbt/AmDo6Ki/Hkw8JTeF+RItunsE=;
        b=XYKgX9kf0kiE3y/TNn5QYTY7t7RgpHqHl64JT28f934X/jRYvYl/QJwncEBquQNlW4
         VXb8bIWPOHSbIUptPz43qNDry9jiKTG++lel+avsYci7DcbULSZuzidWjvSiy7OKU7Uz
         e+sfMSQ82NODX8lk8Qm05YNVeuNqreJV3KyozDnQlifi6Q8Y46OiU7/dbrxDdhxbizIy
         RAZW4Gm7uf0EONSX4kPd0O6fTOvkvlcyASeTVi/UJI3wpcmDYyGzlwQKIqy6s52N8qGr
         YILmVAbs4nN9qtFQ4xxCZ9QnTBrfQJEwQHYXyHcRosbeekQXMOXu/6zZbCSUxf0+4SwK
         Rz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770613589; x=1771218389;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3E7UICCtHoEft9ePbt/AmDo6Ki/Hkw8JTeF+RItunsE=;
        b=epzS32dOmfKa7wZNk23naxR4MNo+Dc4FbqJoHZa92lQ3mkitJW53/rxcgDszuQ2Uyv
         qk2mORJ7XeP0jmifAJcbeUFHdOUtd5XUSmi1B6n50cIWAIN/Bir1PVlv1lBUMZY/IzuG
         wrnGytl5vGN9ekAsI6pifGRlY8oqN//k7HCusSROuLnS/C3rXYv8Yw1Xw5ShHZh8WQQ5
         oZg+PCdGrcyFiy/EgKz6Nxi4oPMFbemozvCtHBVaMtl5edV1EX3tgf7qV/TocXmhntRZ
         BYtbTDdjc0RtxWd7Y0sfGUZpxCCZ4SRybu6Zq+HC6akiMUrgSldu/mCHd3ApNNZYMaeQ
         WT8g==
X-Forwarded-Encrypted: i=1; AJvYcCX5i/I98NsVEjMDS0fFGJZ1tYoOE4t+j6R49nKDMWfOkxksRp0xlcn39iX9hRVmZXAZkybJTignvKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMqJJZmQZW2gHvrmPLp0SvkBjrF6UWUoukq8Mcifc31gJ0WXiY
	bI7djaTK4lWkTql2F16cifrQ3rN3/pWkIGYFo22r/ALJHLghNMLLTLBwDKwDKlFLi7QtYgLkZ33
	j0QkN033sF0Wi/6Zf7UCdkS6p0kXjAJv66k/e2anUVitXq89eEOG6hFeBykpJT4A=
X-Gm-Gg: AZuq6aIJn3ZNateNSmdwVRsaskhjFk/Shp/nce/OQFqSw2oDiKRzjiK6gZwP80vM1yV
	2MQgkQhR6Ciz1I4q0Sr4cWJlsW3gzFhQ+DJP+jyvEYTTpl595mVlTMTygylAoN2cCVWHixMgBsR
	SjQgmkSKHB8xA3u1vLAtnWSrDgvxScVtIYSJ7sAxuoK+gaN9CLINbU6E1d5A0+JbA9KsulvCiek
	L5/R1hjU36TUMS/lMKkEMLLpHB3lW2soX20+0lPzB6Zvdsy53mYZm92IAPB6cPNHm1NqxLUzfBM
	t1aolnOUMVy91WgycGYRR8sv5vZ3b1CYSwNU6/w4hI1W2eHjCKMYjd13kOgqdDTWcRQmNPpEsj7
	nV/HjNsDXPdvVSN9HHEcyyQuXuNTtaExPNw4WJyWjog==
X-Received: by 2002:a05:6a00:3e02:b0:81f:fef:1fd3 with SMTP id d2e1a72fcca58-824416f8f09mr10733350b3a.41.1770613589478;
        Sun, 08 Feb 2026 21:06:29 -0800 (PST)
X-Received: by 2002:a05:6a00:3e02:b0:81f:fef:1fd3 with SMTP id d2e1a72fcca58-824416f8f09mr10733326b3a.41.1770613589010;
        Sun, 08 Feb 2026 21:06:29 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824416952e4sm8810443b3a.21.2026.02.08.21.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Feb 2026 21:06:28 -0800 (PST)
Message-ID: <7c44e9da-e7d6-4288-b000-939ffcdf7b39@oss.qualcomm.com>
Date: Mon, 9 Feb 2026 10:36:21 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: epf-mhi: return 0 on success instead of positive
 jiffies
To: Daniel Hodges <git@danielhodges.dev>, mani@kernel.org,
        kwilczynski@kernel.org
Cc: kishon@kernel.org, bhelgaas@google.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260206200529.10784-1-git@danielhodges.dev>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20260206200529.10784-1-git@danielhodges.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GqNPO01C c=1 sm=1 tr=0 ts=69896b59 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5Gk_b0IoX-7N14tGkj8A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: xLHWiKNIhe3zLTupGNxxIj1mRgzu5L2V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDA0MCBTYWx0ZWRfX9brOSuK8uo9q
 NC3GqStxac/9vTvdhvvaSEGXSv728UzXO1MuRoHAqhacPSuh7u9q0aP+uyQtG76ZcbPQ5WztLtu
 NueSAZzKvzs34E+C3kzn2PF9hZTkDFKKBNbPYb99Vlsd9fESypHkfctmw/xCXqaF33IU+srDy3G
 ZAvIFe6mn99V1nCw0xdFiNsRN4Mvo1WkKkzQy9x/P99PwqepMRJbOVRgOX03zMQCIVuXD6n7rpK
 XKU85hpVdy2Ax3vMuTvghzSBzhV4VY9JstsAO8TkjKb0T+udCjQmxh3cniZ/b4kQbGnc33c36gf
 0sRMChKp+ZN1IYEfJ/00NBKsOLsJ1Z2wO3M6+eJs8P1QWXwnsIZDmCUHG/XW1HyZhMJOsrUrpdW
 6gHRivhzlcThHdycVCRwkD0Z1fLCuk1CxMIomkLDdbn1xVwlje0dHbET/My2CgIF+qlpFsSHc4Q
 3fPFvFoRclJ547sn3sw==
X-Proofpoint-GUID: xLHWiKNIhe3zLTupGNxxIj1mRgzu5L2V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090040



On 2/7/2026 1:35 AM, Daniel Hodges wrote:
> wait_for_completion_timeout() returns the number of jiffies remaining
> on success (positive value) or 0 on timeout. The pci_epf_mhi_edma_read()
> and pci_epf_mhi_edma_write() functions use the return value directly as
> their own return value, only converting timeout (0) to -ETIMEDOUT.
>
> On success, they return the positive jiffies value. The callers in
> drivers/bus/mhi/ep/ring.c check for errors with "if (ret < 0)" for
> read_sync and "if (ret)" for write_sync. This causes write_sync success
> cases to be incorrectly treated as errors since the positive jiffies
> value is non-zero.
>
> Fix by setting ret to 0 when wait_for_completion_timeout() succeeds.
>
> Fixes: 7b99aaaddabb ("PCI: epf-mhi: Add eDMA support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Hodges <git@danielhodges.dev>

Reviewed-by: Krishna Chaitanya Chundru<krishna.chundru@oss.qualcomm.com>

- Krishna Chaitanya.

> ---
>   drivers/pci/endpoint/functions/pci-epf-mhi.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> index 6643a88c7a0c..2f077d0b7957 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> @@ -367,6 +367,8 @@ static int pci_epf_mhi_edma_read(struct mhi_ep_cntrl *mhi_cntrl,
>   		dev_err(dev, "DMA transfer timeout\n");
>   		dmaengine_terminate_sync(chan);
>   		ret = -ETIMEDOUT;
> +	} else {
> +		ret = 0;
>   	}
>   
>   err_unmap:
> @@ -438,6 +440,8 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl,
>   		dev_err(dev, "DMA transfer timeout\n");
>   		dmaengine_terminate_sync(chan);
>   		ret = -ETIMEDOUT;
> +	} else {
> +		ret = 0;
>   	}
>   
>   err_unmap:

