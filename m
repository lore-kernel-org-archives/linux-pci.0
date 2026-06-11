Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFEF3921F0
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 20:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208242; cv=none; b=pEaNpOLmFPHEjBpKyxT+PEO5DPMcmm1ukzHjHzTSC/pgsRqfyW0dHgxlGQFuIyw0blkA8puvdZF1p2e1Em+VeWbRcITvz3uczX/IoCYnyolnqTTcNR8TGtyJ0EHkMJbnWR62x6+jDogZbMn68jc2H/YSJ6AsUMv5bgGCAZ3G1xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208242; c=relaxed/simple;
	bh=kCvhS425Cd+lt0/WxCqTbQdRk8LkCHFoNycXUZuUL2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nvirg4tYfi58qHoAWteSUmGfRH6lBTsOo2Bk7V/+qeTdDgNd8GVpTgqv+NFixBSLNo+5txKOzIGp51YQuXHQY8OA1va2Ecek4yl5a3eAuj5QUVwcimf/DJKmIlxZWceo6Ip3HdQhuzpytzuaAeZpGQJOhxB9vYAbV1G9U4NRBlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rrl8f5Li; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hIv+Wv4K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rrl8f5Li";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hIv+Wv4K"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BJ3GOf1426642
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 20:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=OBFyb5D5/OcA3NsvWjkuD3j3
	aI56Fzwaywe0RW8P2J8=; b=Rrl8f5LiVZ14ULaePi85Nft7mMSMQs8lp3FibeL9
	hgf3jBOwaLmDqIn10+K7yfrNozjJHltFgevJt+zUiKh0ddth9r2p6VxV9O183FUa
	fnh6DogbJYuEVmmW6AEX0lTr4WHpTkNswskC3sluWGv/swgLqHj9rBGnNdffW6gq
	4J9W4eX+FlsNBafxJQWOP1EHFoRAjV72/cI0ax1yp4GN+6mvDDOCOLkm8BR+stJt
	goPcM/Mdd4Wn2Dl8yxVE/thisOCcZNwziOFw2YQGvUov3eTeJqctUE4t28DEWOVO
	gaqLz+gJMFBb4izl+7irCKYJOEARPWC1136vGJjH9SyW+Q==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er1xcgg5r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 20:04:00 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-963b2863d62so83623241.0
        for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 13:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781208240; x=1781813040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OBFyb5D5/OcA3NsvWjkuD3j3aI56Fzwaywe0RW8P2J8=;
        b=hIv+Wv4KeLxX1RmVzubqnPw+VrkaBdQ8aA2Y4Zjgr5+o5fK0Aw+IfIVmn2iKQSIyE4
         MCgXkBFtdGypQxh1CfFnOxqFwPrx2OBcL2YPaywxuKmFIIoUqteL1G00tjwcQpZcgXNc
         6mvs+uSx+WKoCdfWAVH3ezvI0japrqIpY0qO6mPNMC/QniNQkgEp2XO4RE0isLYybv5y
         4lsprusq7phS7UIwAOUFpVloHWtRd3vW5ceplAzyYUB5FhfBYX/qjwhVVPfcmKJU8LLa
         Fu2sjWdxcndCAd4Voz9Rszee6/9sM/U9ayGXZ/XU9LdDu8e+BpQR+Jk9mQ4vgdOtBYGk
         yW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781208240; x=1781813040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBFyb5D5/OcA3NsvWjkuD3j3aI56Fzwaywe0RW8P2J8=;
        b=tMJRFFxRVRC7TSmynGgA1tFpqTsU4GlfeiquU937lKNtvnHFAAmHTb0twbcUZI506P
         YW6Iu0XEEGNBW746/AZ48enyBk+i7oIlqpAI4ZK909eEAmw6vCm76rJODhcgAZUKqYEx
         tIIRkdSMzlAFkZHulvMLn/FUcyGtNzB6c879FsUA71u6m/OPZERWpv9mYiR3fKP8Cubz
         qkhB2QpoGksG5veuukkumBVJh1YB0FQbKKvjzTSsjAVFxbFSaVWdCoR6Oa//oSnmkfdQ
         05Euqm7Q3BuFni4Jj6LtbE1JK4dMVYqS/VGEdZhlJuquh87dr14TE4+GV0xxhO7KLust
         7IQQ==
