Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311952EEE65
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485682; cv=none; b=r8UgzoI4l7bZwazE7QtAZyG6WdXS1wut15jl3F6MnDBcQMM3J+QlK35BaKSemVjq6b6qRjhgXZbsEwZ9QNbrqWSlKfqVE+BQ5i9xeTH9LLY138xAFZ1WEniYoAQw9Q0ctL9/3TevZEDYtXysmT/czeP7GFMGB3ZIMbn+fBz7q/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485682; c=relaxed/simple;
	bh=UCwkJAe8P1pYFdk06PaNaKtvagHVUYsw8cugPruxH2E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=To56PYq5vfIKAHGFYJVBuFpgWF+ffaKKvMlx+hUvi1CcvMZa8I8UrwrcUV3pELzCWuNAxov4lr05VL1ZqFZ0H4zL+Pdn6+orXf++7nRKXMR7ZLUO93kloIJf3vHjRCtj1y+8vDaddD+5l2CXVGWxnSvFaeu3SmwXy3JsmGK6Oe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nZ1SMgbC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bEMRcbsa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nZ1SMgbC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bEMRcbsa"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QAe882607340
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 14:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mYWJkhNIK4vEw8z7nhJCveZpwInyCIrXGAzZOF/vmPE=; b=nZ1SMgbCdM6XOVR1
	iinWb5Si+AAILW4f57MbZ3eRlU/0q35t64nBbizVTVbZNFoCH6nvIkJw6hJbEHtW
	5JVJwD98DI77lkVNqJYPkXVJrvDn32XrCQKSSL6DRJyBW4AjxnXz2xgVJibIytrg
	XyJgoblrtq6VLyEn1JzepHwFwNgBz7bjPYJSzoi+v/HMjobPLtCLK4lqG5+mkO5e
	v7pWy6tPs55DZate5bFbwqrP5j1653J4BDTV/diUTNIHTyKEanmzCmPJeVtKTCOu
	hnkIY9O9h0VSxqx5Oq9mNrT+wH3y8zSeLobSTP5OUTjIbYtQxtoTyhpqi9V24eLU
	p4KcMQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1asjc0dn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 14:54:40 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c7cfa17fe6so15010925ad.3
        for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 07:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782485680; x=1783090480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mYWJkhNIK4vEw8z7nhJCveZpwInyCIrXGAzZOF/vmPE=;
        b=bEMRcbsaOmbvXZtzUT/8Ce2FaOZNNCPhXTwPX1NUdYkgvIphZPIuF3K+nDCVrTuJLS
         z3uxJSzuKiEWGSgKc6l2WGbPwgWqfQ5ZyAAwcYdPCBjunkN21Zq+H7XASH3Pth8YcUGD
         Vs7TF2pokefWxzn8udYaZs7NHmLm+uIMHMkwpaHslvj37/14N6oXN82lPxUvQePAuq8h
         tLwRmAmcB88YPwJA8omIQyiTKpY5TEZEHXchFit8gU01pbWIeqopIoScOGkEZrjaE27f
         dhFc+BahIbUc/r1fSx6xtyvYR2U/un/AfamA2WqZ0lR5nIFW19dUDvfLuMSZIjG/Ah0U
         7PaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782485680; x=1783090480;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mYWJkhNIK4vEw8z7nhJCveZpwInyCIrXGAzZOF/vmPE=;
        b=OwzIwg+ukkAcKSmjaNnPEUo7sJGiOPgq73yHmrqKbKxUcCfWvBuR4L40TazDETUIiD
         TiVaRGv9tIqU2uZbnb2XHJNYhV34PLiV4bNU1JT+oX9/V8quC7yTgOHvIr2Z8NPGLApy
         mBvFqbBWmGa+v6WaZwo2UMG3STzwyo5DpXM+rsPEeei17BEET1Ikfgxv4iaEEQqxK1/y
         gpnSvr3CBONzXafmDGOpHBXn1DvcD9gQr4FcIUc3vlHaghUNVw7bd8gC4hjxL/ue+L4x
         Sup0ZzeswIMi7RJYmHj11NpW6CbR/eRbgzS2KsmYxT/wOZ0M0ublsABfEu1AqdWwkaq0
         4WQQ==
X-Forwarded-Encrypted: i=1; AHgh+RrAngW/kneMXHzua3MtRqNviGVR5KpFS89RtjdYMQF3BLSKFb009HbrABWX32a0pUn0Fj+icYvtlKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIY2A1dq5RF22qKfY0Qep03qKcEF1xmlgZ4YpRWzPwhgDW1Jmi
	DRTjR7lNDugPmubGuVbnyGPNv1br/jaor0Ie3i1rMeay8UdtcwoKSaUHryqDzuz5hAaAcmr04m7
	tDsPCyaBIljOiZxk/Sd7rx80Fvhs30Pq6sisFFVSYr9Akuo+q5VHWARu1V8JTjiI=
