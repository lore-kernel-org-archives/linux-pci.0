Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795778751;
	b=ry+SDuwy8srZSl5bxZ6lUVm5R0XEfKCXbx4B4Ohcq6mKZzspqh67gfGQcBkbEj5+pgq2
	 LrpuCX075wiynBHpNqn3FotAWBgOAk7XUG11fWRh+137DDJKxpxlUPdyYmXKcSgkJRNab
	 UcBOWuw9W/+SfRutNddqRLHcZrsa/yhbJY4e4t8GqgYN/PL52BEaOVVlWAN8WDrVMhY07
	 EDiv+Tafz8Szo0x8ltvZ5xgUQsPojuGE7QOF9AlAWgbgtqfbTh1geSt06NF35E4qoK7IX
	 62/8idsVYeEXu9nb52zFPvB2SPvF0eDO0OW49e+T1ersIRyMmrlsNMbJxtT2i2NuwcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795778751;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=RXY4cOaqM/RVzlWVJzF9UQ04tcS5/A3KbbkTgbKzqmU=;
	b=aJ6YHIAvhP9CEOVUapTabXg3Ddkbd0bZ9zZvITPU4q+wes72pAF8YqEhn75TC2kL33t7
	 twsG+jkcosDAo1nfYYkvHo7Kh232KZA30Djtn9XAT7qFMRui0c2DGHsBeXXj/QuvKO9Wy
	 UD3/2S2GCZPpL0A56uY7PbuBjtfskJxwNvplKw3AFpV6a2mSX3wpGBDFhMFBD55ij9GJJ
	 QDXxROOmjRSEAxJwh3GA2b0UUZG2DTzI1KunTPVDyPi/XEeK852HqpDYbbaISVIna1/Dt
	 IH9voTMToJIjLnDQOCPn4uIuucOrzfvDfPvtk2gOhce3FNrQHeXV/Yr88xjKvnHDPIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YXuGIaRp;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TMY7+JQG;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ED3606A6A5
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 11:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42ED3606A6A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YXuGIaRp;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TMY7+JQG
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARAp1cH1047037
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 11:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RXY4cOaqM/RVzlWVJzF9UQ04tcS5/A3KbbkTgbKzqmU=; b=YXuGIaRpgSfdu0xz
	9+JVNIL45ylbv1CknDEgFcLP4zf2eLutncMF6U4/ntGdQqpzd1jq3MnmtOWxtfRK
	jsKY+Yv+yrZuYBQYDvXcLRz2s84Ag2QgDM8BAzuqQvudXjKd1ElBrTG9iyr6JV5y
	47KmhHe+GEutkid/7J2s706Dm+eN8PHC3euyBhfNqbExTujvPdQO7wcj2ljD57tq
	ps91UeR88hayTKlDGJt+6ezEjbF/Zd7RlfcLrW4zX2NSxVuUkRQzAnsNGCARI7YT
	ohKXEBWHR9F7i66HpOgIQPiN1OeLpetZd1D7qoz0fXT8KRyBQLL+GdzhAeMG6o/M
	HjaMIg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6pgqkq8y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 11:25:50 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5476f5bd009so24923571cf.3
        for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 03:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795778749; x=1796383549; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RXY4cOaqM/RVzlWVJzF9UQ04tcS5/A3KbbkTgbKzqmU=;
        b=TMY7+JQGLIEhywUUxguQNyu2GNCX2Zf8oUsLPvKoI5/HcCKsTBq4843e9OJPaSxKfo
         mLUqrB0xTiqq+iUKu5PU9UpSXm/aRR1g1Sqd8Q7Se+Tc3Sk+bUweqd8heZm3xi9J7cy1
         alUb2AxjuksUoVWnCfCX1OQJwz4TovhVeOcHSdQ+zoW6NsQ0g9ypfgsogjC2xfKkdxj9
         3oE9WHMlMuIAegQvz6o92ptUs39hqExEa0HPor+VGmTsYNea7VtDBIxGFoXap4+fXgP0
         tkxUyiy6rDFQSw9jv9NtERTH5nrfJRq51s6esasS50f56Pro047qTknBKi70g0FQbvlR
         M6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795778749; x=1796383549;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RXY4cOaqM/RVzlWVJzF9UQ04tcS5/A3KbbkTgbKzqmU=;
        b=pdOC7VvYDolZl0unU6UmEXtnUSERHCpk/mHf0o8KoToAl5siMlTCdT7XHR1nyfb4Vb
         FI2b4Syd/5gRw0chkcK8hOclAWtAYEmQYQlmNsHYsZdNzD1bjoBEEXuMjf6pPXZvXc3f
         PBOcjMVJvKwI+4/y5HtbAt8ezmix1Lh+geNnsvNy74ceFI108/o+ln+Mfk9iFHjm9LUJ
         PVU/xMw+tRAjFO/uqB+xKPUdrn0OZ7P6son89NNRC/s3ZqeSca+hqYvKFmQO+zqIRd6M
         E3nH2dvLdR/JdxGaCBw4l2KAk7/1xkG2ZfHqLRa5ZJIzVTEefgMYJCCo3kPIUawmxNZk
         /PxQ==
X-Gm-Message-State: APuU4Z87+BdaW7Py8PbzRnCCf6Uo1ckQSSxr+VBycEArmEbc/yyuVjFA
	M9eTBZBjHsH/KzSzq58hxAPkykZEAndWS01KmH5QRMFMCS2SfLX6J96r4QBxR5wTHFn2NaOdiF1
	TT5BhsQSHsoSwY4FDuKosSA6drJ+HGai+C7wKpZGokPATjGwDWxCzXLWExkDO07o=
