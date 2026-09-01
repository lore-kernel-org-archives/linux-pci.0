Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5A63F1AAD
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273938; cv=none; b=jUW1dpPsWR0nuYSfSS8Xn7EGwbWifysq11zjKh2q41PMym2PN2YYFvW6ZzXhcXXE/PqbP39mGmWQJlMbtr0CDDcETX2XS2LmOr2GFbsIRMMHQ8EXeftCpRcFkXQylS5K++7CgC2G5o/KqR4OoE2PzeF/nidZQF8rUOvfOOZgwxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273938; c=relaxed/simple;
	bh=fKQMBvYKulAxw8GGhm1+J27XYbV4eVyJyPhTEapLLdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UA7vQjkMCNE+eHtgR+xMUNxi4jOfqBJ9mSGFSEaPeRAPwJXJ5TZQC0pkNuFRJpsXnR5nmBxo6+kP7ygF+ksvjwqac/9P2NkjbqxwI7/xiWrs9D9TSyT/+aLM7gNyPqW/NFU4TOCANiSY+qAVobZcOANJlhVVSIceYrM23QCNHpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j1nd2NDD; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j1nd2NDD"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47fe89fb333so2891762f8f.3
        for <linux-pci@vger.kernel.org>; Tue, 01 Sep 2026 07:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788273932; x=1788878732; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:from:references:cc:to:subject:reply-to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cMkyp7j0GDArFH/6epwRcq8HmCIf0xcPQczhEQvkqh8=;
        b=j1nd2NDD5G+EDFnxRLLslgTT6tozRSJrPs+fgr6AEj711o1cn1ZxkSLi/wcWUc2tag
         QF98F/5x/0olme4i9+loNs3J2QNhJBBJuooGGwIasWnRqX67EedM+YkSRP5KoHUKNezm
         /CFPqGmnDBEyYHCTc3/oo0uIFqx9+2o11PZDzwX0ztBxYf0XPP6jDOfJMpGJ/1h1YrE8
         QQvkIjcX2/8Wg51eEepGeUAdM7jPvfuvSoB1hT1pFkUXJQ7h9YhTfWTyoGd080naV7dr
         8Kz1IymcTaRzQjc45kmJQUW/PYgF7qIw1JxQYnRj5Fp5MIDaNl5BB3ViVJPyp6amuqH4
         QtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788273932; x=1788878732;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:from:references:cc:to:subject:reply-to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cMkyp7j0GDArFH/6epwRcq8HmCIf0xcPQczhEQvkqh8=;
        b=eoB3RWaQNW1Wer0nk0p57pKklrhEbXMbd9g2RLGs5Dr2tQXNGYYB/MmYsKO/LMdnGe
         wcGBMowxOCmjh3XTBcIU5GVOaevPuMvV5/8p+5ydKd4a5Qw6rjQtHcHD2+VCKwUuW4YD
         bKPwQdqYp/d3Eo4doHsbR6ajQAYdkK4l6dlzChebYMm2fWG4Ku4Q++NyrD0Yo8eSx2qC
         TIAVWbZuAIX3wtrzgHsl6z/sWCqlni2svhWzfvM8UrW7thT24xZkurTpTZ8VdWurdQPQ
         tf3wM/VayL5a0eSMZQA6cydt/2oIlK8sikuu9eEu0Vb/sWniDVo2fhaynWRT2RaAGOhB
         YOnQ==
X-Gm-Message-State: AFuF++lvJJKbk5bRhLnKJ9U7+ZcQT3fXdi2d7ZXxLbuQTWHayb1yj7Gb
	JDyoCuYv3s5URjgHnDtMtz5Wn/AGIb4hJthhvY1l4R56Q3KR3uCfNarmGG1m7t1uuZQ=
X-Gm-Gg: AYBFou1iJL32ZGbFG6miEayGQp5I/xboqaNFXkvgPVnddMy2H2IdYP0/gfK0sLMViRP
	4uIpSVqmqteBlkpykliLDytW14wZAje5qEpI8cZi8yyrd78lZfH3vDm3Gta0v93fiokKXbt3CUH
	xbGSp+P6dWYWLDmGqa1zOlfGyJsB/hrS8qEsMvbubMghUUKPBctG0+lTPzqqoTIzRR2BEelax36
	AVzXWt5fM8+1UwgvSjRI9iQUp/eaG6lsJKfOg5/NzGNlo+en/0YIRSFz/mJ4w7xo/U1Pt7KP4Q+
	BJpyrGwfgdfvl/V6ZycEk80PF5N1Sy+Fg5G1U73NNmjTdQPcy0scKg2TM/Ll2PprYBJR1iCPHwU
	vzrpgsLjvFr9rrQmZL9g2qIMYSjNStGf2lwsqydbAKHIvu+XRRKLsXXWPtOuJ7kOdJzTpMG1LHV
	7U66CjLzG682pd9MJ9C3qhj/QI3+gAhLQGa7nk7oK+HDmFP6EE5XrtfftF8Ypi3Pa2CkXOpnMdN
	o0NfaQo039lBEapHGaYztgOoCAK0cNo1aJRdaMgRMU=
