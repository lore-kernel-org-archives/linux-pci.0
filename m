Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC8C37B40A
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322082; cv=none; b=FBlsGTwhh7f+swZD2CLh/l0UydVyBGBawGS6CAXOkbQqT7omP4pwh3cPEYkKoTvVRopf8wYyveZsK9nXYz+u4Y7N1llejs2mX07VDyT/PYKYl0upz5NI4UOUMXSSG7qfhsJHpsz8B0jOf1Pv991QtYVfI7T3FKXSDznUl9WDZeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322082; c=relaxed/simple;
	bh=Q3ZengQ4IRLYGNBWNlpT/D14IZyioia1aG8jgyEp4ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gl7kg6ndHLCFA+84XDbLwDYZYK3Um0AXWdVeoeJdb9+JU/xikpjtr27IKl6GvifZOlHAbQXJvIYXN+Sm+1s3Eqemx5Toji3P9/3Hnt47mH10+rpfaBfqlES/VVJxRJA1ai5PdHZbHt8R+1n/aXJxw26/AtliizTkxD3aGxNBZD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mLx6/naC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hwqk+Ihx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mLx6/naC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hwqk+Ihx"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6518fmq04066046
	for <linux-pci@vger.kernel.org>; Mon, 1 Jun 2026 13:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tsQa+ooxL+KuyWD5mAiKr5e5uyRG+3xbCwHL6U6EsC0=; b=mLx6/naCcM8HzVqR
	G15vzsmGz5ceDbttRzUdtzZPnV3cnSZhAb9Lh2mN7B5zYX82u9gadkBsH/BM60IN
	pqalWF/KsB2nPa4PIohAPjIIr6Cpho/reP0VZnXfvUnO0iXip7sta3H+GFx0i+J4
	u3t7y3czd9oyoUjn0tCGelrAk7djqBKOWfYfoQemk3CoEZgwI9ERP9QEqrEBLZ0X
	nolNi8vXtvR/er1kYX9uAcz2EcjtSVNEhwtvbS0xczHUwEzSh5LmXG3yXAm0chdq
	uS1EuSpkFF0vjAB65FPmeouuE1+A9PFrzeUp4qlmTxfEbayLc7A/7MX+/oenlFXo
	PtfUSQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6sws7tu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 13:54:39 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3041ab826ddso17497626eec.0
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 06:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780322079; x=1780926879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tsQa+ooxL+KuyWD5mAiKr5e5uyRG+3xbCwHL6U6EsC0=;
        b=Hwqk+Ihxtn0tatYJGeMy2OF9+ls2d+r8k8zQVhW6t0ZZxegjpiNt5hRNsQLhE2BkRv
         Iffu0d3VpN6vppx1FMVd29rR1OQPibSn+actuZg0wlTNt0zRi91Y18F7tUc2+ovTexHr
         SDTtEMGPXnH3IWixkygeZRLkpQst9vv/JrloTfNo48b7wHmrufT6fLFgbEIS+0g6M1Qz
         GrU7sDf/RGkUHxVsfKNE0oF19Kq3o5q3YNxnMs/zUGz/dC+Lhhwjx5Dq6YtxA3aIO6g6
         LTeoM/peL6wGez4suaOOmkBA94tGcSfvqFHRm2vmUDxU5ngMwL6SoPsMEmsMyQRvojVp
         wOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780322079; x=1780926879;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tsQa+ooxL+KuyWD5mAiKr5e5uyRG+3xbCwHL6U6EsC0=;
        b=GmGOnSexr7gUxP5Lt/BeY13TOtMaa8M9x5qW+EcmBkz+N4u8/3QW9ZJbU/rBdO51QJ
         tRyhOAgwS2byeucpYD5qS0fDAciiMHDB3UaMuKy1NRDJlQPotugJs7qx38KacXv99pri
         AXWcdVIX0bwn0ezcOI5VtGXruDI8cyyH2xbXUtTdMd60eJ9PpnFFjMBqf7mqILGgXJB5
         TPOo+S9B5btUJ37gOQDLxvXFcVQVuWsAurZwDC/JXhS9r6wQpQJxsZt/MTFSN3JwJODr
         lGHXzccFfd6tGqdlM6Iixu1i/uuvGPaaWJ6ACH/7bV+MPrGY7MZGIwOyIzWUJ9The6qG
         gZgQ==
X-Forwarded-Encrypted: i=1; AFNElJ+kBinVVLGvAydYC0JZbSHr7fqBGhc7OjKdyZhVXqju5VH8VziEdTNm8R4rltDcboPMa3VuoBo0ZkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ4y93vuO3WSs10gOISlcyxygvw39pf+nnznG0MKodqfnMVSZL
	DBodG989kKNYeWzZfBRyipZ8HTkkApMWO7oKyy1L3oE2Hm2U5L5dniSd9RaU4jI4fwsBfv1BWnH
	TKdhiQfNnVEdtOy8b64PPFyTLMv7wiywS0pDytDqIHiiSb5UCB+aJoZkoxF33WQE=
