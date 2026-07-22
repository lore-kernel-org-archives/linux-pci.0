Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F0B30C147
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 13:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726369; cv=none; b=TgeiPN75l9VX+BarXduN0B2OhSvmm5vVJosr/lGnN/FiibWOKrzpEGVTMoHO8h3mo1Qw7MGqcclWQxWYGviJW7jp/ECF4XYFbo40JDb3pt0DcLfW2eDQ6MwB/KK/1u3uYvRpeV7YeKmMv2/DhXdcVRmtNOS935fCMiHqGEVBjpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726369; c=relaxed/simple;
	bh=H7xGXrauGjlu5C8rK1hILg6jXkiS69crqkUF3Z9f4rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAIu2eFofldBBTwR2Uzs2ycxaKxu4oUs27c0tqm9R9rZU8CDECt3lb63gkLIgoI2FDXaXAsFMPbBS9+itUZbUTr1Nur9BaIrWarug7WmE6dwrxX/cgMPzF2Zh9hw166brmhkNmI8Fxln/bCZaPUwjr7grO8aIbH2WnGPLtsZANg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bEx8jeQI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d6T/phV5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bEx8jeQI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d6T/phV5"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MD29B1684769
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 13:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=WU6LFLxtk1pyhpL5rLR8mU6q
	z9tm4VLsS8di1Pb2c+8=; b=bEx8jeQILrJXnGor6QGPQf5tuprG7e5mt/VAriRR
	BDMXZZ1k+naTxAsJa9JO/xgtX/dMK2uWqjFTC9uBLKD4rElVqn9b97zn26zvE5PZ
	2ADK9dHkqChDVyndafUWSBf4mnps2ENDEGKAi8bd2MpuPa9R5WokyZlTDdyASdPf
	t38yFd3YFGq4myOISHrQZm17R1ULuI3Aj/9+7NHwku1pkv6pgQtguLc8JXqQqVYQ
	tx6JOE0voRhJ1KSj/obN24RNGEXZcFj7DWjODK3jNEbT1AJcfBFv2Ck3kHP4z263
	taPbESS6SffjESbNqBLvV/qtvpxA18FV09cZAcG1Zt6gzQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjnu4t9xf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 13:19:26 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1d137a68so343293951cf.3
        for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 06:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784726365; x=1785331165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WU6LFLxtk1pyhpL5rLR8mU6qz9tm4VLsS8di1Pb2c+8=;
        b=d6T/phV5U1Odys0vcTstZDBgeks3TYuKYorImm8pcTHQr2uL9eiSuuB0U7nsG3A1qA
         Q8QAW19q6f+EPQyehb4l7xHopBaK7L3LnBUB1wG3oU85bn1L8pds8Vatj7SPU4UPh5k0
         wGn+ZADJgeAAeBa7lOPY5iD1SEW5lPExeX/niNPIvtl3K4AEBt+ZdaxDDz+HHuf1E2DY
         82nV06xE/X4j21NiIiaQfBnr/iiF4ps1tAO+Q5HzyatUjrS9EToO64pHJwqNIO7ln/ih
         U7K3EDZjns3AO82c7E0Lay1rf9rdPdi7g+f6wLshb2y2vZkNvV8R/CksCX0oRJolV4yo
         7dDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784726365; x=1785331165;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WU6LFLxtk1pyhpL5rLR8mU6qz9tm4VLsS8di1Pb2c+8=;
        b=iI5HJmO+dapQOa66Wci8o8kwOrZzHul9rOrJDKq1lEQ1m39d2bFZIuDYXYpmS85+KR
         rCqePN6wQJ6HSDon4wX0FAB3KyBaARdg68UeT+SeHtOiIL9c/ss0vniUyqYkRlDeRUzK
         nl/yVqr+f4MeWFu9Qj53VwXhc9jQwcHwfZPUIHsmmpr8RAfK9Y2RuGzDJZekLmU6hUev
         JwRcidSqx9zO1BRjRxbW6Dd62IAZBTfeYFrS9PZ4GXVAO43MEkA7DXlFen6tVY4iiQ6d
         Akwa0dAKR/r/9djlHHzZEWrUdp+h744APl+Z4Lnlw2bxo1HOSjdBZ4lRsUinBtghF3/n
         9gRw==
X-Forwarded-Encrypted: i=1; AHgh+RrW0gduww0FeSVvTTjH7V+h/mciN669fs1fcT/clKrJYSpn6cY5FkHuYx+QuuzXu8YWN59HriZWSyI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys2hTeDnQdOrjo4POYtB8fFGErWIJrXsPL4E1jBzD9mwP4BX1U
	R5Nw/8ZcQbQxrh7SpBer+PXPO4UEdmxV8s+yQiiBTHiFrVf1MYn62IomTgg/aABvSk7PPZ5/Cfq
	wtnuhfIIkpOHCZfLSy8KWdLh0w0F4a/AhawhY0iMDS/0rEenrg7ePaUiJMLQjMp0=
