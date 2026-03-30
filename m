Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BA537AA7E
	for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774858619; cv=none; b=GvQh3Mbsvr7OB/wqRLHD4fCGJSU16RGKqk0KjoPJhDDEk45pOfbvrLTO0V8h/O5jaybi2Qe7NyxHTp70awU3KRbD4FNEhqkeMx7OC0ITcjtAy8hK8gqcoN4h7x+qRfntjD5MKvvL3P8PQF+ZMJmekj4eM43EW1DIeCjQL/gF9aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774858619; c=relaxed/simple;
	bh=xDHNMwUarD4/IFRYAxF0A0jOcLNBFoAcxyEwKWzzDYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dYueC5kfs3A+WRi3dDV5ccRGFO1XgGrwtgW+ds4T154fHYlVjBobjxnv+SbC66BQgZz8ydCYVm6cw+QR9dXf5Rz4WTllp0ezjjVaabvRb9O9glyPTf1QMKfkXNS3x2J6Cx3vzk+VMuonBUV6AAb0QDhU4E7cHbgmU3PcgsfFGp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b49kfNke; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NKw8utNr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b49kfNke";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NKw8utNr"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62U4IU3X103746
	for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 08:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F4SlIIe0Yv6128iZ/AbQ/BWaZIoyvY16Ez6z84/Mszk=; b=b49kfNkeI7A7ncDq
	eOhKf32tL19D+CJNVdulqKqAHOGKTAEI6sG8sPLaYk1Y6WJ/Mh5TIWioObX5bsG/
	KD//IfvLk4HpPYyECLJ3kFzLnFltUWkwxZz5HzcCIpamAr7G24q1gsaspCrRxOb5
	Th7aZn3syZ+2CGS7gvdU2vG5Guc3IzvPeKIVfQj2NIdfOGvhgrdSbEbVu/VaT7C3
	3Tz1x5S4Q1S3jx+uT57wEEHYSqJbiOyPglOrat/6AAynyzxGW4d3GVxplVLKvr3F
	wNll/ppNCsfkm5cHsR9JsfcjEdLBW0N2ne8ghHdSkWadqBXZ7egzgZL9OYvGIN3q
	siYc1g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d67715596-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 08:16:57 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b24305cb3cso19242755ad.2
        for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 01:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774858616; x=1775463416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F4SlIIe0Yv6128iZ/AbQ/BWaZIoyvY16Ez6z84/Mszk=;
        b=NKw8utNrYpc7Vq2KzjfOsLcrQAXT31fJmHZjnuCHDm1ooNje5uh2sNzarTM+uiG3IT
         1bYOWIvHIMVS1ewGxdgZI4svkWNuEu6SN0RKjyi2DQFRY7iWBo1AHvOgDFR/e1s9LhVC
         VV9Gi5f0S+F0tTfFPLfNOLASrnGSy7Ia9l1UmqkLUURiE8IrHmuOGvJNFM2tXwsJ9yAA
         5mw7iAa4BSyQPWgc5xoHdau9IC0HUy7RCxmVEf6YfKYBMWUF5vcd7CJstyRQgzyM+VSs
         otrvmZYA/7X2dfv2CxmQWQxPllgn2qLZ6xoqPRwuMwojlQOEgrE/hiuivrPVd/wYOZ2N
         xMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774858616; x=1775463416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F4SlIIe0Yv6128iZ/AbQ/BWaZIoyvY16Ez6z84/Mszk=;
        b=cno7Va1r/7fB0q7AG/BVsXxKhpEewGSdopFU68oSi9ZrL/qDG3XwKlqIZzqbYu5tKD
         OV760XLdT7mJBD2GaZZw8UjFsuYVbVj97kGNqO/+ZdyGh95UoQAAYlf3+bKUfatFymFI
         y+gF2EhQCvd9ayXsOBAPF13ENy5XBRkeaM1rdRUlLBFyEa4lS+YEUrcWK8tip7piei8v
         1/awD1YsZKgMf53HfEtDUdiofTtfZUh3UsAsWvucCO3DbDMs/0lr7Cs0e95/t87nN8cY
         Cg4SA2/OBvr2JB96CoxwIpLPtOiqG0GfVxGDF1cz6hOydiW3bRZkS43+Hk7qQf5cwNf2
         cQ+g==
