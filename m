Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794334201;
	b=phshgcjsAid3uYQqPv7SByTY19plbFhh3XDDU5uiQGz7AsalX967VGZ0vv9rj/ltyOoW
	 ldUSUFUtL4sLBMxMBoSQEFjKUtp18obdw35ysVFy/4xTrq3NRzaplbGcVupWZ7gSG9vHN
	 ft6LKwdsfBmln89fFL+gK0Rwld+F3S2ImAtb9gTZtFXYNa78KLEWqj+/GbYjwTgbKjFKz
	 XeJ5F7yzd7ro+JB2CCpwsu8ixbJ3U7BaXWFuQ5KnREMCkCmmNy59RYRSwvp4qSnltzoKa
	 2XaDDZW5+H3SQUEbWx42wZ9CuM0oNC01sRtl5SiyCqFVLbD/lSJmXzdROTzm4AKih3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334201;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=KyNLyJ59IYIaSlS7tMazvluiNDcXTEZYEy2hLQRHv9U=;
	b=Dn/UFXCD0WVTO6NPXtb3iaj5LaZcqUR8LIeSBXPOJaF8JNvlvSBn1BsnxfLhs7qCEj8E
	 XzkAJXguFIvQa33D2NmUACDr7bnfUo99enG6L/tBMBlKR+T5eys0XtM6eadpDMdXPPfYe
	 r/m+PGLadX39H/LUBpv2rsQnXeX/VPMKL7GPH/kFzj/9gGcUHrETCHp7yk4HqVOl7znEH
	 wlnLTjA+sYYpIC9ldAqSnPMZY3wZf/qrlmHSHjiWAiB1LeVzJyu3pI6YfL+5dAffsDulB
	 8hcw76r6UjlyybS1j6vk++gPPz62LU9B4UhB9TvSUxxCikIjZ/+LDlx+7rVQ+0acarA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eiPWudpf;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E59606A31C;
	Tue, 10 Nov 2026 18:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98E59606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eiPWudpf
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAFE7nH1449702;
	Tue, 10 Nov 2026 18:09:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KyNLyJ
	59IYIaSlS7tMazvluiNDcXTEZYEy2hLQRHv9U=; b=eiPWudpf5DOOxLBYDEhyxh
	FTrdt6zo8Y0FQW2+mPS57xaflyRGGUaZfAvZ9mPv80TwiASuyIO1mWrHX+oAlJe0
	tNcGQVDLyNvW4X9ef8yxPIB81WgafmJHMywyARc/zFZtMGZ4M6uxFn2qNm4k9gcm
	vWiDA2oY56yJhKJIX+/8oekw0ylD9jSk1qiMwftloRndj/WUgVBUMTX7BjMYN4Mt
	nNvgX7I+PoVnW7S09pLC3udvQE71U1P0Ww6U5U8jX1PXLFkZUVloQaA2GP0Eqg4C
	vBcXMazpC5XatWas7AcF1YD+b1Xq2u2392EI3EQoADCuUtJPktevkYMziEOZW+jQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdg5wvw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 18:09:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAF4sBm1979905;
	Tue, 10 Nov 2026 18:09:50 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hv4nsrwmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 18:09:50 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AAI9nB28979102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 18:09:49 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A53B58056;
	Tue, 10 Nov 2026 18:09:49 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1EFD5803F;
	Tue, 10 Nov 2026 18:09:48 +0000 (GMT)
Received: from [9.61.242.226] (unknown [9.61.242.226])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 18:09:48 +0000 (GMT)
Message-ID: <04e0b460-da19-458b-a042-753608e67c68@linux.ibm.com>
Date: Tue, 10 Nov 2026 10:09:48 -0800
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
Subject: Re: [PATCH] PCI: Only restore state that was successfully saved
 around a reset
To: lirongqing <lirongqing@baidu.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261110053348.2419-1-lirongqing@baidu.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20261110053348.2419-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af35def cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=zuLzuavZAAAA:8
 a=YKsy9tBkadnfDYZEnRAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA3MCBTYWx0ZWRfXziymyQ706Q7/
 RTAr4R3WFQQqHxQfWNjaB2f8Cgc61S3PAl48qThdIc+r7Y8HrSee9ae457qh2qYyPIbMu9MPfqd
 HdoGgieiisgWePEf3s9fuzWdQHMLmnCgeap43n3+ICmR4tbPPC0ajbu17kPbXYY8NvdyXqWXEZo
 BJT//CypXaE9R1JlhvuEfxHsjWBBU7Il9vHqe4ALgShu1T9wL/GUGsTwh5FtZmuy20/7j+Hy03c
 QfGfVh2IY9oot3A09Q6miw0xVI7odE/G/V3/NRHWarfkiIkJXr5evnguQjTxmzfB4++nL8b1hyM
 odisCl4QzrXqZARvx6tpKBtk5jyHTmxKsbJKUEvAmOirM24ozF6DBq9rSduhEoljXrdf8oZbHjK
 hLUN9DcuTHVsjL8dnXv1uBUlSN9ya9cDtkbaBGaZHzaUTaxfvbjhNBgpeKdpR37HEtaWkOrGVyf
 jTVCl8Dj4mUh+AYrx9w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA3MCBTYWx0ZWRfX9hr4ZlsQasio
 8glXPSDymKYJ7/hHeaVh1F95P/+fL32h8Tn1HRJqalhnA30HW6yohuWUNQVLOAdBym6jbgi0UQf
 4C9sYo1uYI4exnKTCoui37jQOu/thdc=
X-Proofpoint-GUID: vUe9x-MIjA6wyTxIcFb9bdKOcOii5CSJ
X-Proofpoint-ORIG-GUID: 6lhXkhHX5k03QrsEKFfnAWMYFPhNKIr6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100070

Hi Li,

On 11/9/2026 9:33 PM, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
>
> pci_dev_save_and_disable() returns early when config space is inaccessible,
> without saving anything, but pci_dev_restore() calls pci_restore_state()
> unconditionally and pci_restore_state() does not look at state_saved. After
> the reset makes config space accessible again, the all-zero or stale
> saved_config_space[] array is written back to the device, clearing Command,
> BARs and, for bridges, the bus number registers.
>
> Clear state_saved when the save is skipped and only restore when a state
> was saved.

We should always have a valid state of the device saved at enumeration 
due to commit a2f1e22390ac ("PCI/ERR: Ensure error recoverability at all 
times"). In pci_dev_save_disable(), if the device is inaccessible then 
we want to avoid storing a state that can corrupt the device on restore. 
Since we always have a valid state, we would restore to the last good state.

May I ask what device or driver do you hit this issue?

Thanks

Farhan


>
> Fixes: e18d1abc3bff ("PCI: Avoid saving config space state if inaccessible")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>   drivers/pci/pci.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 67fe565..ddb86dd 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5156,8 +5156,10 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
>   	 */
>   	pci_set_power_state(dev, PCI_D0);
>   
> -	if (!pci_dev_config_accessible(dev, "save state"))
> +	if (!pci_dev_config_accessible(dev, "save state")) {
> +		dev->state_saved = false;
>   		return;
> +	}
>   
>   	pci_save_state(dev);
>   	/*
> @@ -5175,7 +5177,8 @@ static void pci_dev_restore(struct pci_dev *dev)
>   	const struct pci_error_handlers *err_handler =
>   			dev->driver ? dev->driver->err_handler : NULL;
>   
> -	pci_restore_state(dev);
> +	if (dev->state_saved)
> +		pci_restore_state(dev);
>   
>   	/*
>   	 * dev->driver->err_handler->reset_done() is protected against
