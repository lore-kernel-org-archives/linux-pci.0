Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795778609;
	b=RjXuAHNitUembXK+FGBTJiNGaBF0RpMwqBQfIQZ4d+NsbIUvu/RVT5V8FReTbOmdVYRd
	 ByBiNbroU4bUrE/gwjco2AO23RK/ArKhNZyWOpdt6CsByw2EVjHVUpb6hJFoFCNbWuG9D
	 +FKeiFs5LYDW8eYV/WHQ/5bqjGzceowcMLzm7J77v4EHRQp1YJMDlR51eMqeYn4HLAtdP
	 jIGWU0ObbpdC9ucopekZNDOoSO8VyOs7GFTPEexoDf1I0Yi9wyrEv+0HZgGpNvNeD9JCi
	 LMl2oE+ELz1chLnNli/4FdQmmSqwo5sD/j20bVuBQx1kTOYLgbUztqn9PkBhVAJ6TSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795778609;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=bwbGdFEkDz0Diwrqb+uD4pMw+aTYw7fIvGX1BVepkok=;
	b=i6Cd3l84Jnd6VC+MdGFGNJCV3JNXQFhjUd9ibaqKWz5jjsyHZuH58vnKuhWGFhNSMjok
	 2I/TUFi1XomR3WJ5N20tvjnuP6edqb4ld5iD2938rwXfBXGhLW4562O07qHMcTbk141WD
	 SnXrqzUBkrn5QQ8yiq3JbR+kxPqgqAqMN8tW6OD9UMF8g0yoI/nR/uUzUQZoOjbvw95dp
	 pFd1TG5e9vNpxokowDesXKtXNFRmtN0hKdS9qRhpUgbMTgr1t0OHgRfGtnOMWiOB8sA1s
	 BHhhr40ktpd5y1rgVcoLPJvmw1EUVXPoHEDR9yH6J6cMsmRVAixiHnC0g52eVSzkNhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ym46Pl68;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FG4RDLUr;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D3E606A31C
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 11:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5D3E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ym46Pl68;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FG4RDLUr
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARApDFY2677332
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 11:23:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bwbGdFEkDz0Diwrqb+uD4pMw+aTYw7fIvGX1BVepkok=; b=Ym46Pl68RgkZGSS7
	h9p16gslZ7WCvAuEQIXPvvuZC2G6ggWUqZqbPX+O76nv4g2VGWPvhmq6TDB3lXQz
	l4qmQpwJVzWSoyex6gOm4kOnxvzWRb/n1OFWWY/lf5xIgXU4YKDKyl3IxScKYwEE
	m3Bnr+ogof+2kEgNBC4wq22J1EVgh4vg9u0wqh3YAWs5uqIOZQnWzwnqq32QumWR
	AFwV5Z46sH7iFi9bJiEId0+DaQI/Gt/cs5eL7w7n5xolzUVIoAlt1tcyNzwxZT2f
	/rbf3k1ShokZlBd1+G6pNIU8fLonVow28NkvwOJzv0/vP2G/mUcARDgb/qvMI9sF
	cFd//Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74gh95d9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 11:23:27 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-55d3ad11f50so9994441cf.0
        for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 03:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795778607; x=1796383407; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bwbGdFEkDz0Diwrqb+uD4pMw+aTYw7fIvGX1BVepkok=;
        b=FG4RDLUr419LzjrJUMgRXDitHecF8ZSOs7jARhzV3mWhLbZwfJU0ffzrvtOvpZJYbf
         qiQlBCU3nCdjuD42TmwqIFuRUmLgpAn7o44OmYlG52+BeR4D0Lsb12i/iA1LMO2bjZDV
         BM3/WCbxwDnfLOu4rJG8teGeO6a1iZXEfF/cXa0b53L7HjEWfNhBevnUjHTIElZ8/a5U
         HrZNXJ1BNNGmRCnTS69q7MHl2qJmZwiVMtjGlfxnkH9uGr+6GXOHh+/FagL59Y48pmhO
         7Peantjz7vpPC4Ip8v8EClrzFFZBFSfDm4HqtO/lMDwQcCicff9j3SztZz8vneHOsNv1
         r65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795778607; x=1796383407;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bwbGdFEkDz0Diwrqb+uD4pMw+aTYw7fIvGX1BVepkok=;
        b=kbL5c1Ptee8N/SGdt5y/2Enn22FORpzwglgO3zL/21wO96CdCYGwhfwSasjKlCoeui
         zml+8UOZKCIBsTlj5GEIY6nawf80xyQUg+9lTlqHf02XnQff7PjKQ2Yi1d0+AcgUnTAB
         cwgOCccvrtnBDRxZHWzRznZWJ+hhL2y4kFrI/5wjf31fqx2XZu9cosAU2SkjEFnwgLm/
         ptRWwbVLRdB+USjX/ZRN8fCqlyqT/rr1MasFOv7L0BHpmZgXCo5nrzlM3V8s6P01OoQz
         1vW7X4rsCeIrl0gf1dWFkfn0oq9QG12bKYthIvgweAie8ioRrEpYtahNZrDU7wfqx/sc
         PJiQ==
