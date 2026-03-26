Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C2535E923
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 18:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549766; cv=none; b=WPzTJSPVveXi9FTa9YG12RBTCmGEvrXjEnZPapM7bpqhvsQGTIfUn/47r5pSku97CTeOtECzIMUPmVE6Fb9OHIlZlR4ZqlIQ/ytdrjSxLlIX25ixJ1IYBcPEx1K75LKIJUQ56UhCdSuUe/+iW/UqG24OZbgQkUXin0XbJGFdErM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549766; c=relaxed/simple;
	bh=2RnMYeqxbIG3xtIeWfFsB1hg5NMXMzWhzE+LRApt/Y4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hkh4yD1StM6HMfjeTm/QPfWhJNYN11xmwIC4cmGCLteMnyaqAEEU7v3QdoBcG4AfNTFJZAdaiQt8IdMaQiqOX8osUbgmDCnT+8xzjMYL0EbQkr+NoK+MCoDWnnlvtVi0sA+hJePpHWFYDgU2a2cUNttg0ISVEQJaOuwioHOQGYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ENRwTg0w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PPHXqAny; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ENRwTg0w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PPHXqAny"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QI582j1476152
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 18:29:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mhld1R/N1HGh4ArMHTWbMovB6Y0to3d0n9zJbwkChvE=; b=ENRwTg0wQgzSXmjb
	Mfte1+W3mldM2W+BFRwd5RobDOHcS6s8+faGOe2/GKEJD9WDyst+D6RhEif5zxkB
	f07S0mjqTvx+yjrj1RV22kPs2lTRdBsFTG8Bm6Flb9AIB6BxNP4kZeg7Mr4CeZiH
	r4AN05B/ZgCQNZqrsF40onb9wXoeab19z7+GnYtCUeQ3/EpHuqsyPDLIY1OTOPwj
	BpPfmU9Z0JNE9EFMybPlewCnDrMBcv008XOVT5vhTlktjiHVgD0LP49Omsr9vvQx
	3060uUgJI8cqVgNyDUGp9xoPwxoOzWirQICEKpKbwV6laGntEqoPrjAQGofLKPqP
	6chb/g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d59s402y3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 18:29:23 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c70dd30025fso2303729a12.2
        for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 11:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774549763; x=1775154563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhld1R/N1HGh4ArMHTWbMovB6Y0to3d0n9zJbwkChvE=;
        b=PPHXqAny6U8hgvEK1fVGS1FyMGn3MsbmCwEG0VS770aUO4koYz2PEZs2iaTrZbHES7
         Op9dt7CURpMY/EDzA7ef3W4jxCUWBmxgLltqvk2Tnl9wFdVYd55GYcOvGsblkSm60862
         haxm8KWiYHMM4AQofOuBc7PQg1G7tNf6iPJE+gpQ3QMkvywOl0QGa3IHaAHSLtuypchd
         0cgITdEhrRoK6tfVbWsUGapuzNWJSEBM5+DmOTVHfkuUzKXegMs1kxBRmsDQt1A5VXc4
         z6v3paSH6S2HAhoPGsyKVvh9WXIO/Lq/H53ckU5mXzAEZM32ZxPDB9GVW/T5hG0EenAd
         BAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549763; x=1775154563;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mhld1R/N1HGh4ArMHTWbMovB6Y0to3d0n9zJbwkChvE=;
        b=j3Ow4EgtveDgs4rQ4S8vVD/pNmYgqqB0WJZAh+qAXH2zAIlOrxu4B9xm3blR9i9fNl
         y9yphpR2OLX4gXsEJSDD5YLTVWn27JtOU2ws9ctSkNyPMGpYTtlwekyd+gApmOub//i9
         9GDMnpAwaHx7LaC4TGZt6WAlKqZje1rJX6aMQpTOywQqJbUeonjT/6RrX736KpI+4MvB
         x1/t1BbFl0B/APwW4ChnKoVMqfApsTdA4/yUiYC5Rgl9wvv4qIOB5vUcVgDsJ+lYhrfd
         avclJpNN/BbX9EkSl3qPFqXO6W8h7IXMsAEe8O4oBHnZEjpbJMpBWfePOrRW1a2Y65Rs
         qlZg==
X-Forwarded-Encrypted: i=1; AJvYcCUcTmPJTzYEG7zr+JtAwJCwL2NBW9ke2WESA0GH/G1pI0c5gqYikIqKrAXZG22uZmVF06aofQdiabc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Q6iJMqYzXRtsFgvcyFzvtWqJperHH1848vapiLKLTP9FivS8
	uA1b3m6Hggsw/gCW6XT9GGhP9Np4cM2Qxp1vQaXwmhLQJAyOdTBHY++zwXlXMVLaNAhesNzyGTg
	rZlP7Rl8U2KauCfySaVMM5hIM7DiY1uJStmOFVsxogV96hocs6mMHm5MzTu72LaE=