X-Gm-Gg: AfdE7cmhkle7W3RhYwDNEfiPpvE9+VTo8KbmUCJLbBxxt0/RdGKEoVqzGFHJAcZI+aK
	jGS5qUuU3VJ5JMIwH3Wb0xddODX4O9X5BKQH1Vx0wqDvU19cYTVlb0NxPdTLtHpDpUNY7a2Q+nK
	yZ0fhzTz0EgBOiZmy3Pz/+idPVaPnmlmv/yhwy9i+M8SIeN40OXkCqLluVJ9LnxUaA3jcaCRpq2
	LO5kuUiu8tMpOjDxFxbdrCqSclhbzc1DlSGeRVpDxe80rtIy4JgM+8PKAX9sYiY1SUg8GS2jWJc
	ZAcHOMYJvHfeawIXaNPPJ/7KUdmO2W2eMr1S+DLlVd1a6se7ej1UxFYd23WgXGMNTwAX9JoSR1P
	APzY1kOHFHLB+cb4poP6Sp5nk1y2qg25rK0Q=
X-Received: by 2002:a17:902:c40a:b0:2c0:a555:80e6 with SMTP id d9443c01a7336-2c7fc654109mr75502975ad.6.1782485679580;
        Fri, 26 Jun 2026 07:54:39 -0700 (PDT)
X-Received: by 2002:a17:902:c40a:b0:2c0:a555:80e6 with SMTP id d9443c01a7336-2c7fc654109mr75502655ad.6.1782485679097;
        Fri, 26 Jun 2026 07:54:39 -0700 (PDT)
