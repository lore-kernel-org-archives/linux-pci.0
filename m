Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5D7365A14
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 04:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788324785; cv=none; b=CIDUEtGu67tkh49VW6jMG4YBA5M+qP2L9cGlqhX5RuSk+Rgcsm4IdeBJ2zIoGzAthXhzA20fJDdHrLAn4xjfxtuQN0ZnScESWFP83gH7LY6Ldnvyk8QqzakF7EMiyxqegLxLRqq2ENpNHtCPfTVVTg5Xcc8YdwUYHnBcUCw9eRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788324785; c=relaxed/simple;
	bh=lzwBvj5rCRwC9vpohTFNC3A3Mdt/eIKsHDElx/0cUzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Je+yRfpUi4rJ5XHxXsUYHIwo0HsdxAn1+zDebUYdd6AXkwgaQ2gUObSw/vYjcHKPO0EpHC+tS+G0ZpwB+e6KsK7UwVKAIIfDWCRKTOkDedLcY8a5AlP+8i9wc3vdmVepxpOd7s5VQxrjvNq9FS44x6Ir7dz0XAZFbr45/EmPN8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U4UyBEj7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LaL1zUzh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U4UyBEj7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LaL1zUzh"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681KTRTY3048691
	for <linux-pci@vger.kernel.org>; Wed, 2 Sep 2026 04:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IpYFqn52MzyyerSAhaJx9+MNvz9oY9L3KfTClhX+lTk=; b=U4UyBEj7NkKGWdyG
	q1Mw86N1eMYbj6BtBltl9J7A3Z+rgCHPb119lZGYX+tbBY/HGzzj3TpPCEBcetXJ
	4XHJtslfDYoCb3ffmVQ1PqrqP5lWLoidDLlug+RFQ8pZQ03HVcOwjQTD5QWaU5en
	3UxryAXhnO3d6IlcYOZedDq9+5OwmRb3zyi3c3dgniofwggkfUMXuJ7hfiBeWg0a
	wHvcYZnf0YVm352Hgqbz8R7aioJPAdQUFgTWonWPAfzzCd4xJw9yEpq2F9nMje8n
	7hz+fD5fMjARQL6AApAJ7wgacICECaAMu452SzxLIDvqWIs+YU0ZbsB9L/oM2rxu
	Rn/CFA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge397a628-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2026 04:53:00 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-398ba5404d2so915687a91.1
        for <linux-pci@vger.kernel.org>; Tue, 01 Sep 2026 21:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788324779; x=1788929579; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IpYFqn52MzyyerSAhaJx9+MNvz9oY9L3KfTClhX+lTk=;
        b=LaL1zUzhlhZYmx99JcqRHY1Au9CYg8qCu6FnA9fB+knjWPAc/AlrOgqzT7HdWj5Twi
         bxTZF9hby9JBZGslTp4QZ4n3RQ6Q0cHUpxcIzLD3bVDeZTA3CDEkz0MqfhgR8Dw2Lu/A
         eb5b2+8yG/QDcSJPyKFXsISF6eSG+e3IoZ5bMrmI8VSUvqAFhCKenuySBGdkSjRPWNUI
         ZNaxqJ1IfONRlhZ5Dt4wHdJwSimMB495ROkKdOKFospGBzShKiecBM7IOFd/m8wu655y
         kyczeuR/m/YqkmdqKLzjBi3fRZykOKcQKRmTBEVB2P39vNaz4udyLC4ru0C8DvDpmjzJ
         t5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788324779; x=1788929579;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IpYFqn52MzyyerSAhaJx9+MNvz9oY9L3KfTClhX+lTk=;
        b=kRYG18Y6nK4WjOGZGQqC/g1AJ/dv1sFrpwrvRlj+qU0Aqy9Skn6xPbgk8PmIHknav6
         Ziwc4jCq319HNV+2Xt9l8mz0GWeKJJ12da6qVkpb+QKm12PNlBVzC3lQL4bb43oZMU1y
         kH/dxODGnt1bUcaeBTzNW+3ApKpqbPo4R8R1xsMx0/kOVPKz7QAuTocEHkQ3O/uY5pQQ
         l5oIcQLBhQ4byouBKaKA8rt6CDYqchFzuUNzNC5YIjhtxPgo5UPQleM4UQUA9WBS1Y+z
         3ptIVDCzKrdbADEVEOyrdxd8n8nVloLORvYd+EFPaKGSNs7Pdhp9lkxN1ZqBrPynRGtt
         J5Ag==