X-Gm-Gg: ATEYQzxrAomIxRhcxikpjGiQkRwOsfFrPIVFMhhfOuWA/UmtWvUQ47mBCLZlcmZCgjr
	ctQvr4fbTxZeJlAFerQVWoQrdjX1fx0pY8Mqdl/Cctv3C+daJx15m70XMl51s8+p9/ypvYuMZ8k
	t3GeiF5oZpGcnOHpu5x/ycca9Q2pLjzcHMRUCxj/AJ1cjIAhR3c62k1bJGBJMgB+8/UXLfWPRic
	wcYCNDUDjA6LsbUuw9PfXMCdL8Zaj2m1w0ophc1njPW/mr4JgumAXkBhLePJf0nWIqDV0gJO/dc
	F2UXWc1lgKcyjgHl5EEmSFaEA6rhv1So1zTU63sMqtoa2gZpaNW1Gpp2s+96fDTr7FaTEJApdFc
	aqMdEaZoW/ii/FnSTDNpLh8Q=
X-Received: by 2002:a05:6a00:430b:b0:82a:786f:e39c with SMTP id d2e1a72fcca58-82c6e0da77fmr8829082b3a.47.1774549762467;
        Thu, 26 Mar 2026 11:29:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:430b:b0:82a:786f:e39c with SMTP id d2e1a72fcca58-82c6e0da77fmr8829059b3a.47.1774549761916;
        Thu, 26 Mar 2026 11:29:21 -0700 (PDT)
Received: from [192.168.1.102] ([117.213.101.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d21777asm3568532b3a.18.2026.03.26.11.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:29:21 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: lpieralisi@kernel.org, jingoohan1@gmail.com, kwilczynski@kernel.org,
        bhelgaas@google.com, helgaas@kernel.org, florian.fainelli@broadcom.com,
        jim2101024@gmail.com, Hans Zhang <18255117159@163.com>
Cc: robh@kernel.org, ilpo.jarvinen@linux.intel.com,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, claudiu.beznea.uj@bp.renesas.com,
        linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com
In-Reply-To: <20260313165522.123518-1-18255117159@163.com>
References: <20260313165522.123518-1-18255117159@163.com>
Subject: Re: [PATCH v9 0/5] PCI: of: Remove max-link-speed generation
 validation
Message-Id: <177454975543.471319.11131195385745201008.b4-ty@b4>
Date: Thu, 26 Mar 2026 23:59:15 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-ORIG-GUID: Snr5zaAqu4wUkJn409i3PL_Nr_5cT-L4
X-Proofpoint-GUID: Snr5zaAqu4wUkJn409i3PL_Nr_5cT-L4
X-Authority-Analysis: v=2.4 cv=CoGys34D c=1 sm=1 tr=0 ts=69c57b03 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=pjPfvbXasfe8cMZvnaMi6g==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=YByT1-VEI5v2HgF6YmoA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEzMiBTYWx0ZWRfXwgc7QF7kwWEa
 cSnQKXKbPwjrXlw294x/+yz4cR/KzJgxePTDq8WumOOLCQXvGgFVJglW/EVxR/DMhoXpWaxZFFO
 ut5ub6aDx/oRq5zDBNtjrA6qzBFOHHHTR0UfnRDddzHqY+0mStRdgEApLQp+a5XlPN5d+R2eTDH
 zvXeu3FzZgWcDoNfkmDqwEMod5+DWmbbvPAT+3nQKrXuQpfRpZ6rQNxHo6+Z7CU9aMso3CZwQgO
 llmTW1KKXKtkvK0Br6+Estb84PWfYOJ37gOn4qjvKDciOxzszLpVMl1rCfjwirUhIIjwZMQH/kA
 XGH2LvZSm7g7MdLhNl+geSP0ahQsVlsaeB+RVV8qfP/YvVbyyXSxkJptE2gxn8MV/9GBZMh+Um8
 NbZl2EcOy4WgbqYYiyDKBGPF/JFgN7C4hwDYm+2QKc6BUZSDckQ87OOahSw1U8fmV8FXnpDUSUZ
 19wwW4j3czWH5gAJ38w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603260132


On Sat, 14 Mar 2026 00:55:17 +0800, Hans Zhang wrote:
> This series moves the validation from the common OF function to the
> individual PCIe controller drivers.  To protect against out-of-bounds
> accesses to the pcie_link_speed[] array, we first introduce a helper
> function pcie_get_link_speed() that safely returns the speed value
> (or PCI_SPEED_UNKNOWN) for a given generation number.
> 
> Then all direct uses of pcie_link_speed[] as an array are converted to
> use the new helper, ensuring that even if an invalid generation number
> reaches those code paths, no out-of-bounds access occurs.
> 
> [...]

Applied, thanks!

[1/5] PCI: Add pcie_get_link_speed() helper for safe array access
      commit: df61f4732adf9de5ad1f5e71b7670710c1597d18
[2/5] PCI: dwc: Use pcie_get_link_speed() helper for safe array access
      commit: d884b0e51459175f17ddc52759ea4533bb752130
[3/5] PCI: j721e: Validate max-link-speed from DT
      commit: 1542ac6d83d0b5706f45e2937de7b4f7b8c4831d
[4/5] PCI: controller: Validate max-link-speed
      commit: d0cc5918a1d539344190cbb19fa3ae0e7b0dca1e
[5/5] PCI: of: Remove max-link-speed generation validation
      commit: 15217c7015c0e1804925693c55d721aad8987e32

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