X-Forwarded-Encrypted: i=1; AFNElJ+HxYrpEZvZa2iLQXh3xiavXj1DMRNcl2fdYLI7Q6Qz8y8h3/tYnzhm7zJakNUy8miHD6BxwjlwA6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc7KkOSm72mGiLrL2fmLV+C2CAMJnKVpzKa8OKPJRCdNsAgKn3
	X5RO2wGwllnTLWw4tei9LgFGBtBUsnbgCIOkcZN4JGbbjAa5YyUV/KHIMx2NCZwvaYAx99Rt6y3
	u/h2atYco1uk10axPD+bFJ24JtQGGY/ruSpp+dJg5upy4B6XrG9f5jcFK2VwRjeU=
X-Gm-Gg: Acq92OG8ZGkkyIVF2v08+FAqEVmsJ5JvWo9Fk3gVQDQ5v6IWwOngFi/TDuQNwE4UvXC
	KPcWK/xBEUXqF3mXCucBOV9V0pKLFbduxYxIpR6JEnmDQAst03j6OkvZgJhR9Mxy6Am2ejTXG5V
	YIAH13uE77uv8U/PK8fA8LwJp+yQVu8oX3Gk7PCSEDRgUPO7CgR7rOIFThgfgfnXUIMCJC3Gsr2
	nescHWl0NyyyzCahE77u3ZkOC1v7M/BGdq3N97BpP99f+yj2WuJmc9ODSbMwx/LSzdAbe6QaecN
	ohmnLl8XHX03ZvaADU0GHz2Zz0AmXshMZ6sgjU67zGp1R6xtesMOKwEPcRzz/rNOF1vHaPcs6w6
	pyVgrDyq9JIZnUleSZmKulJKQfF7PEZGMtqS4bGKQ4j4pGV+He+Q3MbNrjP3JofEwTnBawdFa2P
	y/ogeKTgae99nc4HTR+Na8OlOEHIhMv9NCmP8=
X-Received: by 2002:a05:6102:6a83:b0:631:ab8b:c34e with SMTP id ada2fe7eead31-71d5af2077bmr3143141137.11.1781208239759;
        Thu, 11 Jun 2026 13:03:59 -0700 (PDT)
X-Received: by 2002:a05:6102:6a83:b0:631:ab8b:c34e with SMTP id ada2fe7eead31-71d5af2077bmr3143092137.11.1781208239261;
        Thu, 11 Jun 2026 13:03:59 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39929c6abdcsm138351fa.13.2026.06.11.13.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:03:56 -0700 (PDT)
Date: Thu, 11 Jun 2026 23:03:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        devicetree@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/7] wifi: ath11k: enable support for WCN6851
Message-ID: <qidycur7hkqrccrpbkchztj3p7fgxfhauv6n4ajtxrw3mhhwnp@d64n2nxnlvov>
References: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
 <20260601-sm8350-wifi-v1-2-242917d88031@oss.qualcomm.com>
 <e5b487ea-151f-4d22-b046-b72447c023cf@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5b487ea-151f-4d22-b046-b72447c023cf@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIwMSBTYWx0ZWRfX4WRepJ6HWrAX
 GKJXt8pc2RMapSVkicdUTG6r4YZukbg+c1gV8gHEfBtZUIjsWKphFG79478OmQLXVhz2dDkuSZa
 VeOSZ9RE/1yvCdAsBMi5Nc9iv/8nYysJNFOI8F/kJYFwhCmdef659RMyq82TeS8IiSlN2+IXwD7
 Hw37VzoU0THwp+29Q+Fz2UuMFH3c74I3ud9ESR8x9dZ1Sh3sMIvFQXs/H40cD8B7CtcBZHAhI46
 SEcZyAkFwmNznX4SaBW5VLBs03SohNVoHlbsBbk9Dlua2/jCdyKeVyrLoozSd6HTvz+yuzyBvMD
 Ul8XE+YnZh4e51NBmDFRaynX3sVPQsI3oyEHGzFTnv26/qwtyuArb2h5X68tWUgrBeyygYYA+i6
 9o0HYJyHBkQtLdblHqgrUPqwOhdSQF+N/Hjn3iFU4NEBdHNai/ajcnj8VBSFVfW//deYAj0qgVH
 /fXBrSCBdsf5LZ9FknQ==
