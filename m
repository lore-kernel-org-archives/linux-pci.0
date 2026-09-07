Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9494A9D6F
	for <linux-pci@vger.kernel.org>; Mon,  7 Sep 2026 12:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788785462; cv=pass; b=mn082fkhm06m/HC+TkdiFQg/9aJIQkmc5NXjAl7Q5nQA21UE6dM6sCGuXxI2K1QwyAnqtUj0YeFxEuLhlHK8p6g5n38eRTYO/uHKUrIeiZNd/E8MZgT72cJ5jT2FCueArN67+meBoIpT6aOn50ZXeFsoLGT97ULgwnn7Z2cHdb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788785462; c=relaxed/simple;
	bh=gT+Bt5eURaG5QY5OQe8D6BhKgHr/3HEhc0BcnyDPJsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLaZtmoxr+9gMywHxMkB7Sz7E3xDWOFqnATadTrNRIXSQ2KVa6wGoLAreXDBZDAtSlklr3DUrmX3uvQwV1EoQRq+hY2SkBpeoI+JZjpVRA0Tn9OYhlvFd9v4BZjhDN+Fz+KKTr+Wf+HCPRIAiG83C0x2lb48Igo5enFnAWhjSxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U04jKatk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D7S/LEd5; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U04jKatk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D7S/LEd5"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687AnRkk217671
	for <linux-pci@vger.kernel.org>; Mon, 7 Sep 2026 12:50:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gT+Bt5eURaG5QY5OQe8D6BhKgHr/3HEhc0BcnyDPJsc=; b=U04jKatkX5/Of0Lk
	NmSq95IrJaz5jcdpR2S3y2CdjZZrtZ5yoWV23Nl9G6UoLVXFr5aJFDMsoJi9WX0I
	nscIDNxtlNflYhFNPAXMWADWfbhGH4jyE+UTB9K4qxcPXD49SSYVfWcrjguxeEIT
	5YxVZHRqY0IiHKiufD+oEu3sQ692rdNZR0iwB2iLAudyyGRUXah+yzW/eGC/j5GV
	OpNpHAZsAMwSdDV1TDRFnU/WVuXH2wSDuQRWd50xY5EagiCkjIaZj703b4cFmVsP
	v0sXaSQuO7cUCRLl/3/CJmTrcuN6JvGiwTM4bqVg0Ec4ccJogB1oAkJj0fPshJKx
	ZHO2kA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghtdqgux7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 07 Sep 2026 12:50:58 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90ce21f2cc9so90002256d6.2
        for <linux-pci@vger.kernel.org>; Mon, 07 Sep 2026 05:50:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788785458; cv=none;
        d=google.com; s=arc-20260327;
        b=L5sOg9y2xkjXVL5CzcIoM0PI3P6J1hPwN+k/XivA0wv4jEu3LHIfKfTyEogz6rKIJH
         OAsJ1IviudqZqbCY0BvodVvWrhxo2jgHgcaRC2osPNo0WzdbyrOZQ01CkWhjAChL0hws
         rwvlDa1FiR+ba5D7SVQeiWvN74ZM7/xjCmQi6Er7iMVec9UXd7EwY6xPXguIdWhZf3JY
         5EYGOze3l8oH85f5JQkFEq17wy1MizZg+H+y84pG70bghDX8fOyj1Kn0CpYTZ5F0kQpl
         o6yrRv1c9OiYqR2nmMomnEiOZvs2NAhJf1MEb36fc2sC5ErZCfsLmpSiftMhewlr8WS5
         v0Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gT+Bt5eURaG5QY5OQe8D6BhKgHr/3HEhc0BcnyDPJsc=;
        fh=HNrGYm3FgTn0Y7xgacnWn5+fLrwzuNKSgsT8QlXVf+k=;
        b=sRds8Pnjni7wWyL+zKTdSCdeB5VsxKTuDA+Hy/e3Aiq67pV6nU0lCfd2LWkAYzXkEx
         BcDkimN2jVbh9OD1oEga/1jqJ+YwNCzPucPJTR92oU6e5i8DfRPMhbIVEwbIcP52LMFc
         NCoo1xgiVO+hUm8iRrAtMpq3zzQ7h0TkJxmgSpCCLFi3HWWQ+QC9ttUoq1ca/EvpQlcI
         Lh1ST6O0nDmcv9veDb9B3HunU9bXuO/S+qLN6yMaaZj6YojSTZoaJDeSTQvUziTZ4SXe
         vl1omTZm6yY7rMgF1KzaziBbsRiwaEYuQ1iKdWVx1mCAMCL7zRfjrahptV9oZ3Z8dgTb
         HZJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788785458; x=1789390258; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gT+Bt5eURaG5QY5OQe8D6BhKgHr/3HEhc0BcnyDPJsc=;
        b=D7S/LEd5tfmtAEoVBVUlbGFPQU6VKZUF6Je2YKaHzboMgG4c99XlJi2XdYmYUTlbFV
         2jcTK3II3F5K7p3rCXJWuLbI23ZM/zO4YMK1gF9S98VsFnH9njBf9UL3qWHYCDrC/iQ1
         P8KcfZ2fjjnCiuRCybfFhjBvFTifik1vvY70WK7D4A0dSmotItmcUZ2jaIxZTkqcH+cI
         ry4v9QNHbBpTXQGV1d6qic2TEaPCOCzgTIgVv1e80EnheXyqK2M+eegseltrbo8kVYvN
         yVWdPTTYKtR1xBSXGe0YDdvv6hpftT+suysydKLOpr0WFpUIcKyWHWH19noPraGnXB8j
         +9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788785458; x=1789390258;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gT+Bt5eURaG5QY5OQe8D6BhKgHr/3HEhc0BcnyDPJsc=;
        b=HcAit0IcGnpRVRvU0HCUDqqyG2Pwrr7Yi4UxoFDuG86U+6Nk0EdtoMc6Gu+kLmLxE5
         NdO4UleWy9+OgJ/xB+oWMNlj/i/Zz8+sGXE2zCwklsGKkUG/X9n84+//mlCuRcg5UOPt
         vNQ0l4YJYIDjmPpHX+9UAvMbajjSlAdbzXFn0FpVKOPSFM0UyjHYhema9vw59orMeRcH
         HTV41/1w36PYZrrGa1YgaEfVNMAa7SZ5Dnv1ZRq4kJKpG9UnWvvuXmL9kxTuvKSSOMJ5
         3Qp4DPFVr6XYnQz7ymrpJsHFhtTmBwJfD3EpF1WNsmNa6+ukAVtp3fmWxUIBVK88FY65
         /xMQ==
