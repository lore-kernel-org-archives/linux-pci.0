Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989872;
	b=zsUfOLWw9Y1Ab5wGH4XaQm55UDKFjzGdbbCLBnyOnlEE4XLLqEcPp5ALKru8WcICehMX
	 c8UvMaGfU97ABQFUKC/R++i3Yp17dz/+OzeUws+5/3TZdGEvwsFhZv8LIt0UhTNWfOgSE
	 RE6FjwkHSTpuG2xXNAW8idqpKyp1eFuh9Xg/BltdIUcil0u6AH5Kuad3KXVjklVUfSk99
	 jYyv5clwa+xPyuWHMTjpHB77CcgYsgdEYlmq4pyuZCdtetvDBy75hQ8d2Wwyx8q8Bme4b
	 yt+PvkZSWs9vGILoNrRiLnoOawn+zZH7L0N8SuA4FvMrCbyYR2QlIJ+NQeuA/azOTIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989872;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=3xH03NUHcmWpaKwCeok9TVi3U0p01vOJ09Gd/XJiWe0=;
	b=l6W7HLbbtt30cee0N+7iaazsUkWsO+5GWe8iI5BQkCOw8xxzGT2vAtmBw4X27+jw3QvS
	 +gZKuF381DWjhBG/TmiKq1TIWs2lh/YEA981nup/iaNhoJVZC+aROMGQHL+M8d6kH4GJ/
	 BtZT+ZJLGJK+XrjGjBMqx9Odhw+EtxJBmDe55FsdxBvjuFwPf96XWSyoGg7pifZZX2BEQ
	 NTLbbnUy7cfjN70XmLRtAYOvMlDyz1DKo/7mByZFIX8SQ9xednid66pNF/4zwtjxVyQkt
	 +s6viknLr/uUH5QHxkjZGvOhykk/ukObDCqdeusi0cZlPLUSXay+WOw02OV5CJOjLwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nb55O+XA;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5028606A326;
	Fri,  6 Nov 2026 18:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5028606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nb55O+XA
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6IEJIu1994429;
	Fri, 6 Nov 2026 18:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3xH03N
	UHcmWpaKwCeok9TVi3U0p01vOJ09Gd/XJiWe0=; b=nb55O+XAdWXyEP0OZno9us
	APw9l5dI2UZvlDXH7ehkieTeuOSUMnSHT2C2j6lr7L1wBS8ujGrlaC0SUOp4Kuy3
	KbAIz2wjChEcMG+M8KC8fuPn73WrJRWrBXIXayZjmSxOGSbfur/VXEqvMcy7rXyE
	yUSd1mSLe7+IHzfC9Pv54IRv+YIp49CjjoY+bnfhNjcY0Hi9gFORFcYBawaWdzOa
	DkhHMQIjibI48tYPncuYyt877McUc/uh/4OaER6l/qm+5g8jpo9FrDPLHRc3vGfF
	hgUhb2UU9mAsYJC1uDqRrFRustujfsKCXMYMkYlHy1hM9KUBuvbXMMyY1F/HWOtQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rbxv5v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 18:30:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6I4rWl3846102;
	Fri, 6 Nov 2026 18:30:54 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrka73fat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 18:30:54 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6IUr3g21758552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 18:30:53 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6056F58061;
	Fri,  6 Nov 2026 18:30:53 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B61D58059;
	Fri,  6 Nov 2026 18:30:51 +0000 (GMT)
Received: from [9.61.255.215] (unknown [9.61.255.215])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 18:30:51 +0000 (GMT)
Message-ID: <0a003a9e-573b-4c4d-b0a7-f88bc11818f4@linux.ibm.com>
Date: Fri, 6 Nov 2026 10:30:50 -0800
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
Subject: Re: [PATCH v2 1/2] PCI/MSI: Skip MSI-X restoration when configuration
 is inaccessible
To: Richard Cheng <icheng@nvidia.com>, bhelgaas@google.com, dave@stgolabs.net,
        jic23@kernel.org, dave.jiang@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, benjamin.cheatham@amd.com