X-Received: by 2002:a05:6000:64a:b0:484:3621:6341 with SMTP id ffacd0b85a97d-48441011660mr15993949f8f.15.1788273932264;
        Tue, 01 Sep 2026 07:45:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:3b72:e9ec:2552:5b90? ([2a01:e0a:106d:1080:3b72:e9ec:2552:5b90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442d37111sm5175659f8f.5.2026.09.01.07.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 07:45:31 -0700 (PDT)
Message-ID: <5b10cb13-77e6-4754-a885-92c873866ef4@linaro.org>
Date: Tue, 1 Sep 2026 16:45:30 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 5/6] wifi: ath11k: Add support for MHI bandwidth
 scaling
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
 Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 qiang.yu@oss.qualcomm.com, Miaoqing Pan <quic_miaoqing@quicinc.com>
References: <20260819-bwscale-v5-0-6dea79786b37@oss.qualcomm.com>
 <20260819-bwscale-v5-5-6dea79786b37@oss.qualcomm.com>
From: Neil Armstrong <neil.armstrong@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260819-bwscale-v5-5-6dea79786b37@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 8/19/26 15:25, Krishna Chaitanya Chundru wrote:
> From: Miaoqing Pan <quic_miaoqing@quicinc.com>
> 
> Add support for MHI bandwidth scaling, which will reduce power consumption
> if WLAN operates with lower bandwidth. This feature is only enabled for
> QCA6390.
> 
> Bandwidth scaling is initiated by the endpoint firmware based upon the
> bandwidth requirements, if there is high bandwidth data endpoint requests
> for higher data rates or if there is less bandwidth they request for lower
> data rates to reduce power. Endpoint initiates this through MHI protocol.
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04546-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Somehow unrelated, but I added this to the ath12k to test on an WCN785x and I just
got a single event to set the speed to 5GT/s and no further event whatever the state
of the Wireless link is.

Is there anything required on the ath12k side to allow lowering the speed to 2.5GT/s ?

Thanks,
Neil

> 
> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>   drivers/net/wireless/ath/ath11k/mhi.c | 38 +++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
> index a6c9ff112c68..9bff4c4bca3b 100644
> --- a/drivers/net/wireless/ath/ath11k/mhi.c
> +++ b/drivers/net/wireless/ath/ath11k/mhi.c
> @@ -20,6 +20,7 @@
>   #define MHI_TIMEOUT_DEFAULT_MS	20000
>   #define RDDM_DUMP_SIZE	0x420000
>   #define MHI_CB_INVALID	0xff
> +#define MHI_BW_SCALE_CHAN_DB 126
>   
>   static const struct mhi_channel_config ath11k_mhi_channels_qca6390[] = {
>   	{
> @@ -71,6 +72,17 @@ static struct mhi_event_config ath11k_mhi_events_qca6390[] = {
>   		.client_managed = false,
>   		.offload_channel = false,
>   	},
> +	{
> +		.num_elements = 8,
> +		.irq_moderation_ms = 0,
> +		.irq = 1,
> +		.mode = MHI_DB_BRST_DISABLE,
> +		.data_type = MHI_ER_BW_SCALE,
> +		.priority = 2,
> +		.hardware_event = false,
> +		.client_managed = false,
> +		.offload_channel = false,
> +	},
>   };
>   
>   static const struct mhi_controller_config ath11k_mhi_config_qca6390 = {
> @@ -311,6 +323,30 @@ static void ath11k_mhi_op_write_reg(struct mhi_controller *mhi_cntrl,
>   	writel(val, addr);
>   }
>   
> +static int ath11k_mhi_op_get_misc_doorbell(struct mhi_controller *mhi_cntrl,
> +					   enum mhi_er_data_type type)
> +{
> +	if (type == MHI_ER_BW_SCALE)
> +		return MHI_BW_SCALE_CHAN_DB;
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static int ath11k_mhi_op_bw_scale(struct mhi_controller *mhi_cntrl,
> +				  struct mhi_link_info *link_info)
> +{
> +	enum pci_bus_speed speed = pci_lnkctl2_bus_speed(link_info->target_link_speed);
> +	struct ath11k_base *ab = dev_get_drvdata(mhi_cntrl->cntrl_dev);
> +	struct pci_dev *pci_dev = to_pci_dev(ab->dev);
> +	struct pci_dev *pdev;
> +
> +	pdev = pci_upstream_bridge(pci_dev);
> +	if (!pdev)
> +		return -ENODEV;
> +
> +	return pcie_set_target_speed(pdev, speed, true);
> +}
> +
>   static int ath11k_mhi_read_addr_from_dt(struct mhi_controller *mhi_ctrl)
>   {
>   	struct device_node *np;
> @@ -387,6 +423,8 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
>   	mhi_ctrl->status_cb = ath11k_mhi_op_status_cb;
>   	mhi_ctrl->read_reg = ath11k_mhi_op_read_reg;
>   	mhi_ctrl->write_reg = ath11k_mhi_op_write_reg;
> +	mhi_ctrl->bw_scale = ath11k_mhi_op_bw_scale;
> +	mhi_ctrl->get_misc_doorbell = ath11k_mhi_op_get_misc_doorbell;
>   
>   	switch (ab->hw_rev) {
>   	case ATH11K_HW_QCN9074_HW10:
> 