X-Gm-Message-State: AFuF++l/0vnVp6EriIqYdlQvN2bFYJoxHvSeCU3Su/K5rCY32GtroyaD
	q+gZIu60ot5oEpo4f+y22j8+vInyQFjZkt4sI4ZQCLMOBbnRbSkfhyCKsp0vk/nQD6cEQ/Ln7NY
	bbO+p+v1zL0j99U+KZKm3+NyCItfctyEnjFjAvW85lENn8Wud+EqhVWx1edBRB5+GNSh2CnLoXt
	PECNdmNKP68uc6Ri2MjbuWFCTJQ/QHCffJuJcu2w==
X-Gm-Gg: AYBFou2Tk1XhOWOAJRfLmJ/oN2wkOAnHzdv/96yl08EX9zkPB0d+dXWUdxV/9v161yU
	R6REYgYD+c0ros4f9kEqt8d0hFb4dTOJMFhDVebGOtIrR4NH8GL6YvoSoN6F0rujH5aTyDgmlop
	5OjwJH+46F+b3l5q3NtNc9oTQX/bFpZiXBdSy/z3qvxL4U7stl/cibhPySAA3w8BmVskohLPbE4
	vsL5l42l4xRphtFBcINAOqaG/sTNnHlREntT3EHhgHlDgAl5CDbETjGsDCwmuNhyCbYvUdiswU=
X-Received: by 2002:ad4:5d67:0:b0:90e:84e1:8b93 with SMTP id 6a1803df08f44-9103efbc676mr253793466d6.16.1788785458357;
        Mon, 07 Sep 2026 05:50:58 -0700 (PDT)
