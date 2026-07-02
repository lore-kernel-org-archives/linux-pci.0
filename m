Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FB24229B7
	for <linux-pci@vger.kernel.org>; Thu,  2 Jul 2026 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993436; cv=none; b=kGSUf8NEhILucOb0LuRv0ueBPSBrM5AVWNbnOHKpqscSwoBeNQaccS0/9O65tq6R8LNdqzDU8f3841OnA3ObJiVdTPV8iZFvbdIhS0AZDUX00DvmXM/uevucHv+74etweMNwGNdYvIJJxws08uLALiGlJogQMBM7ah4S4Er17Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993436; c=relaxed/simple;
	bh=7W1GCpEe3Gdv9nXmjbwQh2a1LPAEYYmV2hnpUZRBLKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKFvt5a+H5n+W0SuX+qiInGqKrOLVaonuxFAg9q551jefz9s9ISo9W1ni2ZdCNmF2Na49i6HKj/FzrNwc+ZdyajU9IgtEilmHdpgzVQtQHiufHAo91jGCDqx7rQ6yBc+WBjhJvOxlnoaAAu27bQJ4ie13e71TcqJtKuhj9qBFBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QKHeWgmZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EJrxwTto; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QKHeWgmZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EJrxwTto"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6629KJlA4115125
	for <linux-pci@vger.kernel.org>; Thu, 2 Jul 2026 11:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dcUxmlJb0u+2w0hmOr3Gqno9
	mV/FfHmW/GhrjwOQzaY=; b=QKHeWgmZbjqBL7V6KkgD9JFOigaMVHSiSKFNlkVk
	LfTtb9KT/urbl6vl1KwgR/oMsqQas9TYPBUOMNeewjttN3C7BV5UX/xVcu5APUBx
	2PyV1YKjW9vL71GABIb9AnZ6+mAcI11IDRdRsvhVFJRVqlqmfjlEuui6+3mkeS6K
	FY+cldfXFzHqHGV5XCjTz/URpfPlYhWekHlVEXhmXizmfvOfVeeJkC0ZTHbNu1T/
	cMfOZT1WZeo4LZfgZuZxCR/BFqGL/8DlTOfrW3aHM+v3GRPL+WlARgQBwIzmG1co
	EjsAyRLLDMT8x5GiwNJ+TUgO68jP2fHFZiCiaI4C5Ix41A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n940jpk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 02 Jul 2026 11:57:14 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e82060977so66885585a.1
        for <linux-pci@vger.kernel.org>; Thu, 02 Jul 2026 04:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782993433; x=1783598233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dcUxmlJb0u+2w0hmOr3Gqno9mV/FfHmW/GhrjwOQzaY=;
        b=EJrxwTto2+FdSvp+RrK/CJITXeO3z62zl0uTHysmen7wl3FXy+PpXXk1amEMj46zgw
         DnKHBOeHiAdEhXkpZY2IcVBkA4+q3gp1VV/lihjPiYTWTqkUTAwTIKm7i6OtIePbLMFC
         QkseEIwluYAsMfQhXR/Rsc3MxiuAriY2h7jaNNxJ03YpqguKDZwJxCIlil3Ur2qJ8jx2
         S49PxKLhfd8W7yyVMA574RhwDA+/eKQKxbmk3zoQcnkTvtbXi05nSD47WoSAGWKZF3Fa
         bJzPNndk58TImzZDt3Pa8BEwxATPDgzmEaYFdvOdx0Tdc8oBtCzqqRxdY+hU5guU8+mz
         9eJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782993433; x=1783598233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcUxmlJb0u+2w0hmOr3Gqno9mV/FfHmW/GhrjwOQzaY=;
        b=JlAmo5mG+dq5G41VRdUsX17ANqHvDWcqiADCQekMojKTa6SyovxX2rjU1QD6Ou5jbL
         5d9mIXxOY6VmXUFFMpWyyw2eu8hTDvjAzHEm7rRE6BXj7l/MeaAfQi0qjOM3iA54vyYl
         PeVNi30xo2Smfx9CZM0MS7iUnp+zE0ZhxP1wPYUmO1H3SOXba60xP7VBMEZJTiyrlX3B
         Jj+ggQ2sUw3fdhnS31ppxwr3RKlvoDIhAZwrfUZNeDWKTrWajJHQ5XbiE49cD7rK8BM5
         uc0CRVzLt+E1kG+IrQZDXTtikbm50ea+LCCHUjhKTBiW5VI5zVMaQ17UoZzcIJcRbSpW
         +8Hw==
X-Forwarded-Encrypted: i=1; AFNElJ/XjbvVzssxPGxZ1gP445qce2mikJLQ6W4zRHCNhuDfQqGinzbdTutd4WqxIqVxs4tZ4DzPFa5KgE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkDGJkcNJn0thC9QI5YYuzmTr/jqIxRCf8+GjVGF7INrcnOA9G
	ZmzRAkdMabVjq3Q9GRJSW4D01SCwMWMYly7RixX/hzfMnuoI4BGjT8bemU3HeGmbXUmbleN9uJO
	xwfuW8YgpQSMPvmwfAFZ/l7inR92l1phTEJjrCFLqBt/XJDVm25+CZ7yye2aMvjs=
