Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C5547FAF7
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 23:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789514479; cv=none; b=BPB8Sv3kK3UUSXbqCm+yrXzCdvLiLyCyOydcx1ORXOSXF4g24OX4DqizuxYN8xlV4qbJfstoSeRjG+8+ORjdEeCHAnEAWI//38I5HEE0yce+cPawwd51OiZV1C5KVGwZxJPN2YaN82MNPy5QPZ6aWFACyrt7Y+dV/OaVABwSi+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789514479; c=relaxed/simple;
	bh=xmpAHbc0WkXgKRZPrvgHxoTAgIyKCkZGiPIgQRMRYVs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uew2zVQNNyhMpOsNk4WumG/ISaIz3QgFPYX+lfYQQszOrELjnt53s87qKq9UhWYbYfCS5e7zeV6+zADE1UD4Urc4oALuOKN/m5UCrVintd9IkW555+qWAwjxAe4u+lR0DCJ1Ma1VHnw5AFlFWhBrzSaON9nL5pt8X7JT5nUMliQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jVpHuJyz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MiB4s9tp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jVpHuJyz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MiB4s9tp"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLYxW0619923
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 23:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lyKoyOjIfv9w+YYrFTayF9TTz7lNx0qSbUIbPxqiGT4=; b=jVpHuJyz5nF9Pyx9
	Tj708RnGg7QJ+1opQNvo1W8ygwGxR6NC70o3BUHhcVherBpE514SfP+NY5+NPq16
	j2TH2PItWV2fIywzy3mtzfHg0lgKAaUrviCR+aXtDtivg3iBqMua5QrklRE+spVg
	2znFZG+ETjCzNKIu4wtcwYHzGNlkT9Z6FvloXPl37G8gW3rufmyQD6ps4SgC2FCx
	2n2U9z98pkQIsC2Mek1rhQ1m8e4153RORiqLYddRQY+OigO6AqFwi4xjmyChuRCL
	J04NkXLsAVm1dTJy1Lf83wzFU2uSUttWpWfyAaVdOGbIWMnTtlPh1IDJ00MFXoDn
	ESxApQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq2y2krp1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 23:21:16 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38ea32e57e2so9910202a91.1
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 16:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789514471; x=1790119271; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lyKoyOjIfv9w+YYrFTayF9TTz7lNx0qSbUIbPxqiGT4=;
        b=MiB4s9tpR53As5M4uME/YhkV45CRLV0wEYqOdZnwnsZg057Gp5U5W+3WFR5wbGbG5l
         4bgxsRVKC3Ix9KUmhJ3gfl87aHt0qIkpAnebhwdegrh6QKhsJuVY45yuUFVIU3R8SK+o
         lhPSQ8rvqjQUVnowHdjLRve/dk3gCaftybyVi4zqY3Qmr6/0ZQc/zDPcgc9mCAFDfay8
         SKHrPD4HrIix+nqh1DxlMN5LBLICB6h5LzYL0B/wdOTIHXkZ+mukmXEgFSlhkFctWhUj
         Mdj7pwLh5EVESg7WbbnvCJMjDAELxv9OXf8KfqOGW3ljBbsNhK4SEMoHziHcq/EkmmqD
         s7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789514471; x=1790119271;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lyKoyOjIfv9w+YYrFTayF9TTz7lNx0qSbUIbPxqiGT4=;
        b=gzMsO0i94LjZSTgWbgmNS6tMEf/C+infHVo4LJ+TirM/ltZn09GVJs3WOTKQbxCbdg
         LQDSOu0RczGplmxGyZEV3h7g1XDl88h1YxZWo/TPgTcHi+YlwBrTND1kPgWlaHupBtmF
         XwGKUjvQFDLWxINvAOgz/v7ChHf8nMnhGsRH+Dsgq2dbncZ/yOqESbYBaipucVjXvbV8
         Td5abO2x/93S7YAkfnE7IN1giEbaY2E8U7qDKBGpB+GPWtFSNaDvGCdiwAJb1QNG4EBW
         bXxm0FZiuxci+9jl7PpZsN5Oeu/XwlREcTtgRbVoyxIhRBaHi5wGCutNr9njKmCxzb+J
         wh8Q==
X-Forwarded-Encrypted: i=1; AKwUvBxwFrSfVwzyRkBEU8Va/ojiTT246652F1gEBXcnznAKlZ5rJoCJaI7uJ9jB35dXsOSgrTeqZhZ7e3o=@vger.kernel.org
X-Gm-Message-State: AFuF++mj84sSuRz8wPbHXWt9Q44eB5wwcl9A0LF9uHemEI2c8VVnXhHz
	IB2Kf5X9gHq6ZpEPoyYyhrh2QYdaqWcvoToVUf4i882PvMqsIANs41MXGrAiYHuM1StIPcNmvY7
	2mTT6m4yLaDkzUxZ0Xcre0zHaveivelDNehJ03adJQPXwBj9hloHRZQ6VCKkOS8g=
X-Gm-Gg: AYBFou2mUtE2kHl5p/ygL6QUgPxJ/BUhkz8tAC2+kZnU8a69gcJ4jocxU4y5XKC6N/j
	KlA+rvyT8j9aTw+eWfw97vuhPmHcuLFkrtS32pnNCG4elzWL6rkj0s3Gd3h3CDwwNenrDOpsr5R
	Ow0vJj/FkXOYbc4JiB+KPbQkrCuynvlyPUgCNiOJW006dAxVJqSLiS9hN/GFXQzNltjqhcjjIeF
	zflfGuG9wtLaLZz69f/5VtTulOJkl3S1OkBM/h86BRzUZx8H5sw3Loh3PeahqtZilyZ+/rLlb68
	I/YbwL+3Cmw+uv3EnhTj/a1Q0paCbul7smB8z25g3GaG5kDhRFFJE6Dd1UCroSMS6Rn7ant09+o
	yd5zwzgOfupbIYP/26fOVUdSEy4s=
