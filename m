Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22D53CDBDD
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 12:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781179452; cv=none; b=O1nj0uk4BcplOMlDh3z4F2F1IACYfi1nSJ+cXmKcqHuBqprUp4lWcwjHbNULza4/WMRmD6CHFDH9AMBlIXWAGDR/OZgThTxSBefg53FcNDzfYEv186WgKRixHK7Rnlp8gvfGBuVxV7ALuHaT9kd2FNpy13o7hRd+klMBmDE4SdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781179452; c=relaxed/simple;
	bh=w+y1X+ZNiJg65rSDstMld5R8KxYOqoox95WB44xxs3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rQFSK+jw2FmzLhjVr2m/eqOR3ngbpjIiNvVFHVeaShuvJzqazsXwXATc0EOKwQ2b1QY1yuwQvKWNxi7+CDnlItpyUCjR2vZ34XL0djWaFFk2gTDpXSrRlI8r1EZeFFHDLHqt5rzy22e2EJIKN4YSdNRvw7xLXxi9uuAa1ovAIWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BGtw19oG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=keNQ82Ib; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BGtw19oG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="keNQ82Ib"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B9xpbt214478
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 12:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C0RiQNzKW417vkjMQkmym11eTxmsfGp45AkrTPKlifY=; b=BGtw19oGKNB/HWnP
	yq/EmwUlaOsudKOSR02wTI4jjuMRQpJuFqB5jrtIyovdYrbVvtM0pNx23k1IaYuX
	D7vuzLzmjgiucyVEgcWOZB2OlDDpZVx+Rb9zA6+VN0NXCCotSgsH8DWQXYx8aNs8
	w6IpmV0jmKN2o8KuGoGxdPlqUODpQ48JzDvCKnvRz06q8WrAYtkm0E8HzToWUY56
	RwegB9KBvinRANH/I2WlEfrrHPK/PGTf5qmd09XNchyRB0HH8nk1bi5ig7enKoyb
	S1CMe4Pq6Lo3iFZqhKED/eI/pyE8NgVtSGRGEzm3CtjyXnShmG5dx3/wDnG7ribp
	B0QCpA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6skbfw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 12:04:10 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-6c4271166f3so330088137.0
        for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 05:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781179450; x=1781784250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C0RiQNzKW417vkjMQkmym11eTxmsfGp45AkrTPKlifY=;
        b=keNQ82IbYioI/w7JjixnBHIeW39mQUVQuniWrTxN28c/S+a3wOnCjijgACbNNh3xMc
         Ydu+Ke7DLyLnXIc+EksfGDsEM3qhI4+/pohH93jUSYyKPaVRv5gnJbSjscwiHtoZTc0c
         AN8RXY4JhzLVgaWhqLaiNTuWOANZPrMHv4TGmLo9ZlLHwjKzQAsDjoU8LepQ8NyB5A7N
         HsA+VqKjcEUNE5YfLqFgychHHiYLzY+C6Ct+5P/ALk7tTXLLTvnnX3kkXkjapTgN8vTd
         HV/m5utHuJ6zUQU39Tms7vMlXh7hmq+Z4uf000oNB0viw9OsVD54wzOog0MveyPgqQmR
         ysDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781179450; x=1781784250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C0RiQNzKW417vkjMQkmym11eTxmsfGp45AkrTPKlifY=;
        b=BCYwcXlLQGl3aV0Hi2wczzfWC1l0IWEW8wpaAwQ8tEWMXqsCQSbjgJTc2GXJm75kuW
         zyS5AuSCWeaivYB0bTIa6Lv6M+L7KxC815mQ4b9O9uHiSITTIvgvhsRB7UXEAShGMIHt
         n4qpyOQCzu9bM91KO/V2lgrpqp12xPjXRojvudXyjOqpXTDt1iRzmh4v03NL/a5A+cxK
         m2W6IbJ9T0JJ4vmWSrgRnxH6PYaKgfetRhxM2JxmKbVHIyP8A1sTSq+C8SDSGaUbFM++
         Fv+m8KPe6FVMq13HKn1d7S1aO745obP1XLNVOLhtErxVa2h77T/jrLFulHlf0/jREai8
         eeBA==
