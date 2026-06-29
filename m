Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E91360745
	for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2026 09:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726285; cv=none; b=W4JhyJEa/fMbLjtcE8zGyYLWwzfE7aTtwNfLkLsindDXiiZjNoM1wFkZiwia4yZsVbu1Lsn+pUPGXq3T1VDbhqsJXnqc6z+mZ6PnDcnO+maK9OdepPfmeULPAuPR3gtkokjelENijIIpsVPZKRmNFoC2RrrlyC1tuOw8/LJE4wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726285; c=relaxed/simple;
	bh=MjjXrkMnUwdq0FJ4Cu9/oZ/NIF4VGt0nFl1suBh70b4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A0l+EAuriG1X0gmeMMDj1VX0GfElhoMW5j/Dy2pO9hwljRXegpjlNzE4eixpHchP0MP4S4v0GaAS6ISpZ4ecLPHRRy7iwJVRpkBTzdDKTqCdhXHKH3x0xsM8fX6VkVhmi/VtuufzT34CuzFyBvpYezg1fY95G6ZLeC2hwQCSeYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nq0dTQhO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BCU1AENs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nq0dTQhO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BCU1AENs"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6sNZ12143207
	for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2026 09:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	29xDUNTed4jXAy3Mgxyo8ge5rsxJ/2Bn9rzkJN7OPjI=; b=Nq0dTQhObC4rViq8
	hHEZ1cCiH0k/XJAfNPJgmIX1a/lj4zi3R2RIn2uCc6bDwNWPmxVgpitUNAQtfPoA
	soN48DtvuBi0duKZozhcNkj3/BKV7Nkfu1Oapfs4FK8Wy5IDtQIdRmqiJWhfxFT+
	21BuaT7nZAYyZ1B8DNrxj323ONG2jt8M+lfHNwJhSO4y4T+Ya+725vXDoc+vxqGL
	1jor/PekNcFzoYt+9d6kK5+SPfQcA1t6O+jq8pFIbmvIynVwDdRPn15bFFLvBqNG
	+SYJdAEhTC0zFWxP50x/mgdQzXMZKSMVYhHlq6I/zbBpnWM/XyJrukNHo79Aqifg
	xqgepA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26x8nvaa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2026 09:44:42 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-845c733743eso2318611b3a.3
        for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2026 02:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782726281; x=1783331081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=29xDUNTed4jXAy3Mgxyo8ge5rsxJ/2Bn9rzkJN7OPjI=;
        b=BCU1AENsrcqamFZ943Wr3D+TobYkJSw4NxAhAS3Zd5wrB2B0sePMXGg77+hLiMdDuq
         5ZcKsw1epLRW3uY+6lMfWGhbdJACIJdn2GPbtoRNeHvDmAGgnOcQLGbUU0vZX+LqF+bY
         VFs82o/JfeledXZOzm1JoQu6s4je1ErkQlSVlaUuKxJaJDizGXFss2JIsKz9GJFwYwJx
         /o52mLwJU2QZMRZuYJ7I4jpiIRmRPS7Y2kDAi3YDW1t1y+hSuWfEveloBmuXQCZ2xbfs
         1t7lrkm5Vmm5BcavnefQCDVfPb1AKsLH+603/Bd7kd5v6C7nYnIWlNWSf2ws3uycyAtt
         qcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782726281; x=1783331081;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=29xDUNTed4jXAy3Mgxyo8ge5rsxJ/2Bn9rzkJN7OPjI=;
        b=OS5Kq8Evpe236Gww20GHZcgOh4LU/Ph5p39S8zqAl/oOf+5FMBIJhwe/tqZswEXxaw
         P5JFZnOp8EJ7fOV4T12zK+lH1+K978z+iQiiEiWU0cEEhZDq8HRK3PFmy+ojxa9fY7yM
         WfLWoXa9CkkZbfZV2LO51cvImZJTDbh5tPu/rHNafHff/21fTraMSXc+MP0Qf5SKXIQR
         RCadkPNTAggMWjSNNgjkdUW/vVW2j+IUUpqNGreUrpuNRTU2lTBoIy4TScUnv4uCuqIy
         kMmxGLZV2Kzl43gMdZSVDLP+Brx188QyCBqMMgWqADA3tW20YEGwe6G5+y2avmspky2U
         vEUA==
X-Forwarded-Encrypted: i=1; AHgh+RqgzZvsdm1h7/4xfRTlj9AkInl//8OYbOzHlNC8r3BWU9tl+obGoqyMKSc+XjRwbUQWp82Cil7IdTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIWCRrpxfdUOswIJ5xMK1z3cMSG5azZmSKn7LtHbDS1MrhK+FB
	Nr+/vOEuRKY09k4t4UMRqZUWo+SXP08Rmy/SO7nEQHIK8URNEDU+NsGgXc+VJ1guXkmb0f5Qi2R
	FXjnnWq9JohfcH7ldkDWWyeCzTZstv4vY/ITWHa5GG+a+ccQMpFgwTvIukBWUAvA=