X-Gm-Gg: AfdE7cmKX7PpmnG8Wz6HcC/kWb0LP9wtwbT1FK6D9ICSWsj7FeTczLreQD6aM4Bpd0d
	D/ivBhz24gEq6lDNx+jNhgjf8iPXlNHGkaK0uPngpdLS+n0kc+8lUbDK7lXPQOV8hz1JKBHZT9V
	3rjs0DLdSM83mbMpMMgOfz0SWvqyuc/nOl53JluCT/W2J207IaVoj3aCQ7cT+RI92w70QrNybKJ
	kmkf2GvOejT00Pqh7T/JULX+FXX1LlPo4tTU1R9KoQNzhbKSKzknWPVV3A+A2iujcsMto/bi12H
	+Zc6TSxp/pI9dyMqCzwekfBfqLpeCt6h3svucGLvnwCuo6/FaxINs7VIN648fO/2MSK2DxzCZ7E
	uAxldRpWDzxp8TLU1RdUWlkyGmSAiF4fw6Z4VmMF/rfm7VeG0TA//nd8H4WslSgJlFEUKKxi75/
	SjQnu2yy61tsrmf3SZs5gSk9cT
X-Received: by 2002:a05:620a:4728:b0:915:9931:3a3e with SMTP id af79cd13be357-92e697c24bdmr1334936085a.27.1782993433322;
        Thu, 02 Jul 2026 04:57:13 -0700 (PDT)
X-Received: by 2002:a05:620a:4728:b0:915:9931:3a3e with SMTP id af79cd13be357-92e697c24bdmr1334932685a.27.1782993432780;
        Thu, 02 Jul 2026 04:57:12 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aec89e56d0sm618674e87.79.2026.07.02.04.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 04:57:11 -0700 (PDT)
Date: Thu, 2 Jul 2026 14:57:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/4] power: sequencing: pcie-m2: Add QCA2066
 (QCNFA765) BT serdev ID
Message-ID: <xzudpqgyunuj63h6o6npvhlwiqduz4ythmbgufovotptbzvraz@q3hhppxledpj>
References: <20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com>
 <20260702-monza-wireless-v2-2-7b56e2a6a6d4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702-monza-wireless-v2-2-7b56e2a6a6d4@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEyMyBTYWx0ZWRfXx/P0VmsH/Ui0
 sxwDIqL5pQXsswFZxdU0+bpA2X+2GuoXg+8GbXvzfRTZH9cJ5QKmqYtphoeQg9ZajqOMMafMm9P
 4RBRwUgTW3o/mzoST5jIPHGEOv9gACl3VRGqC0WEovaQRmWMI9yn73WBl4mBDz1UXyI98m4Gakp
 iHIbzPmcAiL+uR3wqTS2IbD8WPN4olAktUlqjgtmw32e5adFuVB4kD8lyv6Jm/ZLmvy4ZXQ3QNy
 nMyT1rAOeLl8z2UggCbB4PVfiYSTMIAal01ynklT9Dy5noo8+Ri5AOOZn9Z6BGCpYPZZ9mmSj8J
 Lb8ad7svLKfXanYFecvu3ni+Sz2NDl8LP/h4Pmwo4fkgswd4cG3u0T7Lh40L2nH9F5kXOJUv5ZU
 0hGP88eM8zIYD/v8mnM/hmFvUeBXQx55GYCe8tHMJb+msXH+T6Iki5TSy2qOFtdPUmJM+sAGSDG
 n/PUEcjS9iiDlXlFIXw==
X-Authority-Analysis: v=2.4 cv=Lv+iDHdc c=1 sm=1 tr=0 ts=6a46521a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=HTi0trrisHXCjICuZMYA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: fSi-XYFiTwGfI6vsQJrRHPTMR5xfT9al
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEyMyBTYWx0ZWRfX/v5tev3fZM0m
 Pt57bGze9ZLaRh3PmHgR4XJpHJPpFzG+nMiYOPYfAvAN6O6ZTgH49nkmXDHDUD0Bgf+wZprIG5b
 kfmJKnaBuekQcAPxp6mPvVChOwB04OQ=
X-Proofpoint-GUID: fSi-XYFiTwGfI6vsQJrRHPTMR5xfT9al
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020123

On Thu, Jul 02, 2026 at 12:46:14PM +0200, Loic Poulain wrote:
> Add PCI IDs for Qualcomm QCA2066/QCNFA765 to the M.2 serdev ID table,
> mapping it to the qcom,qca2066-bt compatible string.
> 
> The Subsystem Vendor ID (SVID) 0x0108 distinguishes the QCA2066 from
> the WCN6855.
> 
> This allows the pwrseq-pcie-m2 driver to automatically create the
> Bluetooth serdev device when a QCA2066-based M.2 card is enumerated.
> 
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/power/sequencing/pwrseq-pcie-m2.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
