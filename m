Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794849259;
	b=yykLw+7g95JuYlCkOVpIlc20k7muKGey4UK89Vm1w0gkfEriB46QpfYXk7d7Cj4lH/6S
	 CALKJCGx55BcDdCW1TIkZ2vHlvxf4tUk7kItaJz6yTLrEs1p/XB2PoGttF/q4ufFsW9b2
	 1lmq7+7DwWeEf2dhL9mcRS50RDPg3xnuXyE69AFroZN+Vy7tPEIVWDgm5cNRbPS1++F6E
	 0Vws/5vBC04BVZ6I5noCM3kMQL7hYrlMynlL96OaIRhVneGtiXTADqGmgS82Xbbg5lAmR
	 H/4cr9PN9mAI2r/wFQZWEz5VpSSbBv4r52bRQZ24xNHoxYRUBRjX8q7PtrgAHQ1sRAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849259;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=UGIDXdp2RIrXTSdgnrAspAZ/nkS4v0bZBuA1gb5G5i8=;
	b=w8tS6UKtWriqMp4eu5rop3NYVc1YBOAYJ1afN7RAdiBVZnKObmV8Km8YuUzLrvD8CdzP
	 tr5Ka7fYkHw0o6TtF8ShPUip7WMaqxdvb2+IrHrTpCsH4efwYpptemAVs7ekx6BWM9zHA
	 nQXtj4SyswK7xZglABlgn2zFYMfVv9KzYz9AJax6/Pr2ZoHbi4Ul7P7CAiTCIhaiWK0TN
	 9/uTUYO23kSnNEYIoiTM918mjoPNQb4gclJ4MZKEUhDAbiJphQGTzXBQUOIbj0QIbjabs
	 WMZxrHXETDEnBZUzC/O+5tiFPtqOE3kuv2qMtV5unC5t1Z/mPqpuCnKKVLZ+F7WBjhg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NywTcSMT;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Oavvq+Jw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA80606A337
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 17:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DA80606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NywTcSMT;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Oavvq+Jw
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGGIQYE2789944
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 17:14:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UGIDXdp2RIrXTSdgnrAspAZ/nkS4v0bZBuA1gb5G5i8=; b=NywTcSMTB0SjVUH8
	zpjux3PRGT+tY70cwKUHkTdZU6FQce64TaRkPm55vIxr2cJyMo+bEdnrpOKiv31O
	FFQIlEiLf9N9yJLplM7D8VMht3Te2bvxzvNzib6F+Fh3/GJE2YfxEfkSh43plUNn
	0U1jZvUAj1k0ASPm4mybE5QcXm+kJol8yLMjkVb02U85KmpF24PWjWCvAtJF/98A
	CoC5ifC7q+rvAkW3KWJF8yyVOUcN2Y/WhBKI04O0FA8R95QVy1aOW3+QGT7qfpqA
	LoOOYzr+6iz7S4t2RDspWL/9FPDi3hgcY3SmQ40L6u9MAWeAL6SOBB8V45aF1VzH
	4Zp33Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j00nfhext-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 17:14:16 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-948d83322f6so629080985a.1
        for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 09:14:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794849256; cv=none;
        d=google.com; s=arc-20260327;
        b=SVvxACW9S1AzeZKog9nwDYG3F0PPv2UWxBAMSG+W7h4VtwzyX8jd6TvxVBLcQPFJ2t
         eX13QOEstmhMz0zZzdGGYqL+4IjhaU2WibO5+lbf8z/D80J/uzB/4Gw/Gowg9mf6CVye
         XRO2bQEuZG9HhrJRq92W46HETc3LZMl2TOt9l5FTkUCOjS+m6Ax66yefD3BBxqmtWtgx
         bCtUu1AcuxxwdHx3keiLv3cscI3PiuaPCamasTluSnRLEKWSCU5cshvOxgIE6Q37t3YB
         cRCkIQ1kDzO58mMjoxdQBRp+louMIjwqLeDElpZrMMe8UeDqsj/m6RCJjdcch+3SxezW
         tJzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UGIDXdp2RIrXTSdgnrAspAZ/nkS4v0bZBuA1gb5G5i8=;
        fh=AkTk9dPkJHzWgQG8I76gP84Z9MY6iDO5l3wuDqRs+zo=;
        b=F/LQTIxcWurnCOa0NhUYK8e1BkccVh61Q9fWNgZvq648HU4g2ccRhXj4wNNkTf88Wx
         T95Ury1p+sTrF9YVMU6wlJFCb5fVBNrqHmpc8QTjUjYXDO9b18sF686rq31eyGC8KVk5
         Js9C4ovpI9dq0TB7DZLRU4/7LW+dVM3SAVkNexP5rmUaWGzzHzjhCQlj5+V7YAPnDfRc
         8SvBInWpzqSAAB6se0coGTGnmE6Xpdo2nXUjDbCay9c9ZiSS7Jj+0zZVB98hJTYjLOPa
         K20VO068sVOltm30eSQ4R/P4fCn/hpO4eizRrnXOuCtuFcL2tZiobw8FAYcsLLvM7b7J
         PwEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794849256; x=1795454056; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UGIDXdp2RIrXTSdgnrAspAZ/nkS4v0bZBuA1gb5G5i8=;
        b=Oavvq+JwNQrTn5YmGNpTNeeEL/plcUcvqJpF8HaP0iHoXVlerGo8RsTb33IrKAIXEa
         UEbEmF6gVxDQsV0OCOX/zkrltHSnDA/k6NhQQqLfv/6Ae7kPJWuPUdYuJiX8SFb/z64w
         oS/RslhJ//HsCF29Pn7yZejEuMX6UepSDdxXS9kUADNYfKKIMW+iXQKSDTN1IpZsJ2Ni
         UkfUCxJeFnm5RZC6II3tEJKmWDl0zZgHtU6QpAPJfzsPX0XwjUT1K+lICHFXZ0umgsQt
         byVlH5niBMIQMv2sX4dAZoK9OVqMnv1CXIZqO9CQKuvg4O+sXSxeJJZsf7q/tDQ0S+UJ
         jxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794849256; x=1795454056;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UGIDXdp2RIrXTSdgnrAspAZ/nkS4v0bZBuA1gb5G5i8=;
        b=Pk3XNgkNZwPX0mIAgLUxwUe/L93K7b9SKeQ/G9KMHvKmLhJHJmOCHs2rwf+2SDJ4Sx
         2/2gwrrjGNmUrNEXQnocZYKLMEJYa7MxyNM8BcxVVvUt0ON/MF5xu1y2jP4F5BSlJyDm
         S1uUjvcbOeiCyO4CiW9vAhxCr90Rwx2jyD5k4mI2dyi9gM0tTTXA9FhAi99ibBceNOT/
         D/f+M2qEvKlhfa2+ZKOTEKZjyFAJ5uuM5hrN8XsTO0s4Unx9Ohal+7j8zZ7h7bdyrpLJ
         bDb2sSaqe+2bdA7N+ad2YsyK6uUsKQEXqICzO/SszYc2MlHKFpwYqmbBiAnOjc+8LEmX
         S7YQ==
