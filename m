Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC37C3ADB92
	for <linux-pci@vger.kernel.org>; Thu,  8 Oct 2026 05:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791438738; cv=none; b=Tv4+CrpELA+d96Di6AzHjIhQFUdszUU+SshGmtbpigx/pSZOLl2uQob/BxXXI/69F7buL2EfntHkEuyE2xcFM/9GPapDszSyMaaXxw4KsypovZfwMWyLGtqnSKtXTZ5ovG748+wpHytZ6oioJqVmEsnzRDV9eG22cLLASf3GfhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791438738; c=relaxed/simple;
	bh=eQV9p9UYhsQ3ApYT0Wh4i0ldneTjolAW8NyWSQEXrtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EcZARWceR0e1luDyAjXd9rmshucvYrqp3Z15oJQ3g9O2I0Hl4SIGX5yHaVFokLpePO2JVC+95DM8TQDtUZo/I/01+KnnrNNK7HKEnxx3YgGfWJXqxqQ3qOJpGwQTOziuv8ZqrOzW8S1zUnLVYWz6kWWPmfnqzXaM7Z+YLaouoFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ny2TzCJV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RFhivXFy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ny2TzCJV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RFhivXFy"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6984BXAF1157823
	for <linux-pci@vger.kernel.org>; Thu, 8 Oct 2026 05:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eQV9p9UYhsQ3ApYT0Wh4i0ldneTjolAW8NyWSQEXrtU=; b=Ny2TzCJVR2wZYgLe
	QbVAU/dgqbupsn9ExdPxgbi6YZmWbKmmx8V5YH1dZFf9uB8kUnQcO3P8WvvgZVGb
	+ENAlmVMtF8R9+Q+s42e2mVu/xweeWKpkmC2+hT8lyJtdhCgn9iWRI11rg1z37sR
	ITodF/lToSxtGSWJrHNX+vh5fQyN9jXW/x64b1uEc8O+XEQh29Aiy5hGvClyQub4
	GNs4e5B0mdiYVp44k5NZ4uGyiyckfqIDMhRl/+3cDzv6FF/jKuY9K3mZn9lPdocY
	A2yvs+vYGUhg6TfqgEh+KvFE7FRVmOFIf8RMCdm1cNaHaE3mV4YMoIj2TVJa63y2
	RIpH5g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe51b5f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 08 Oct 2026 05:52:15 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3a813204f87so3433785a91.3
        for <linux-pci@vger.kernel.org>; Wed, 07 Oct 2026 22:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791438735; x=1792043535; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eQV9p9UYhsQ3ApYT0Wh4i0ldneTjolAW8NyWSQEXrtU=;
        b=RFhivXFyvvDLoJ0YGEt/iAGZjZq38JV+mjI6WiaVpFuLVt84WcPifRJjNgHyXQ/joL
         8KqF6yFAlqgs/jOocgjlRp8+KCrnOe9vytpKpQuXF3Nti7wN2oJKEHtdTahGtevJcyqV
         pVDiF2osuNj8G7r2C0zIGDgTS7J0who4ZR2OPXK/4vP81hZCPJwtFCb+E596DfFzbufz
         w2sZIbqTsS32edEBv3tcW73Oc9ZCw1nEvSFeBGZluFj5Vzp6hQ4Wqn+gL6OOJ4kNziOG
         gRr/d8OWjJXvvpI1ep3lOcqNPaikwm8gkeKdaxwTmYNpf8Q8z/GHlAH8JXObpefnf4qN
         m9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791438735; x=1792043535;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eQV9p9UYhsQ3ApYT0Wh4i0ldneTjolAW8NyWSQEXrtU=;
        b=GJZWtx4yOj/j1ZqITWzN0dwAYIVPctrMXDvDH7tozN1l4GQxG/njX2DivZA/uD5NYk
         1jlNIDtg4HnklZBlC6+63TBikVgtQOQVEEJABYLns5erGgGcuva5jpBMESDpTAiQ634/
         Vb2K7cHmNrxFg5E0kf8dg++l+hH+l3Os5tVbYzuceh8ZFCOZikU0kC56Ls18UWbiB3Ja
         jmPW+R67rJQ3Gl9aceSOqwCXxR0y9wCiAW1Usjx+Pcw9JpjmDGqECbG9AgOETjhEF+9l
         4XFI4fDdKKj9PiuBFLI+QoUlT8JwPgD339v7CW/dbG/q8u4wDT6hylaWc8GtY9jjDODk
         JKUw==
X-Gm-Message-State: AFq9FYIwE6BjuOJijuRylJHtBHrJswJGsykDe+q4LviywdEji3GyXXwh
	SnE9d8YvMDorjHiOGz1aA/vLlStcBbuhg27v9ZRiNWggEaUAjS/GPhBLrgxH9ZcbupS4lbtjJbF
	cAFXgWDmRW3zv3NEpjEwq8Hr+hpfbhMePhEim3jxZZcb9rIPcSntr+3Q5skr8EXo=
