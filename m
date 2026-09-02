Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAF4372EEC
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 05:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788327062; cv=none; b=HHWWjCzXLD3FBbyZLxPmuPbMZAdPtmJBbGAaqJ594a3jknf2bdZKes/NiAOhQigcJqRIAlxUWF305G79wS5f/dlmbSnGsqXn3fM4IZ/eYC0e9m7i1mqm2XQFQfaRivc3oGdeNkpQ762Q/+fbXzFdZp6FXN1zT3ct/Lg4TXPj2pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788327062; c=relaxed/simple;
	bh=EErxRj9UamHxjL4qovNFexC2eoDhDkme3XwtJu95u6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rj+hb+goW2NalutXXcQrKnXQLNurGR0kxKpEVzbHhAz1N3fAx5JlXiUlkmRDJE/n/fRlKeBfcA7gn2CsfJevyGqWmfrzJ02HibJ3KL/WdSYYG4h/L1sjq0ZOhbLaUXtVn2qW33NTa+i/krkMloySRT1hKQqgBec9D1xhzVIuv38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c2jPeDiT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cVUiNyW/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c2jPeDiT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cVUiNyW/"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6824wPrO3108437
	for <linux-pci@vger.kernel.org>; Wed, 2 Sep 2026 05:31:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EErxRj9UamHxjL4qovNFexC2eoDhDkme3XwtJu95u6Y=; b=c2jPeDiTCeOUZ+Ms
	LDfvknHx3w8HS4tzLQFo8FeefuE26hYIfDzmCR63ke5HsTrJhVNRJ4izfpXB0ssw
	webIHA/6bABWsLA1p/ztDuFgHvg1mkJXMCDTkhmkQP3IGyj7VCPugPCCD+1Oq7Oe
	GKwl73PE7usS1R0M0BFMgfEmqQwzWrKy2dI0rZbPKedLcZDptd4JdDT+Ap5zr7or
	Xcj9TYijr4hxx1KlLlOSR1iT/240UHSABpzX0lHN4vfOpdyXfvXJSNYZVlnVAgcA
	OQaL+qvn/miYq+lTGRaGVsYnHHepG14/UNsfuRW4Uht9HuVYjLcLQQFZ8OMwvjOS
	GVLutA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge1wpasvd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2026 05:30:59 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39512608fb1so1659651a91.1
        for <linux-pci@vger.kernel.org>; Tue, 01 Sep 2026 22:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788327059; x=1788931859; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EErxRj9UamHxjL4qovNFexC2eoDhDkme3XwtJu95u6Y=;
        b=cVUiNyW/ohBB+s7jOsi+qnKDuhoqnsuIqqXC6JiO1+cXdWMuegmxe0TrzVCLnvvhc0
         3tHsxF4IX2c+KjMxnRRUHzHYaUJN252/ubYX0D+7eC8di2GkQc7yjvZu2xPfRFfvGYGy
         cAFCwd/3XKPHmaWs3X9R98gBKLQBjOu6HkNYGRVwlBULfteYKCGl9p0H3hpq0mvzXzhp
         i4C2OOjgMk1UYrSeWqa9eCsItFpd3MyP2Zi8WXc+0E2AqcbhKrZogBZiQo4130PR1HRL
         Dg6gIBTlZ5H8NiVDdww1aWJlRE5D23RVK5VZkkF10at0T93liQCBoDhjDuDdlYLtjG7N
         qCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788327059; x=1788931859;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EErxRj9UamHxjL4qovNFexC2eoDhDkme3XwtJu95u6Y=;
        b=tZtlpN2qEwUxnJgVyVATbmvXRhHNlZZ4TBn1TNJ+sPPNzCxcMIuLmknV8OQxgmRPO7
         busn8ih+MubzuPTQ20YexsguDbuumiey8dTGDf3qLELbzEMXQSvGSQJiRdKUwHCbpAL4
         sJrUW+99T8AmGHB71UFTRNbw72ybHOQkvWG9jK6N+6zulFPVA4QPtrfIuj+QFxOO2sob
         wNfiUHL0SFbW7kImXyUyF7HXYNNXxzevCP8FVY+cuWfKnttTeh597XLTfcJ4uo9fegYG
         cw+Y+2LBB8DZVGIlRnK+5ODRtKwzYRrD9OcCoBhHpjNklFtkxi/4CA4DKBDTxX9DriRN
         BL/w==
X-Gm-Message-State: AFuF++mXujtpCnGx6Gb/i36OseWqOyY/HoFWwoQiLdaZpNsv2zgvEzvC
	zGQSQ9qN/+NV5xTx6tJkkQMaqCedHCqm0UnY+sjmJe+9wDywObiGi9iMC/YlerWRsQJ/4xW75FT
	nAsvdgWokHHNxdtbT9nVqyFJiXtK4VMWFlkwW3tfh5QyyAteoS3YhAl9kUiUMD/E=