X-Gm-Message-State: APuU4Z+B1WuJGas/mdSCo1bBZWhv3v42NvpDMqOKwsYciQntrOpLJNTC
	PVUVCUh4hQve8m043uV6yFCeJj6xFGQs+JAKtVr1VE8vZcVCaGB11jgIFHhDIPge0IT0ESTYcpF
	ScOPzWU7fWR41pYK9DKc6e8VTs1cqDwgErFnlfG+nhA3fJnHm56dT8EyQUvkp6TZ5po8H0kMjmb
	1sE2o4z/R9hoUPwEIVWF9DY574Sp+ksOYyYEj3aQ==
X-Gm-Gg: AYBFou3+SwZqC6ff9hMZcrAFINhkBucuNuyICyyFbSakLOCZMI73kuB6xHQdqNFjU7z
	c4FpYzF9i6A2Ozyj7IYjPOIQbaie4HidUBWtjPrL5NkITr2w5ER3elGw+vxU3JHZltYrGa3uW3h
	+GAuRcSyML5jJjh8ZU4saQBKA8j0mVGfNWfrZ1lz5wstoWyp7AA21NWeiSngySwSzp22QDuVXXs
	Cpv2i1KULSmCYV9dOmR+pj2SiVV2MP+uxkXjN5qTcADpxjCFluC+gCpQlZ7fOiGKB602mqe5vF2
X-Received: by 2002:a05:620a:370e:b0:949:7502:6a8 with SMTP id af79cd13be357-94975020921mr757115885a.56.1794849255611;
        Mon, 16 Nov 2026 09:14:15 -0800 (PST)
X-Received: by 2002:a05:620a:370e:b0:949:7502:6a8 with SMTP id
 af79cd13be357-94975020921mr757111285a.56.1794849255104; Mon, 16 Nov 2026
 09:14:15 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com>