Received: from [192.168.29.96] ([49.37.170.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5ac899esm41390565ad.7.2026.06.26.07.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 07:54:38 -0700 (PDT)
Message-ID: <2a52ecb1-be8a-4522-aa23-f3277f0555fa@oss.qualcomm.com>
Date: Fri, 26 Jun 2026 20:24:31 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: harsha.v@oss.qualcomm.com
Subject: Re: [PATCH v2 00/11] iommu/arm-smmu-v3: Add PRI support
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, robin.murphy@arm.com,
        jgg@nvidia.com
Cc: joro@8bytes.org, bhelgaas@google.com, praan@google.com,
        kevin.tian@intel.com, kees@kernel.org, smostafa@google.com,
        baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, skaestle@nvidia.com, mmarrid@nvidia.com,
        skolothumtho@nvidia.com, bbiber@nvidia.com
References: <cover.1779944354.git.nicolinc@nvidia.com>
Content-Language: en-GB
In-Reply-To: <cover.1779944354.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TO11jVla c=1 sm=1 tr=0 ts=6a3e92b0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=asHclmMlXTalQ/2ShlWtEQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=XZ8z-I0mWLgmP2cXQ10A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: jREgLHgp5vsQQgoTiw6OxnDHR4GU7n1m
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDEyMyBTYWx0ZWRfX6+TBh7D7Qd5m
 pr9sTEXGXVi4M+6OUs1I+QrHbqpSxTudwEndl+ypYe7XV4/2+pwQTPQ4snnG0a6//lPAgENw6tR
 bgLkfoal/DoiN8yZtJi8HZGbDKpFcQQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDEyMyBTYWx0ZWRfX8680P/5ZhbJX
 wM0MPjS1XDeLARUDAPdXcpgHetAjxhSsHuksjSn6RsLRLvEISG8oot2yX2j5M9UZNJ+K8fRBc7i
 /ynqqoyDk5o+6073ALNM569QHyjMj/Xh3mhjr9hRb6GfEQcxfdkoGfbmZkzwfikZ86XIT++D037
 xyaswuQmALzZGWVBJ2IkQbbqB6hyOrcN/Xc7JxnrzgGUmSa8xV40HmOkJP1PDvsvcu7dDxYvFDd
 ZyEAq7xaRSVE4S0XMlvjn3vOtkIQTdb9XEN/4EptlOhKkaT7v/sxg0z5gavpsEdGNXNzmsV4cp3
 RIyRbuBbvKDPwRRQ1Tchnp75sHimLUIS63xPKotogg9DeVJB/PtMbmEgMnOnMVqXj/afZhSBR5+
 GUkLja+ShD7IaZg2iqwUD/KX4+Xw53sJVvBS5vha32NZNKcfS4H9k82+xhTIjqXr2ZD6drPQlNF
 xuUu/A3HwVuyfaXxBGQ==
X-Proofpoint-GUID: jREgLHgp5vsQQgoTiw6OxnDHR4GU7n1m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260123

Hi Nicolin Chen,

On 5/28/2026 1:29 PM, Nicolin Chen wrote:
> The SMMUv3 driver doesn't handle events on the PRI queue or respond to IOPF
> faults. This series adds the missing pieces, using the IOPF infrastructure,
> to convert PRI page requests into iopf_faults and issue CMDQ_OP_PRI_RESP.
> 
> The iopf_queue_flush_dev() contract requires the driver to first drain the
> hardware PRI queue and synchronize using a threaded IRQ handler before the
> IOPF software flush. This drove the additional commits compared to v1:
>   - arm_smmu_drain_queue_for_iopf() drains the hardware queue to the PROD
>     snapshot
>   - arm_smmu_attach_release() moves the teardown outside the global lock
>   - synchronize_irq() closes the gap before the final flush
> 
> This is on Github:
> https://github.com/nicolinc/iommufd/commits/smmuv3_pri-v2
> 
> FWIW, engineers on the NVIDIA side have managed to verify the PRI feature.
> 
> Changelog
> v2:
>   * Allocate evtq.iopf for ARM_SMMU_FEAT_PRI
>   * Pick up Jean's PRI stubs and PRI export patches
>   * Enable PRI for PCI devices in arm_smmu_probe_device()
>   * Add arm_smmu_drain_queue_for_iopf() for EVTQ and PRIQ
>   * Add arm_smmu_attach_release() to rework the IOPF drain
>   * Add IOMMU_FAULT_PAGE_REQUEST_STALLS_TRANS for STALL mode
>   * Gate pci_enable_pri() on FEAT_PRI plus a non-NULL evtq.iopf
>   * Deny unrecognised-StreamID PRG_LAST in arm_smmu_handle_ppr()
>   * Disable PRI when no IRQ handler is registered (unique or combined IRQ)
> v1:
>   https://lore.kernel.org/all/cover.1772568590.git.nicolinc@nvidia.com/
> 
> Jean-Philippe Brucker (2):
>    PCI/ATS: Add PRI stubs
>    PCI/ATS: Export pci_enable_pri() and pci_reset_pri()
> 
> Malak Marrid (1):
>    iommu/arm-smmu-v3: Submit CMDQ_OP_PRI_RESP for IOPF event
> 
> Nicolin Chen (8):
>    iommu/arm-smmu-v3: Add arm_smmu_attach_release()
>    iommu/arm-smmu-v3: Factor out __queue_empty() and __queue_consumed()
>    iommu/arm-smmu-v3: Add arm_smmu_drain_queue_for_iopf() helper
>    iommu/arm-smmu-v3: Drain in-flight fault handlers
>    iommu/arm-smmu-v3: Support PRI Page Request in arm_smmu_handle_ppr()
>    iommu/arm-smmu-v3: Disable PRI when no IRQ handler is registered
>    iommu/arm-smmu-v3: Allocate IOPF queue for ARM_SMMU_FEAT_PRI
>    iommu/arm-smmu-v3: Enable PRI for PCI device in
>      arm_smmu_probe_device()
> 
>   drivers/iommu/arm/Kconfig                     |   1 +
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   3 +
>   include/linux/iommu.h                         |   1 +
>   include/linux/pci-ats.h                       |   5 +
>   .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |   1 +
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 244 +++++++++++++++---
>   drivers/pci/ats.c                             |   2 +
>   7 files changed, 221 insertions(+), 36 deletions(-)
> 
> 
> base-commit: 74fa4c177ad09800b007cba043370c887bb1b4e3

One thing I noticed while reviewing: when arm_smmu_priq_thread() detects
PRIQ overflow, partial faults (non-LAST pages stored via
report_partial_fault()) whose LAST page was lost in the overflow remain
permanently in iopf_param->partial. This is a monotonic memory leak —
it grows with each overflow event.

Intel VT-d handles this in prq_event_thread() (drivers/iommu/intel/prq.c):
     if (head == tail) {
         iopf_queue_discard_partial(iommu->iopf_queue);
         writel(DMA_PRS_PRO, iommu->reg + DMAR_PRS_REG);
     }

iopf_queue_discard_partial() was written for exactly this scenario.
Could we add the same here arm_smmu_priq_thread()
(drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c) ?

     if (queue_sync_prod_in(q) == -EOVERFLOW) {
         dev_err(smmu->dev, "PRIQ overflow detected -- requests lost\n");
+       iopf_queue_discard_partial(smmu->evtq.iopf);
     }

At this point all surviving entries have already been consumed by the
loop above, so discarding unconditionally is safe — implicitly matching
Intel's "head == tail" guard.

Best Regards,
Harsha Vardhan V