X-Gm-Gg: AYBFou3i4Ytr4ZRSobEtksciw6lbYAXvWuksdD1DqM11kdSv6zLu09HXiMuTSvH2iW2
	lGnDN7pzUqWaxjmHvE4rBvEZpiScmj1BYQ1BXv01slrjkjChfFVpWAG8FSxAH8ddEoHYeKWijx9
	9hbTQX2D47WyFSL6w3S4RWsUwwv2demYC9OExy7CED27Bn+YhEbqk5oQ7F4rtN/n8nQXUNLLgwO
	PmYP/cNntJtZFMpUVjfmk1aXXVZg7b8QsAsYT/61UbwFLrFMnUdusRk6QaBeuhIuEAs0xMq3W8L
	aViWq/aBPrDPMnx5Wmagtfbpu2QPYQyEz4J/7bA2VvmyJwHQ99QNi4xWuEoWnYtaxaw5seTCXAr
	bYqSRjxSOKAliTuD2K+Cya0jEJz/81MzB
X-Received: by 2002:a17:90b:1c07:b0:398:d8eb:cb2a with SMTP id 98e67ed59e1d1-39aee260bc0mr2726724a91.23.1788327059338;
        Tue, 01 Sep 2026 22:30:59 -0700 (PDT)
X-Received: by 2002:a17:90b:1c07:b0:398:d8eb:cb2a with SMTP id 98e67ed59e1d1-39aee260bc0mr2726667a91.23.1788327058905;
        Tue, 01 Sep 2026 22:30:58 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1430e8c6fcbsm5163942c88.0.2026.09.01.22.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 22:30:58 -0700 (PDT)
Message-ID: <774adaa9-55de-4456-9ee2-eb3c5d7ea0a5@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 11:00:51 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] wifi: ath11k: Add support for MHI bandwidth
 scaling
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, Miaoqing Pan <quic_miaoqing@quicinc.com>
References: <20260819-bwscale-v5-0-6dea79786b37@oss.qualcomm.com>
 <20260819-bwscale-v5-5-6dea79786b37@oss.qualcomm.com>
 <5b10cb13-77e6-4754-a885-92c873866ef4@linaro.org>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <5b10cb13-77e6-4754-a885-92c873866ef4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=F8JnsKhN c=1 sm=1 tr=0 ts=6a97b494 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=WikkZxfSKXF9q-dYMVUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: H6D5tAkdhGQdRw_fVAvdK5LPCLi5MavE
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA0NiBTYWx0ZWRfXyjKOa3MjtUqj
 WSvSq9fBlVoAiRWmEL3XTcdB8GDpB/+RjX4hfegy06FK9RhYYYM19XHf544EErS2e5kXYtZaBep
 MLoEk3Bb8NbeZw+Bgk4JzSx03vNy/co=
X-Proofpoint-ORIG-GUID: H6D5tAkdhGQdRw_fVAvdK5LPCLi5MavE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA0NiBTYWx0ZWRfX/fdNZ4aROPJA
 XxofORx4LfwsEu5GkvG00HUyT3p1C64CVEMAMAidzQXsdiTBpoB7BqIhXnkZeORhfiISsAOUHlm
 USPKPBeIKew6EExBUslRjQx47dKBAqGLpAAGd8fWDLTKvLiZzVh5/8tsl2sU5pSlaWW9uzNw4Vo
 dbE8e8wd6M9MUBL9YF5SvF0Uc8PRrgyFzAd0WKdy3AvnkDmFPAC/tUiIpjP1t//MNIBonyOzkcn
 XqIB1X8/rtf1tb6bo4f3rjh8q+nA0z+gfDgrtTwUZgeDGmvxJmeuBkMni+WPUW7OLDyRWwUEbwA
 NvrzsSyXiZL1PWF13IIzi8MIy+pPLzfP3TFKKPSZmtoEvy97cS1mIixWAIB/1QWV8kJiTW8midY
 qRakzZ+YvJuf+YzYSrlzd1X6edUVFHbGYoVNrHFVnTImFA9OW8AGNmjkKPiTKO4kxAx2J5PMfXx
 8i7YRG87mz+v52ef3hA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020046



