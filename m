Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23C33D75AA
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 08:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785226098; cv=none; b=uvDHKDkOOqSm80kGBRF6mzV2E5npKH/dl44zOK10SfpUmmVcHahhSEmkDJDGPBPGk+er1/KmsdYS849PEdrtxZnOVLD/LfzbpfwhdXgNH1lQn7/i/ljtJU6sFpkBF3vYOwqe6RQGEnoYvadKgQZ/Jd2/PfMHkO8ObrWllozl+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785226098; c=relaxed/simple;
	bh=q37I5XVI0Q+iLKP5qsaezNyPiLXtMNHajU5etzKIRWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YvD9lVD1zs/1GGaCUGgYOgOCQxFqU6nvXMtO//lPZvW0ydVDn+YxmFcJ8UouNLWP/MJTzZzLeVdGmX1oPc0ZmPUExuy4wfiGJgDEH+A7zcDjDjw9k+9qa/pWwTfjHaaW1GGl7yiTYVXQ7mcJf5E72sP9wk8wIOux4ItKyWY+CtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MdX/o1D7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FK7RUKgH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MdX/o1D7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FK7RUKgH"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S82E0I1908724
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 08:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0R53usW3nkPTm2A0goKCOwYwCqYk+4lZv0scDNTk1MM=; b=MdX/o1D7OfoL8HbX
	6wCEsSoj02rlpqkKU52J5RHlg60Ps8R6YvS/USZmoqQBQysjoVVFUiMF9b58/W/+
	ktsQtjwLoB6kQXwVGOLytuNZ4ZXrOFW3u3D7/OhUPKlU/93wE7UpQoWZyynoO59n
	1KLPwm1+JLNrFcrwCwPCnImXhKE51stSwl9h4lsxtTV8ZdApNKANFRCDBLca1DMd
	oXzDNp4fY0kAa1YyijhBuc8JJidNUne3vASoUVWmfKgjN4qsVeriiBFReKBoOGWp
	HhaZdWrPfrvEYmE1PFrjuuonQHI1CXdRxaHiLgx3kpdd+50VX2R73Lo4b08f6n2N
	7YugXw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbp8b8g7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 08:08:16 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93102454272so16630385a.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 01:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785226095; x=1785830895; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0R53usW3nkPTm2A0goKCOwYwCqYk+4lZv0scDNTk1MM=;
        b=FK7RUKgHtJ8cMzxm04rl6JmdvDDNJfZQpzYzaT6LInA6MQ62IWOBtOsZqKWSDreBVZ
         BBPtuZpUmdk1nuiJzfvZZz6MPF3vVxBeBySJKwD60aGfQXSQz0UrJb91a/RKzmfW+vOo
         D8lielY1dDIet9x4lTKYT/gxybfzVpMG5DRjRgtzDZtC+JoWClFfMMKg2hxZR4laNPQa
         v9dIRbHDnOTyF3NP22fn+GW6PfV5+Eaq8/JgDfBz0dsZ6GihmzZHQ+p+Iwm58V5+bYvk
         875vnqc14AI6s1UgmGH+kUnMOpezBQx0/1MuPG8TMEQglQnQuSx4SffnM9hupkHC2W0U
         wUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785226095; x=1785830895;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0R53usW3nkPTm2A0goKCOwYwCqYk+4lZv0scDNTk1MM=;
        b=WRJzQTX6HQhxfSoZt+utrl0wKob8mHle2R46gJPHnonyBZNlkByC6BkOjKIxdnyEQx
         ht4u2+DhlWUAdLQv0tYc2LVoeytNPojpOZ/c70xsu1Eh81ZifUiPwZS96P8P+vJbHPmZ
         Jo6TgHwDZdroeYjR6qI+iR06A1ZRlwFyKZLfzWX2bmod0Jzjk8HnER+yVwv1WfTBe66q
         crMdt4lt0vnYE4gVZyM25rX0CMaLHPNHV4he9nZmf1fOUkaoJNeIfDIOg1whRxGW3ODc
         1tmr4p6mmdQIYC7UY6Nm2lWq+5g8m/YceOWEleaDxOCzXNcWAWgvmnsgItJqPsR0oCpq
         BLRw==
X-Forwarded-Encrypted: i=1; AHgh+RqeGZs+bBcdOUSMmCXFFLf/ugyeysJjupW/UNnI8Y3Pf3x1b0okTLI94t5i5NV3MoPsw+kKHk1UCxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgjcHtiI2VSUck2ZUBs60J19Ob7mQeEdKcdu+n1jCcj3iFWKob
	qMBJ6yps3kDpghz3RGn7Kya09MqTgi97/xszN1hIH3YF4iU/J61dpJACm93g/0HNj9YN5pm+zO3
	pQhYNxXVrqDeRHihtedlLvB+8WT7dACkr89EBkjYapBnBd/pGEcPpjktdiK78VJ4=