X-Gm-Message-State: AOJu0Yz1CjS/Mwc8vIQ5USdDUTspK5nSVng21+9CEilkM1NQ/yRGd9mQ
	7NiH2zC/t8W9jecj1wiJuUkToaqRcetkyMOKwm9m/HG80YJU2ioN/4b3bSdUcUv2Hmc8QVKqmHx
	rTUtnNkv2DlL8uoiwjwxPtyw2eREbNj+H9tBioi8TYPyvPNsk4PwW5HO5vE1V28Y=
X-Gm-Gg: ATEYQzzjaGC9BxErgGym4jIc1kVQy2a5H+QkXkon3r7CPVvSEKzHL5FeAUKxtxhWkLD
	y1DOXlbF8x2GFFxC44nqztkLhTDqhMDBIQBAgt6P5lUGiXil0VG9Uh/pf1mlskoLBrZDWyRV8RF
	mgG1js5bCPlPA1r8ORRurP13VdcwvUdUAz0Vgm8+IlJGoeDd19f5jwN+g8FB0Nbp02rI2vRs4gi
	p8koFmD38QmFy7uyGZjuaSSgy3vU+aiLz2PI0QFR+KDOT2mLIYgZj9mdAWfmM5nrVdufJ1MVkOK
	AywlknRRtrBB7/ZuZvrnAMdL8yX4TQZpXSi0DgBW4AzHHBwB88pj2NlYnm9mMCt8qlMFY2mAEpt
	2gFvJUIDEk81CHK96b7jkddRAtcH17Tl6r1PQv4CUOUb6VPNQ0sD5qQ==
X-Received: by 2002:a17:902:c40e:b0:2ae:826f:2c50 with SMTP id d9443c01a7336-2b0cdc3ab90mr128223335ad.12.1774858616501;
        Mon, 30 Mar 2026 01:16:56 -0700 (PDT)
X-Received: by 2002:a17:902:c40e:b0:2ae:826f:2c50 with SMTP id d9443c01a7336-2b0cdc3ab90mr128223005ad.12.1774858616016;
        Mon, 30 Mar 2026 01:16:56 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427c5339sm73986605ad.79.2026.03.30.01.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 01:16:55 -0700 (PDT)
Message-ID: <6e843004-62ec-46e2-a7c7-5e0ad18d4954@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 13:46:49 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] PCI: qcom: Program T_POWER_ON
To: Shawn Lin <shawn.lin@rock-chips.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mayank.rana@oss.qualcomm.com,
        quic_vbadigan@quicinc.com
References: <20260311-t_power_on_fux-v3-0-9b1f1d09c6f3@oss.qualcomm.com>
 <20260311-t_power_on_fux-v3-3-9b1f1d09c6f3@oss.qualcomm.com>
 <04fdfe0b-5867-0a94-75ec-44cec913756d@rock-chips.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <04fdfe0b-5867-0a94-75ec-44cec913756d@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: He5bO1aIU7QvyqDR1Bu2LW09f0FG17tQ
