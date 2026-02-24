Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0E921CC7B
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 05:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771911241; cv=none; b=fI67JKwLHsAGrIVAuxgFoXUWijhfsfrBAl0cRmIhFlIuj8zX84OzxpKVjB5rF8UVp7Sc85VnvWuxHBh9RtMSKZYZarfnHZPYQt9yjkJohwUgGhi+bkP+SE2gkxmUjyBdoG7tBtdcu/1rE04O19biMi33+SRDWezUplCyvKrPaKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771911241; c=relaxed/simple;
	bh=XCeJaBe4ABQ+gvdp7O5e9ItRKiaRd8O4UO09HRN55Ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cFsFyl2iUnQCK0jrL3mK6QstXnr/TEwj4gzdLJRrneu2O2BZNODaAeFTOamHjH0qzcJrgrJLqfdJfh9mooeUgVfNGaCy884WhkWMVf5TnaPPud3tquV/cKhaoFBHBnZ38z2IsHdAxZnl6l+HN45V6oMKBWrEW6v4cpkirkGratk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=imc3D8Z7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MaWR8nWB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="imc3D8Z7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MaWR8nWB"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O4MSi32571578
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 05:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vswKj7+4AbGECyBbxdxx7+8FxcUo0j0q6oQwh1bnl9o=; b=imc3D8Z7GrUH41xF
	54PDZR4t/hLxTSb84ItlmMYIj8bm8m/Ulma9kL3NAKMYCISTerwMU3UQmEVtSTA4
	2DsJwhfan6dGj5bOWYeVPpaXnIK5GjV+mB2xf3NolAjuVLgFuQjj+ymiknDfKrVP
	QKGa7z2+JE5utkyEHp4PC8mwbGMujUt/3VY/iNsKA1W0ZbkE88SGf6bacfbkekG8
	eVt+wSVyGWG6exD42dnmC10vJyfLiLS1plEqSg3Yd9UOCI8HEO/+nx4sI/RBTjY6
	LOit4IlYyuNpzc8USwS0+veFJ6qaGSJi7huYDPKWxDIZos1UPzlm36jeU+vMnJHQ
	YyI7vA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgn8y317m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 05:33:59 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35620e2faf0so4079814a91.3
        for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 21:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771911239; x=1772516039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vswKj7+4AbGECyBbxdxx7+8FxcUo0j0q6oQwh1bnl9o=;
        b=MaWR8nWBkbpJ6uvSs8frfHkZjWTxjRs0w1dJ2TdbcDQZTkgd4kqF7kViUkLsjW7tDC
         B95DnGZ8LHelT1K2X9qZ0QZzKw5UgHoBpgEWMfrGPN2f+BSKnWG0A2TsRTutEQmb4aHg
         7gO4qBY01PnDjM6j8aWmvXnqJsiJTcNQwSb8wKqJBk/mUvoUZpLm8R/gqJDTcGtIrD4n
         d5Gevvm03L2VA11quUMfUOpmJ/yFb/HXWWjljZIsLRQbfS01gCuWnBEWJaxHNSfrF78W
         AaCXYIltTW0C6CTut9H34nbnZU96nSBM7Gca47fdmFo8kvToWAUrNPkG9T+vBzaFOMYZ
         aRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771911239; x=1772516039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vswKj7+4AbGECyBbxdxx7+8FxcUo0j0q6oQwh1bnl9o=;
        b=CwQt/bccuEvOLYCd6GrpzujeYay8f3EUOafAVm46XTUFS3V8sscaZCn5cL+R90Og1h
         y83q2JVUszCylutAmSS3UiNZiJ+L0pExNT3AwqBW0cAVsyJ337eIe13x15EMd1mJv1h/
         yZ+ruJ0JtoJchC2tgpFTjggPdKTisN4FAYXqAKha6GtdrrvtDGUs5JIEpMkgXfEB410M
         fHfNYH5B4+XD4Ocl7yBZLXbuhppYU3z2WeibfWTPR7Nx2EjJQRU3qniIYZuoTwAwF66s
         TMWFcUXAAGUFIi1fZnT4zg9p5MualUL8rsFkxgseIJpzVv2X2YEMKbTrx/VddImf0brY
         DwWg==
