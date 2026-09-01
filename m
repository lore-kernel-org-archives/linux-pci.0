Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A393F38552C
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 12:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788265215; cv=none; b=PsplE4PSn6OvvJGuYDqzQM4qHLtjMj1LsNk12JIUWCTQHDrdRugH9lEXDPzcxzGkLye/cQL+gXqexx9s8NxDT1p4x3E01+8dwPpDcPfbKYpeyNVaDolnrSaZGTrv3sibAM9IBWWcpLxqwHH4EQqldbyBBIwFp0SI6ZeB6nYLEIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788265215; c=relaxed/simple;
	bh=qXg8sssEt9Q9EeWhnCnsQ6Z9yvVpjqAAzFP2DSeudrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hc0SYPdguUlar+/S/5sXSNKa+L754xL+Us1dcHdYgmM1J7Olqf9m+k/Khu2+S0zpbAf+fC3LBu95k2jJc56hyD05zIG7PnrtSTARpncgEeQZ2odcywDZ8yPvOspmahEoqpJDsgoh1W4POE5emNkFksx7QGqfcKoom748Fpn57nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lWqn8avk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZRcOQcf7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lWqn8avk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZRcOQcf7"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681AJ9so1641292
	for <linux-pci@vger.kernel.org>; Tue, 1 Sep 2026 12:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kN2kJoz7hO2o7NskE9YevJ8bM5MarrXbwTiIKjarUso=; b=lWqn8avknas80M0G
	+rPK9sTcfUabALhvPkswOLG5U4wgEa/xDpbFr4/OSbbYdm1/sdLbJ+PWAYYHXcdC
	LOVA/ADi8OIEXBfoNmGYPRKy8VouuGJqcINCVxuWGoJURicmBa0DTMGUSOm1ZE+1
	V8wnst+7Qg1T2CX+em6qE3TIabME1mBGSQB4szoe8PYVbDcTQ0ObMT1KUx9sMax/
	Ez+WD1ampzDU3z2QrLSH2VJEFiMHqN4kk0oVwx0w2EJSGJs5N0SonGfS+4iju9AB
	UnAINYs+ZRqJGKDKayoum7aJiXLQEI/ICffGTVK2YXL6ZxAbSS7w+AfX47YgeoM2
	hA+GfA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdnk8tj04-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 01 Sep 2026 12:20:13 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93102454272so90828685a.1
        for <linux-pci@vger.kernel.org>; Tue, 01 Sep 2026 05:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788265213; x=1788870013; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kN2kJoz7hO2o7NskE9YevJ8bM5MarrXbwTiIKjarUso=;
        b=ZRcOQcf7byOjReIBQtpzjFZXIaSxr6TUTj+mhwh14Y3yuSnNnvOduZrp6xQglaSnyG
         3IgIxFxYd880ogejdXlUZ5UYI5K6VTtCVZ81ck2v1vhANNmebLgeY/toDBKxM8haFwcd
         dXDVkKoYOpLTpXOUkb0F3tSMnDPsXhiTODfO83jj9NlPBNYLnqg1XxzAq8s4X4bzK+WN
         RvSy6yhe6OlTQ9w4pxMmD0ucNveY0eXbRqTfbUNboTyU+7iLmP9tQe0x/nlr+D1atiTk
         VbIlyyDS/C1k25dqj/7DHelMdijmMrvqlc2VUwrMV+GLMyxTrmVX1C4WPlYmI5xASltS
         djeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788265213; x=1788870013;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kN2kJoz7hO2o7NskE9YevJ8bM5MarrXbwTiIKjarUso=;
        b=W86vUVJQm0PFEIHurMAB5wug76VWbrqxERo97aVNjnGOXpscWxf1i0Vfci9q79mqnJ
         RJY5V5zY/yRAFlq9JgHcyvfDDwYb6LViPLeRr6XpDtGn3niZKzMFwp1wwvvUIOn/L0ie
         d8Q8H6F6zwZZaY1GjxqiSlFBwAjLFyI91Npx+RNM7R3LFmvmqJy1MCCnKxNVkGC6Glkj
         osyDY3/eXiksYhiW7IqSAwjLbaKZ5SSrf6N3b5r1M0VtYe0Uq/x/3in62KR+ugn1t4iO
         U0+bppZg+k1sGMZoq+RWc7i82u0HACMNfJitIK6RqcZ7e8TLOpSs6sjp6hr/ZSXnQQaJ
         aquA==
X-Gm-Message-State: AFuF++lZVKObl9AAZsWQxZqYWlPhWYs7s8d2Rqzzl72TiuWUcQav4wMd
	/7sRA9UgxV0VQtlVZn+FfFxDORqyj1fCH/Yqs5NM/mZBAgk7cj85/NxlKZF50aVdJWFGncyxEwr
	vWCCW0vZs0hhf1P/XAUj8lbZ03H+pnXnfRBduVrS9w5wU3EcX0IP+FsgeKE9q1c8=
