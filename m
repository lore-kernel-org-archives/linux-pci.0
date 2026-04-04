Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA7327057D
	for <linux-pci@vger.kernel.org>; Sat,  4 Apr 2026 10:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775299680; cv=none; b=sRQzkSNfSvtnTiypOqhkxynMggwDU97orsKHyyyOxpcd8ZsopV2ce+MAjVBUqpm037pQYvG21PWLlJo0YRxr2IVqodtg56VhJlRkQ1aric75RY2j6wFbN1blmCSdTj+kVHsMAJkDbcSP09WZdg3RD1pt/EEyT5tWTGcaZut06yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775299680; c=relaxed/simple;
	bh=ulNysHlLc0gfitjNO4zeFkJJ0amVWNfywT0m6ylhFyI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ThkAamcLNmcvC0oVyqu7SA3Y7cOKEu4Zq6SRXtSoVv4W1wt6bchfuwOFTOPwCgvmplx+UyQ+IlvocRbfsGf2BydCofuYaQm72kV3AlkDQIx3Rok5NCAL6tae8ZiLp7uyVeDrmyA6HRAxjy9o4wGg6j58s90cg1llN18gmnM4N5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oDHrOEaM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Yn73XQGe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oDHrOEaM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Yn73XQGe"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6340JumZ1309708
	for <linux-pci@vger.kernel.org>; Sat, 4 Apr 2026 10:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6EL0YsRH/wroXw2MpV25EmqJjMu9P5jpSq5sUl5drg8=; b=oDHrOEaM7uiCv90K
	UhtD7pMp0TyZgA6CbD8CQ8ngoGeBxbfUPC/Z+qr+t1Uuk/Se//s9aFQ1DYuGxH6/
	soqQE6xKNo7D6+ks+AQ6m8WkfhTl6JoDX45KJhWASyESRG/PBypK6XHvQ+uwfI3Q
	du+LcI0brxH3eFKp4VY2jo5eApZlB2tIi5qeJbipHH7+trtADITT8Mh3m9vgt2cZ
	zGGkzrFrA317jJ3FLd6NWUaBCi57PDGjiW1DQlEhVW7mPlNv+ByCsNgNoASrTyIR
	/ZwDP0b3GePeB20joVjYO41TesujIyttGPBmO+7kejhGsSUpl2NRE+IL4jvPtpYD
	bHRidg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dar0mgw6q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 04 Apr 2026 10:47:58 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b24308165dso68875565ad.1
        for <linux-pci@vger.kernel.org>; Sat, 04 Apr 2026 03:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775299677; x=1775904477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6EL0YsRH/wroXw2MpV25EmqJjMu9P5jpSq5sUl5drg8=;
        b=Yn73XQGeO//4y2cbYpVfpCasZCtZQHVFghrCsdwHmXjkff5SDT9w29wb3LEwNguuT9
         jLsKA65ub/7RJBu/w1tCW9qxYTHz7YumZluIEOjc0Am6l2eziDXj4oU+bH8AD+2X8GgS
         FnJHFfi4hBtoazniUGL+y/sVPwMIVLw/4BefRBut9DJyEIkb8FLId85vjxJOfjvUCERa
         9wyDIqFwYneoAcLGZUr5UUKmA2py9psjiMqnqmVabdfGFDYbbhXHAdMK1JUgwU12d1mZ
         YyMO7qGO3v/HlukPKKCZxqQOvccMFb06cKGB6KmMmUXSqL3bjE8fz2Ocwj4qxLUzLJgH
         +xyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775299677; x=1775904477;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6EL0YsRH/wroXw2MpV25EmqJjMu9P5jpSq5sUl5drg8=;
        b=fp3GQgsG5CZjZx1dSLKJxRr4EG7GtcMH3O3+92K1MS7GUcDaycv6HCAm45+KjPTpLt
         PVVFjC1kI1AT0xFK+s8tDGkchIJcnR4RmodFo5WZdlqYJyEw3L6l25FJ7TnVXjv/S8wv
         Z2MS/REqmQyHalyZ8prhEh9vbbeX8Dl/+QtcIFREEN4U6fYMLn0pW70w/bDHZ9ZAm4CR
         nsXKRKUkqSTsQsPElieXEXVy5p4u1T/fOKjE9FLbxWLJv3qKYkQZbaADE7fLNKrZwQrJ
         rumyfLaxmVWK+tSfLV+dfDfEJuejTCnXZvV63Nzs/NPXsJaGS9zQYKSPkDwtT0ps+UHn
         GRwA==
X-Gm-Message-State: AOJu0YygOFfTdezC76B8bD0Xt/IHbojVUOjOtzyEMxb1smajH1+CHxdy
	B/E/THbCnSH0LeVTBWOcYzl+NRHTaLalB6qYeHrIplYBB2wTwPHDXtoXdBRE2bbYnSUd5BmAiR+
	osYJGhKP/Tv04sK1RQ4nRjekl3l7dFyM+lotROSnGnZD06PTsmbU3EWeGdW7PAtk=