Cc: iweiny@kernel.org, ming.li@zohomail.com, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        tglx@kernel.org, wangruikang@iscas.ac.cn, vidyas@nvidia.com,
        lihaoxiang@isrc.iscas.ac.cn, xiangzao@linux.alibaba.com,
        shawn.lin@rock-chips.com, 18255117159@163.com
References: <20261106111829.55823-1-icheng@nvidia.com>
 <20261106111829.55823-2-icheng@nvidia.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20261106111829.55823-2-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: _6eCb96jv-51KZVfLGMn8J0PlJOwuhUY
X-Proofpoint-GUID: oxIXGDitamPJ_v_ajjSIbD-jiLmezUeo
X-Authority-Analysis: v=2.4 cv=MqLHeGae c=1 sm=1 tr=0 ts=6aee1cdf cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=Ikd4Dj_1AAAA:8
 a=letvWEv4QDVn0nEJEU4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3MiBTYWx0ZWRfXxdlrruOzhuwy
 xkZED9U/q2ps5OazJbtcIod30XwrSkREJGwxYVFM98akOiX4S4jyfrElkdydXLWUgOXa4hFoeJ+
 mQCv9pLGs6EK8jIUNLtKz0z6YjJjKQE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3MiBTYWx0ZWRfX6zE1yD7Fz1a4
 zNHR6E9DQrXJyRGfMO64JXq/psSJBfsfpIabFklOCQdWTZv/+mR0v37FPMh4Qduskqb5Xi0suBP
 EgycJZ5seGSGlrS9BAXINq2OxbGTmXRsW5ag8LnttvyhW96H7/utNP0a5dUW715ZJ/2Fvm/rwxP
 6VJeoN4DeryzkKnC9tU2dWtI8g3qtfTHkthsIIe5VQgvVldf+xW4EuDhzuosbYNCmpRrp3rX20t
 6UhxepyHIJ3vvv1v46l7iPjDLWF1fjpninKjioXfLZWWNW4cmL6j+TC5oVJpUcOZOI+UUBAmGN4
 OfwWmWrm+W3ugU1vWTRjgXYpmRvAV1+m8jqVlwOXEriX8Bp18HCV3d9K4STDbKCB9xizKzBp+aP
 l3UJHOz7nCJP2VsL4+geWy0LocceBr6fkjasLu3w/XRGGpiKql5VjmoIBJl4lwGq50vnZZ0wAJA
 qKX+2aCmM/S58IuNZTg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060072


On 11/6/2026 3:18 AM, Richard Cheng wrote:
> PCI state restoration runs even when a reset fails. If the device's
> configuration space remains inaccessible, MSI-X restoration can issue
> table MMIO accesses that trigger additional errors, including DPC
> containment.
>
> Check the existing PCI Command register read and skip MSI-X restoration
> if it fails or returns all ones. Preserve the existing handling of a
> valid Command register with Memory Space Enable clear, which temporarily
> enables memory decoding while restoring the MSI-X table.
>
> Limit the change to MSI-X restoration. Leave other PCI state
> restoration, driver reset callbacks, and reset return values unchanged.
>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>

Just curious, why are we limiting this to only MSI-X and not MSI? I 
think MSI restoration will fail as well since the config space is not 
accessible.

> ---
>   drivers/pci/msi/msi.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 8a0133a6a286..37de31f4cfb6 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -887,7 +887,11 @@ void __pci_restore_msix_state(struct pci_dev *dev)
>   	 * Since the MSI-X Table and PBA are in Memory Space, enable it
>   	 * while restoring them.
>   	 */
> -	pci_read_config_word(dev, PCI_COMMAND, &cmd);
> +	if (pci_read_config_word(dev, PCI_COMMAND, &cmd) ||
> +	    PCI_POSSIBLE_ERROR(cmd)) {
> +		pci_warn(dev, "Device config space inaccessible; unable to restore MSI-X state\n");
> +		return;
> +	}

We have a helper function pci_dev_config_accessible() that does the same 
check, so might be appropriate to use (of course we would have to make 
the function global rather than static).

And maybe the check should be moved up before any config space access in 
this function?

Thanks

Farhan


>   	pci_write_config_word(dev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
>   
>   	write_msg = arch_restore_msi_irqs(dev);