X-Gm-Gg: AR+sD10MIPZGYuHW9ifDkpIsmRsXmSORxOoKegwAWkySv63uatm9YgHH+D+swMjauxY
	zO0OjET6Bciaf3cTR1I0XmztIVupognfe9eWw1jjgWBL2U2Ouvisxx5F9rt3BFrUvXwwsJX0jG9
	OAg5dqvdtxiCdjciQ9uz7KZXvaxCPSwmUcIPg8EyI3dZ3T71HZGlZrLwalQGCHJxbRVLvH8pWDi
	tlWjEOL/WFzCgLon3xdh6XQ56ql6v3kydX8eB2+92LIq3DIdgRphQTtpm+M252xKmd37LFep6Wp
	TM8gBLGMqL1KutyhY76ZoeKirj3Wkps/2F8fOL/zyZYs56TlwF+nf+Ye8oDbdBXHYtUSJGHJL41
	kWa2o8/QyG9V6tEGqu2acfQ==
X-Received: by 2002:a05:620a:46a3:b0:931:23a:83ca with SMTP id af79cd13be357-939287bdc55mr1477160985a.4.1788265212329;
        Tue, 01 Sep 2026 05:20:12 -0700 (PDT)
X-Received: by 2002:a05:620a:46a3:b0:931:23a:83ca with SMTP id af79cd13be357-939287bdc55mr1477151785a.4.1788265211504;
        Tue, 01 Sep 2026 05:20:11 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255ee2872dsm590060666b.15.2026.09.01.05.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 05:20:10 -0700 (PDT)
Message-ID: <b4dc8702-212e-452d-b0a9-c9816b545066@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 14:20:07 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: qcom: qcs6490-rb3gen2: enable TC9563
 embedded GPIO controller
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Michael Walle <mwalle@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260901-pci-tc9563-aux-v1-0-dd9b80738e70@oss.qualcomm.com>
 <20260901-pci-tc9563-aux-v1-5-dd9b80738e70@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260901-pci-tc9563-aux-v1-5-dd9b80738e70@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=f6p4wuyM c=1 sm=1 tr=0 ts=6a96c2fe cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=fFHDuP4XVuiI0RsLl8oA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEwOSBTYWx0ZWRfX6SmoWAmZGZ96
 Hskt86jBAUqZDaCwqBxT3DagsmMIFrlvGJkayLTm3v9jU1oNoQcwlqT8Cv3+vrTDGBTpLbfSgCY
 o7ha6eyqKtvtq1JpvUwmfAlREaxnstTFLGWRgKhZxGhrYKDiXMt/dkXZs/JNkkc8e9IiHGOJoAq
 tuK2MWc9dRIc8RtcWEv3jDR0iwtEqmsyGafB5YljF30Qew46jwSGRH2DubYHzrrJ7jyAC66hwwE
 CvoRYnTp1OW88E1A1gOHaOJXmdjSzCXY3oh6fZKWL183hoSexUU5UIBGGAkj6Z+b7quBCWM5wl8
 jFlrCEzK+1wJ3h0vqeoWJq1ObYagdlgEFkWU6Bfw9oRK2Hksg0An53U1oTOb0ZXRLbdxdsOTSkY
 NVAazwNqtX1dfrbtKqKVh68xi3hH40Sug5YM7AMXmMpm1ENopHB9j3uG0QIAaqo7Snt4TnmY0OK
 dQCcibFM12gSbqbE/Rw==
X-Proofpoint-ORIG-GUID: GfER9ZRAlddq4PTFcic5-5UGPVHF7R0Y
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEwOSBTYWx0ZWRfX1HawcMZ1qR4f
 ySJmcWgwxUj4kSbIM41KXHGieSFhYuSj90hWCKosTOhDEvQXSTFuTWahT4ATgG88+WPr51Z8w/z
 H7eQxejoHsYiggjbUy/M75OXRStlDqo=
X-Proofpoint-GUID: GfER9ZRAlddq4PTFcic5-5UGPVHF7R0Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010109

On 9/1/26 12:27 PM, Lorenzo Bianconi wrote:
> The Toshiba TC9563 PCIe switch embeds a GPIO controller providing 37 GPIO
> lines.
> The controller is registered as an auxiliary device by the TC9563 power
> controller and accessed through the same i2c device.
> Describe the controller as a "gpio" child node of the switch and use it
> to control the PERST# reset lines of the two external downstream ports
> (pcie@1,0 and pcie@2,0), as expected by the TC9563 power controller after
> switching to the GPIO descriptor API for per-port resets.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
