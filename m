Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4A93EBF01
	for <linux-pci@vger.kernel.org>; Fri,  1 May 2026 17:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777655517; cv=none; b=CEfkYDZT1SQGnc8y61aHOWtPGjOpPJ7JwUTAAqqobOhIqmCQLS46Jwtn7SSJk/QQ3CCfamu5PgH7fDzMpbhkVq103fg0QFDJfJJvUOpem4xt1V7dBAbnAiwXz7u6JzLtDX75qiIkJUV0N5D3F+HapESFL38ZFfFAzpuGQ7x2RSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777655517; c=relaxed/simple;
	bh=Z3a5AIemC0P5Z2ddkXW9bNGDgr5uQaLtGhFfS6kUzXI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZSDxIoU828iLkCtRTqQdDeZSTDF9VmBVmYi6g7zjqKfsyT/ljdXNmir6wTGnPOs+zXLt6/Iy6bOqrmMZtXtEoHj2ppDz/G6BfJ+b7EpW+ILmlBu+rO54F4T7Pz1vqXzRiPF343r0PiAkTbtIZR38kDkpp9nNONn4LKw3OHNMtKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W0QbA3Vp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UNZ1S8Zv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W0QbA3Vp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UNZ1S8Zv"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 641GLjSE1345632
	for <linux-pci@vger.kernel.org>; Fri, 1 May 2026 17:11:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QFApflFIpR8skWF8n01PwLi2UjQ748Wi+jg6Hh8UytI=; b=W0QbA3VpwRA45kDV
	b2HKsL0Vrb57Zo2lV5jIyauIazhcEsqNBV28NUJAfD86r1pNRz4y1QZxFchpS+G+
	UkXt5OsVjW+PY7Ib+KjfXBUnPwXU2sp5PKZEpI8nRGs+RwI9UOAzya3lLuRzUgkp
	xlgkKzzvg9r1ZBlKytKxcUjuALEEFDeTnewjA6aHj6FtJ/G1hf6kfR37gIvZxBA0
	5FOGpjrYAhzDkeFnbJATv5b2cH5sq8RPQj4VFqJ3KXpf1ps4ppwLE/U5ctQ5hqOK
	Zi6aSENekYRd8khF1rA7LUIzpdxYplezmetYX9YLQu9IrVmfpzHLm7XrKJNxD68v
	UL96mA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dvwd5rnfx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 01 May 2026 17:11:55 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-362eaa3aa61so2263810a91.0
        for <linux-pci@vger.kernel.org>; Fri, 01 May 2026 10:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777655515; x=1778260315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFApflFIpR8skWF8n01PwLi2UjQ748Wi+jg6Hh8UytI=;
        b=UNZ1S8ZvsjF/uJxOiO7Hcrxv53BnaedKF4MAGq5TB4koJAl2TqOrGD6n8r1+1iePZK
         QO1AhXL5+f1xtjhFU/FLYU2NTcPqz6hGpIColL+Rr4a1EVB2s3Fme02v7EyV40Fpycsw
         YkQuKoqsWei5U/F43eGJwkYFTpHtMvQBj7gP0C9Ed8G2O/Ja4Jd3OGl2EVj88++XUv1K
         fEjhYAKsMrab9UpXfqo+Wg1GzZWCAKkKAyI9MHOSha2z68BvwUiIqmTwSV/MxKpEoQ9p
         Nmx4PvHgnLuIKfGRCKX6LS/hjvUSbCGkMWzgbcd91cm8lonfRncis1Ux70gGtuSTCoqZ
         mVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777655515; x=1778260315;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QFApflFIpR8skWF8n01PwLi2UjQ748Wi+jg6Hh8UytI=;
        b=HoXzA2ybJWRdpxaAQNFGDcIBLWWQ05g3qf1tTOv+wqS7OF/+bT5x4kQcka0WaFKAKZ
         zj7aOwEio4/uGWwZP3qlYYJHoaYnUtoWTWz810KzPp8HSzdtJ6whDmVk4kXiPRuVFTJQ
         9bn0sp1nWAYLogD+UkGsa/B37EQHzy5HUxZCO+/vB5u5ytn5iKZVjHArSjPDOYfW1YPd
         ythrmA+ykiBPsmAwOhrH4NVn684wc7LyPCNtgImHprC6lh7LTt95EbmFFcthRUBTJw7j
         fnVSypy0W+svhIzH5g/qGO557IiKJmkKzlctFlMCSU0EzXFaJ8H0VNTx2MNSmUeAxsJA
         Jfng==
X-Gm-Message-State: AOJu0Yy5GIn5Ks9AZQWe98UoQBHohnb4Mnqn9disjQLXNSpQFsJHn5S6
	wuUHwGzn3g0PQrcb1KK7/pN666L16IA20DOyXJPfmXsBQfimez0+jsqia8H/oXmsNn+lBdEV/KV
	eIQRUPOrVA28fdlU/8LqCVQSaIozQIEHm+g0tL18LyC9QUjaqvoE/JXBr2MfBNFk=