X-Gm-Gg: AfdE7cnMYp7ycPgKv+lcxP3zWhUsXiXXY5pbiEtz3aYDKkHLcmai9XzzKZrVwmHhjsD
	lEz7nZPVjgZoCU6Y3cy5lQPM+Om14LtSEjSVz0cr9MGvNibPqIk7+WOQ+XcztR3ScVnFPLeG9CO
	c2aplfcTf2/8xCg/EMsTjtLkyi96gMbbm3pd8d5pRCXypLBHYgUOPyySoxv/JIW1xKedVgpu/Ud
	kt7FJhcI1ozWMN1a4CAjAwLYA45CgYvXvcBnTIThEpFMs0/JjgSeQWuHR7VxRwd3P7btkF4IgV/
	RbYDwQD2VrKvbJ42V/nC8+T9FZdoBsMeWeoHiuWGcrrWJEgF3ciFrUG5p0rESWgcwBiHktaBZL9
	o7UrZSfxutcIK/XIFhnXtBMmxRdheG2P+MxC9jGtMZECgaSj1WUiDfGxBIY73fEYtClXraqddFM
	WbamtOAA==
X-Received: by 2002:a05:6a00:2d8d:b0:847:9692:5cb4 with SMTP id d2e1a72fcca58-84796926134mr348462b3a.53.1782726281029;
        Mon, 29 Jun 2026 02:44:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d8d:b0:847:9692:5cb4 with SMTP id d2e1a72fcca58-84796926134mr348440b3a.53.1782726280533;
        Mon, 29 Jun 2026 02:44:40 -0700 (PDT)
Received: from [10.133.33.8] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847833efe03sm1741991b3a.44.2026.06.29.02.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 02:44:39 -0700 (PDT)
Message-ID: <b2f3eb30-ff30-423b-aa8e-3cdf47aa600f@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 17:44:35 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] Add device-specific reset for Qualcomm devices
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, bhelgaas@google.com,
        alex@shazbot.org, jjohnson@kernel.org, linux-pci@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, mhi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20260623183115.1585273-1-jtornosm@redhat.com>
 <4cdfb71b-2ef8-4985-8294-c4a29e37faa3@oss.qualcomm.com>
 <l3pcelhxn46p4smkkg5yob5enf4d4garp2p6macopnq5h2gwyf@zbbn65k4tz2q>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <l3pcelhxn46p4smkkg5yob5enf4d4garp2p6macopnq5h2gwyf@zbbn65k4tz2q>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3OCBTYWx0ZWRfXxBjloiBfeap2
 poYxR8VAIzPS26zwhwel+JZTH+x5DdvyuOkeUbL2+OJ1/DFnZHHCBdNBziqrS53jo9nmtYnM8qx
 4J96m/xAIQJipLjrzS7CGzyd10rBl0Y=
X-Authority-Analysis: v=2.4 cv=D+N37PRj c=1 sm=1 tr=0 ts=6a423e8a cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=RRcNAnSy7hG7cj1Ejq8A:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: A8FQOowIsAkLLzsX5cW83Fui9DdWkCgt
X-Proofpoint-ORIG-GUID: A8FQOowIsAkLLzsX5cW83Fui9DdWkCgt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3OCBTYWx0ZWRfX0+te4mcBEg5U
 ksS3wdtYm18f6Aky0nYs5a1YH+JhrC6CZh+09Fi6heU2rVCS1LdmhuG6fhh0AkLJWUntM9EvwCF
 bT4lTPjziC5jsB6w6/hsuiWbP0aM1fvSG5FXym5vHpA7MJ5jRgHAGD8LjgWoyEm+iBwv/lee9tF
 5oQXxs+uDYnmbbX5FjhOAz6DLA+sMUH4z+vSTwAnCENbtbMthsI/pTj1Palb5TKo91PoeDcjbwF
 MLSgSir4cqBIE/MR3ayskBhlhwp9FQ2VzdLcg3Y+8w01u7Gedzzd5gElIyCAN6wVgAEyfhHvwwE
 yZlEvDhZp0AYkEERbQ5PpPq/BJvx7FTyhBSxmX5bZYhuhfe12RQT/1G3+9m91lfhom79L5nFu3p
 7P7IrM4ZVVdkQfQlP9NgWaPDemo8MEtIdeg7Wk9Y3jfLtQ1WLf3TgSzgy+fX8toMUeknnbBQ3LY
 YRSeDAo6tsB6DK3dT2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290078



