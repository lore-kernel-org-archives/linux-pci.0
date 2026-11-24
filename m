Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543219;
	b=jHOiynCUTN2gbaqBQYpIBZ6g9nKdFUKZ1uUo2gUIoNssXU1bH8pztcACo8SZhi/c1vMB
	 7PkIqL/K0Eq8T6R4i0pPOn8akh0JPIg897ovyipBpW1pcSqzM2rvKwkLK60fVfbx/EXg+
	 v7Ei48G+vpVZdLxxzHhfsn0yRnBhc6oO21B76EHnwof0S9WNGzVT8N5emn9/gIiOT2gc6
	 QcTX12h0CBhBaPD6W8uEu+ihLFgfHvD0pTjAJr0mv7fgg7WI8hH+I1qIGIzFAa4bPkQWK
	 jB66CwMqyjeBevhqzDncS285ARcEjJlpCo/U5xKWeP0jtPLyFPhfcwIZhsgBMP7FbDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543219;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ycCgtFbnUFTrGmOIe0OARY346iGILkVRHavRitgLl4k=;
	b=Mjte6V3oj/TrF9HOLmR42OLTChH0ncQYOebi8oeZTTf2zyCyxLJWY7y01POZpHGCwT46
	 0U6mXrx9O2aBccLulXgMX2HQ32AMVNQ9uKvOJo/x7T4NseBXzvz4l9zdOyM+9pStaga0n
	 UcrvwUNr1ccSLNyGuNTSYxNXB97UnONLGkfFXl5gH2o1IfghFkuwp/kP1QEaX8VJmAiIW
	 ckIFSHZ2Gb2PCNKyr3PIQ1TIAdQhOB/HCaXefM5JQJxZV5Q8PHaIciv2zIJUamJ0PVZuv
	 gCtwEr+u9ba2UwP7LmlT1NGajpVK7xoTgjMtgOxM66b6f5n6Es4wYXY0MNNR91duV2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DajAxfGI;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447AC606A323;
	Tue, 24 Nov 2026 18:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 447AC606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DajAxfGI
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOFYXNo2857895;
	Tue, 24 Nov 2026 17:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ycCgtF
	bnUFTrGmOIe0OARY346iGILkVRHavRitgLl4k=; b=DajAxfGIzZy7xBkIRpubnL
	yMGE568+G2htTknnJUvIZyqipFsUxgw8fNA2/QfKvgFD+MfU6cnglYSIGBJGF5li
	Jvi8PMHi5XQytJFRQaL8lFD7OasH/KThccOOlEKRmGF2IlSc5Q2pno90G3K7285V
	7UJ6zz0bhhflrysMRQgXbQCoGRV5cCwkeVo9gPJ3TkbrA33aSoaf42Xpr1ixYw+0
	j0dNtsjLhA3efdYlKkF2iXebXYR2hUtWbB8EFSiqb9NVVtQW2sSPcrnOwkcV/ibD
	DGV3UH9DGhdVlX/5hxjLtCTd3V/tci+BxfFFC2qVugq63vwCLcAPRudDB3+/LwOg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g18kc5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 17:59:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOFJQ1b2467803;
	Tue, 24 Nov 2026 17:59:47 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3qufubrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 17:59:47 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AOHwsmN18875022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 17:58:54 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1642F58053;
	Tue, 24 Nov 2026 17:59:46 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0111058043;
	Tue, 24 Nov 2026 17:59:45 +0000 (GMT)
Received: from [9.61.251.62] (unknown [9.61.251.62])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Nov 2026 17:59:44 +0000 (GMT)
Message-ID: <67707a70-ae59-4f49-8087-6ceaf9535db5@linux.ibm.com>
Date: Tue, 24 Nov 2026 09:59:43 -0800
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
Subject: Re: [PATCH v1] PCI: Ignore Immediate Readiness for Samsung a826
 device
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, lukas@wunner.de, mjrosato@linux.ibm.com,
        gbayer@linux.ibm.com, schnelle@linux.ibm.com,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Judy Brock <judy.brock@samsung.com>
References: <20261123225006.GA1117350@bhelgaas>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20261123225006.GA1117350@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: F4fHmwfWHDL_xbL-8Y2U6KSU6CcOIYL9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2OSBTYWx0ZWRfX8FnjU8Kccr1N
 uMoYpqC9s9EGbM+NhbtvIIbKcTjtvtmj4Ff9s6ieaaU20hj2U7CaodWYoZqE93XJJkzUowdZZEZ
 wCslAEg+45YjljLpAXNZaiJ3FCPij1A=