X-Gm-Gg: AZFdTZfqPk6CWj/XxsocisY4bNOtFD5CFWmOc1W4W/g8eRzSXSSjDIo/8Vxi9Ae3Ed2
	vmG0jp7n04GVU1G0QC9daDCmVuhRmrIL7kOIkOBJCWxo3Tr5bR2AE7Tg8Phvn+j3lbRPObf+KiQ
	Z+FQsXnQOu2n4j2lYBeu/WDOKI2EGcX4VAR9BAdK36MySNSNdgbA+m89+fm1M6+lHJCNzKAuBmw
	JYxJwekn7EzG3oWLRuHAu4vpIZSE7+det86Eb6LPVHCVyD9kr0xH3iQEN4X5xBIWXmWsZswtrX+
	c4z5g+T/zQ2BKz8idGoQEwXwy523uGOYuC80hNhphwGQcaAEyyNXf+ytSB3wuX4bwvUz5Fq5XbX
	/MtB6HS8Pj0QGcJLCBPXotbssY4HhjewEAd1ddY2ipvgcKSGCq/JvA9CHctqziwwhhO7ORiw=
X-Received: by 2002:a05:620a:a801:b0:949:a385:d30e with SMTP id af79cd13be357-949baa12795mr4351118985a.4.1795778749289;
        Fri, 27 Nov 2026 03:25:49 -0800 (PST)
X-Received: by 2002:a05:620a:a801:b0:949:a385:d30e with SMTP id af79cd13be357-949baa12795mr4351111885a.4.1795778748592;
        Fri, 27 Nov 2026 03:25:48 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afc2d97sm847396866b.59.2026.11.27.03.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 03:25:47 -0800 (PST)
Message-ID: <d06c0143-2630-442f-9e6b-89580266e5fe@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 12:25:45 +0100
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/4] PCI: host-common: Fix early bus-walk exit in
 d3cold_possible()
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20261126-shutdown-v10-0-fed60d9687f2@oss.qualcomm.com>
 <20261126-shutdown-v10-1-fed60d9687f2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261126-shutdown-v10-1-fed60d9687f2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: YHikcz3rYnolVY2jf808LiHcwas005O1
X-Proofpoint-ORIG-GUID: YHikcz3rYnolVY2jf808LiHcwas005O1
X-Authority-Analysis: v=2.4 cv=A7H5rKWG c=1 sm=1 tr=0 ts=6b0968be cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=1dD4SeorvVlWizVoyX0A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0NSBTYWx0ZWRfX4+PF57X6mwo2
 B7rxif8Sn7982TtUw/cc0xNa7VhikTFE79tguZTxWbr0j/C+xcSVbnA6JVCdSMqKQdpmaAbleMH
 IDXRwGsIu1tw9te3n2HvH659QEM6pS0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0NSBTYWx0ZWRfX5hkYLEfuDpoJ
 WKgpGJZEOVeIiR8MIcFRSCCZoOpenbXByj7625usJUxrUiOSn2bV0vL4Svu7WQgfU5wzOugLEZ4
 TlFLR7D7Xef94MpaWW+WK5bmua7l89sjK6TsUindD2L5XkSNmlWvbpu9VH2UP9ZcpUeRRqiaNxy
 T8GccAwq8WdnEO/O3JTZaMZMrx3q/jCv5HnuI33Ts8eFNIIsu0UyJIG8AImoKvrpymJ9l1ODmx+
 hXK6pV54SfxdTg1Pyb2zsAwqQ7+X4YnxrDFzcP6XMM9zQAg+96qCU2H8tJmJoY2+odGWP48xF1q
 Vq9ov1l4y6cN43Lqi88PtmcGoygqvI6G1kw7ZiKcPwM3+77Bf2bGnXw5Z+NFAkSfQjC1Tkb5y4v
 bpNmS5BZ1aDta+K2r5oJE6lA8zYfKHRO+ek8TldEhWK8jAFmGdHprea9b25EjAc275kPAQ+Z0hS
 DDM5jqSyw1GJhDn340g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270045

On 11/26/26 6:16 AM, Krishna Chaitanya Chundru wrote:
> __pci_host_common_d3cold_possible() returns -EOPNOTSUPP for the first
> downstream device it finds outside PCI_D3hot, and pci_walk_bus() aborts
> the walk as soon as its callback returns nonzero. Any device enumerated
> after the disqualifying one -- including a wakeup-enabled, PME-from-D3cold
> capable endpoint -- is then never visited, so pme_capable can come back
> false even though such a device exists on the bus.
> 
> Since pci_host_common_d3cold_possible() already returns false whenever
> any device disqualifies D3cold, aborting the walk buys nothing for the
> plain suspend path: the overall bool result is unaffected. But it
> silently drops pme_capable detection for any device ordered after the
> disqualifying one.
> 
> This matters for the upcoming shutdown path in particular: unlike plain
> suspend, shutdown forces the link into L2/D3cold regardless of whether
> pci_host_common_d3cold_possible() itself allows it (see the following
> "force_d3cold" changes), so at shutdown time it's common for an
> endpoint to still be in D0 and disqualify D3cold while a later,
> PME-capable device is never visited. dw_pcie_suspend_noirq() still
> uses "pme_capable" to set pci->pp.skip_pwrctrl_off, so an inaccurate
> result here can cause Vaux/wakeup support to be dropped for a device
> that actually supports PME from D3cold.
> 
> Fixes: 1d2a29ccd3a1 ("PCI: host-common: Add pci_host_common_d3cold_possible() helper")
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
