Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011FD380FC7
	for <linux-pci@vger.kernel.org>; Tue,  2 Jun 2026 17:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420219; cv=none; b=P9aiLFlcbHW9j6iEbhXIr7jwyWTFjhNIA1+jxe1+y0xybg7owN5ByixwHaIvCbr79YE6/MiyjUgMAObHXRjquABQB2cB+81YdsrtajaaLsDLjyYi4o0Ifgwwe9Nc5Sdtd1zYzRdauEHGh8zyF+mOlphnIobKzs0m6MOUGnoYbAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420219; c=relaxed/simple;
	bh=EtD5/9vaC69fMoxqqSkuAD764a7iBGKyoM1iNno7R5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=edRW9LhCTgJbd74teFf9Ne2+mYtQrRwWhEcza21gVYRk8p7XE0kR0nsbzRK1qvObEsxBlKrf8U529Z/8WHCth5JdC1ZndmXxPiGcD+jSIyNeaM502pyh5wj9CxNHpCClDkPc13yn8IE/p1cODnqymSJnG24kwHZ+wdA+Y6HW7vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RvGqCcDN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Nt/oCSDh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RvGqCcDN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nt/oCSDh"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652CNpgY1854894
	for <linux-pci@vger.kernel.org>; Tue, 2 Jun 2026 17:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0WnpHurriknASg1CchB30qt7X0mCuqO6Pf6V96jiWis=; b=RvGqCcDNYtozPEiS
	CYLS/1v9wUP7ra0dhlJpkOOhOO9laDsk8pM9hPeXxK2WSDfiJHmrX7eFDeIFjW3R
	Vgw8CYBJaPcJFi2nEQU4j38RE6pFJj87Loajsn/11q7Ti2dR1likcCeJs92naRtY
	Q9lv2IuUqBxXxgwp9gDI3i2H/qdn7wzTWmWW3xr1EQ423C8Rhv+53dkRve0d+xBy
	Eph0XrYHFm+6BXqeZQAtX0KWK+FIA4NgaCjGLSZikyRuE6b9oDJ1jbk1D0Ec7M5C
	CcRXcOkAQDdJZe/GvFazntD3eFruKEWa6xGnpg/FtEAdzmtYkc9uy+3qxq4zvwAT
	RUqbOQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehsf7atce-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 02 Jun 2026 17:10:17 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3074d4102a9so191822eec.0
        for <linux-pci@vger.kernel.org>; Tue, 02 Jun 2026 10:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780420216; x=1781025016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0WnpHurriknASg1CchB30qt7X0mCuqO6Pf6V96jiWis=;
        b=Nt/oCSDhNGmsmrkMaH0GkqEZqYaFqXpOO+IFZALgzkcptqSqb6TvX1MItJ229nFLdv
         UinuTX/mrV7odMhIKU+BLud31w1UNHPRkjujF1Vqd8Du0KxFVzFh0hSVVIqGLJbXHKcF
         +6tPTkuXZu/e6VWGmDRe1Mv9Hz092U+OLqfMhkExrbhsAwlYQD6UiPSE4AS/Qlae/7ec
         SoY+jP30afLqKDRg/8hpgh9AnwwNA5wxkKN3ZC9gnW2lQjPKcD8AoqIQghoAjGNqtiqE
         Hh05FOJdb111kkrHLkOPLviEezfQTeBlH3IHB9qADZSRVDOzsL2bQKKHJ2usTMJBz00c
         sKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420216; x=1781025016;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0WnpHurriknASg1CchB30qt7X0mCuqO6Pf6V96jiWis=;
        b=VRFyF/EyAT29JuQKAjgvCFh6s59D0fwDF/G8PjYzMgnZLXREdZMK70Dqtd09fBDM/j
         JBlV2qKSokqrASA/ixuI9ThaMLm5zghKT2GrAbfH69HXBHAF8KanHvdxxRc1rsW4acSq
         U98Flh9J4Hi4asxRPWbeqsOoJ9BkL2c3nDM93AhacIyPuVF6bvfMHkH2+878WnEPMfiE
         0UVVzjOAF6G12QCHl0xMBffu9B2tHCFpLrwoeNJV3+kNGIqhZcNsMMdBNm70AamG+u0A
         AiqfK07WngdL6BPvVV2RaASO4n4u/I5o9b8MC5m0YzGMR0g+c6UwTZ7aWRHpkYm5/RXE
         pjxw==
X-Forwarded-Encrypted: i=1; AFNElJ/yvQAZHRrRVvyEc9txkdKrEf5O7KVT8AZtyjKK7e0UMvJhvVrGQUMka+fV/q1dgP4PF8MKskOwriw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGvo1OWWeAprFHQVNS1qzLzrH4bt0KSDf/LwDm2+/TwtXrlUCQ
	ZAEIK32OHwmYn1Gwn+PPv+JHCT4Srt79vumn3ciAJRCv4e4/mHaXYbpJAYpEgLo40W/azs7jV/1
	cGhgbuGuiqb4ch0qwBgULaFwjOksv/9emBvPgbnWQTzlcPdaJNUPIUw/iW3p3lnU=