X-Gm-Gg: AR+sD11RjvrxtiiNK2E9hzaBpxb88UpprOPJOsW5cfA1veb2AIb5fR0mA0kzxuhyfhq
	xyi17GZC9xY5KFz9P5rNXTkMe1wFVdBs+lQQ1x4jVGqYjilztmHtR+DMR1YWlh562mWzDKQs2Nv
	Tnql1joeCcB0rP0QD6y7nKpWCXZSegQdak4GtFI/yxwDPp8lOUz9sPPN8O2nxVfrlLPERysng1I
	URFvIajU/tGMht4rIXTkHjxBMoPUSGxXJ3pONTH9sJdG1l2mFdBy1Sii0rIheNYFStGSl2f8Zsp
	yNEsk8A1UCxWx6lPcjbBUhV1QgBYF3ethEf0T7BDfYsVq24GwKl+XvU5v0LxGTuez6kYw77dhv3
	PS0OPFApnR+Ai4ffEWcODy+3iL41wdYwX2zQPHgIg4UNmhayBfx+3+ftUwo2gzO6JRGTKmrhOLt
	htubZr7sdQZil85Q==
X-Received: by 2002:ac8:5f90:0:b0:51a:8c9a:8fb5 with SMTP id d75a77b69052e-5213f2788c7mr216839261cf.70.1784726365395;
        Wed, 22 Jul 2026 06:19:25 -0700 (PDT)
X-Received: by 2002:ac8:5f90:0:b0:51a:8c9a:8fb5 with SMTP id d75a77b69052e-5213f2788c7mr216838481cf.70.1784726364629;
        Wed, 22 Jul 2026 06:19:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2a9d318a8sm475581e87.42.2026.07.22.06.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 06:19:23 -0700 (PDT)
Date: Wed, 22 Jul 2026 16:19:20 +0300
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
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v5 07/11] Bluetooth: hci_qca: Embed bt_power in struct
 qca_serdev
Message-ID: <oha2k2z4gts52xjrmjsquqbhikbyfrequxuuwpqx4pjcdiwuqj@3u3wvmkeivkp>
References: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
 <20260720-monza-wireless-v5-7-69ec6743543c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-monza-wireless-v5-7-69ec6743543c@oss.qualcomm.com>
X-Proofpoint-GUID: yRP1EaSay4l7j2O0jlSZqUGTHMb-BKl4
X-Authority-Analysis: v=2.4 cv=KLhqylFo c=1 sm=1 tr=0 ts=6a60c35e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=u2VBbWAUoUYCFW06j9kA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEzMCBTYWx0ZWRfXxExW+UNOCP9f
 FmrxYLZJ5BnA4eMI2S6B27OV6gkIyHEplrxFT9VB2Y48NclLK2dWQ6l8+LOXnJVu6gdhrXQYy9D
 ipBDjjdhBSd3NdbQDBdvxgIjzqBdS0kC/4UHnC8fmMBEWNWUo+GAz7e4AxodFaLB7iSoiadZsES
 sjNC84URE8b1/ss1+kMhxXRmGu3IMZzTPJzDb/QBDVj//Ot5svM+/4FlrgBAsIGLY/xBt4qgYv0
 FOrtr7NTq/vqlZ1ixgizSjbGVnE7mxbvFDfZ4sRtddzcvrWu2khG05NHf02zZd1B86npcsKY4YH
 9H/jj1vqOUqwv51NFVfcgl/Qi/IEXESY7sw2zroSfVsVhOvj57mWVC4QvDTAW5Ec5MY0K1wm1Ox
 wxl+Br+QnbCy9TrKA1hn2OmRCCL9onRqh8tc1TXjiV6SLx/Gt0a8EI1Xz+Gxj+PnoQh6XkuLxLx
 sgutj7t+ip9Pdugz81Q==
X-Proofpoint-ORIG-GUID: yRP1EaSay4l7j2O0jlSZqUGTHMb-BKl4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEzMCBTYWx0ZWRfXxtz2A3AxzEax
 b4Pym1hWz2O6YkbB1ICJCCYtNPSkcVqKqOGpkf+7qJiY3ITINnWVheHALnYZt81fCrvaa8JGDLv
 YECybqTNJPVB3htigfi+j5T9U4QN0dQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220130

On Mon, Jul 20, 2026 at 10:04:09AM +0200, Loic Poulain wrote:
> 'bt_power' is allocated dynamically only for a subset of SOC types, using a
> switch on the SOC type that mirrors the one that follows it. This is about
> to become pointless as the power sequencer path (used by M.2 modules) is
> independent of the SOC type and needs 'bt_power' populated for any type.
> 
> Embed 'struct qca_power' directly in 'struct qca_serdev' instead of
> allocating it separately. This drops the extra allocation and its dedicated
> SOC-type switch, and removes the need for NULL checks on the pointer.
> 
> No functional change intended.
> 
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/bluetooth/hci_qca.c | 72 ++++++++++++++++-----------------------------
>  1 file changed, 26 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 81fa41915363ce577ad7c6f25fe1b0a69536d462..7e4cb03d3db0722e5f9fa2e7a5a9a0894bf4f18c 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -226,7 +226,7 @@ struct qca_serdev {
>  	struct gpio_desc *sw_ctrl;
>  	struct clk	 *susclk;
>  	enum qca_btsoc_type btsoc_type;
> -	struct qca_power *bt_power;
> +	struct qca_power bt_power;

Can we drop it completely, putting necessary fields directly to
qca_serdev?


-- 
With best wishes
Dmitry
