Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED792248B4
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829111; cv=none; b=GZc5aylnFY+m8CeaTASIxCe9HBJIAYmHyaZZolzAspm3QQtULHuupKdFSyKtZOgrW6P9xAjjGl4jcRRCNp3tPNDZ7vbGD1XePuqRPGVRGe4CSHkhCWzezwuPnKRcrXkz+9dqZ/1CZfG1o+leX8qtdA45yv6ggH8wjlDQEKXNoFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829111; c=relaxed/simple;
	bh=fuqUYcg8JyTJO77tUbShVZbGD6Q8Y0SM/8Do+nLvQAI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r+9GDHt90SrUmF1r4dDpJNT+Ssr4nViMV6BZu//axmIms2RPgGxsO+xAY6JGFeBxxzqAvVhHSJnZFjvolPZy2taQY8VAmq45Z+lbjscz+vjZEBObHbQIyRfQUn2Jsw7iw7Y/iEu8y173RiNhEZPxav49cicN9px3G+t8kLeMEww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BmyoA9Rv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XRsW1NBg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BmyoA9Rv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XRsW1NBg"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEDKhK2128896
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 14:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IG0h16TPXM/brEFoRwskxJmKMoE8Kp3fTWZsdFNMAH8=; b=BmyoA9RvOmEyPSGz
	4DdeycYqRg5PCw4Sxn8ZYj5d67/KDrOpCaGBDY7TZ6s+x+WiyiRV5ePHES5IeqAK
	iL/+cW5LWLx0rzSbXefMMWSHzBSI5/IOPq53z8xX3tPJna3JcK6LjNBY7bg2y02W
	oFJA+JjUPagK07YIJMMFCeoStdq9cTIDDQttRK5oFLySxr10PgFXYz7FmSNRfDfv
	sdmrYhSaQ5SpRlduvX6+DHOce0hqZxJV/ZC/MM843ibdoKzmO+WJ29Bv1o93F4jP
	OBn6Hu+ZqZ/NcLUMXU4xtxQ0MuNoEEjTvB5d7Z3xxODCim5c4aiadSyvKaR7lQzu
	/yyDoQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3yw93tak-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 14:18:28 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30c011c7cb9so12800987eec.1
        for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 07:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782829108; x=1783433908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IG0h16TPXM/brEFoRwskxJmKMoE8Kp3fTWZsdFNMAH8=;
        b=XRsW1NBgKORvbnLJBs6xKBUrFmVoS4ELibiBrJ2sHlEFRFekdaiEXaLxLpvPbPlA/w
         lEJprpq3cLCmdwNfcPdovtZO6NKUaRzZKUqa3haFR3YI0CEzabRvuJ1P2n7c0mJ6QNUB
         6XhLt5RERvBOATWGbl8gUGOiWGicn0yyFag8ezk/YlD3o5GqY1lL97ACrtyRihhIKaby
         OCffsB/q2MOhIp4cVPFQP2OAFfbBdr3oYEc0ZfFtKUL/0iBsN/aCrb+h1x7EajB2aRAO
         j+u6uwNQ14Al29tjXQl3PNkVRHa5jkt8HkMlbHw8rByRJi13tk+ft6aM/2ksXQxwd9W9
         lRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782829108; x=1783433908;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IG0h16TPXM/brEFoRwskxJmKMoE8Kp3fTWZsdFNMAH8=;
        b=ka9rBqtbKDYzHYHB0GxljBVxUPSluPHht7Wef4miZxg7vNhTfQD5GjIiK9rhZzAckm
         EbwVzN0o6bYhduxlzKJ+6UFqQW+12/s+ctT6Bc0SQdwqY4YWQ+g0SbhPldb1o4HjRvP3
         cIjrFbU8NMRwF2UU91dDupm/vgjEMvJf3CaEBk8xggB4VONNpQgerQa9xBOYhYedRz5F
         vdywStURX9PKqFR+vOFg4ThJO9fi9ReKhpy5p6bWbGtdI+gdIrkXyYQmfW7jYhzu0HLc
         8h0Fg9uTNDmYn0bJGX1YZQxZW0LkuuKBFWHrJPp3eE4U4Xqi7peAiSu2+kvAPuWnsAxF
         pd2w==
X-Gm-Message-State: AOJu0YzHeP62XCjipAg6qAOtSkXIzlNieqYRh8pMiv29zhsCphENrYqH
	/UawvVfCfK2VummNiyEuPsecf+/3b/siWtylA8OlB1SYS89ZsIKkKvszBZ+XDwee0VpNC4zme/+
	1+Ivq50DPW3l/PEedWDWobM5LudYkhqxFfPOWIM4ETmhoG0HQ5q9GnQoEtikjmBo=