X-Proofpoint-GUID: wVWMIOXPVFAnrNi6Ew9Z3kl6_svjerl8
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6b05d094 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=2LOvVq9JJqQxHECtSV0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2OSBTYWx0ZWRfXwQfKWDMOl1RQ
 bXNZZvPONCBijBbE9TwBldUMtvWSm9wsl0w2KQ4L6t3DlGbB3ifRc4cwwH32SPgveydNXWtLqXS
 /ARTVmzKPL8XbuVuc7OVg3+yTKigiNJNeF0bvnXnzRecgzZN/AROZTaZxK2IAq6LaHt4DK3lmLc
 pdLBKEmeeW/77d1czxZqZGNkRcnagAKp/M/ua1uudQ/iAN6YyzAhBGA9IMWP26tPUFZ3kDloBBP
 /PE22JeaLbDmnYuN9QQSL//2ATklSPFxeDzVb7+/mNnH5V9BQluc4jr/JSY9nvZjz+ZqDJQetRb
 c74zVeH+SRFhovOHkVo8xGw2kX4VU91IIILsLOMx6fcLbU2OzJJw4EJxBdIie6+dwOr4F8AF7Yt
 vNw07RwY9EP0c5PecRIaLHWhqykRn57hGUcledIn5w6iLvxrETypNDpioSBw3bR8En+iRbAP9QZ
 Fb9qaDRpmfcP4o3ti3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240069


On 11/23/2026 2:50 PM, Bjorn Helgaas wrote:
> [+cc Kanchan, Nitesh, Judy (scraped from lore Samsung NVMe traffic)]
>
> On Mon, Nov 23, 2026 at 01:53:08PM -0800, Farhan Ali wrote:
>> The Samsung NVMe SSD Controller PM174x [144d:a826] advertises Immediate
>> Readiness, so pcie_flr() doesn't wait after FLR, but the device isn't ready
>> yet and config reads return ~0 after the reset. This happens with
>> firmware version SNA6SNA6 or older.
>>
>> This was seen on s390x with the nvme driver bound, by resetting the device
>> via the sysfs reset attribute:
>>
>>    # echo 1 > /sys/bus/pci/devices/200c:00:00.0/reset
>>
>>    nvme 200c:00:00.0: Unable to change power state from D3cold to D0, device inaccessible
>>    nvme nvme0: Disabling device after reset failure: -19
>>
>> Ignore Immediate Readiness on this device too, so pcie_flr() waits.
>>
>> Fixes: 10baa9b4df40 ("PCI: Drop unnecessary retries when restoring BARs")
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   drivers/pci/quirks.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 4a02fc80755d..11c3b45afe78 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -5790,6 +5790,7 @@ static void quirk_no_imm_ready(struct pci_dev *dev)
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SAMSUNG, 0xa80c, quirk_no_imm_ready);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SAMSUNG, 0xa80d, quirk_no_imm_ready);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SAMSUNG, 0xa80e, quirk_no_imm_ready);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SAMSUNG, 0xa826, quirk_no_imm_ready);
> We already have:
>
>    996a59519af2 ("PCI: Ignore Immediate Readiness on Samsung PM9D3a NVMe")
>    0f8b5d90d179 ("PCI: Ignore Immediate Readiness on Samsung 990 PRO and 990 EVO Plus NVMe")
>
> I wonder if something like the below might be safer and avoid an
> ongoing series of quirks.
>
> The spec (PCIe r7.0, sec 7.5.1.1.4) says that when Immediate Readiness
> is set, "the Function is guaranteed to be ready to successfully
> complete valid Configuration Requests at any time" and "software is
> exempt from all requirements to *delay configuration accesses*
> following any type of reset."
>
> I thought that meant Completions for config requests would always have
> Successful Completion status, but I guess one could read it as "device
> must respond with a Completion to an access immediately after reset,
> even if the Completion is RRS."

My interpretation of the spec was also a successful completion of the 
config space requests. As Niklas mentioned we see the problem with 
devices running an older firmware version. Maybe Samsung folks can say 
more about how these devices actually implemented the spec with regards 
to Immediate Readiness.


> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7c6f2aba8144..c9f95852e83d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4457,15 +4457,13 @@ int pcie_flr(struct pci_dev *dev)
>   
>   	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
>   
> -	if (dev->imm_ready)
> -		goto done;
> -
>   	/*
>   	 * Per PCIe r4.0, sec 6.6.2, a device must complete an FLR within
>   	 * 100ms, but may silently discard requests while the FLR is in
>   	 * progress.  Wait 100ms before trying to access the device.
>   	 */
> -	msleep(100);
> +	if (!dev->imm_ready)
> +		msleep(100);
>   
>   	ret = pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
>   done:
> @@ -4534,16 +4532,14 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
>   
>   	pci_write_config_byte(dev, pos + PCI_AF_CTRL, PCI_AF_CTRL_FLR);
>   
> -	if (dev->imm_ready)
> -		goto done;
> -
>   	/*
>   	 * Per Advanced Capabilities for Conventional PCI ECN, 13 April 2006,
>   	 * updated 27 July 2006; a device must complete an FLR within
>   	 * 100ms, but may silently discard requests while the FLR is in
>   	 * progress.  Wait 100ms before trying to access the device.
>   	 */
> -	msleep(100);
> +	if (!dev->imm_ready)
> +		msleep(100);
>   
>   	ret = pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
>   done:

This change looks correct to me, feel free to add:

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>