X-Gm-Gg: Acq92OHitR8Gtl9Wmt+lRFpzUyPrktF7KdqCO++BOhRtVXBFJIhGT0K+vJDINxwD4Q9
	QaA75FhqKWhBc/8IJhLPbxpnsczat1n8wxOhG8/Vi5A736hNZ4ucW/hZ0VyEgCu3gHjBwNWcLId
	AhF0ZNa6M07YpFVTI4x2Son5fUDFCIZFFO00itGAoN7h7/B3yKsJ07hlF8b/JLXIIutv60Kke+L
	Tvvm0MuPaRuJh+0P91rO+N8OcCrinqhuaT+eh1tUrqhu85TfYdiLEhFA8wjhWwr41K9ssY0FBKt
	2/BRLzdWMDIEyMfNiqPyk3je4B8tYNZo+Oy+KHWGsK0g/UCDTcP6adh9CrA6sRa3kIU5/tQHhXD
	dukvzHpq7WCLcE6ps/Z4klKY4Z6x5g1dkRbwaYdAbbwywfs5eelxMFFcg2YBjO0N4yhgxS1LGZR
	Ake+2acHIHWmCaQoRcda6IWvNw
X-Received: by 2002:a05:7300:ef83:b0:304:ba84:a0cc with SMTP id 5a478bee46e88-304fa74682bmr8020153eec.33.1780420216460;
        Tue, 02 Jun 2026 10:10:16 -0700 (PDT)
X-Received: by 2002:a05:7300:ef83:b0:304:ba84:a0cc with SMTP id 5a478bee46e88-304fa74682bmr8020119eec.33.1780420215911;
        Tue, 02 Jun 2026 10:10:15 -0700 (PDT)
Received: from [192.168.1.59] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed53f002sm12470560eec.18.2026.06.02.10.10.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 10:10:15 -0700 (PDT)
Message-ID: <dc836218-2f18-4465-882c-c41b5289c379@oss.qualcomm.com>
Date: Tue, 2 Jun 2026 10:10:13 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] PCI: Add device-specific reset for Qualcomm
 devices
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, bhelgaas@google.com,
        alex@shazbot.org
Cc: jjohnson@kernel.org, mani@kernel.org, linux-pci@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, mhi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20260602160024.1171949-1-jtornosm@redhat.com>
 <20260602160024.1171949-3-jtornosm@redhat.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260602160024.1171949-3-jtornosm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=WKRPmHsR c=1 sm=1 tr=0 ts=6a1f0e79 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=_dsfnS01iu48ROCZzqsA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: gnNGJNycQVoPwZsedYcplx784T9Pjhfv
X-Proofpoint-ORIG-GUID: gnNGJNycQVoPwZsedYcplx784T9Pjhfv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE2NSBTYWx0ZWRfXwlDQMz8KmgeD
 uNZY9Rx50Jw4Wvk2nJjq91+MGsXFbvKUwv2HssD18yUboTODRJuCvHraDPLSiDEFXWCoxLL90IM
 VyoQCug76Zfq9ac0AgtWySMB45ZhGN7WK9zho9MjizmrYfsScM2wi03+sq63b8eOoy/4Z0WLGbt
 aES4SPcT1/ORkt1uhXsMlpaXYJVSDx3oItp6oSoshd8jo0XJwy9ITWJT05RvK8hAZYJwdTD5tkT
 cD+RqTNvo7e65ze53s2PPiP0oOhqsUJol5cUmvxb5JUFgqhP1rRHe4jj+7Ckwe7Pjm1Sc3uZVrc
 Dja/IkYWID6zvij9IhK5QUuEFnxSnNwQKw0mGiAVm83akexF1+FZAe5ZPP4/Xna6qJrsxWkQPVu
 0WZuFdLnv5euFi182nNlfiZpadYgMHN9IRq+XbRm/hgdBwLyU644NC8rOjoByujAAn56nCZaRDd
 R2z8ogDFleowSsG3u5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 clxscore=1011 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020165

On 6/2/2026 9:00 AM, Jose Ignacio Tornos Martinez wrote:
> Some Qualcomm PCIe devices (ath11k WiFi, ath12k WiFi, SDX62/SDX65 modems)

Throughout your series you refer to ath11k and ath12k as if they are devices.
They are not. They are device drivers, each of which supports a large number
of devices.

> lack working reset methods for VFIO passthrough scenarios. These devices
> have no FLR capability, advertise NoSoftRst+ (blocking PM reset), and have
> broken bus reset.
> 
> The problem manifests in VFIO passthrough scenarios:
> 
> - ath11k WiFi (17cb:1103): Normal VM operation works fine, including

17cb:1103 is WCN6855

>   clean shutdown/reboot. However, when the VM terminates uncleanly
>   (crash, force-off), VFIO attempts to reset the device before it can
>   be assigned to another VM. Without a working reset method, the device
>   remains in an undefined state, preventing reuse.
> 
> - ath12k WiFi (17cb:1107): Same behavior as ath11k.

17cb:1107 is WCN7850

> 
> - SDX62/SDX65 5G modems (17cb:0308): Never successfully initialize even
>   on first VM assignment without proper reset capability.
...

> @@ -4252,6 +4268,9 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  		reset_chelsio_generic_dev },
>  	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
>  		reset_hinic_vf_dev },
> +	{ PCI_VENDOR_ID_QCOM, 0x1103, reset_d3cold_d3hot },  /* ath11k */

s/ath11k/WCN6855/

> +	{ PCI_VENDOR_ID_QCOM, 0x1107, reset_d3cold_d3hot },  /* ath12k */

s/ath12k/WCN7850/

> +	{ PCI_VENDOR_ID_QCOM, 0x0308, reset_d3cold_d3hot },  /* SDX62/SDX65 */
>  	{ 0 }
>  };
>  

same guidance applies to the 3/3 patch

/jeff