X-Gm-Message-State: APuU4Z8pYiyjpsvRbj7V0E9xup6KyjJwMiNxrBmawAy9v0HT1NY0DAnw
	VnGW6VXjm/0kUf92UJd7cR2PqS8Lc95z5VykkmA1pP2Elu7vmpBW05f0I02FRKE3oR4LMPimUN1
	zh0+GsKUeu2fWKUFCbbvEhrX1rNceLcDLDkHLQQeN/xH7r47bB+U3sJc29q4KduU=
X-Gm-Gg: AZFdTZdFllvVyuNotd5h9mzziYUu2zXv2K2iGUYmip5I32NqpM3tfsFuA+mW4O3qdo1
	gIZPNFcfoixmTJ2LBhzlJdUoy5B9RLc1XNDSeVQp0p/+MLG1ay0C/0EqcfStQpvzLTWUxw/T/J+
	hiX9LQc4+Yn4ecqZkI/BD6wMNlzMUYmM3awAcA6cqJo2462XkEPcd9WHWxGVKAAb9deOkma7Dqb
	ri6E+6P1qHsObqMkn2TVjxGULh6sKby7/EYuT2YeP2hjct/9MdqxFFQGO6pbYNuQO4UAxf65EHs
	nTznFECD2gzyBd4yG6IfICJYKLvyPGFIMBuOUQUTozokPJMjJ2DStbhaivrsQOCDOrOWmzAJN+U
	yXrq3/PJXNwL2sGnBx4eGELjHUZDglOb548VL2G7o3t3HSWcyS3vhPPH8GLdhAONT4IIOJao=
X-Received: by 2002:a05:620a:a017:b0:949:7642:6de7 with SMTP id af79cd13be357-949ba85c0b3mr4637602085a.2.1795778607114;
        Fri, 27 Nov 2026 03:23:27 -0800 (PST)
X-Received: by 2002:a05:620a:a017:b0:949:7642:6de7 with SMTP id af79cd13be357-949ba85c0b3mr4637598185a.2.1795778606669;
        Fri, 27 Nov 2026 03:23:26 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513aea31e4sm863728766b.39.2026.11.27.03.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 03:23:25 -0800 (PST)
Message-ID: <0d0fcbac-2d04-41dc-b596-21e6ea622e2d@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 12:23:24 +0100
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
Subject: Re: [PATCH v9 1/4] PCI: host-common: Fix early bus-walk exit in
 d3cold_possible()
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20261114-shutdown-v9-0-5430c9f242ed@oss.qualcomm.com>
 <20261114-shutdown-v9-1-5430c9f242ed@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261114-shutdown-v9-1-5430c9f242ed@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0NSBTYWx0ZWRfX5BihY4hEMhdt
 vPbuzYjYBbak4KjtM1bnIGqFF2UdEAZfYDEFAuXdUoTJfUcwX9wkoGvbKNswODuOVKwZ1pKxuog
 QAPjiQ21cRKcVIAok5KjqBsh8ex6fVw=
X-Proofpoint-GUID: fUJoPb-m1Z7pqTLhHSGRLfv0D2lg69PI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0NSBTYWx0ZWRfX3+MV+mqYMN/j
 mXJY4WdkkoQQZOSl70lEkw0RAJXkxcpmCDciyMeG9u0RTjUiy1XcB18ngUnRBQLfhKcVUyEqwP4
 bexOYrfGU0Xe0IKrawIe6RcQSlFxRb/5brsG7ihmA8qzAGuxyqoA2odV1fBKvmejlbP2lgIKmD5
 bf24RmR9ypgFLrba790bjc1e89kADMne8kU50OkoH9iNtZ0SuhewOLuzStgk+2tKx6tBRVnhSdC
 LmKUTxJhqVwwgsa6mTe8lgWM6lG8pyvgKCKTtlMwAhwEm/eq9WuRfOj+d8KzG+JJ7uc32LJyIPc
 05447dp1BdkQGY/0Xqs7YPex4B96XcbgSgbLq2TaYlmFpC/Eed7rIyuI5ADxnr7mcVp9gvlFS0i
 HaQ7r/mbWuTR1IigYL+gjGMfw7MPkIl1q5yQMw3y+wOxbuY4BKCm/gmFw1UI3/till/dUIyj1+p
 pz1VPOaqKDT7v3cF/eA==
X-Authority-Analysis: v=2.4 cv=U5kHnuru c=1 sm=1 tr=0 ts=6b09682f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=1dD4SeorvVlWizVoyX0A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: fUJoPb-m1Z7pqTLhHSGRLfv0D2lg69PI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270045

On 11/14/26 3:00 AM, Krishna Chaitanya Chundru wrote:
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
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