X-Received: by 2002:ad4:5d67:0:b0:90e:84e1:8b93 with SMTP id
 6a1803df08f44-9103efbc676mr253793026d6.16.1788785457864; Mon, 07 Sep 2026
 05:50:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com> <CAMRc=MfDAiUMzOYRWioK2NDM37=yQqb4pQ5ETZz1PVOKQhhdug@mail.gmail.com>
In-Reply-To: <CAMRc=MfDAiUMzOYRWioK2NDM37=yQqb4pQ5ETZz1PVOKQhhdug@mail.gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 14:50:45 +0200
X-Gm-Features: AcwNN1Uy8Dv_z6eHdNiSSHvTLy1MMXc0Rh3LRZ3dI-XaUt9s5OrddNB4Kn5BgT8
Message-ID: <CAFEp6-1PuGMGkdfWYiUQnYffm7en8b-DQybg_4M9xw9MVDNRsQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] arm64: dts: monaco-arduino-monza: Add support
 for LGA WiFi/BT module
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE0MiBTYWx0ZWRfX2T1KsxVLEKPS
 3DHj6G2s8ZYH0BwJyUqbI3xuOdmyBseKj9Mj6/MJwh/blva9UJE0U8uwkJMFvglIKmo6Kuh1X5w
 061CtycNOBDABLXV0F+bgBS71ismcavH+k36mqInD/SiJTOdItKBdUU2D5ck8+C1UpGDrjPRVuG
 uePVR2tZy53VZYfdQh61vvu0fgPrPVumr0oybo1QypB1bcv4yqtc2hhXUGRj0mPzt97HjMeldWN
 k5WPwQrpo3kWwYqnpzPNLJBcKXtw85w3wflBbtE0I3ZHI1BOuASwMollPxFiQ6purwf6jcWMRBh
 FtN5Y5iu/EeD+SiKq63ZuCDzQFvtH63ET8FnU3+BlYxVI+1veXLO3ghc5YikZJq5lgVWYJ6yQQm
 YCFKq/hJkNHRBFRBPi9tvzfyBzaXlmCMOB/O9QNvmA+y7rZaiZf15hane6CMfQUSMnzqp8kMJdF
 cfPeocCSt2hcEGedfhw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE0MiBTYWx0ZWRfX9hLRDxe01vO4
 v/C4cQcsP7EPjdwaiuHIPhE91F8SXENwnMrC0qOIgsMQ31V2ukAqjkfmB1Rjzv3mHjteKWZRCHM
 JED+EjXY0QwHvju6frSYSMnj/noHnS4=
X-Proofpoint-ORIG-GUID: VzxDzjF3UNmhw574fz14VHmFUWOoC4kM
X-Authority-Analysis: v=2.4 cv=U6aiy+ru c=1 sm=1 tr=0 ts=6a9eb332 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=YKo8iWYt6ehE2M1v1KUA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: VzxDzjF3UNmhw574fz14VHmFUWOoC4kM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070142

Hi Bartosz,

On Mon, Sep 7, 2026 at 10:24=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.or=
g> wrote:
>
> On Fri, 4 Sep 2026 17:42:15 +0200, Loic Poulain
> <loic.poulain@oss.qualcomm.com> said:
> > This series describes support for the onboard WiFi/Bluetooth module
> > present on the Arduino VENTUNO Q (monaco) platform.
> >
> > The board provides LGA pads for a wireless module. On the VENTUNO Q
> > these pads are populated with an NFA725B module featuring the
> > QCA2066 WiFi/BT combo chip. While implemented as an LGA footprint,
> > the design is functionally compatible with the M.2 Key E.
> >
> > The NFA725B exposes WiFi over PCIe and Bluetooth over a UART.
> > Both interfaces are gated through the W_DISABLE1# and W_DISABLE2#
> > signals, as defined by the M.2 specification and handled here via
> > the pcie-m2 power sequencer.
> >
> > This series models the hardware using the existing pwrseq framework
> > and connector bindings, allowing coordinated PCIe and UART bring-up.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
>
> What is the merge strategy? Do the pwrseq changes depend on first two blu=
etooth
> patches (I don't think so)? Can they go onto an immutable branch shared w=
ith
> the BT tree?

The pwrseq changes are only a dependency for the Bluetooth changes,
not the other way around. So yes, they can potentially go separately.

Regards,
Loic