On 9/1/2026 8:15 PM, Neil Armstrong wrote:
> Hi,
>
> On 8/19/26 15:25, Krishna Chaitanya Chundru wrote:
>> From: Miaoqing Pan <quic_miaoqing@quicinc.com>
>>
>> Add support for MHI bandwidth scaling, which will reduce power consumption
>> if WLAN operates with lower bandwidth. This feature is only enabled for
>> QCA6390.
>>
>> Bandwidth scaling is initiated by the endpoint firmware based upon the
>> bandwidth requirements, if there is high bandwidth data endpoint requests
>> for higher data rates or if there is less bandwidth they request for lower
>> data rates to reduce power. Endpoint initiates this through MHI protocol.
>>
>> Tested-on: WCN6855 hw2.1 PCI
>> WLAN.HSP.1.1-04546-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
>
> Somehow unrelated, but I added this to the ath12k to test on an WCN785x and
> I just
> got a single event to set the speed to 5GT/s and no further event whatever
> the state
> of the Wireless link is.
>
> Is there anything required on the ath12k side to allow lowering the speed to
> 2.5GT/s ? 
some wifi device has some limitation due to that they will stay in gen2 only.

- Krishna Chaitanya.
>
> Thanks,
> Neil
>
>>
>> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/net/wireless/ath/ath11k/mhi.c | 38
>> +++++++++++++++++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/mhi.c
>> b/drivers/net/wireless/ath/ath11k/mhi.c
>> index a6c9ff112c68..9bff4c4bca3b 100644
>> --- a/drivers/net/wireless/ath/ath11k/mhi.c
>> +++ b/drivers/net/wireless/ath/ath11k/mhi.c
>> @@ -20,6 +20,7 @@
>>   #define MHI_TIMEOUT_DEFAULT_MS    20000
>>   #define RDDM_DUMP_SIZE    0x420000
>>   #define MHI_CB_INVALID    0xff
>> +#define MHI_BW_SCALE_CHAN_DB 126
>>     static const struct mhi_channel_config ath11k_mhi_channels_qca6390[] = {
>>       {
>> @@ -71,6 +72,17 @@ static struct mhi_event_config
>> ath11k_mhi_events_qca6390[] = {
>>           .client_managed = false,
>>           .offload_channel = false,
>>       },
>> +    {
>> +        .num_elements = 8,
>> +        .irq_moderation_ms = 0,
>> +        .irq = 1,
>> +        .mode = MHI_DB_BRST_DISABLE,
>> +        .data_type = MHI_ER_BW_SCALE,
>> +        .priority = 2,
>> +        .hardware_event = false,
>> +        .client_managed = false,
>> +        .offload_channel = false,
>> +    },
>>   };
>>     static const struct mhi_controller_config ath11k_mhi_config_qca6390 = {
>> @@ -311,6 +323,30 @@ static void ath11k_mhi_op_write_reg(struct
>> mhi_controller *mhi_cntrl,
>>       writel(val, addr);
>>   }
>>   +static int ath11k_mhi_op_get_misc_doorbell(struct mhi_controller
>> *mhi_cntrl,
>> +                       enum mhi_er_data_type type)
>> +{
>> +    if (type == MHI_ER_BW_SCALE)
>> +        return MHI_BW_SCALE_CHAN_DB;
>> +
>> +    return -EOPNOTSUPP;
>> +}
>> +
>> +static int ath11k_mhi_op_bw_scale(struct mhi_controller *mhi_cntrl,
>> +                  struct mhi_link_info *link_info)
>> +{
>> +    enum pci_bus_speed speed =
>> pci_lnkctl2_bus_speed(link_info->target_link_speed);
>> +    struct ath11k_base *ab = dev_get_drvdata(mhi_cntrl->cntrl_dev);
>> +    struct pci_dev *pci_dev = to_pci_dev(ab->dev);
>> +    struct pci_dev *pdev;
>> +
>> +    pdev = pci_upstream_bridge(pci_dev);
>> +    if (!pdev)
>> +        return -ENODEV;
>> +
>> +    return pcie_set_target_speed(pdev, speed, true);
>> +}
>> +
>>   static int ath11k_mhi_read_addr_from_dt(struct mhi_controller *mhi_ctrl)
>>   {
>>       struct device_node *np;
>> @@ -387,6 +423,8 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
>>       mhi_ctrl->status_cb = ath11k_mhi_op_status_cb;
>>       mhi_ctrl->read_reg = ath11k_mhi_op_read_reg;
>>       mhi_ctrl->write_reg = ath11k_mhi_op_write_reg;
>> +    mhi_ctrl->bw_scale = ath11k_mhi_op_bw_scale;
>> +    mhi_ctrl->get_misc_doorbell = ath11k_mhi_op_get_misc_doorbell;
>>         switch (ab->hw_rev) {
>>       case ATH11K_HW_QCN9074_HW10:
>>
>

