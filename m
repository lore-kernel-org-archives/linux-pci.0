Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C60408612
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789492122; cv=none; b=kpqocrFGMKr6PkM32uwZSSlKKVIB0LrSOKlm8Vw5lcrP06RtegFHe0ozCll2UvYKjooJ0/9Ap6ExOa3AypKsOkl0K6MNb8S0y6d2DbSZLQ48mZd8PQcIe2DH9oF25j5QAPRICXhYF9glQXHI3ekEE57MdWDAGOo/Y9XuyIyHyVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789492122; c=relaxed/simple;
	bh=iKI7Bj9viUvrtKGbobY5GgeX5uQR3KF3uuio5XqeTGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H1Cy+RjIuBfSywgbu18nWmuECOEmBYvIzAaUc5nFleZAGLp3qQhyygM3DEZXIxIIDs7H3t6kKDqi1UnfzEZWG2X5enLFvlPORcA5oQfOMz7pWdRpdp5tIbzgLob/7bMmykLDCGA+nkkqogtTBW+vpB/nWjPBbBcw7KPWDDA6ZDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sgOyB382; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sgOyB382"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FFVmoF035845;
	Tue, 15 Sep 2026 17:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yA1ULx
	muodc27fMStYe19S5MzJzAOPLmlLNrCDQgJxQ=; b=sgOyB382A40dtUFeiGEHTI
	OaYEMYUVKnAMGXDlVe2l01jB2CtBupbdYW/eJaN5gTeKt5kxZsTw4a0x0S288G9q
	4D1eH4TLiL1ifzEiA04il9FaSeyHopvjvUThvWNyGsqk20AeOTXnVduOo04h9CNV
	o9FNuGeGyi1/hpzsbdWONwVwHNxalP4xN62fzlCaSV6aRK3Jg+ldZSiNeWO6RYoB
	zJDbVbBjhJsPCOpG//BCmfzCZ6fYSlZCxCopoCCwIQX2dxrkbqiTNNR/oRKvsq6P
	JvSaeQ4I5A3Oln6nCfvhzSmosjkmcb5XnJvxzYXLpAEeWqsDNpW6a12IiDxqis2w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5e04k7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 17:08:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68FFAcOY4154552;
	Tue, 15 Sep 2026 17:08:33 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gq089jayh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 17:08:33 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68FH8XkI8586166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Sep 2026 17:08:33 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0685E58059;
	Tue, 15 Sep 2026 17:08:33 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 516F558043;
	Tue, 15 Sep 2026 17:08:32 +0000 (GMT)
Received: from [9.61.249.123] (unknown [9.61.249.123])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Sep 2026 17:08:32 +0000 (GMT)
Message-ID: <6a45ad46-efa6-47fd-9408-302ea8bb66e2@linux.ibm.com>
Date: Tue, 15 Sep 2026 10:08:32 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Fix order of device disablement on reset
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Riana Tauro <riana.tauro@intel.com>,
        Alex Williamson <alex@shazbot.org>, Keith Busch <kbusch@kernel.org>
References: <4c908eaab127d82ecfdc1e9948964b2e641d41d8.1789478646.git.lukas@wunner.de>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <4c908eaab127d82ecfdc1e9948964b2e641d41d8.1789478646.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI0OSBTYWx0ZWRfX1s+WNSRSv9wj
 WGDohHbvLwt8OPX9v9ZgbaInBczycBlzTFyD5SdHg1hlWHXk+vTyP3LVi66hYaqbqApySK8i9zv
 fd0oduk+6ADZVeTOiY3tpZ0VjMrG+itqf4il9Pgyb8hZEWBwXlKAw92E3dQ7iXCJroX0opNtOFa
 7QeCPcrE2OtMzbJrlZXge9duTsjIiLr4dA1be1hT31V6A48H076oQXoS0Z1i5zBDA1ANnltHdzE
 2VrOsgRSw0w1VBBs7ptdiX68SH3C8kk89uwiqmIJcQzoL7KInukKZAiNlQnYHp8C8qaDqCuIiL9
 5ljodJzGHwI0Ay1WmS5yySLAZtRRCwsm2LfxBi8yApSqiyCkkAKhfyWrvziPs1r/+Q1G2R4T/P5
 9Evl8C0BuPTOBjl0YQ56ozh3arFvBCs2do4wl+DpKVYoFfp5mjRpB0hThI747xMUX05bzAkoNUM
 X+itGdExKedjDVwzsKA==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aa97b91 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=_REshyblgrS0cHj4K0oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -dU2toFOGMuteI2ELq6oWHaT9xPSUytE
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI0OSBTYWx0ZWRfX/MQkmSXsVRRp
 Vein+GdxeTz0GBDYyMb7RZF5ksWVUxLEDHJw7GLcCi29y6O4LLlyRsL4da66G9ujx8p2vjffK/T
 74Mgquv6bUh+G1cSBukzyFeaFDglZbI=
