Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CFB242D9B
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 00:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781569608; cv=none; b=o403FMhilI/MepD5LxCIKUxIYvGvds6LhCjd+whKPmwBpmKkDpBzxh8dWb84UoIq/orXwV1xVjteFXAsa/3VQwQhJFjqf4iZ9CfYoEXXlvqDJkCTUb8/KyNvJkQVO67HGWpfa5DqCYJnzXyKBF9VWaOhPnCzXfQwuyHVj2uwII4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781569608; c=relaxed/simple;
	bh=0TrEdUJRvXuitdwBSWjGtGrN0JNohG3HeK5r141lp2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RM+cWFW4/PUhENB8X4/xOqHCk7LrPLLgNpovW9WtvLCDmeeVX582AAK5W7NwdeHCdDyHazE36IKZuN6pI5FHOoHSwAgzrnObhtrmmboPqHCRmwLs6/UJvWXfKbhFzIgZ/W2Gy9hj9T0inU7iNMqUah0rQITpFYnlyZw8DDEvVfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mMyUv+U8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XmVeOM1U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mMyUv+U8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XmVeOM1U"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G0OXSY1915677
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 00:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2PULfDpM/oWn3b+RYT5n7mKC
	3htGe0l2sW/Vd8Ndc2M=; b=mMyUv+U8HmIqMyQxa7CCJ5jRFG/pk6aXjOLnYmKU
	FvgETP+v6v9agNp2dyEGkAixrimrf2zcXrvXHsANpgguPafynfNdycyYQ2uziEez
	5MgJnfOa01GACEp68bydD54dso5Do2qGT8BvM5mL/TqSV5aMo4w8H3DV7UUL9xW7
	GqDw7xUemJrbXqRg8gz/zuOl9fPetB8AT6BiaBP6Q6jefikr/vuD/IN06oveef6y
	/g0Ve40r2yIb+g2/fwxdjPM0gFXfV+4SHHnCP/rKogHOYUF+ZHVR+AkwWTcTk+sF
	nULqryoSpoRCYCojbpvW43vEPTZaE1Kl139ii58NPyWLow==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etevx3rrt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 00:26:45 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-915f7bd027eso1042885785a.0
        for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 17:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781569604; x=1782174404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2PULfDpM/oWn3b+RYT5n7mKC3htGe0l2sW/Vd8Ndc2M=;
        b=XmVeOM1U445ulwE2RZklfaoObhWq2iYZpWAjMdCRq57aCk4Vng4zrdQmC7gIMQpwiE
         /8B6cd+pjWLGOR8more4U4Oh8iO+gK5SB1sVp3/K/hNUNh9Ec/x4jjo3/fZefu2fLCJ3
         rlie9Xpe3S4dbyzYhuLI4Umd5/UkUQCrpxkb1QhomcMy8T8GREkTKdT2wFj/MBwJnN9n
         gDgM6qAtbiOx/xp5qrCOQeKJHG3uWJQ4/Um9pOGfl5DB5IV88TIBz5FY3/v3OLlrx89A
         xZn1EYvI187W8BiZY05nyrbnd9/NqzTZbb0gg4/4umupabEHFHA+O1WhsPXAFOMZTM8N
         dYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781569604; x=1782174404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PULfDpM/oWn3b+RYT5n7mKC3htGe0l2sW/Vd8Ndc2M=;
        b=dgJKGNqLJnjG7fXJb3WlKrDFu1waKT/X0qaMZRdS1lZN6MeKWlZtClGx081CvPSbxq
         lMyS8o8pHuPW3EHNjMLWOLiXaTtdw4TTtAsW8upEyAt3HyLgK/w48Ob5SCyOWbB2Ux5+
         59RaPDojK+CKBtjCh9jb/0H2zuORFLLZ36EChuF/rPa1/03ksMDUpRzBMtY/IpFQ6XkX
         x4V3S6Xcqn5Zm7po2IetyAS5biNeq5Sn/5WsxKQExLH/xps+lUNBdmuWfRYJp7cesBqB
         5H5kWpdK7If0/x6Y8Nhyi9vddgrDrcZ0VbSv0GJLdQ50Pdb6s+y+ANoOdxWV+2/AuVAt
         JVdA==
X-Forwarded-Encrypted: i=1; AFNElJ/Yos92FLECO0FG3DvyKp1pqU+GMZGA3W+I/M2VyBaB5lglh2CuzbZfqt30omFTLMCLH+xKXo0Xb64=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY1o8wUZHDq7iU5YWnopdAHlIGPYDy5Tkhjfha6tFRFNetbhtB
	NSEVCHqweAWnSvjmjQIrR1kejTHSjgW6QxnhK4DgVysGo+xzNfgzBWeCOLEq1r+rdg9CvOpYieO
	M5VvoX7cYkiBtvltG3AmcMnonBJ3id3cgu4XSKrfWGg4Epj215Ye0cDGK+yqWvcs=