X-Gm-Message-State: AOJu0YxBFpr/K9GDNi3obHpgO1r9eRlo2Upk/eRAHP57Qm6uac8x62az
	TWOjRCuNR7hcunIOfjqAK+fUVOlKyQ9qZ9sh+QzPLXwkVF6l/mTQGwRzEOpsxWs91zBhsIFbZxn
	VPhp+rLA1sWnHAt8aKTeJmU/bZM6MbEeD5MRA2INH6xSLR6VIDpx5IyVOouVto2E=
X-Gm-Gg: ATEYQzxM50zrSWVN0/tD8fUdolOcapIIv0GU4OsDo6cd0aw5Th3eyd9SZAQW9JEhjT6
	Zc1N4l4wTf98JP5SDyYzPTE3CaozTMkHKVImDOXcDXoCNmp/sfLEYlqkBrr4ENOPAOZ27qMwO3Z
	oCLUH8S8VbF/5KUo4VH0Y3Pw4960sA0qCU+LLtQaqFBmmUsQp+NQNMXuUtyS8nbb+lImvQN7dSC
	IBfE4ZAORptOFj0erBuGagHBlwArb17JPT+9Lz3KVoVWpwgu/G+Wk7kmdhYfqPIBm2TCr2YuPfy
	KNPYvjyQcO3h6e7ZGw01CN/rdJIxdV1Ck8z2wyGQrINxebF6jJjC0U0GBCS3Dz+57ek9x3SM+bk
	88k618vKREXp65wdNBPqEams3FTW4mGO2FrDVLsLa35Maf/8tJTegsA==
X-Received: by 2002:a17:90b:3d47:b0:354:a5eb:a642 with SMTP id 98e67ed59e1d1-358ae8209aamr8535541a91.15.1771911238629;
        Mon, 23 Feb 2026 21:33:58 -0800 (PST)
X-Received: by 2002:a17:90b:3d47:b0:354:a5eb:a642 with SMTP id 98e67ed59e1d1-358ae8209aamr8535523a91.15.1771911238100;
        Mon, 23 Feb 2026 21:33:58 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358af701af7sm10494073a91.4.2026.02.23.21.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 21:33:57 -0800 (PST)
Message-ID: <f9b510e8-b5fb-49f6-a70b-96322002ad4a@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 11:03:52 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] PCI: qcom: Program T_POWER_ON
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mayank.rana@oss.qualcomm.com,
        quic_vbadigan@quicinc.com, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>
References: <20260223-t_power_on_fux-v2-0-20c921262709@oss.qualcomm.com>
 <20260223-t_power_on_fux-v2-3-20c921262709@oss.qualcomm.com>
 <85631e65-6328-3154-67a9-cc1b5ae8183e@rock-chips.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <85631e65-6328-3154-67a9-cc1b5ae8183e@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA0NSBTYWx0ZWRfX7iyY9EMbzQRS
 5PzjSHzrds8+V7MF+P01Fb6hhBGm7uPPN+/f7tSxNtGJtvTgMbwPKR2snsMZDc4iXPRXXGr2ZYE
 9ZHFIqtK5qanJmbPnPxxLkxHPSuaiRJL6LUn08yTGXysjNHuIm35bG5QcSvxFrmxTmTb8dIXELd
 qWDC9Y7V2XlKTS0jIQcKZXlQ40fX3RfmASJDcc+gnEGYyNhXTOTHM7iIohVxxEO7HaONlQNmhz4
 jNgGbfQ3n0/rQtkYysdHbFdWduWSOnXA8n5gzoM10Ve+rSSPSoDfceKdN8qhAISbNzObcISKVO8
 H1X/MxWVW7mg6H9veHJHRxrcRreflII69PkTaknAbplvMUL6UygHbyU0TRpfFY/zA0jR0gyDv4D
 qPNR2SUgh1VrPbZY5gOo1QQ/NPE/3ktLFuxtP33gCuGEBeJiqHZdF9d7o2dpZc1cLTbDxYo1PiY
 ++BQuJ5bnkGAAzZUEFg==