X-Gm-Gg: AYBFou1Jx9qCwjBK2zgSoa+fsV4T8ydtPWNGLGsdPVljeLmWJbQemqywK+O57pTunQC
	Oa4GrfFvdidWGyUUrmTyBnrFY4pqVmYn80S662VSR8x1t65xoH0j0ErjOalW+ok/jl9QE3WkaeR
	PrvDBK2HdBRtn7TdUmdJPnHixcD2eU6slBHNX1jAJYNioFe0V1D1JEmPZ2smW0NrD6Xu6VpsZeL
	xwRzx4eehjeRMv2l98/8ePVKKxftQJ76PIXbaa71+pMO4+i52Br/akSCucwJ18USPA6yNGi+pDj
	zetovcIIQsNMLIXKoMJNyPVaAA9KiGdIeUIr+ITRtql6rMysRUAd3yfZhwHgSzkDayI935qp588
	WGnbCrk82Q7piYV3p51DgongQoROutmq3
X-Received: by 2002:a17:90b:17c2:b0:3a8:10e2:acfc with SMTP id 98e67ed59e1d1-3a8a1ceec9cmr3579222a91.65.1791438734926;
        Wed, 07 Oct 2026 22:52:14 -0700 (PDT)
X-Received: by 2002:a17:90b:17c2:b0:3a8:10e2:acfc with SMTP id 98e67ed59e1d1-3a8a1ceec9cmr3579214a91.65.1791438734295;
        Wed, 07 Oct 2026 22:52:14 -0700 (PDT)
Received: from [10.218.42.145] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9f1a79babsm2629601a91.6.2026.10.07.22.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2026 22:52:13 -0700 (PDT)
Message-ID: <ad34ebc7-df81-414f-848c-0d5b820227b8@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 11:22:06 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] PCI/bwctrl: Set host bridge OPP and optionally
 disable ASPM around link retraining
To: Val Packett <val@packett.cool>, Bjorn Helgaas <bhelgaas@google.com>,
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
        qiang.yu@oss.qualcomm.com
References: <20260819-bwscale-v5-0-6dea79786b37@oss.qualcomm.com>
 <20260819-bwscale-v5-1-6dea79786b37@oss.qualcomm.com>
 <f189cfc2-c36a-4bf5-bac7-36ddb15cc7a4@packett.cool>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <f189cfc2-c36a-4bf5-bac7-36ddb15cc7a4@packett.cool>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: W7l2TywvvsDakQ-H5CHqVqwzoAjGXB3K
X-Authority-Analysis: v=2.4 cv=E4dYNqdl c=1 sm=1 tr=0 ts=6ac72f8f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=6HI80psrSe5n1y8aGwAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAyMyBTYWx0ZWRfX3GXw4SnMjz1p
 L38vsb0TbTUm15YLbzByAYnv9wzwn9dGALjlcusocpZQzXs60GdMlfwm0FENMvefsPAg9mpRe6D
 4hq1xZ5aI2mTNYxU9IZ5ZtjVn3BhSr0=
X-Proofpoint-GUID: W7l2TywvvsDakQ-H5CHqVqwzoAjGXB3K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAyMyBTYWx0ZWRfX93aF9Y8xm1Kp
 y3Py2M8FsagCEeTzrY0x+daoKdKP0wRWh4uXxB6qWtaGXUfVG/GxzJ2apciGDER1b41daetn5nM
 GCZQYLFZDwZVl2tZWW+cWukG96xXawPL1LG7aUsKhmd7B7Uixl5dwmrnuo1FhUbqTsj/bLlNRUL
 PB0wrn8ggTj06nQ54dFR8Sp8z5SWnLbwc/+DQBIRNmWa3G505j6C8olOjixIodUkdBbKn8mhUgo
 PWWjTxqUifF1UTQj+C9dU8/6/4MDtq86119C5uRXCk4z3SrSjaD7WOowNeobLbON96It7r000Fq
 YCJEUqlfhPtWy/uNtQokOHm4B2A9ukEsYcCGMXQjAUlLbuU6pepfzJsTPVShKJOCtRPezvb4Yxj
 aN5baq3lhxmEpPo+mo8/rqfE+cl6/cnE1X1EyEbLcxH3Mc5cmpFvZxYA7ZUsZRnZ+lVCpgnReGQ
 Sf1Ylp8ArA69VC7Gpew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080023



