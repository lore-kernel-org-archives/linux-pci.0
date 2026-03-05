Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE8B2E173B
	for <linux-pci@vger.kernel.org>; Thu,  5 Mar 2026 06:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772692100; cv=none; b=j4nrqG889nf1QNF9U/BsegUYQPJ+/O0ZDw2lVtlk2JT+PNIIyK70INEigVi+2X2J/Du3pIU/QCpr2B1vV9oSSYbUG0kv/ftAIsXHkf52GufMjHtf35MDWYrQJp2X80MjDJ1HeiYME9JhIYLeoJ8Eivd0XQjPujAsbXVvLHnDTtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772692100; c=relaxed/simple;
	bh=4ZsXx6I4m+/kdfe99q4tYLEpgAyuiWmYPw536w5DT5M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c1ONhFjOq5gh+tSlKEDXNcXs3xBbodTxQ4oTTvWeivtQlKdFw1I6eNE8ZVEVRn2witLvWU00GK37QsMm5xTfpP+ArDYHz8Rkx7Rq7RVPZ6bA5b9yYeUgA+C3HnOlpCyuKXfzUecqv598y2IJfBhtzj+g0y2Xhg7AlfJWOkARs0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=faIu8x4M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LGXHoVRt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="faIu8x4M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LGXHoVRt"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6251BgZp020981
	for <linux-pci@vger.kernel.org>; Thu, 5 Mar 2026 06:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NBiOAj6MCtfTD4TvDBxgPZ/PXk95ruUstogVhUh6ov4=; b=faIu8x4MUcCONgMb
	Jvjh6Q+Rw6Mtn3wzvPZ3eLncElgTzp/SB6Te5KyllIM53TqnO7bcWHklDABMBYvu
	94u6Uf9flRyvAFyfr5RziB5mc1SwLeITCKCVt0VzWv3FM5twyaOOD3kXeiNbUZ4g
	0nuL/IAu7fuCbwF0WqeKoIUabfQy0WE4mbYT3yGjw3zgj25irauXdRRfbEWHPe2/
	rqBXKdi8T+aIv0UUh8jXm43uxGnN5GOwulVEM/Eqp1cStS4vvhndtUnp/Ygddf+/
	kZLiFjrf+cn5QueQVCNloG8kL3uHjqaQwrCwgMu0pQB4uXD3hOE1B+DC1wQ29Sf2
	h76aRA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpupthgcs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2026 06:28:18 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ae4a6bb316so44396235ad.1
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 22:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772692098; x=1773296898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBiOAj6MCtfTD4TvDBxgPZ/PXk95ruUstogVhUh6ov4=;
        b=LGXHoVRtWuLjFJT5QeDuvza0J766uaQwHpQCLacCFw2WD030y9r7by7/+K6MyvhF5+
         uHs2o2QFlkEYH2TopPe9t+Pmz9Eyvb4/IGCTG7j1WbE+K8RzGuhvZdIVaTeBsTZYy9t+
         VVfWTteMnUSUsGjB3v62Tj2OG3IgsCcFGWE6R4G5BrLOiNjTIe0J4A4rKxj5ZLjvlcEp
         cGVvGBaG8a6jDXaZIwwrs8LsQJSXXgqBPSDF7YDimm3je46Qy06EY02W4rAcpEnxh0dV
         vswpSP/5wXPFA2RygrQgAcKCJ8fk2rv7XPdF17PsDdz0TAtg/e+yDvqEIAMNTu3l+tYU
         oAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772692098; x=1773296898;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NBiOAj6MCtfTD4TvDBxgPZ/PXk95ruUstogVhUh6ov4=;
        b=EkBBH/XonRqE6URAIrgGbLHwUPiaKqxWbGdu0RFqcwiWzDjeuzl/YCRdAgJMqBYYY3
         JmVh8gUcMN4TsVYFb0q6Wu8+XpNUGp1lgZwPuhp1XHK8Q2xkhUA3uf76xmBFzE15An0N
         mY05KXXMZJc+Ws3/mZV8aif8II6jSfp3yPqcSIVhJMXIn0kj7Il/45yVbVWMq/NIb14P
         +eEO0Fq2nz7ABY2gTm9hzJ3/sWpBvWubqjjYMAFbUWN8DhwpkXFGdH25WoBri9eFxgLX
         Yf5o6QVaIu/2wLpRdvKPN7HRj1a8An4SHVzT7U2E7dKDluXOP1iQdv5VBSaIvH9YBbMH
         4hYQ==
X-Gm-Message-State: AOJu0YxzWv2S/6rG25RJO7fMWNyNAORj9XrNU0LCfw2pt6/4lGqVU/p+
	FacPwCkrdWWH380g5dfTafk6UwfTg48TZSId6bcf/tCQ5NhW5KkzzWubYyNgooNJSrI3zeiwgPB
	oJGl7vrPnY88oyLIHbC/zqNbZ/63PCMJPSs7Y19MpDMe2vhr5BhpO762s3y922to=