In-Reply-To: <20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 18:14:04 +0100
X-Gm-Features: AclHuK-gzqgD2ofKvkGd7o_qM6TFIZRuqcKLnoXo_1NUG577lrtNPElPOvNnw5A
Message-ID: <CAFEp6-1ys9CibgvvaQL3dvA7y0GjJbhNgf0wD5YAAFz3AqFkaA@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] arm64: dts: monaco-arduino-monza: Add support for
 LGA WiFi/BT module
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-pci@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=BrEIUoX5 c=1 sm=1 tr=0 ts=6afb39e8 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=AQfUo8DtNGVBezQI14YA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2OCBTYWx0ZWRfX3odIrUbtqO8b
 vIsWzoSWBXxIcnRQLWMDQVHmxxd/dcnHr3GUrGOTudy1MoyTi8c18wcJVXewdW2os57t2aYS0hJ
 BG372e4gbvUbpsJgQfFhoocEJUpf1RE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2OCBTYWx0ZWRfX7jgfP58ewOj/
 j3uSfg7OGm1kq45QaZPMAiLLnQLZr+fDM44DUFUeKutINGqGJMbnjfgVywSEOEQPt76miNzxycN
 zru/sA/oEv96A1MO1ZMApGwHJtiLm0PyqrT/CQspwpG/3g80mJ6kJdPm8hR8hHX6TLyuy5n1FFk
 nPoec4DxBA+4AUphJ86CPkKy/VpQo4gCadumABPVtdIhlLULDcXVa6IChUPjKk96jldV7rnmMnR
 4rB9qtw7BC0W8aCFx/IvLrYWauITm8HnJlnyQoL8OW4DfR+v7UHcuOiMaBjvKi24x3UjnGmmb1h
 PpSPcKbGuOaLA1Da9r7hY/AfJxUA2mCNz7H7Ae3KugRn3oCu2HyUdNLwmdlNJMwlTYoj9eq6nmJ
 UKuvZdLUpscMbRNESalfs8d3NFby9QYztwpl3FSjmCfwILi+UQslWiLfIpQioYCyaV5/AXKtHf5
 gyNXrgi/FKIJHUkrYOQ==
X-Proofpoint-ORIG-GUID: Wf9b4SeAQG5zCEH3Z0-lLDfE9XSCJATO
X-Proofpoint-GUID: Wf9b4SeAQG5zCEH3Z0-lLDfE9XSCJATO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160068

Hi Luiz, Bartosz,

On Mon, Oct 5, 2026 at 2:21=E2=80=AFPM Loic Poulain
<loic.poulain@oss.qualcomm.com> wrote:
>
> This series describes support for the onboard WiFi/Bluetooth module
> present on the Arduino VENTUNO Q (monaco) platform.
>
> The board provides LGA pads for a wireless module. On the VENTUNO Q
> these pads are populated with an NFA725B module featuring the
> QCA2066 WiFi/BT combo chip. While implemented as an LGA footprint,
> the design is functionally compatible with the M.2 Key E.
>
> The NFA725B exposes WiFi over PCIe and Bluetooth over a UART.
> Both interfaces are gated through the W_DISABLE1# and W_DISABLE2#
> signals, as defined by the M.2 specification and handled here via
> the pcie-m2 power sequencer.
>
> This series models the hardware using the existing pwrseq framework
> and connector bindings, allowing coordinated PCIe and UART bring-up.
>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Is there anything blocking this series from being picked up for
Bluetooth? I've already rebased it, so I'd appreciate any feedback if
anything still needs to be addressed.

Thanks,
Loic


