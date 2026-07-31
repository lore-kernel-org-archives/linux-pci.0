Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9898042E8F8
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785509129; cv=none; b=ea+rVcGhLQ6HrZXm9w7iXTM9k6cTL3s7ZYXZZ5dOhB7JXeN7K7JH0iUZfQfp+Wfj7blFtQaeDkxfRP0dfFqRow2JBEiTz8zfsWVwaZiLswzmeSXVPUvmWASwSfYivzoKAb/CABQyU6PSckWM1Zv7wJoqbnHUtNjXdAPhvYGGHdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785509129; c=relaxed/simple;
	bh=E7eJRBrZC7S6Dyl1yr3XZTSVgHOfz9ZEHGWqdMcDUsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KJXM7dEz1peCAPQb/JE5SpLt08p5ONqxAh5ckGPyPjKtyfkh72+7TYIa78Plvl2zxu/ZsTGnilo5oCtV5ohWrm2sqjtj/mJiYjg3Y3w51k1uAqMVowjS18S7P1vvZdeCzqsYBrH10SXoJ6vBL2ms06vXpgEyiYLl2mJSB678FC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PblENfWd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JRTfd9Pn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PblENfWd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JRTfd9Pn"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBa5x23742918
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 14:45:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zUUexB7yi2dILgMSCy1Iht2kViTXKPk+CZkKSkRmhf4=; b=PblENfWdzolEPPKm
	NaHHVyHcnaaL+p03zGEnFLe20xztcSUywPvQ4QREHQIpXrFcWi9WpxKEK6POmr3x
	qjGDS5VZ6sp8H0STHBjH6eq8opc4Bgu/7TMkzSHzVifE6kG2vC26ve+iSJzf9LMC
	vGTRg8Pb/u95/J6O9l/Tp6Z2wqOVP4uxLssuhqWdziyAqoreqm2zkj0l032aT71M
	pJiLwwkyNvjPij0jr1SN5qhsaOxHbsclWkB/aP6gSH3JNrjeVM3Wt+INcZy8ic/b
	IJ3R+dqIprDJInKKskGfTjKwUsJiqZPaMgAHDgTJr/1SmWMZiYVqVezTbnSX2qzy
	bKjF1Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frtyqgtq1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 14:45:26 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51bfe3fa93bso9867301cf.2
        for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 07:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785509126; x=1786113926; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zUUexB7yi2dILgMSCy1Iht2kViTXKPk+CZkKSkRmhf4=;
        b=JRTfd9Pn2rao1ZhlXYOOS3Pu5qCTPZpFUKl9loBg8Ku8r5jPoLkpwiySj/kMlMZPIA
         0JXMRN59sczYc/300ieBRV4TcmcJzY5W6CWi52HtnHHzNND/Ta41gSXwhLV2LbsI4Jzg
         qBSddO3fTe6nSdA3LvQgndcr83Q55gdcT5h0iB96phdLII+ObrJoG0+U2Ra+MCoThsd3
         l1C/kFw4kdNmxKmOgzVbixIgZADS2L/lGKj+CKZeWq5bWy6auC3b5cnXflykBW4VrOf7
         VNBmPX3sKMAzOTL9Yj2twQzy0fNU51K3I+PxYkkUS6knCWrMeOY+uHFc9Q2oy4jkxrf+
         LlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785509126; x=1786113926;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zUUexB7yi2dILgMSCy1Iht2kViTXKPk+CZkKSkRmhf4=;
        b=ZA/n9Y8FG2IpCCiCGUjM0YKoHgD//l7oV8kOKPw4ASawMrsGZMFDyNLm4Hk1CBtuus
         HJtRH0Djwj2cUwzQ0c0GQbiyczl6FHe2+uaxxH8tEXd7+Wl9ydJpV64ohAOpPVaoS6Ff
         MfcZL0ddcCWQrnddk71RmV/aMwS9cwCkR9fIzYHYBgtWVBoR/qfocLsqNT6ZNXMYqQrc
         kaNUko06+tmg7S4eT5b63UzJmgp5tigJuoOjiFp7myOQ3I7MtDLCGPxi+Nz/IOHyioWy
         KCm2bz2DNmaXot6kj4UeY6kOKB8dGlF/xUFpKPjM7oBJ2SG8Ec8GaFd6VVorR0Tl6lj6
         8+Ug==
X-Forwarded-Encrypted: i=1; AHgh+RqiTj70E+bqtOUYVPuIRK5jU8xoegkoW/uMFzF9KKMQDB4JQZEqAbVfiHyP0B45VlUc3fJy8RMfYHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqRjddqQ58i36Z60Ou86FUwHFcVAOL/q1hPeCwM5kOxNPSGltB
	PxVk2L6wzAUeCaXmhCzqt2wP/v+lbK79ysm2EyI8iEZGdJWEnVGoZPl6k/ZPwlqxR67Z4JxuPFN
	d/Jz/27Fky64nL1qm+c9MU0ejyT6No4fRwG/wYP92mKvvQsXoQpzevs7vgRxWlrU=
X-Gm-Gg: AR+sD12mC2rAl4X5z0W88qSh6HnPgQJu2ZXTRDydp23WTEE4GDGNJv+SZNKw+kIWT4J
	0eIRdkNyfVv/Eun6BEtclL2YYMBozZGZRKlmIcoOQR/E94gIWilgL6RC6ZHGGPFdxRKCnlPQb8F
	htNDhSxpv6jLx/l11IqxTjLPdIltY+DFcc7zp5ntUIuyuRUTYagI+9CfpkBpJnkmqf4NOjUZSs4
	Gmd+UXk9EOB37KRiqOBcfDXWjm/LyyLESXAz5kbUyvjSs8bGuy3dw+NyYr6/yb8wI1ANsBUSWxN
	V7Vxg/0gHkI3QMubB/w3+VfWIehYsfomNfJnuCL1Exe0/2kADJzq+sjTyyp+R/NAT/ZvoWCxY11
	XcXEygF6omkFyIvWonaZh2h1+Yf3IAj+j