X-Authority-Analysis: v=2.4 cv=efYwvrEH c=1 sm=1 tr=0 ts=69ca3179 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=HIfOsU49naKVPb5QdBEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: He5bO1aIU7QvyqDR1Bu2LW09f0FG17tQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA2NCBTYWx0ZWRfXzCA9FDfpDLc6
 mNthGYx89+O9Lo1Af7ikW1H9UqJ56CMloTw4ruYWiTSNXz4P2fN+puua1PLYDBTdZVUeEAKM6Ky
 PQ6ZECAX5dP1UG81MVK8OEBsDA7sS26e7jd4XwS7LUqYhsenXXROv+DAToonp/ZFR0UIxjotSMy
 gBBqTUbw9qaISXwTCvH+nNTbVc46pxgb1var8tWpj2cOraNUUA/OyWENOrrVUt9Xh59Eo3a9fLQ
 PHaC4ZIEqGgYGoZ3IBnTOafHOguppzjg0pJFOL6J+1CZr8KuTJAakOYZQPFNAvlwAm59zn2szvL
 vrm5dGI70KJm9YGXQAFfucXIpPVx/2XV8Cc9lcn9+pc+loDksB6QX6sPIDpCXa4g6kJihwAYhFJ
 mYAHbFfa2XzODthMsPPAEYfTFFX9bh+u8Kh+MSNxloYrubAwv9UEn+cSVuQxCKK37odGejDk4T3
 1N5ZgvGiKkFrqh0umRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300064



On 3/13/2026 8:19 AM, Shawn Lin wrote:
> 在 2026/03/11 星期三 20:40, Krishna Chaitanya Chundru 写道:
>> Some platforms have incorrect T_POWER_ON value programmed in hardware.
>> Generally these will be corrected by bootloaders, but not all targets
>> support bootloaders to program correct values due to that
>> LTR_L1.2_THRESHOLD value calculated by aspm driver can be wrong, which
>> can result in improper L1.2 exit behavior and if AER happens to be
>> supported and enabled, the error may be *reported* via AER.
>>
>> Parse "t-power-on-us" property from each root port node and program them
>> as part of host initialization using dw_pcie_program_t_power_on() before
>> link training.
>>
>> This property in added to the dtschema here[1].
>>
>> Signed-off-by: Krishna Chaitanya Chundru 
>> <krishna.chundru@oss.qualcomm.com>
>> Link[1]: 
>> https://lore.kernel.org/all/20260205093346.667898-1-krishna.chundru@oss.qualcomm.com/
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c 
>> b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 
>> 67a16af69ddc75fca1b123e70715e692a91a9135..63d5628e988d3c07f42099c0d86e6b80fd54ce32 
>> 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -269,6 +269,7 @@ struct qcom_pcie_perst {
>>   struct qcom_pcie_port {
>>       struct list_head list;
>>       struct phy *phy;
>> +    u32 l1ss_t_power_on;
>
> u16?
>
>>       struct list_head perst;
>>   };
>>   @@ -1283,6 +1284,14 @@ static int qcom_pcie_phy_power_on(struct 
>> qcom_pcie *pcie)
>>       return 0;
>>   }
>>   +static void qcom_pcie_configure_ports(struct qcom_pcie *pcie)
>> +{
>> +    struct qcom_pcie_port *port;
>> +
>> +    list_for_each_entry(port, &pcie->ports, list)
>> +        dw_pcie_program_t_power_on(pcie->pci, port->l1ss_t_power_on);
>> +}
>> +
>>   static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>>   {
>>       struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> @@ -1317,6 +1326,8 @@ static int qcom_pcie_host_init(struct 
>> dw_pcie_rp *pp)
>>       dw_pcie_remove_capability(pcie->pci, PCI_CAP_ID_MSIX);
>>       dw_pcie_remove_ext_capability(pcie->pci, PCI_EXT_CAP_ID_DPC);
>>   +    qcom_pcie_configure_ports(pcie);
>> +
>>       qcom_pcie_perst_deassert(pcie);
>>         if (pcie->cfg->ops->config_sid) {
>> @@ -1759,6 +1770,8 @@ static int qcom_pcie_parse_port(struct 
>> qcom_pcie *pcie, struct device_node *node
>>       if (ret)
>>           return ret;
>>   +    of_property_read_u32(node, "t-power-on-us", 
>> &port->l1ss_t_power_on);
>
> Ditto?
the property has -us and doesn't have $ref to indicate if it is u32 or 
u16, by default it is u32 property only.
can we can't keep it as u16 even if have always less than u16.

- Krishna Chaitanya.
>> +
>>       port->phy = phy;
>>       INIT_LIST_HEAD(&port->list);
>>       list_add_tail(&port->list, &pcie->ports);
>>