X-Forwarded-Encrypted: i=1; AKwUvBynJfVk6gg/smzK41CRhK/OgmyFiJLbZMwfqLeU3JwadUxK2z4vgvBvNX0l7J5ZbNlxmCMQYb9nMEI=@vger.kernel.org
X-Gm-Message-State: AFuF++k0+oZKnHBKH3Yoxpn8jw8fI8g5nn0sqzorB2t3F3PQEcon4ZWk
	EKs8QqC8dviB08ipIZdPjQjwOR89tWqnqI5F3BpsJkre0n++/kX9kEbTYTe7DPnixMCrOqm1adx
	HtoJlUVtQh+C8L/f0Y76uaMDTfQ3miKom5YXk5lEhNIWPANwgpW+UkXqdwbvCaoA=
X-Gm-Gg: AYBFou0xiMHiXz2iB8J6rSN7yTYUyNUSc3m9pwa8eEdmfSUiV/2G3rtfjuaNkd4CzsW
	tB87uqo4OXoehFl6gBji7SLKonjNhLawM9z8fRNNb/q7W/hz0/10Vyu9Y5UAKTofkR/rhLhf7q4
	b9B2dwXVP86sGy4bs+FIiCFmai7EjC0knkApKfOwKepXxQ8vcERwJQ+3nDvYughCAJ5GcTYoW8l
	xRme2UQ3JrSkJ79o+wYOem0bXD5YweZhFhipJ1yp/dfbc3eAhe2r3MQyR+a/Y0gRxWbUW2l3Lc1
	8G1yecnENSGiqZFOCP3uVi/pyH91PDbOIqfpywvfPKQpdKJhXSO6uCTLEm4nAevcuJ690I03vnu
	olHx7pfWBrSSGCI9DRn8SBA/ZUhlsX2Ma
X-Received: by 2002:a17:90b:35c8:b0:393:194d:5366 with SMTP id 98e67ed59e1d1-39aedf43130mr3258285a91.10.1788324778535;
        Tue, 01 Sep 2026 21:52:58 -0700 (PDT)
X-Received: by 2002:a17:90b:35c8:b0:393:194d:5366 with SMTP id 98e67ed59e1d1-39aedf43130mr3258234a91.10.1788324778096;
        Tue, 01 Sep 2026 21:52:58 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14310adaeaasm1068788c88.10.2026.09.01.21.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 21:52:57 -0700 (PDT)
Message-ID: <5c3f1611-275e-4664-b3e2-748da6d210ed@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 10:22:51 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] PCI/bwctrl: Set host bridge OPP and optionally
 disable ASPM around link retraining
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com
References: <20260819-bwscale-v5-0-6dea79786b37@oss.qualcomm.com>
 <20260819-bwscale-v5-1-6dea79786b37@oss.qualcomm.com>
 <atba2336nxz566wvbfrvclbx7yyma5elhnojb7ozz4ku6dk3q3@c2wa24laiqyd>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <atba2336nxz566wvbfrvclbx7yyma5elhnojb7ozz4ku6dk3q3@c2wa24laiqyd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA0MSBTYWx0ZWRfX1naJONut+wFD
 WVoPdTIhfBq638T46JSi8M7rx89m00EZLmNRsQLCLLaNAvtvy1eBheJfo0Vj3P9KS8Le4ogfuvw
 AiLjq0D3EeGzp2+kKLspVVu1WaLW4TQth+UZJtps1PU9E2b5yQiRybD+YaRPWHRJn0wSXClwtb2
 fdj3wtt8UFtgdsfwkajeuH99cSIlivKPz72byOMpxRsHiIzEjZTTvrjwCwIHfR29Wtpzp1Am0pc
 OYyQSwWtyMUdTh5qvnvXVixisj4qijN1nHC2p7anD/0R5uFy4oGfuaFECBcTaZ9e4lfy0pc/Iv6
 cS+dayK45+XMIYS/UybuN7ZsBp9ZLvemdcyxpm5zBtYAolQx1RpKlUy/nRXBIy1AVlmFcP129EJ
 cxE85dr1K5Ij9JAxsvfGxvAUiu1/lMaSilgauTF+RvZQVkOP7Y3Ay/lw2ndYCL++U+fvh3n5q9S
 uC+mRWOJTM55sVoM7sw==
