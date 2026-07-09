Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854C53E16A5
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 07:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783583099; cv=none; b=d+uQ5Pxrk20e/eSWR++a2OjDOWJqfAEzXEXWrEOXgy6KvAaqD5m2UMc9xenNrsRafZrAThzDUCJC0FlFUUffH7uiI7xQsL7lMtLtKklygNUO5Nf1LLGSiE3zrwN+IKojyFX91V2OH0MZK3ij0mF5uS9KXIsibz/q9ALbwgMJAs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783583099; c=relaxed/simple;
	bh=LDfUi4NZBgfLrHI4B/s+P1VjuEhuEUnOiCpkxRIJFXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSQXcloUmwd6gJwmb321ROGHJ82TIWk9wJg37Urewg2+LOh7fg8Eipn2HV+7wfaNPX2c40QZsEjdUAvZdZLZjzbJCi8zgHRKXBJGpOHFdcVJVqFoAihh8/thxB2JdcxPgJyjYXxYLCk7SF2+8FQZmv9WqKJzGXByaNtSYzg46XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fUmEcQ5f; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HBImtEa0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fUmEcQ5f";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HBImtEa0"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66960Gnc931976
	for <linux-pci@vger.kernel.org>; Thu, 9 Jul 2026 07:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=67btAJqJoA11VZfNhZNlEX7T
	AwysL2FeNXAbd5m6mXI=; b=fUmEcQ5fNrKMRaFMON+9uWDyKpxaNZ2wmND69fld
	GuMkYzHrEMJcto9pWUifWxdW9+y/fA5OIeOggFBHDJdjrMWqorB5HhQtXBaNUAOq
	9kTtir+0a6B8kylB5CpSCEgZQ57xystTcExxcPDnjdLeUNZRtrlvO3pLUsVZDGDJ
	2Al8gSp8vtb/6/QeTbNzvcbrvCW9DE8i/rIwoSOSTSq3+BMmweFudEPHIP3pwuN8
	OOMhXO6oGjh5aZ79iqOrarDTcdQdbKh1H+7pfyn8A9BPtxS9+FxlWKdHYPN1+WaD
	+EzjtWG4zRyvDJ6Ji5tN9cDwhMg5Du/c/pVzCNQAANuetQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9sqsb0p0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 09 Jul 2026 07:44:57 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-737f1f1e0e5so440893137.3
        for <linux-pci@vger.kernel.org>; Thu, 09 Jul 2026 00:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783583097; x=1784187897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=67btAJqJoA11VZfNhZNlEX7TAwysL2FeNXAbd5m6mXI=;
        b=HBImtEa0TVu785iY8mLdUBUszgZvEJXZE45HxdRfYFIvJ4+A7C9ac10LqeZjWjfUhI
         a/n42lZBR1HSk5fhZa0JadgqpzyorFOQ31wSPHqkNZ7p/y1qb5hveo1K0i9KDimi7tVD
         ylbFbq/qreOZxJ1ZsbVvkFmNlDTFlRKLckchjbtzE4hY0C6tOy4Bzb6ThWy4mbuwqOmX
         0PnrJBbIhUMleCu5gO1JNyevJ8eShfXVrHFM6+rR1AdwS/hmmVN9vA1yU9CPU8IgyZiu
         eyR19pjyeb5TWvlAXIxxhxify7N4J9RYo2qdf1NsnLOwx+lAFCmie8ldtt9mQSnAC9LI
         6TpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783583097; x=1784187897;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=67btAJqJoA11VZfNhZNlEX7TAwysL2FeNXAbd5m6mXI=;
        b=SQQyltuEbCViNHuWQNm+wLiOOtN6v8hrIuVZWftZv42P8mg4LN5Y271DlhkWGS9RzL
         Q8KkucscqlvvrugkgGxTOPMwslHo/CdYO3TGCKYbH0ABa4xnktU7Le/odBR0jygtQLny
         MOhWcNePbJ9KsZJGk0knqw8aE7ZuskWtHXOdzkgcdcOuHenVglZbEAOzyYHo3rnj+nWk
         uCmAWLSVgY4BkwS2zx7s2WbJ0BNxssmXN7wX2sEchzrbRRxPiHmuVmdM2pw6xwdYxITd
         naJYPmCQyWwLacEJ6UTfRacFhsu7ej3LLIqu1WEayySvhQCKBR7CpALlsZrcAAJsWa7R
         jwgg==
X-Forwarded-Encrypted: i=1; AHgh+RrtM+xIKfo7bWapCgDoyuhuZESl7JCRLf+m+KCM0y+YZfw102WpLOAFNpsUR/J8n8A+3DXox0cHjDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMZN0nWIlcF/wHk0WADReOvHDY4P+HwszSYXdoD5O9CUkSqtU5
	p7PWbT/t6N2AtpsnceDS27z9j//pTvzT454k2iO58q61ts56uTGgNiEo04lpTZQFMNy7QbGoG+T
	xIZAk3AGHcu8ZhpGlX5fYBqZTmzzw5fvBIjMi02fYZTvmbIL5/X/llNZ+7HVxNm4=