X-Gm-Gg: Acq92OFvsewLbMgA+ygE0YiUVEOD/cnNvaQ1AZTzlJ12XXR8QthThqyh/pndH5V+1p7
	o08MriibfbGsPocAXK1VAzAeVg4n9Ii6mouuQVlzEjWn/uxwe7xm/OvyZjMDxwP/C5gYVAllaGz
	Q9RKg4yJbBdpQyxdFIWOOTKnrgGsxCPsk2Ak2Mr07s3ZvLLy7Lvz8oraD68/rUTbxuj/SIGieQq
	qTAyL5ERhihS0pHXhNT24jMgPVC+vc0vT7qCC7CGfmHtVQV4/mNpeXBwimI1mk18qwqfWaMwmhJ
	2aVS/yHSEGq8rdihHGrkiliTBsU+W4CI5wLsqLK2dUlo+vTD1pC+4/pLNMdRfa1r+f54QCf97wF
	qr9WSUiuPR54XpEgk81OiUfaGrOtBs6elYhl5IfsG8S/b53OSFSuNpCAbRkUvSeZO8W0LdfmB/j
	pSSSqs+9zLAZ/dJ3eROPE/nF7tcU1vBm6mF9g=
X-Received: by 2002:a05:620a:3943:b0:915:cf88:1e37 with SMTP id af79cd13be357-917f2a16e72mr2177768085a.47.1781569604540;
        Mon, 15 Jun 2026 17:26:44 -0700 (PDT)
X-Received: by 2002:a05:620a:3943:b0:915:cf88:1e37 with SMTP id af79cd13be357-917f2a16e72mr2177763185a.47.1781569604104;
        Mon, 15 Jun 2026 17:26:44 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e161fd4sm3161734e87.14.2026.06.15.17.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 17:26:42 -0700 (PDT)
Date: Tue, 16 Jun 2026 03:26:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wei Deng <wei.deng@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        quic_chezhou@quicinc.com, cheng.jiang@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH 1/2] power: sequencing: pcie-m2: Add PCI ID 0x1103 for
 WCN6855 Bluetooth
Message-ID: <hndyeomouu754rwevoigc2ai4ywtz5lhodizj4amjuyn4azjhq@f6ixgilydtg2>
References: <20260608091702.3797437-1-wei.deng@oss.qualcomm.com>
 <20260608091702.3797437-2-wei.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608091702.3797437-2-wei.deng@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: WiKOaoiEyH9QeNwzNp1NwkXFamp8gahg
X-Proofpoint-GUID: WiKOaoiEyH9QeNwzNp1NwkXFamp8gahg
X-Authority-Analysis: v=2.4 cv=f8t4wuyM c=1 sm=1 tr=0 ts=6a309845 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=1WnTIQmyWdCf-KxfHyAA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAwMiBTYWx0ZWRfXy7I+xUhetzIP
 SsPZ/d3V5vc1r4KDYA6+2hk6iEGtpxdNxLu6H0RvNw//D69vGr9Z9A4r/eBaiNeLK9me2FFeaFo
 joYVILfeFvPzyfQ6SxRLHz+rCCsjMVM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAwMiBTYWx0ZWRfX+39L4BfR33f7
 IPJQOP2HOe06ClMAkcD40qyw/4toV8dMmeNyhrXRnIAeas9WWuoz94gmLja3anb1wSz1WpgwyeS
 kTQIW1ZaUi/qYd6+M1VsjrlTqhS18gEU70vH/HJix5Q/Iq94OHWiJj+0Q6E2GVFrYxLNijJ9W+r
 ochG1NtjSeStaFb6T8EBPb8cS1rgsss4WFD1zJCbuOIRF9KfccQ2XyRwoOC2Ft15CrfBSVePn8H
 iw2VIZq2I1u7fmnL8KrqJTQEC/b/JE72NshPhM707rAnSEQdyzzS8Bc3JJNjjWeOAdS24Glgub7
 sWhtCh5qvQEZZ5hPWHiVjzh59HbN0wx6YjL7OyQEAfk2IgKdO28vUWXgdPYHrADCy3f7CZdcfSA
 S1qwxmY+d/5K6Qfx0yEe/g4SP0/Mj849QBtREzadDEM5/nu/xDnusSoXgv+yfdrEk38ty9oTT8m
 4U2zP7sD6yDqyv9QllA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160002

On Mon, Jun 08, 2026 at 02:47:01PM +0530, Wei Deng wrote:
> WCN6855 is a Qualcomm Wi-Fi/BT combo chip that uses PCI device ID
> 0x1103. Add it to pwrseq_m2_pci_ids[] alongside the existing 0x1107
> (WCN7850) entry, so that the pwrseq-pcie-m2 driver creates a Bluetooth
> serdev device for WCN6855 cards inserted into PCIe M.2 Key E connectors.
> 
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
> ---
>  drivers/power/sequencing/pwrseq-pcie-m2.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
> index efeb25ba9c79..b3af14464314 100644
> --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> @@ -188,6 +188,8 @@ static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
>  static const struct pci_device_id pwrseq_m2_pci_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
>  	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1103),
> +	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
>  	{ } /* Sentinel */

Please keep the list sorted. I saw that Bartosz has applied the patch.
Would you please send a followup?

>  };
>  
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