X-Proofpoint-GUID: IPBSH94Iefz9cadj55y9BhRE4lLID_cW
X-Proofpoint-ORIG-GUID: IPBSH94Iefz9cadj55y9BhRE4lLID_cW
X-Authority-Analysis: v=2.4 cv=Re6gzVtv c=1 sm=1 tr=0 ts=6a97abac cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=6HI80psrSe5n1y8aGwAA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA0MSBTYWx0ZWRfX8G1nkjyC4rct
 9fSJBWJ33Jb+FmHlCgCTo5ymO4Wd5+C5gVT+U18sd+n4e4nzXcaT03Q8IiKVMer0zd/3k3FWD16
 xpBMekLL44ZVdHvfPQVIvWWpalaUwXE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020041



On 9/1/2026 1:12 PM, Manivannan Sadhasivam wrote:
> On Wed, Aug 19, 2026 at 06:55:52PM +0530, Krishna Chaitanya Chundru wrote:
>> PCIe host bridge controllers may need their operating point raised before
> Use either "Host Bridge devices" or "PCIe controllers".
>
>> retraining to a higher link speed so that hardware resources (e.g., RPMh
>> votes on Qualcomm platforms) are available at the requested data rate.
>> After retraining, the operating point must be updated to reflect the
>> actual negotiated speed.
>>
>> Add pcie_set_opp() to look up an OPP on the host bridge parent device
>> using a key of (per-lane frequency in kHz, LNKCTL2 Target Link Speed
>> level).  Keying by generation rather than total bandwidth lets OPP tables
>> remain width-independent.
>>
>> In pcie_set_target_speed(), call pcie_set_opp() before retraining only
>> when upscaling (speed_req > cur_bus_speed), since only raising the
>> operating point requires pre-staging hardware.  After retraining, call
>> pcie_set_opp() unconditionally with the actual cur_bus_speed to settle
>> the votes.  Both calls are skipped for downstream ports of PCIe switches,
>> as those are outside the host controller's scope.
>>
>> Some controllers also require ASPM to be disabled around link retraining.
>> Add a disable_aspm_for_retrain flag to pci_host_bridge; when set,
>> pcie_set_target_speed() saves the child device's ASPM state, disables all
>> ASPM link states before retraining, and restores them afterward.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>  drivers/pci/pcie/bwctrl.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++-
>>  include/linux/pci.h       |  1 +
>>  2 files changed, 63 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
>> index c4c8d260bf96..6fa1522c47db 100644
>> --- a/drivers/pci/pcie/bwctrl.c
>> +++ b/drivers/pci/pcie/bwctrl.c
>> @@ -28,9 +28,11 @@
>>  #include <linux/mutex.h>
>>  #include <linux/pci.h>
>>  #include <linux/pci-bwctrl.h>
>> +#include <linux/pm_opp.h>
>>  #include <linux/rwsem.h>
>>  #include <linux/slab.h>
>>  #include <linux/types.h>
>> +#include <linux/units.h>
>>  
>>  #include "../pci.h"
>>  #include "portdrv.h"
>> @@ -120,6 +122,38 @@ static int pcie_bwctrl_change_speed(struct pci_dev *port, u16 target_speed, bool
>>  	return pcie_retrain_link(port, use_lt);
>>  }
>>  
>> +static int pcie_set_opp(struct pci_dev *pdev, struct pci_host_bridge *host,
>> +			enum pci_bus_speed speed)
>> +{
>> +	struct device *dev = host->dev.parent;
>> +	struct dev_pm_opp_key key = {};
>> +	int ret, freq_mbps, width;
>> +	unsigned long freq_kbps;
>> +	struct dev_pm_opp *opp;
>> +	u16 lnksta;
>> +
>> +	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
>> +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
>> +
>> +	freq_mbps = pcie_dev_speed_mbps(speed);
>> +	if (freq_mbps < 0)
>> +		return -EINVAL;
>> +
>> +	freq_kbps = freq_mbps * KILO;
>> +	key.freq = freq_kbps;
>> +	key.level = pci_bus_speed2lnkctl2(speed);
>> +	key.bw = 0;
> 'key' is already 0 initialized above.
>
>> +	opp = dev_pm_opp_find_key_exact(dev, &key, true);
>> +	if (!IS_ERR(opp)) {
>> +		ret = dev_pm_opp_set_opp(dev, opp);
>> +		if (ret)
>> +			dev_err(dev, "Failed to set OPP for freq (%lu): %d\n",
>> +				freq_kbps * width, ret);
>> +		dev_pm_opp_put(opp);
>> +	}
>> +	return 0;
>> +}
>> +
>>  /**
>>   * pcie_set_target_speed - Set downstream Link Speed for PCIe Port
>>   * @port:	PCIe Port
>> @@ -140,9 +174,12 @@ static int pcie_bwctrl_change_speed(struct pci_dev *port, u16 target_speed, bool
>>  int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
>>  			  bool use_lt)
>>  {
>> +	struct pci_host_bridge *host = pci_find_host_bridge(port->bus);
>> +	bool is_rootbus = pci_is_root_bus(port->bus);
>>  	struct pci_bus *bus = port->subordinate;
>> +	struct pci_dev *child = NULL;
>> +	int aspm_state = 0, ret;
>>  	u16 target_speed;
>> -	int ret;
>>  
>>  	if (WARN_ON_ONCE(!pcie_valid_speed(speed_req)))
>>  		return -EINVAL;
>> @@ -152,6 +189,24 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
>>  
>>  	target_speed = pcie_bwctrl_select_speed(port, speed_req);
>>  
>> +	/*
>> +	 * The host bridge driver may need to be scaled for targeted speed
> "Host Bridge resources may need to be..."
>
>> +	 * otherwise link might not come up at requested speed.
>> +	 */
>> +	if (is_rootbus && host && bus) {
>> +		/* Get function 0 of downstream device */
>> +		list_for_each_entry(child, &bus->devices, bus_list)
>> +			if (PCI_FUNC(child->devfn) == 0)
>> +				break;
>> +
>> +		if (child && host->disable_aspm_for_retrain) {
>> +			aspm_state = pcie_aspm_enabled(child);
>> +			pci_disable_link_state_locked(child, PCIE_LINK_STATE_ALL);
>> +		}
> You mentioned that the Host Bridge requires disabling ASPM during retraining,
> but here you are disabling ASPM of the downstream device. So the issue is device
> specific or Host Bridge (RP?) specific?
Issue is RP specific, if aspm driver disables the ASPM only when we pass the
child, if the we pass root port dev, it will just return without modifying the
aspm.

Ack for remaining comments.

- Krishna Chaitanya.
>> +		if (speed_req > bus->cur_bus_speed)
>> +			pcie_set_opp(port, host, speed_req);
>> +	}
>> +
>>  	scoped_guard(rwsem_read, &pcie_bwctrl_setspeed_rwsem) {
>>  		struct pcie_bwctrl_data *data = port->link_bwctrl;
>>  
>> @@ -176,6 +231,12 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
>>  	    !list_empty(&bus->devices))
>>  		ret = -EAGAIN;
>>  
>> +	if (bus && is_rootbus && host) {
> Maintain an order for this check. I think this order makes sense than the above
> one.
>
>
> - Mani
>