X-Gm-Gg: AfdE7ck0EolWr9TRHm+LZPSapxzpKrYLSObQdHmLBcwl716JjxZUv6SIwXQQ56muxDy
	yObBwcBsXRbyyPYiOqyOVdOelPUASLolEtcMQ9rBbsuHqqTSX/7PPvBJPznREaXlng0ANON8lZX
	xnT1Z5gLLt4mPPXxhwDp2l0OznLK6Yb6WBriILz/HSxpxheGm4iJSdA2I1wfasNGAyX0bMMdJjP
	oau9EZc170B7rPCVTWB9SdtHWfH3Tuu0CGLOwCeLiX9ohCv+gsrdu4eOhy4zxaHR4kAUDiZkfwW
	FuoY4nGHHUARXy7+LkSnkvACpPLPuwfuOnsTS1Qt67KD4hPf8phej/iPF02URBJjzuY7X1hCKcS
	6W+h5k+SbtATLO2ns4O4oi/NL829CTJBIPYm4sRBXMeFIgnuLgbOC4lMLAPpuVrloBatTjxPSAn
	V32QQZ+27GDqkuv024W6b3oh6c
X-Received: by 2002:a05:6102:5122:b0:737:d207:5608 with SMTP id ada2fe7eead31-744e00ecfc7mr3803433137.21.1783583096730;
        Thu, 09 Jul 2026 00:44:56 -0700 (PDT)
X-Received: by 2002:a05:6102:5122:b0:737:d207:5608 with SMTP id ada2fe7eead31-744e00ecfc7mr3803414137.21.1783583096218;
        Thu, 09 Jul 2026 00:44:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b00cd21ca7sm1444264e87.56.2026.07.09.00.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 00:44:55 -0700 (PDT)
Date: Thu, 9 Jul 2026 10:44:53 +0300
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
        mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH 1/3] arm64: dts: qcom: hamoa-iot-evk: Describe the PCIe
 M.2 Key E connector
Message-ID: <vpsczyjw3ew4lhjwy6edzjomryna7ygyamgr5idw2aiq7al2lh@64to3cet3ufz>
References: <20260709-fix-hamoa-m2-w-disable2-v1-0-5e725091266a@oss.qualcomm.com>
 <20260709-fix-hamoa-m2-w-disable2-v1-1-5e725091266a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709-fix-hamoa-m2-w-disable2-v1-1-5e725091266a@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA3MiBTYWx0ZWRfX6rzXV4YgEGvy
 TTydcsImx17UopEfO+imwv476WQhV1VTH/w1nwN9L7+mZjw4gvPUNv2d/HltxNMQtYgAZ7v28GP
 o/Pebd3RympZ/KBach1pOlBSOfuEJxg=
X-Proofpoint-GUID: AhQ0aoRdX-zVrKbQ4WylVFeP3o7gos1h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA3MiBTYWx0ZWRfXwiaSZA3+3zYh
 3OjkETomoulXyvrirHfhB/Bhq7ZDhvSd1WuZhz3wZKKOfs8LWP4sAf5UkZXnjBtpi9QoVAxhmyS
 qzxHyDkERCbdAKH3eMFWA05Wb8RxCiv/te2jKD4gFlB7pE56U/kt0GwBbFY7AUplBbEOSToe3CO
 874MTLsFaa7zA0oqu2oC8/GrS72bEJ4freppNzkLmX4JqMTlefGVGD3jwvwRrITr0EK3Mw9DNF5
 EusoKeNqZrWwgWmbsZ/dK9RtcNXmGX2zxDJMeAPLVxIVJLNhRtkG4kjwAAvhEvHBAw+vplL0CyF
 sJVPXQkh0gZrmcfMKsQTZyJyCnJwO+lXcrKmC9LqFDFcdK82H4vOg0Sl/nkO/uDB6HmnEoynqAx
 rUU5IzN6fL3vyt29fHC4Ig9lEQCPyn1+aZgLROLfXiENPZ4ZWb74BGMtf2YHkHijPga1pcyorae
 myrhwwzReB2qasF5sQw==
X-Authority-Analysis: v=2.4 cv=Sv2gLvO0 c=1 sm=1 tr=0 ts=6a4f5179 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=MVNNC7U5w37-LmZrIMoA:9 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: AhQ0aoRdX-zVrKbQ4WylVFeP3o7gos1h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090072

On Thu, Jul 09, 2026 at 12:59:40PM +0530, Wei Deng wrote:
> The hamoa IoT EVK has the PCIe M.2 Mechanical Key E connector to
> connect wireless connectivity cards over PCIe and UART interfaces.
> Hence, describe the connector node, link it with the PCIe 4 Root Port
> node and replace the static BT serdev under UART14 and the
> chip-specific wifi@0 child node with graph port/endpoints, allowing
> the pwrseq-pcie-m2 driver to power the card and dynamically create
> the BT serdev device.
> 
> The M.2 Key E connector is powered by vreg_wcn_3p3. WLAN enable is
> controlled via W_DISABLE1# (GPIO117) and BT enable via W_DISABLE2#
> (GPIO116), both described as active-low GPIOs on the connector node.
> 
> Remove the chip-specific wcn7850-pmu node as the M.2 connector
> approach replaces the WCN7850-specific power sequencing with a
> chip-agnostic one managed by the pwrseq-pcie-m2 driver.
> 
> Also add 'compatible = "pciclass,0604"' to pcie4_port0 in hamoa.dtsi
> to allow the PCI subsystem to associate the DT node with the
> PCI-to-PCI bridge device.

Separate, unrelated change?

> 
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 129 ++++++++++-------------------
>  arch/arm64/boot/dts/qcom/hamoa.dtsi        |   1 +
>  2 files changed, 47 insertions(+), 83 deletions(-)
> 

-- 
With best wishes
Dmitry