X-Gm-Gg: ATEYQzxLnJPCbtZjCd5FaoPo4abOG69KIKcWDE7hGOMzf0RoxMhogtxGCdzg29Lhsw9
	VmnMOBFn6CHl5IdxnsdXdsprVaZCA/RqwU/nCu7EDZhou43vbjrfNd9IOKITaklTQv6aM5PNcb9
	h1fmJzB/+cs7FWgIHwtY+Y2pdpArkpO/E3Ezky1FtyZOrnZUd8JEZ/YpgVhvWA5rRZUyiv1YbwY
	aaLue2vAnA29pzU4VxMhewz/5BoJLJOYp90usZ0/setdyR69w3h4ZuFFHXxNVwpNbg3dtiUNqMN
	knHNR47vEmaG/hvrZZYIgzUMt/B+A2avdiSsg82oOSUNfXW+Jnk8aXJYsHekK/GU8XR7Qap/MAI
	bkl4tp+vCr7Mfy5RST7uXjbQ=
X-Received: by 2002:a17:902:e952:b0:2ae:6887:5c2c with SMTP id d9443c01a7336-2ae6ab9d5ecmr48269155ad.50.1772692097759;
        Wed, 04 Mar 2026 22:28:17 -0800 (PST)
X-Received: by 2002:a17:902:e952:b0:2ae:6887:5c2c with SMTP id d9443c01a7336-2ae6ab9d5ecmr48268675ad.50.1772692097226;
        Wed, 04 Mar 2026 22:28:17 -0800 (PST)
Received: from [192.168.1.2] ([2401:4900:88da:227d:1b86:2ae4:5dce:122e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4bbdec99sm153479575ad.64.2026.03.04.22.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 22:28:16 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-kernel@vger.kernel.org, Randolph <randolph@andestech.com>
Cc: linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, jingoohan1@gmail.com,
        lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
        bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
        alex@ghiti.fr, aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, ben717@andestech.com, inochiama@gmail.com,
        thippeswamy.havalige@amd.com, namcao@linutronix.de,
        shradha.t@samsung.com, pjw@kernel.org, christian.bruel@foss.st.com,
        Ghennadi.Procopciuc@nxp.com, quic_wenbyao@quicinc.com,
        qiang.yu@oss.qualcomm.com, vincent.guittot@linaro.org,
        vidyas@nvidia.com, elder@riscstar.com, s-vadapalli@ti.com,
        ciprianmarian.costea@nxp.com, randolph.sklin@gmail.com,
        tim609@andestech.com
In-Reply-To: <20260225085504.3757601-1-randolph@andestech.com>
References: <20260225085504.3757601-1-randolph@andestech.com>
Subject: Re: (subset) [PATCH v11 0/4] Add support for Andes Qilai SoC PCIe
 controller
Message-Id: <177269208749.19225.17035061961654742152.b4-ty@kernel.org>
Date: Thu, 05 Mar 2026 11:58:07 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA0OCBTYWx0ZWRfXz6OwSKzD0up6
 8mTkkrsmyl01JreDFrwUjP3eUxFCOI/Ksq4vVSzqktjtvwg9NKi7OwlVVjGLxjK0JwU7dATzluz
 wSOMG9t/YYKRqMXgbHfYbdbf96obKrkta13Mpvh+uGcZ0n7Rc/47XEq1n5NF7wFkfIAOVh2Lq+N
 +lKuzyUIiCWIXpHManlsWi1f5FnSnYN1Yh7Q7YDt0mwma4ZaAuKvA2Xj8OsE/pi4rl7ftfXwPyg
 lfrDMRC6DEFKGe9ifl95vMM5RhFMHqPRvrAeON0CrTeVNpGDsf2FPGVqRTgBenESIlvHS9BfIIp
 LNdpjtuNBw4DZrvKFtcyS5I5bPatE0m5LFlB8LKUSWz5mnpNqUl2QJLfyC7NvJ0NajEMlsIJnOI
 tf0Y0qow6ieL0O7cqytMFArdc5f3VXg/DaokKs5DLaj2Ud5c2Ou5dlUfHpD9kJfr9XrzSLOTtF+
 mJiBQGh9hyuPrScXy6w==
X-Proofpoint-ORIG-GUID: yA5heuDufCuERJ6UwN1LUm32Iwm8Cwcp
X-Authority-Analysis: v=2.4 cv=Ddsaa/tW c=1 sm=1 tr=0 ts=69a92282 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=ZT-azI6cAAAA:8
 a=VwQbUJbxAAAA:8 a=GRD_o9NNUOsNfMSRe4IA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=MMnepr4wVL9Sz6vaZzge:22
X-Proofpoint-GUID: yA5heuDufCuERJ6UwN1LUm32Iwm8Cwcp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_01,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050048


On Wed, 25 Feb 2026 16:55:00 +0800, Randolph wrote:
> From: Randolph Lin <randolph@andestech.com>
> 
> Add support for Andes Qilai SoC PCIe controller
> 
> These patches introduce driver support for the PCIe controller on the
> Andes Qilai SoC.
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: PCI: Add Andes QiLai PCIe support
      commit: 6bf2305ea846868dc1ff9004eb3f61a6590d8431
[3/4] PCI: qilai: Add Andes QiLai SoC PCIe host driver support
      commit: df5d8fb6fe55754bc2956e501a9e6acaca5af7d9
[4/4] MAINTAINERS: Add maintainers for Andes QiLai PCIe driver
      (no commit info)

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