X-Received: by 2002:a05:622a:c84:b0:51c:92a0:b2cb with SMTP id d75a77b69052e-52b5682e980mr7805771cf.26.1785509125552;
        Fri, 31 Jul 2026 07:45:25 -0700 (PDT)
X-Received: by 2002:a05:622a:c84:b0:51c:92a0:b2cb with SMTP id d75a77b69052e-52b5682e980mr7801041cf.26.1785509123372;
        Fri, 31 Jul 2026 07:45:23 -0700 (PDT)
Received: from [192.168.1.10] ([122.177.247.168])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2e24564d3sm353641e87.71.2026.07.31.07.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 07:45:22 -0700 (PDT)
Message-ID: <712f8a14-d2a1-4a90-82f9-05cd694f2658@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 20:15:09 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] dt-bindings: bluetooth: qca: add QCC2072
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Manivannan Sadhasivam
 <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
 <20260727-rb3-industrial-bt-uart-v2-1-2d100f30e202@oss.qualcomm.com>
 <20260731-first-righteous-bear-dd72ed@quoll>
Content-Language: en-US
From: Rahul Samana <rahul.samana@oss.qualcomm.com>
In-Reply-To: <20260731-first-righteous-bear-dd72ed@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDExMiBTYWx0ZWRfX60k3OuG+YD3J
 UCRGk+yZ5dr4cN3cF+zglxu2jwcpcohjgqL8MSGeTqwRwbre8UupuacDJtpY3W5a/mX6GvrY30U
 8jvgUs+TE+1rIQoF43ey/mnqN+ATPCOqTR31c8MJF9bAFBiRVjJeWYTWz8OfVic/JllIQ90NwI6
 lZdAAzyuEAsIjojj4ZC2viEre5U5QusIXZ3/4mBCDQqCa4a2Wp/8XO/8e6oOjUezdavvW7cVAK3
 RXQuwWYo+32EH0vyxTAVBVa2YI17wmKUJlD1uemlhkxGzm0mGHGZD0P76rHVEoQJCADOEjDBkyC
 NeLf6jB7zKdVe5ss6LxkjKTnSHjPk90l1aQcEy3Dk+nXTHTfowvPGHzmAyoU4BO5w+sn68Lkq21
 YNUWPfN/ZXbpJJ8kjyysrT/cLblmyBBsIKC77jk1ptmA/NHDmlqOw79HTH1vgEs34Oh00TzPJza
 b1LfjwTSwlXyP/i/HjA==
X-Proofpoint-ORIG-GUID: M8eJywsmt6fTwZIlT1pSP-Z_0FioQ44V
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDExMiBTYWx0ZWRfX5w47qbVKzIC2
 1mIQ1dO1CNWhOFrFb8TojBHvhC01DbogU09CZEEchtWH6W/xXWXa/R1QGKpuo/G7u+ToGhktvrM
 SNdrENCjxPwXgycgMcN1BFNuR1XoQgE=
X-Authority-Analysis: v=2.4 cv=YaGNIQRf c=1 sm=1 tr=0 ts=6a6cb506 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=wVA5pQU3D6HtJETKl3oCcQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=ZtkR8tRNVxI1tjOBf7kA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: M8eJywsmt6fTwZIlT1pSP-Z_0FioQ44V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310112



On 31-07-2026 15:16, Krzysztof Kozlowski wrote:
> On Mon, Jul 27, 2026 at 09:15:01PM +0530, Rahul Samana wrote:
>> QCC2072 can be used on M.2 E-key cards where the card power resources are
>> described by the pcie-m2-e-connector node. In that setup, the M.2 power
>> sequencing provider creates the Bluetooth serdev child after matching the
>> QCC2072 PCI function.
>>
>> Integrated non-M.2 designs need board-specific power resources. Document
>> only the compatible for now and leave those properties to be added with
>> matching driver support.
>>
>> Document the qcom,qcc2072-bt compatible used for QCC2072 Bluetooth
>> controllers connected over UART.
>>
>> Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
> 
> NAK, exactly same comments as before.
> 
> Nothing got improved, although what is weird - original SoB is gone, so
> this is legally dubious work.
> 
> Best regards,
> Krzysztof
> 

Hi Krzysztof,

Thanks for the review.

For the binding contents, I tried to capture the current scope in the binding
description itself. This series supports QCC2072 only as an M.2 E-key card,
where the card power resources are described by the pcie-m2-e-connector node
and the M.2 pwrseq provider creates the Bluetooth serdev child.

The binding also says:

  Integrated non-M.2 designs require board-specific power resources. Those
  properties, together with a static devicetree example, should be added when
  integrated non-M.2 support is added.

We do not currently have an integrated non-M.2 QCC2072 design, so I do not
have board-specific regulator supplies to document for that topology.

Could you please suggest how you would prefer this binding to be handled for
the current M.2-only use case? 

For the authorship concern, I mentioned the earlier QCC2072 contributions in
the cover letter, but I understand that is not sufficient. Since this still
documents the same qcom,qcc2072-bt compatible introduced by the earlier
work, I will carry the earlier authorship / Signed-off-by chain in v3.

Regards,
Rahul