X-Proofpoint-GUID: -dU2toFOGMuteI2ELq6oWHaT9xPSUytE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1011 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150249

Hi Lukas,

On 9/15/2026 6:35 AM, Lukas Wunner wrote:
> Riana reports an AER splat when issuing a Secondary Bus Reset through the
> "reset_subordinate" sysfs attribute:
>
>    AER: Multiple Uncorrectable (Non-Fatal) error message received from 0000:01:00.0
>    PCIe Bus Error: severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Requester ID)
>      device [8086:e2ff] error status/mask=00100000/00400000
>      [20] UnsupReq               (First)
>    AER:   TLP Header: 0x40000001 0x0000000f 0x81190008 0x00000000
>
> The Secondary Bus Reset is issued at the Root Port.  Underneath is a
> Switch with two Endpoints.  Riana has identified an ordering issue in
> pci_bus_save_and_disable_locked() as root cause of the AER splat:
> The function calls pci_dev_save_and_disable() for the Switch Upstream Port
> first, then recurses down to its subordinate devices.
>
> pci_dev_save_and_disable() quiesces a device by clearing its Command
> register (in accordance with PCIe r7.0 sec 6.6.2, "Implementation Note:
> Avoiding data corruption from stale completions").
>
> On devices with a Type 1 Configuration Space Header (such as the Switch
> Upstream Port), clearing the Command register causes MMIO accesses to
> subordinate devices to be handled as Unsupported Requests, as seen in
> the AER splat above (PCIe r7.0 sec 7.5.1.1.3 bit 1).
>
> The drivers of subordinate devices are only informed afterwards of the
> impending reset via their ->reset_prepare() callback.  They get no chance
> to stop access to MMIO space before the Switch Upstream Port disables
> access.
>
> Reorder pci_bus_save_and_disable_locked() to recurse first and only then
> disable the Switch Upstream Port.  This mirrors the order in
> pci_slot_restore_locked() and avoids the AER splat.
>
> Do the same in pci_slot_save_and_disable_locked() for consistency.
>
> Fixes: 090a3c5322e9 ("PCI: Add pci_reset_slot() and pci_reset_bus()")
> Reported-by: Riana Tauro <riana.tauro@intel.com> # off-list
> Tested-by: Riana Tauro <riana.tauro@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v3.12+
> ---
>   drivers/pci/pci.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6..ce9f74d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5508,9 +5508,9 @@ static void pci_bus_save_and_disable_locked(struct pci_bus *bus)
>   	struct pci_dev *dev;
>   
>   	list_for_each_entry(dev, &bus->devices, bus_list) {
> -		pci_dev_save_and_disable(dev);
>   		if (dev->subordinate)
>   			pci_bus_save_and_disable_locked(dev->subordinate);
> +		pci_dev_save_and_disable(dev);
>   	}
>   }
>   

Since we are changing the order, maybe we should update comment for the 
functions to reflect that. The change does make sense to me, but I am 
curious why we didn't see this before?

Thanks

Farhan

> @@ -5543,9 +5543,9 @@ static void pci_slot_save_and_disable_locked(struct pci_slot *slot)
>   	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
>   		if (!dev->slot || dev->slot != slot)
>   			continue;
> -		pci_dev_save_and_disable(dev);
>   		if (dev->subordinate)
>   			pci_bus_save_and_disable_locked(dev->subordinate);
> +		pci_dev_save_and_disable(dev);
>   	}
>   }
>   