X-Received: by 2002:a17:90b:560d:b0:39b:3109:10ce with SMTP id 98e67ed59e1d1-39e1e45cbaemr914886a91.16.1789514470792;
        Tue, 15 Sep 2026 16:21:10 -0700 (PDT)
X-Received: by 2002:a17:90b:560d:b0:39b:3109:10ce with SMTP id 98e67ed59e1d1-39e1e45cbaemr914831a91.16.1789514470342;
        Tue, 15 Sep 2026 16:21:10 -0700 (PDT)
Received: from localhost ([50.35.44.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395d11cb3sm1432321c88.6.2026.09.15.16.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 16:21:10 -0700 (PDT)
Date: Tue, 15 Sep 2026 16:21:06 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
        <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
        <kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
        <baolu.lu@linux.intel.com>, Jean-Philippe Brucker <jpb@kernel.org>,
        "Eric
 Auger" <eric.auger@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <skaestle@nvidia.com>, <mmarrid@nvidia.com>, <skolothumtho@nvidia.com>,
        <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: Re: [PATCH v5 08/15] iommu/arm-smmu-v3: Disable the queue IRQs
 before disabling the SMMU
Message-ID: <20260915162106.0000145b@oss.qualcomm.com>
In-Reply-To: <0ca69e93a9370e4e172e4335104859648b8755c2.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
	<0ca69e93a9370e4e172e4335104859648b8755c2.1789446520.git.nicolinc@nvidia.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: MDFRsxEPcpDhkw81bb_kOQChlPs9zWrZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDM0MSBTYWx0ZWRfXzSgKVUsS2hfi
 7V20TEbt25Ir+Tx6k4EHp+etyb5oi53FgGyUfS2/kzHc+FInlTMBpIhlyzsHIUywhZg5Ltp2fHW
 FezH5CpjrRdqoP1BLnTb4b2x5ZcV9vqSW0t+F7Jjbwk9WIp4qmvKrtLzJsus+6QQ98nCWBatKjv
 7iEU7oBY/6aZv+ao6sjoIKe2MpouURkWaGyUiHQsbRikklctR9SJQJtRdCBpYVA5zWuu6kKp1TW
 sESi5Ik2qkaaNXGBcJ/OK/mo/dd5iIdhkeRxpBHkBcugKxQTOAP1ppc38uwVL8Weh2dcc5OKPM6
 7B780UqZ6/x2ECMnW3xAmw/t/J29ChiHbWDGluB60eAM6dwseFMu+SGfFevpKTbTeygTjCm4fwj
 d3RzOUzeuZ3qGcRnEY9WH4a6vSMsEVR9RZHWuF+0MDMw7wWCToKf4XyLAIxnz29kr+zYsAbGDaQ
 7ZsHJ6wwvB8YvWUJ0Ew==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDM0MSBTYWx0ZWRfX5E5kUyuCL45C
 bK7wuSR79CcfzrowkT5UI3FaP8BdCNfy2D/fHi7VEx/N2QtvaTlzpUikRhc2O5xZlz+V/E7IhOB
 IQKwC2P6vC/8n1oDz3JyVJtiRKHP9v0=
X-Proofpoint-GUID: MDFRsxEPcpDhkw81bb_kOQChlPs9zWrZ
X-Authority-Analysis: v=2.4 cv=IcISymqa c=1 sm=1 tr=0 ts=6aa9d2ec cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=aNnz9XPx1a4JIXSYt2cE/A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=Ikd4Dj_1AAAA:8 a=EUspDBNiAAAA:8 a=qr_CdHuHKQtOmQRTACQA:9 a=CjuIK1q_8ugA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150341

On Tue, 15 Sep 2026 09:38:20 -0700
Nicolin Chen <nicolinc@nvidia.com> wrote:

> The EVTQ, PRIQ and combined IRQ handlers are threaded and issue commands of
> their own, e.g. a CMDQ_OP_PRI_RESP for a page request. Disabling the SMMU
> while one is in flight hands that command to a queue consuming nothing, so
> its poll waits out a full timeout.
> 
> Two paths disable the SMMU while those IRQs are still requested: a failing
> arm_smmu_device_reset() returns to a probe that disables the device itself,
> and arm_smmu_disable_action() covers an unbind or any later probe failure.
> Both can run after arm_smmu_setup_irqs() requested the IRQs.
> 
> Disable those IRQs first in both paths, so that no handler is left running
> once the SMMU goes down. arm_smmu_device_shutdown() needs no change of its
> own here, since it already just calls arm_smmu_disable_action().
> 
> Also clear an IRQ number when its request fails or is skipped for a missing
> ARM_SMMU_FEAT_PRI, keeping disable_irq() to the IRQs that this driver truly
> owns.
> 
> Note that the IOPF queue needs no such care of its own, as devres frees the
> IRQs before running the release action of that queue, which came earlier in
> arm_smmu_init_queues().
> 
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
I'm still not loving the disable_irq() in here just because to me it
feels like it may end up masking stuff we ought to handle more carefully but
I don't mind that much

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>