On 6/25/2026 9:03 PM, Manivannan Sadhasivam wrote:
> On Wed, Jun 24, 2026 at 03:47:12PM +0800, Baochen Qiang wrote:
>>
>>
>> On 6/24/2026 2:31 AM, Jose Ignacio Tornos Martinez wrote:
>>> Some Qualcomm PCIe devices (WCN6855/WCN7850 WiFi cards, SDX62/SDX65 modems)
>>> lack working reset methods for VFIO passthrough scenarios. These devices
>>> have no FLR capability, advertise NoSoftRst+ (blocking PM reset), and have
>>> broken bus reset.
>>>
>>> The problem manifests in VFIO passthrough scenarios:
>>>
>>> - WCN6855 (17cb:1103) and WCN7850 (17cb:1107) WiFi devices:
>>>   Normal VM operation works fine, including clean shutdown/reboot.
>>>   However, when the VM terminates uncleanly (crash, force-off), VFIO
>>>   attempts to reset the device before it can be assigned to another VM.
>>>   Without a working reset method, the device remains in an undefined state,
>>>   preventing reuse.
>>>
>>> - SDX62/SDX65 (17cb:0308) 5G modems: Never successfully initialize even
>>>   on first VM assignment without proper reset capability.
>>>
>>> Add device-specific reset methods using BAR-space hardware reset registers
>>> that exist in these devices:
>>>
>>> - WCN6855/WCN7850 WiFi devices use SoC global reset via BAR0 (sequence from
>>>   ath11k/ath12k driver: ath11k_pci_soc_global_reset(), ath11k_pci_sw_reset(),
>>>   ath11k_mhi_set_mhictrl_reset()):
>>>   - Write/clear reset bit at offset 0x3008
>>>   - Wait for PCIe link recovery (up to 5 seconds)
>>>   - Clear MHI controller SYSERR status at offset 0x38
>>>
>>> - SDX62/SDX65 modem devices use MHI SoC reset via BAR0 (sequence from MHI
>>>   driver: mhi_soc_reset(), mhi_pci_reset_prepare()):
>>>   - Write reset request to offset 0xb0
>>>   - Wait 2 seconds for reset completion
>>>
>>> These are true hardware reset mechanisms (not power management or firmware
>>> error recovery), providing proper device reset for VFIO scenarios.
>>>
>>> Testing was performed on desktop platforms with M.2 WiFi and modem cards
>>> using M.2-to-PCIe adapters, including extensive force-reset cycling to
>>> verify stability.
>>>
>>> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
>>> ---
>>> v10:
>>>   - Complete redesign based on maintainer feedback (Manivannan Sadhasivam,
>>>     Alex Williamson): use actual hardware reset registers from
>>>     device drivers instead of D3hot power cycling
>>> v9: https://lore.kernel.org/all/20260612142638.1243895-1-jtornosm@redhat.com/
>>>
>>>  drivers/pci/quirks.c | 118 +++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 118 insertions(+)
>>>
>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>> index 431c021d7414..8ad3f214e520 100644
>>> --- a/drivers/pci/quirks.c
>>> +++ b/drivers/pci/quirks.c
>>> @@ -4240,6 +4240,121 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
>>>  	return 0;
>>>  }
>>>  
>>> +#define QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET	0x3008
>>> +#define QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET_V	BIT(0)
>>> +#define QUALCOMM_WIFI_MHISTATUS			0x48
>>> +#define QUALCOMM_WIFI_MHICTRL			0x38
>>> +#define QUALCOMM_WIFI_MHICTRL_RESET_MASK	0x2
>>> +
>>> +/*
>>> + * Qualcomm WiFi device-specific reset using SoC global reset via BAR0
>>> + * registers.
>>> + */
>>> +static int reset_qualcomm_wifi(struct pci_dev *pdev, bool probe)
>>> +{
>>> +	bool link_recovered = false;
>>> +	unsigned long timeout;
>>> +	void __iomem *bar;
>>> +	u32 val;
>>> +	u16 cmd;
>>> +
>>> +	if (probe)
>>> +		return 0;
>>> +
>>> +	if (pdev->current_state != PCI_D0)
>>> +		return -EINVAL;
>>> +
>>> +	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
>>> +	pci_write_config_word(pdev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
>>> +
>>> +	bar = pci_iomap(pdev, 0, 0);
>>> +	if (!bar) {
>>> +		pci_write_config_word(pdev, PCI_COMMAND, cmd);
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	val = ioread32(bar + QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET);
>>
>> QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET is beyond the first 4K bar area hence requires MHI
>> wakeup before accessing, see [1]. the wakeup callback for WCN6855 is
>> ath11k_pci_bus_wake_up() which calls mhi_device_get_sync(). Not sure how this can be done
>> here. Maybe Mani can provide some hints?
>>
> 
> I don't think the device needs to be waken up before
> QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET. ath11k driver wakes up the device for
> accessing the MHI interface I believe. Since this callback is not touching MHI,
> there is no need to wakeup the device, AFAIK.

MHI register space is constitute with 3 segments, with mhi offset always being 0, bhi
offset 0x100 and bhie offset 0x224 (the latter two offsets are for WCN7850, but I think
also apply to other devices). That said the whole MHI register space does not go beyond
the first 4K region, hence wakeup is not for accessing MHI interface.

> 
> - Mani
> 