> ---
> Changes in v7:
> - Rebased on linux-next (pwrseq changes dropped)
> - Link to v6: https://lore.kernel.org/r/20260904-monza-wireless-v6-0-d8c5=
042b3efd@oss.qualcomm.com
>
> Changes in v6:
> - Rebase onto v7.3-rc1: drop the now-upstream "power: sequencing: pcie-m2=
:
>   Add QCA2066 (QCNFA765) BT serdev ID" patch and adapt to the
>   pwrseq_power_on()/pwrseq_power_off() -> pwrseq_enable()/pwrseq_disable(=
)
>   rename that landed in this merge window.
> - hci_qca: fully drop struct qca_power and move its fields directly into
>   struct qca_serdev, removing the bt_power indirection (Dmitry).
> - Pick up Reviewed-by/Acked-by tags from Mani, Bartosz and Dmitry on the
>   pwrseq_is_controllable() API, the pcie-m2/qcom-wcn controllability
>   reporting, the bt_en_available rework and the M.2 connector support
>   patches.
> - Drop the pwrseq-m2-bt prerequisite series link, it is now merged upstre=
am
>   and included in the v7.3-rc1 base.
> - Link to v5: https://lore.kernel.org/r/20260720-monza-wireless-v5-0-69ec=
6743543c@oss.qualcomm.com
>
> Changes in v5:
> - hci_qca: comment why the M.2 'uart' pwrseq lifetime is bound to the ser=
dev
>   consumer device instead of using devm_pwrseq_get() on the controller (B=
artosz).
> - hci_qca: note that dropping the always-on pwrseq handle is not a leak s=
ince
>   the descriptor is still released by devres (Bartosz).
> - Link to v4: https://lore.kernel.org/r/20260716-monza-wireless-v4-0-9b02=
e6f549d7@oss.qualcomm.com
>
> Changes in v4:
> - pwrseq: rename pwrseq_power_is_controllable() to pwrseq_is_controllable=
() (Bartosz).
> - pwrseq: move the is_controllable() callback from the unit to the target=
 (Bartosz).
> - pwrseq: add might_sleep() and guard pwrseq_is_controllable() against
>   concurrent provider removal with rw_lock, matching pwrseq_power_on/off(=
) (Bartosz).
> - pwrseq: clarify the pwrseq_is_controllable() doc (Bartosz)
> - hci_qca: lifetime follows the Bluetooth device rather than the UART con=
troller (ChenYu).
> - dt-bindings: also add the "qcom,pcie-m2-1620-lga-connector" compatible =
(Mani).
> - arm64: dts: monaco-arduino-monza: rename the 'pcie_bridge_ep' endpoint =
to 'pcie_ep' (Mani).
> - pwrseq: reword commmit message (Mani)
> - Link to v3: https://lore.kernel.org/r/20260710-monza-wireless-v3-0-4625=
3587af64@oss.qualcomm.com
>
> Changes in v3:
> - Embed bt_power in struct qca_serdev instead of allocating it (Dmitry).
> - Add generic pwrseq_is_controllable() API + per-target .is_controllable(=
)
>   callback; use it in hci_qca instead of peeking at the W_DISABLE2# prope=
rty.
> - Implement .is_controllable() in the pcie-m2 and qcom-wcn providers.
> - Treat non-controllable BT power as always-on.
> - Integrate the pending Bluetooth pwrseq patches from Mani.
> - Link to v2: https://lore.kernel.org/r/20260702-monza-wireless-v2-0-7b56=
e2a6a6d4@oss.qualcomm.com
>
> Changes in v2:
> - hci_qca: extract M.2 pwrseq into qca_serdev_get_m2_pwrseq() helper, cal=
led
>   outside the SoC switch; drop duplicated of_graph logic and redundant
>   bt_power NULL checks (Dmitry/Mani)
> - dts/bindings: use qcom,pcie-m2-1418-lga-connector (fallback
>   pcie-m2-e-connector) instead of the generic M.2 E-key compatible (Mani)
> - Link to v1: https://lore.kernel.org/r/20260520-monza-wireless-v1-0-9f69=
42310653@oss.qualcomm.com
>
> ---
> Loic Poulain (6):
>       Bluetooth: hci_qca: Set 'bt_en_available' based on pwrseq power con=
trollability
>       Bluetooth: hci_qca: Embed bt_power in struct qca_serdev
>       Bluetooth: hci_qca: Support QCA2066 on M.2 connector via pwrseq
>       Bluetooth: hci_qca: Flatten struct qca_power into struct qca_serdev
>       dt-bindings: connector: pcie-m2-e: Add vendor LGA connector compati=
ble
>       arm64: dts: qcom: monaco-arduino-monza: Add QCA2066 M.2 WiFi/BT sup=
port
>
> Manivannan Sadhasivam (2):
>       Bluetooth: hci_qca: Add M.2 Bluetooth device support using pwrseq
>       Bluetooth: hci_qca: Rename 'power_ctrl_enabled' to 'bt_en_available=
'
>
>  .../bindings/connector/pcie-m2-e-connector.yaml    |   8 +-
>  arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts  |  64 ++++++++-
>  drivers/bluetooth/hci_qca.c                        | 160 ++++++++++++---=
------
>  3 files changed, 157 insertions(+), 75 deletions(-)
> ---
> base-commit: f0406245cb9855e6318335a8a223551354291a46
> change-id: 20260520-monza-wireless-e6ce7f013f38
>
> Best regards,
> --
> Loic Poulain <loic.poulain@oss.qualcomm.com>
>