X-Gm-Gg: AeBDieugYFzNAuLcroD3c594ahJA+J+CGWyNSutVmNSfpAtv3zHscQYkNioxbpggoEJ
	2X79CkveNkOiKT1blvuHIQpEPgO46tco1N5LgAzM+z5g0Uo4vdM4sSBm9JPkCjjdAJaRrQtDuzu
	MEveZj/pHkd2qZiCGrUKEs59cFO94xKJ3QPD+OUX7Tu6nxtZPKdmtD3+ubYk/9y40fDJlzv4GOA
	SbQVZFD0Hgt5ER8PQGhyNHwqddOgbiMe9VO07L8wBjB5aJJnaiAUR837WORV8ytOSMQf4C/3FiB
	kh/lZ5RBbSZZVFarPjQPPsgqrZr1iAp/Bov4SI3i8NdUt2VFhD20WxDW4CwO87fi89PTaQwdeY5
	46p/p3d83APrLh/c=
X-Received: by 2002:a05:6a20:12c5:b0:39f:24ad:ad00 with SMTP id adf61e73a8af0-39f2ed758bamr6249126637.7.1775299677247;
        Sat, 04 Apr 2026 03:47:57 -0700 (PDT)
X-Received: by 2002:a05:6a20:12c5:b0:39f:24ad:ad00 with SMTP id adf61e73a8af0-39f2ed758bamr6249090637.7.1775299676718;
        Sat, 04 Apr 2026 03:47:56 -0700 (PDT)
Received: from work.lan ([2409:4091:a0f4:6806:d6bf:182:1f3d:df20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c657e5f3sm6846661a12.23.2026.04.04.03.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 03:47:56 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org, Frank.Li@nxp.com,
        den@valinux.co.jp, hongxing.zhu@nxp.com, jingoohan1@gmail.com,
        vidyas@nvidia.com, cassel@kernel.org, 18255117159@163.com,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260324080857.916263-1-mmaddireddy@nvidia.com>
References: <20260324080857.916263-1-mmaddireddy@nvidia.com>
Subject: Re: [PATCH v3 0/4] PCI: endpoint: Add Tegra194/234 BAR layout and
 pci_endpoint_test support
Message-Id: <177529966991.15382.16154309268895745992.b4-ty@b4>
Date: Sat, 04 Apr 2026 16:17:49 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-ORIG-GUID: gdGcdZB0DoNzU-mP8yX7lj-bVTo7Q6Mz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDA5OCBTYWx0ZWRfXz0fzxJeJ2dAE
 /q6xqKnD8OUM3oqY5ZIiPtwfxlFl2wQvmp4s8yy7gyag5GTUkl38X2egibyVUVIbmY2Wtu4uQ5j
 3xWpKVOYY8a0N7xVaq5nrPU+++/KHXK9fxSTZAibWCLfj9M1cKq8QJiUMbYf/oy5TvP2u5dfxmL
 XVSf311tcXEIXnpFZ7vgFalILCmNfqpYPh0wH7KP+bpS6OJaifU5FrSUEntr96xJ1nJn97K6YV4
 tmKw2pMCwDoI8PsB2SrAlfMAM6jPSjx1Rqun28D+GzEOXTZHKhTaohP7BvNDZB3kjy4tiFdsaXS
 5f0Fh+FcNltXDpXLmb+KCPYGOqwcdLS26t5zG4H+t4zi4imBr2oUn+DBfjI/0nNGpv+pTHz5x3X
 OLz5pe2xJ1LrZRyqu6ahRnTa2EfzsPsQ95Vb1/7MzeLyx7JrppLdkY08UUFI+bHFm0XmJkOqDgL
 tOaJdXF0LhXVDF5qz9A==
X-Authority-Analysis: v=2.4 cv=PpaergM3 c=1 sm=1 tr=0 ts=69d0ec5e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=PrOecTzESOjTxjvV5LEA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: gdGcdZB0DoNzU-mP8yX7lj-bVTo7Q6Mz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040098


On Tue, 24 Mar 2026 13:38:53 +0530, Manikanta Maddireddy wrote:
> This series is on top of https://lore.kernel.org/linux-pci/20260312130229.2282001-12-cassel@kernel.org/T/#u
> 
> This series wires up Tegra194 and Tegra234 PCI endpoint controllers to the
> shared PCI endpoint and test infrastructure:
> 
> 1. Add a new reserved-region type for MSI-X (Table and PBA) so EPC drivers
>    can describe hardware-owned MSI-X regions behind a BAR_RESERVED BAR.
> 
> [...]

Applied, thanks!

[1/4] PCI: endpoint: Add reserved region type for MSI-X Table and PBA
      commit: 5f352433ea39171e19fbb3a7e18d983510176854
[2/4] PCI: tegra194: Make BAR0 programmable and remove 1MB size limit
      commit: 5aec1f18b326ddc455ae9d9d0f5394efc20eee9b
[3/4] PCI: tegra194: Expose BAR2 (MSI-X) and BAR4 (DMA) as 64-bit BAR_RESERVED
      commit: 12a22fb38cbba1991a3f174912b343cdb6afa186
[4/4] misc: pci_endpoint_test: Add Tegra194 and Tegra234 device table entries
      commit: 5ab7a225888baa5474def18ba3b0a298d27e6ba0

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