X-Gm-Gg: AfdE7cnO4Px3nBWdudVLCwZXWABa7TQPItCkvUXF+BvXENkZFH9JOEjSZsjSv2l1vb/
	E4gJY7j1KBdHkIyMeSVwuriWn8i5KpVfNu4zT/4OzUNmhUDT/MiYYROAwqachYh6f7GTExLVt59
	G7OTCoGM/68fNRE+i1uvaC9ESjVOTCWPUTEYTeiJJR/zso9WeqcA/QenFOBBFmAyWOHhvbnYSCs
	2rS27LYxu3ibpp7m1HLaSYYNpCtCyvwrf4jq5sq8Y3Fqqe3IF0cCmfjmRwPD+izbg2LQcKXAsh3
	sunw/JxSvnfLCaKZ/rxZtEsLDOchwXc8LpW+9LZDvY4Gu8ORwHzKnVgLMN2ShGJanB7xhFh2umz
	OaWosswpOYmkD75GjAJsVmmZvubUg/w==
X-Received: by 2002:a05:7300:f691:b0:30e:c1df:4592 with SMTP id 5a478bee46e88-30ee149bf8fmr3700868eec.34.1782829107805;
        Tue, 30 Jun 2026 07:18:27 -0700 (PDT)
X-Received: by 2002:a05:7300:f691:b0:30e:c1df:4592 with SMTP id 5a478bee46e88-30ee149bf8fmr3700817eec.34.1782829107056;
        Tue, 30 Jun 2026 07:18:27 -0700 (PDT)
Received: from QCOM-IvKeorbwK5.na.qualcomm.com ([120.60.61.127])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee3170ef9sm13888083eec.16.2026.06.30.07.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 07:18:25 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        bhelgaas@google.com, frank.li@nxp.com, l.stach@pengutronix.de,
        lpieralisi@kernel.org, kwilczynski@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, hongxing.zhu@oss.nxp.com
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, imx@lists.linux.dev,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260618092100.3669556-1-hongxing.zhu@oss.nxp.com>
References: <20260618092100.3669556-1-hongxing.zhu@oss.nxp.com>
Subject: Re: (subset) [PATCH v7 0/3] Add root port reset to support link
 recovery
Message-Id: <178282909958.294720.13302580439189608628.b4-ty@b4>
Date: Tue, 30 Jun 2026 16:18:19 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEzMyBTYWx0ZWRfX+BykeOl0ivQ2
 WANNThXkyWV7n+KRGOCJUc3bRk+4Kz6r+LRteDyPhqsxj09RKhRqI0GqaKmJsb00851mFw4EUhg
 E8UDNoWeynOQ+7t/mqkJGPnEyhFNytw=
X-Authority-Analysis: v=2.4 cv=KfDidwYD c=1 sm=1 tr=0 ts=6a43d035 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=H7IkG6lIOHbWVTtTQWLpKw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=8AirrxEcAAAA:8 a=ccIQWBWPPgp-iIgOqYMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: NoxtMulbtHljUOsOR_EBDwvk_G-sWnWO
X-Proofpoint-ORIG-GUID: NoxtMulbtHljUOsOR_EBDwvk_G-sWnWO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEzMyBTYWx0ZWRfX3rERV8erGQ5O
 L2ZCIq4AnJfUrdP+Hnako6VoBpEqppJYI48mPf+dLk1TPZcXHqsWwXxylwagT/22oU9GfIKShya
 p6pLYYF4o61me6lfEmq4YyKm17n1uqR82eLkX0ahJuV7Agnk1kK3dsDwXrBoGI117guz/3N36iU
 Om0pYLTP5K8t38aEBwdZiksreGMTJfArpXZaZymgSU4uJJRus4RmOm7imJ/rKi9m0oEZi5QR7Ug
 St0MkUHf2l8WquR9OGWtPq3wZI93c6vpmu3gVc6gPjtOPu/c+tr08WKgZprI2LcJyLqLfVdZhVn
 1SMXw929NXolKKXbp0/hyn87cxeBJzK4KMVNBJtnAMKEG1COv0UPmjuFoWASd49tiN+xtI9FrM1
 E2hrIPUyH5uu0wrb+S2vnmjWqZnWivML+EnZWynTwjPhRdUFNpZIarHxUfvUvJhEZlqCVrrb/qV
 L/YJF6Xdx3mRUFvkAdg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300133


On Thu, 18 Jun 2026 17:20:57 +0800, hongxing.zhu@oss.nxp.com wrote:
> Based on the following patch-set[1] issued by Mani.
> Add support for resetting the Root Port for i.MX PCIe to enable link recovery.
> 
> [1] [PATCH v8 0/5] PCI: Add support for resetting the Root Ports in a platform specific way
> 
> PCIe links can go down due to various unexpected circumstances. This patch series
> adds root port reset support for link recovery on i.MX PCIe controllers when the
> optional "intr" interrupt is present.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: imx6q-pcie: Add optional intr/aer/pme interrupts for i.MX95
      commit: 7186ac21201a9a408ae80fcbb9c985c959b3febc

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