X-Authority-Analysis: v=2.4 cv=edYwvrEH c=1 sm=1 tr=0 ts=699d3847 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Ym3PPFOpFhoklKWBbF8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 8spr0TuaH7ESe2shAnCEOhzvedZxPoMY
X-Proofpoint-ORIG-GUID: 8spr0TuaH7ESe2shAnCEOhzvedZxPoMY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_06,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240045



On 2/23/2026 7:27 PM, Shawn Lin wrote:
> Hi Krishna,
>
> 在 2026/02/23 星期一 19:13, Krishna Chaitanya Chundru 写道:
>> Some platforms have incorrect T_POWER_ON value programmed in hardware.
>> Generally these will be corrected by bootloaders, but not all targets
>> support bootloaders to program correct values due to that
>> LTR_L1.2_THRESHOLD value calculated by aspm driver can be wrong, which
>> can result in improper L1.2 exit behavior and can trigger AER's.
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
>>   drivers/pci/controller/dwc/pcie-qcom.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c 
>> b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 
>> 67a16af69ddc75fca1b123e70715e692a91a9135..489ed64c1df0fa3ed9f6b0d4c3e0bb65cfc3308e 
>> 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -269,6 +269,7 @@ struct qcom_pcie_perst {
>>   struct qcom_pcie_port {
>>       struct list_head list;
>>       struct phy *phy;
>> +    u32 t_power_on;
>>       struct list_head perst;
>>   };
>>   @@ -1283,6 +1284,16 @@ static int qcom_pcie_phy_power_on(struct 
>> qcom_pcie *pcie)
>>       return 0;
>>   }
>>   +static int qcom_pcie_configure_ports(struct qcom_pcie *pcie)
>> +{
>> +    struct qcom_pcie_port *port;
>> +
>> +    list_for_each_entry(port, &pcie->ports, list)
>> +        dw_pcie_program_t_power_on(pcie->pci, port->t_power_on);
>> +
>> +    return 0;
>> +}
>> +
>>   static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>>   {
>>       struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> @@ -1317,6 +1328,8 @@ static int qcom_pcie_host_init(struct 
>> dw_pcie_rp *pp)
>>       dw_pcie_remove_capability(pcie->pci, PCI_CAP_ID_MSIX);
>>       dw_pcie_remove_ext_capability(pcie->pci, PCI_EXT_CAP_ID_DPC);
>>   +    qcom_pcie_configure_ports(pcie);
>> +
>>       qcom_pcie_perst_deassert(pcie);
>>         if (pcie->cfg->ops->config_sid) {
>> @@ -1759,6 +1772,8 @@ static int qcom_pcie_parse_port(struct 
>> qcom_pcie *pcie, struct device_node *node
>>       if (ret)
>>           return ret;
>>   +    of_property_read_u32(node, "t-power-on-us", &port->t_power_on);
>
> Your patch 2 adds a common helper in pcie-designware, but why not add
> this parse as well as what the qcom_pcie_configure_ports() does, into to
> the pcie-designware core, etc dw_pcie_host_init()/dw_pcie_ep_init()?
> Because I don't see anything qcom specific here.
>
Currently dwc doesn't support to read multiple root ports, but these 
properties
needs to be read from root ports. For that reason I kept it in qcom driver
until dwc supports multi root ports parsing which is currently in process.

- Krishna Chaitanya.
>
>> +
>>       port->phy = phy;
>>       INIT_LIST_HEAD(&port->list);
>>       list_add_tail(&port->list, &pcie->ports);
>>