X-Gm-Gg: AR+sD11XazxffKaGp+DK8dV39HCC+qxDffPWjbK8Zdbi+5AFpSrrr/qnZKtY9x4G8g6
	Pib2UtPz2v2LWqeumjIoucjVLLZu2rDBAaPNjyckqo66F6Q72xg3LvTkQegIlnbjZW9IG/7vgTn
	4eF5dvsAdXUHD1aqTBbqYn68cu13o7htyDBcAio4Z/pKMKGyganXQd+a2cH+oA+ByIv5LQahD4X
	0AtlSR0mEayzSqwp/zEBl3JB81DPfZ16m8fc7MrmuIksFt3I5OMHpejnFIbRk3N3HEaox5mkWqX
	RneWbnEcC6S1gqzcwM6ununvormsIEs5TuUHZQrb+DdLWs8KM9C4RfK2KLeP+10JGnwq4bg99Wl
	g9If6IDNri183lwUMnjqA5/6v
X-Received: by 2002:a05:620a:a01b:b0:931:23a:83ca with SMTP id af79cd13be357-933027200admr143515685a.4.1785226095313;
        Tue, 28 Jul 2026 01:08:15 -0700 (PDT)
X-Received: by 2002:a05:620a:a01b:b0:931:23a:83ca with SMTP id af79cd13be357-933027200admr143511085a.4.1785226094885;
        Tue, 28 Jul 2026 01:08:14 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32a798a5sm720897566b.9.2026.07.28.01.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 01:08:13 -0700 (PDT)
Message-ID: <3e5470ae-887a-45be-963f-ee3ab10d36d0@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 10:08:11 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563
 PCIe switch
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20260728-eliza_evk-v4-0-decc7fe5246e@oss.qualcomm.com>
 <20260728-eliza_evk-v4-3-decc7fe5246e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260728-eliza_evk-v4-3-decc7fe5246e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2OSBTYWx0ZWRfX0Sl4Ea6/fW+/
 sGqTUW3NXQjvZzdTBvZ8ifNHXyvaLio3fKFm1zpiCVwjXMiptiBMaBfAEznnJVsX/jrM+Yy6UEL
 k7SyBon1aTmG5HVg1LwOqqH95nsv38g=
X-Proofpoint-GUID: nkt1D4x67ShuNSqRFspUbaBFK7WqtS3l
X-Proofpoint-ORIG-GUID: nkt1D4x67ShuNSqRFspUbaBFK7WqtS3l
X-Authority-Analysis: v=2.4 cv=KLJqylFo c=1 sm=1 tr=0 ts=6a686370 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=6pHcnep46kEejBPVP2gA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2OSBTYWx0ZWRfX/5PfhVx4OO4m
 nzQpDArILhePkpREXmcUl1BCPXw0Omosf3p+YTVO2xYUWCZG46pefOH4xGjwbqanR1T8FNbWm4H
 9IHdEv5F+7b49Hz4gsWxM/pQ8oIRScpOD0yNCkqwwbvO/1VB5ARxn4edUJFcClxVdMkgprakwTV
 Rs1sMc4Dauci+7hmsD9F0WzyLC8gkjQtRe9NM3cKSUnlNIw01L6G8DJNsaUbLO1tqWTIuX1eqqn
 YRpzLaKflvF2o4d2LnA6uUQhIANZKxtKfkA6JsgPIugNQ9lcOjc44H205SqaNZGoQttwwnmNhUY
 uA8mN7VrGCWggVPI3druqpdQceonz8IoDowCRCpXEu7UlXkKn7ek485R/isIF/FKgbJC0zENd0y
 kA60oJ/GvSn30mJeW5uJyjM+wY+8bIOyXin1oxGIkW17VU7L/ZJ+f+0BsX0gL25+KIoo7XcIO9F
 +aXkGVam0e2apY6wwqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280069

On 7/28/26 9:06 AM, Krishna Chaitanya Chundru wrote:
> The Eliza EVK board connects PCIe1 (8GT/s x2) to a Toshiba TC9563
> PCIe switch. Enable PCIe1 and its QMP PHY nodes.
> 
> TC9563 uses I2C (at address 0x77 on I2C4) for its management interface.
> 
> Override the base iommu-map with the expanded set covering all the
> switch's downstream ports (0x1400-0x1408 SID range).
> 
> The TC9563 RESX# and PERST# are OR-ed internally to assert reset on the
> switch. Use TC9563 RESX# pin via a TLMM GPIO and skip wiring PERST#
> from the PCIe controller.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