X-Gm-Gg: Acq92OHDB9v7GKWn4iTP5OXudcQl/fFMX6WhxHV5JFZz15T8EuyVizmxC4fWCVFIeW2
	mhJcGBEm04UU1L68u7VUIj7iOmZn6N/DB98AYWpi5pgIYiNzMaXJYkCvtk/HFLI3XV59Fd2pZGc
	gBzcSg8KJWKn04l6Iew0bS6JMxQQD5SxxEpHToWCK5dRkXkCtN02lc13IW7S+QQVeUwTn3wDTta
	txBXmvydWD+zDeyZD8lgvXY72D+hIzkjg75HUZf062VL/wig5fXR6fZuklOKHx6mmpIoeD3a5y6
	ZG2tUMingyp6TZ1ROeDgXT+P1xI8HxR495ZvA5dYXqwSw1hgRWY97Uh+KVtHebhmM/stbNxuNj9
	cmynRR4NwdaTZXahgBSd9h+4qAKd/wkV/LtXrLEHjXSJsBXyS0gyAENEn5WHuqUz1MBAE8p+hYu
	39eV6/HbOxib9Eb5D9
X-Received: by 2002:a05:7300:72c5:b0:2f2:6dde:df66 with SMTP id 5a478bee46e88-304fa628f82mr5384223eec.22.1780322078924;
        Mon, 01 Jun 2026 06:54:38 -0700 (PDT)
X-Received: by 2002:a05:7300:72c5:b0:2f2:6dde:df66 with SMTP id 5a478bee46e88-304fa628f82mr5384181eec.22.1780322078081;
        Mon, 01 Jun 2026 06:54:38 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5a0b7dsm9202218eec.22.2026.06.01.06.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 06:54:37 -0700 (PDT)
Message-ID: <e5b487ea-151f-4d22-b046-b72447c023cf@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 06:54:35 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] wifi: ath11k: enable support for WCN6851
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
 <20260601-sm8350-wifi-v1-2-242917d88031@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260601-sm8350-wifi-v1-2-242917d88031@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Z4Hc2nRA c=1 sm=1 tr=0 ts=6a1d8f1f cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=8x70SPmrBkAdAYyFYvgA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: WnB0upYhUjvUnr8PCSxMXUtz5Fe34y35
X-Proofpoint-ORIG-GUID: WnB0upYhUjvUnr8PCSxMXUtz5Fe34y35
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEzOSBTYWx0ZWRfX1W9dktr9VIbK
 thKIlJ31tYeZo6KXJ/Eg4gjlPsJLhqi0sDUocOKC+qDGF3t83Vk9X+9Tksi68BJokAn2gSq06yg
 z8W+8clYvuiGaMgfVO64vdjLXc6fgWdMF7YGoEnrQiLJH/rxBw22oTzLnnSqx42V6whRK7ujiPM
 lnTht/UmFSNTS1B0ciPrp3ItHMRqOQIPb0wyheBXoZFOgBGLmOvPmZhrJFHITlmqk2fJrTJid9N
 z3Dz9Dmk8VBCNRgA9upvwYZ02tS77XpWW7dBuaMjQbNYGan25zpFbv4o8tQ8xhxX67Ev/fv6m8M
 tVd1sYeqEpXeRJledk7A4EToHcQMh8Mdquw+M2S2MwtV3yutVcifMUpRJ2t5uY+tnJkgG6AvWsm
 eoG61uMcBWS/NVg6qmMfjUMSR3AoStw7DMyC6+5SuxpeZX9Eit0BmVsD+s3tlxMZwyHHZGm2+bh
 4f7kPvQFcIj7QKf7zeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010139

On 6/1/2026 2:46 AM, Dmitry Baryshkov wrote:
> The WCN6851, found e.g. on SM8350 platforms, is an earlier version of
> WCN6855 platform. It identifies itself as hw1.1. Copy WCN6855 hw 2.0
> configuration to support hw1.1 version.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath11k/core.c | 92 ++++++++++++++++++++++++++++++++++
>  drivers/net/wireless/ath/ath11k/core.h |  1 +
>  drivers/net/wireless/ath/ath11k/mhi.c  |  1 +
>  drivers/net/wireless/ath/ath11k/pci.c  |  9 ++++
>  drivers/net/wireless/ath/ath11k/pcic.c | 11 ++++
>  5 files changed, 114 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> index 3f6f4db5b7ee..7e997016cf6e 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -393,6 +393,98 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.cfr_num_stream_bufs = 0,
>  		.cfr_stream_buf_size = 0,
>  	},
> +	{
> +		.name = "wcn6855 hw1.1",
> +		.hw_rev = ATH11K_HW_WCN6855_HW11,
> +		.fw = {
> +			.dir = "WCN6855/hw1.1",
> +			.board_size = 256 * 1024,
> +			.cal_offset = 128 * 1024,
> +		},
...> +		.num_vdevs = 2 + 1,

this value is being modified to 4 in:
https://msgid.link/20260525020711.2590815-1-wei.zhang@oss.qualcomm.com

It is merging into ath-next today and should reach linux-next very soon.

/jeff