X-Proofpoint-GUID: 3Em5RoREtD_Vewn0KXPX5i4RC849TSlm
X-Proofpoint-ORIG-GUID: 3Em5RoREtD_Vewn0KXPX5i4RC849TSlm
X-Authority-Analysis: v=2.4 cv=NZPWEWD4 c=1 sm=1 tr=0 ts=6a2b14b0 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=mbcBxj5cxTrRBoZ8tFYA:9 a=CjuIK1q_8ugA:10
 a=1WsBpfsz9X-RYQiigVTh:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIwMSBTYWx0ZWRfX5C0rCzCR9Vkj
 Drw1OpjfeZHdErD7ihQhRNXvUvR7OquIxV1w1SiAEZ9HeURQxEYmRSfe5tQQS/uwQ8OP2Wka9TK
 cdaXG53TtSqZ58SYUhPbq5s2jFuxxvw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_04,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110201

On Mon, Jun 01, 2026 at 06:54:35AM -0700, Jeff Johnson wrote:
> On 6/1/2026 2:46 AM, Dmitry Baryshkov wrote:
> > The WCN6851, found e.g. on SM8350 platforms, is an earlier version of
> > WCN6855 platform. It identifies itself as hw1.1. Copy WCN6855 hw 2.0
> > configuration to support hw1.1 version.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  drivers/net/wireless/ath/ath11k/core.c | 92 ++++++++++++++++++++++++++++++++++
> >  drivers/net/wireless/ath/ath11k/core.h |  1 +
> >  drivers/net/wireless/ath/ath11k/mhi.c  |  1 +
> >  drivers/net/wireless/ath/ath11k/pci.c  |  9 ++++
> >  drivers/net/wireless/ath/ath11k/pcic.c | 11 ++++
> >  5 files changed, 114 insertions(+)
> > 
> > diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> > index 3f6f4db5b7ee..7e997016cf6e 100644
> > --- a/drivers/net/wireless/ath/ath11k/core.c
> > +++ b/drivers/net/wireless/ath/ath11k/core.c
> > @@ -393,6 +393,98 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
> >  		.cfr_num_stream_bufs = 0,
> >  		.cfr_stream_buf_size = 0,
> >  	},
> > +	{
> > +		.name = "wcn6855 hw1.1",
> > +		.hw_rev = ATH11K_HW_WCN6855_HW11,
> > +		.fw = {
> > +			.dir = "WCN6855/hw1.1",
> > +			.board_size = 256 * 1024,
> > +			.cal_offset = 128 * 1024,
> > +		},
> ...> +		.num_vdevs = 2 + 1,
> 
> this value is being modified to 4 in:
> https://msgid.link/20260525020711.2590815-1-wei.zhang@oss.qualcomm.com
> 
> It is merging into ath-next today and should reach linux-next very soon.

I've upgraded it 4 for v2, but it crashes the original firmware that
came with the board. I'll revert it for 3 for the next iteration.

For the reference:

ath11k_pci 0000:01:00.0: BAR 0 [mem 0x60400000-0x605fffff 64bit]: assigned
ath11k_pci 0000:01:00.0: MSI vectors: 32
ath11k_pci 0000:01:00.0: wcn6855 hw1.1
mhi mhi0: Requested to power ON
mhi mhi0: Power on setup success
mhi mhi0: Wait for device to enter SBL or Mission mode
ath11k_pci 0000:01:00.0: chip_id 0x0 chip_family 0xb board_id 0x6 soc_id 0x400c0110
ath11k_pci 0000:01:00.0: fw_version 0x110c80c8 fw_build_timestamp 2021-05-25 21:43 fw_build_id WLAN.HSP.1.1.c3-00200-QCAHSPSWPL_V1_V2_SILICONZ-1
ath11k_pci 0000:01:00.0: firmware crashed: MHI_CB_EE_RDDM
ath11k_pci 0000:01:00.0: ignore reset dev flags 0xc800
ath11k_pci 0000:01:00.0: failed to receive wmi unified ready event: -110
ath11k_pci 0000:01:00.0: failed to start core: -110
failed to send QMI message
ath11k_pci 0000:01:00.0: failed to send wlan mode request (mode 4): -5
ath11k_pci 0000:01:00.0: qmi failed to send wlan mode off: -5

> 
> /jeff
> 
> 

-- 
With best wishes
Dmitry