On 10/7/2026 2:41 PM, Val Packett wrote:
>
> On 8/19/26 10:25 AM, Krishna Chaitanya Chundru wrote:
>> PCIe host bridge controllers may need their operating point raised before
>> retraining to a higher link speed so that hardware resources (e.g., RPMh
>> votes on Qualcomm platforms) are available at the requested data rate.
>> After retraining, the operating point must be updated to reflect the
>> actual negotiated speed.
>>
>> Add pcie_set_opp() to look up an OPP on the host bridge parent device
>> using a key of (per-lane frequency in kHz, LNKCTL2 Target Link Speed
>> level).  Keying by generation rather than total bandwidth lets OPP tables
>> remain width-independent.
>>
>> In pcie_set_target_speed(), call pcie_set_opp() before retraining only
>> when upscaling (speed_req > cur_bus_speed), since only raising the
>> operating point requires pre-staging hardware.  After retraining, call
>> pcie_set_opp() unconditionally with the actual cur_bus_speed to settle
>> the votes.  Both calls are skipped for downstream ports of PCIe switches,
>> as those are outside the host controller's scope.
>>
>> Some controllers also require ASPM to be disabled around link retraining.
>> Add a disable_aspm_for_retrain flag to pci_host_bridge; when set,
>> pcie_set_target_speed() saves the child device's ASPM state, disables all
>> ASPM link states before retraining, and restores them afterward.
>>
>> Signed-off-by: Krishna Chaitanya Chundru<krishna.chundru@oss.qualcomm.com>
>> ---
>> [..]
>> @@ -176,6 +231,12 @@ int pcie_set_target_speed(struct pci_dev *port, enum
>> pci_bus_speed speed_req,
>>           !list_empty(&bus->devices))
>>           ret = -EAGAIN;
>>   +    if (bus && is_rootbus && host) {
>> +        if (child && host->disable_aspm_for_retrain)
>> +            pci_enable_link_state_locked(child, aspm_state);
>> +        pcie_set_opp(port, host, bus->cur_bus_speed);
>> +    }
>> +
>>       return ret;
>>   }
>
> ASPM is not actually reenabled here:
>
> LnkCap: Port #0, Speed 16GT/s, Width x4, ASPM L1, Exit Latency L1 <8us
>         ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
> LnkCtl: ASPM Disabled; RCB 128 bytes, LnkDisable- CommClk+
>         ExtSynch+ ClockPM- AutWidDis- BWInt- AutBWInt- FltModeDis-
> LnkSta: Speed 2.5GT/s (downgraded), Width x4
>         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>
>
> Because as the comment for pci_enable_link_state(_locked) says, "note that
> this does not enable states disabled by pci_disable_link_state(). Use
> pci_force_enable_link_state() for that"!
>
> This needs something like:
>
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 4bad311dc7..c54f2658e0 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1709,6 +1709,12 @@
>  }
>  EXPORT_SYMBOL(pci_force_enable_link_state);
>
> +int pci_force_enable_link_state_locked(struct pci_dev *pdev, int state)
> +{
> +    return __pci_enable_link_state(pdev, state, true, true);
> +}
> +EXPORT_SYMBOL(pci_force_enable_link_state_locked);
> +
>  void pcie_aspm_remove_cap(struct pci_dev *pdev, u32 lnkcap)
>  {
>      if (lnkcap & PCI_EXP_LNKCAP_ASPM_L0S)
> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> index 623731b96c..530b9047a0 100644
> --- a/drivers/pci/pcie/bwctrl.c
> +++ b/drivers/pci/pcie/bwctrl.c
> @@ -211,7 +211,7 @@
>
>      if (bus && is_rootbus && host) {
>          if (child && host->disable_aspm_for_retrain)
> -            pci_enable_link_state_locked(child, aspm_state);
> +            pci_force_enable_link_state_locked(child, aspm_state);
>          pcie_set_opp(port, host, bus->cur_bus_speed);
>      }
>
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 9f20bae6d7..59d7b67c9d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1960,6 +1960,7 @@
>  int pci_enable_link_state(struct pci_dev *pdev, int state);
>  int pci_enable_link_state_locked(struct pci_dev *pdev, int state);
>  int pci_force_enable_link_state(struct pci_dev *pdev, int state);
> +int pci_force_enable_link_state_locked(struct pci_dev *pdev, int state);
>  void pcie_no_aspm(void);
>  bool pcie_aspm_support_enabled(void);
>  u32 pcie_aspm_enabled(struct pci_dev *pdev);
> @@ -1974,6 +1975,8 @@
>  { return 0; }
>  static inline int pci_force_enable_link_state(struct pci_dev *pdev, int state)
>  { return 0; }
> +static inline int pci_force_enable_link_state_locked(struct pci_dev *pdev,
> int state)
> +{ return 0; }
>  static inline void pcie_no_aspm(void) { }
>  static inline bool pcie_aspm_support_enabled(void) { return false; }
>  static inline u32 pcie_aspm_enabled(struct pci_dev *pdev) { return 0; }
>
> (the addition of the new force+locked variant should go as a separate
> commit, but well)
>
> With that,
>
> Tested-by: Val Packett <val@packett.cool> # x1e80100-dell-latitude-7455
Thanks Val for testing and pointing the ASPM issue, there is actually patch
for this[1], I missed this new API change, I will fix in the next series.

[1] [PATCH v3 2/8] PCI/ASPM: Add pci_force_enable_link_state() API -
Manivannan Sadhasivam
<https://lore.kernel.org/all/20260708-pci-aspm-fix-v3-2-6bd72451746e@kernel.org/>

- Krishna Chaitanya.
>
> Well, tested without that too, but losing ASPM is not good :)
>
>
> Thanks,
> ~val
>