X-Forwarded-Encrypted: i=1; AFNElJ9m+jyYViZj9nE70zC7N1EM3gNMWKhZfe016tYhSGm6EP2fEgfbOcX6gIfO7kwLS0tEhvvcZnDWOYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyrjEihKk5ULU2yR8pK0o8qIsVwx+dt4Sx5tOR4o4zEk84uRqb
	2KpLtrSqWwKPjNi6tPTOSEg6jiR21Q+VlyP3E8EBoZYnSwOIFE9hRRqZzoNqqy9WpKxOoUkwHqT
	aTBZHKG0oQOWchJIp402NJ9ehoBN/dyGoze4VG4Gqj3N+lfFh0d4RR/FSR9XOZEc=
X-Gm-Gg: Acq92OENFA6kytHzg8JTG8Vh3yRKxaKPSjNaq7OlGb2FHLh57bfMHyQuh1sbZrNjfby
	ao+vRR+iyC6mljOkBglWzbatb4MZg0yQWt3R6M7z4L8m49DDSdRrRRzxypB3MLv0aTG0UQpvCHP
	HIpHeMq0vB5g1pIQENUX/xukXeocoOp+0u/1I3BdIYWfL9a70jhOg958W0m8Of6Wq3c9ZzQeqEh
	js2BLetZsGmtScqbLjsyxsGSPA/EJgaiVUX/InnlUH2pJlEIcivniM4/rSd8bxV1Dg/wDCWCE/P
	l5O4nnY5XaWpIi2MoV8K40ZCqxNyf7ykGjaaNSvvIpbaYYW9BRo76psqi7wc5FtyzyVlJrzVNfq
	kyVZOTG9UHqfR3rvv/se1sJeQW/wpUuD4cXCH/N6glNjVHy7WF6U+UCAm
X-Received: by 2002:a05:6102:374c:b0:632:c8af:8a8c with SMTP id ada2fe7eead31-71d5948c72bmr230960137.2.1781179449900;
        Thu, 11 Jun 2026 05:04:09 -0700 (PDT)
X-Received: by 2002:a05:6102:374c:b0:632:c8af:8a8c with SMTP id ada2fe7eead31-71d5948c72bmr230784137.2.1781179446795;
        Thu, 11 Jun 2026 05:04:06 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e65867e67sm10883829a12.21.2026.06.11.05.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 05:04:04 -0700 (PDT)
Message-ID: <34796b1c-7c82-46fc-87c9-6c0b9327e894@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 14:04:01 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] arm64: dts: qcom: sm8350: expand UART18 to 4 pins
 config
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org
References: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
 <20260601-sm8350-wifi-v1-5-242917d88031@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260601-sm8350-wifi-v1-5-242917d88031@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GbMnWwXL c=1 sm=1 tr=0 ts=6a2aa43a cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=IZRSYuELQJJGqPscr9cA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: cilnCd6ozd0XPwnI3uju7U7flqek7CSL
X-Proofpoint-GUID: cilnCd6ozd0XPwnI3uju7U7flqek7CSL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEyMSBTYWx0ZWRfX5xoz5iKvF2V4
 EYV8aHpUhZ5w+wMFTgU3ZGEG5tGKx+DVAGMMP8QIUWD2UEJDMhBum72zz1yC/8Adok8Fa5fgeoe
 pkwKfGMY8fu2L4Cw3hBbR4XfMevyGfcCPKjPDf3JwPE/wz43RknJL147vV6A0DRXxOQ66hCloDB
 EoeTos4XQv62efdZJYqPzWWS/SZtywB9n/FD97mJQ17B07nCE18NF7CymcfUG6yLbxPBxo12w8a
 Eu3kc5N4QdytIQw05FqXPM6mu1fAI3dAHci4AIn4JgU3BULCDB57BcvJl50cHoMJLdG2LQ8MDPT
 SHjLn3hUlYUrsajrrRJooexKu9KiWEK/hIUmcw3gzj/QZQIJPNMV19dGNY2gjRv5TOlnrNFCbqh
 R9w8lN7zVIQe888c1Lb4mCcE+al3Rg9KEax4O5Tng/pSnpg/SdiNYed9YMTUKPwTOoAs+K0qAPX
 xgUnf8HhfVf+wI2XgNg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEyMSBTYWx0ZWRfX8JCg+PGfV8u1
 Yq3NPIGvMS98j1HOzCbuQN/hVwte4VbnXqF2BkzKaLTXdOpmqUaof3mua9gtRDRzaD+rGk/01Po
 kyWniLCBXbtK7h/3ny5//9MpxRg0GDU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110121

On 6/1/26 11:46 AM, Dmitry Baryshkov wrote:
> On SM8350 platforms the primary use of UART18 is a 4-pin UART (targeting
> Bluetooth or other similar applications). Add all 4 pins to the default
> pinctrl entry for the UART.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