X-Gm-Gg: AeBDiesSRTt/Tui6Pb9uJH3S2Rp1NS8QBNynYs9ZT5kboM9YJG08UdYS5aYFgRtTLTg
	PnGhs7uXNN0g+662JiSJuz9zSCeYlG6bkbs7WmTBsv6sgGB3/HtJRlY2rCblx0ZG1TJ2JVmp3mG
	FhAoM8LfQBOedMg7/ouPxYUenxRRnbpnhk1KX24HsHqnj4xNE2bl8zxupuZWg5Fjl3ZT0whpSxP
	UiGVHSSL7lmMgrJU2ebZIWy/hox2p0Tl3hGEY8y8YX3U8Myp0XqWQUdlp6CyjJqwRbeBfLRP8pw
	WgUcjMohHtY1TmtMfj57Cw0MFsnitDCjoXssQ9mkTizbxS3bqf0JBiCwU3EjlXA51JZ/T+FyeLV
	hGKnTg7sswLaMtjHRMoDOen7UGgd9m9w=
X-Received: by 2002:a17:90b:2b45:b0:35b:a418:698c with SMTP id 98e67ed59e1d1-3650cd988e4mr115309a91.12.1777655514803;
        Fri, 01 May 2026 10:11:54 -0700 (PDT)
X-Received: by 2002:a17:90b:2b45:b0:35b:a418:698c with SMTP id 98e67ed59e1d1-3650cd988e4mr115264a91.12.1777655514265;
        Fri, 01 May 2026 10:11:54 -0700 (PDT)
Received: from [192.168.1.102] ([120.60.59.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ebf2affdsm3628258a91.8.2026.05.01.10.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 10:11:53 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        Ratheesh Kannoth <rkannoth@marvell.com>
Cc: will@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        robh@kernel.org, vidyas@nvidia.com, Bjorn Helgaas <helgaas@kernel.org>
In-Reply-To: <20260414081730.3864372-1-rkannoth@marvell.com>
References: <20260414081730.3864372-1-rkannoth@marvell.com>
Subject: Re: [PATCH v2] PCI: host-common: Request bus reassignment when not
 probe-only
Message-Id: <177765551005.15551.445091492424222415.b4-ty@b4>
Date: Fri, 01 May 2026 22:41:50 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDE2OSBTYWx0ZWRfXyAmimM81mfNV
 /EoipdauWcQX8uw+RjBpl2QtlBLQHfsAaAOYszmNQSQSU7C6nYST82TztDQWAdxWHEFVGkq9F/v
 KsSmNW7UljorakKw4KC0OPjhSc6CbStwmIaV0tywnF5twltjD4tZN2Q852kVlL5WoaFwFRVY/qb
 lDsaLUz5FJyGHmCWmc5ZJwGKfJ55pi7ip6KvCnneWZwTgRm3IHavTNIRzVeywmBbPBTsUtVerdV
 2oks/ihvbJnTaPH947OBCp9e/RHFNQtv1N7fTQUZk2HEiTqAxV1W+tdEz/3ox63Z7B7Q/ktxbfT
 k7hQQ+1ZZvqihBE2zM36okrqF1FlbXJ3tp9mK7YTEK0xnZPaOibZzG6RZZpQi99/PThlllVVt1q
 saex9uJlOF36sV5xUVe5PsI9/rC3fUTour0M4NlP+s3H3OVGX/ySP3cwESirwRP3uEAV0NFIJES
 DZvdL3P1HlfP2v+QNoA==
X-Authority-Analysis: v=2.4 cv=OdWoyBTY c=1 sm=1 tr=0 ts=69f4dedb cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=VvXziC1WMG9Np/cC0Lm1wA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=arANb0FDTjGILoVY1XUA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: Nf3Abuh1xpuZEUp3MNASmVQVOlXUa4KN
X-Proofpoint-GUID: Nf3Abuh1xpuZEUp3MNASmVQVOlXUa4KN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605010169


On Tue, 14 Apr 2026 13:47:30 +0530, Ratheesh Kannoth wrote:
> pci_host_common_init() is used by several generic ECAM host drivers.
> After PCI core changes around pci_flags and preserve_config, these hosts
> no longer opted into full bus number reassignment the way they did
> before.
> 
> When PCI_PROBE_ONLY is not set, add PCI_REASSIGN_ALL_BUS so
> pci_scan_bridge_extend() takes the reassignment path: bus numbers can be
> assigned from firmware EA data (e.g. pci_ea_fixed_busnrs()). Skip the
> flag in probe-only mode so existing assignments are not overridden.
> 
> [...]

Applied, thanks!

[1/1] PCI: host-common: Request bus reassignment when not probe-only
      commit: 76d06fb36e8e6d1705fbbf75a450e5725199ed5f

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

