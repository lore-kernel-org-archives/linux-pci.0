Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114FD382F1A;
	Fri,  9 Oct 2026 17:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565705; cv=none; b=DRZKHSyd5phLCP33eGXJKCb+TgQM6K1UeKrS3iS2BRi/a2unzj+8AxEapFCg2aV8lvU+CtfV1f5jMWpFl9Ckijcis1HQo0xnDVpERUHlFcqqR6J89Z63BvIXP3fUISm5LcSKc7d+MKeeJFLbn1cX8JatbneJCfWApSFofsYsRfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565705; c=relaxed/simple;
	bh=6YzTNOLTT1Te9JhJDtNggsuthcxl1b3q6N63kjISzg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NdYNXTIpfHmn2oP9Gc7RmQkung+by11yK4ozVL06HOPVj+GIz9lgfA/wkzXYfoTGi02ntplb8Nsu3G7oAXekOIFj4IGfC97yt6Q01JZ5eksUqm6rXLWsH7uxGyF8BH9zy3aqPHV7RHnPadBpa+VSMKnn0/Sz65Ml7z1W4J7HYBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=obtGyV1j; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="obtGyV1j"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699H6xiv636456;
	Fri, 9 Oct 2026 17:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wXIsN+
	s46Yidwn8rxJkjnKxRl2Vxbvm8hA0IJ2zcWRQ=; b=obtGyV1j76gcby9omZ9iv9
	dBIYr4z+Yq91nzkFJpa3KnHQOD4hZOUJlBly0uggh/dZoQF0dkGzhdmwae6cMcIS
	PAAFQVbe7yFLJ/c5ow+G8NTvR022CQCiqKdbvW+JoWeBbjuZsh236o09OS+uVrD8
	xQYKNvqRFRDpoF/FJoG8M/k1BY18p/9nWgP2A4/YxbjwlcqMSfq47Loh642vmnLV
	Y4tiwDyLiPbdP8cOZfvfrWiWEpmlJzA8y8601WH9FXOnhbPmpQIRq1+PZl9I5Tqp
	S6VCsx+7xOdQSnDThORaTQnQZSQwq1ybokt2BsCgl0QzWNg5pvREYIeyRxMm6e2A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvm0up-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 17:08:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 699H8Fst1204260;
	Fri, 9 Oct 2026 17:08:19 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h6x1y9egx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 17:08:19 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699H8IT824904234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 17:08:18 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47CF35805D;
	Fri,  9 Oct 2026 17:08:18 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B61158043;
	Fri,  9 Oct 2026 17:08:17 +0000 (GMT)
Received: from [9.61.241.153] (unknown [9.61.241.153])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 17:08:16 +0000 (GMT)
Message-ID: <7ed02ff5-d7f8-42e4-bca9-b3d3ce7b6795@linux.ibm.com>
Date: Fri, 9 Oct 2026 10:08:15 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] PCI/PM: Do not save the config space of an
 inaccessible device
To: Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?Q?Francisco_Beltr=C3=A1n_Millal=C3=A9n?= <fbeltranmillalen@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Andreas Noever <andreas.noever@gmail.com>,
        Mika Westerberg <westeri@kernel.org>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
References: <20261008225825.GA936610@bhelgaas>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20261008225825.GA936610@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 4ZH1ueigKIh6mBxxAAiJQcABL3lcmDGH
X-Proofpoint-ORIG-GUID: U-Ctq-YPjyfDCPUwRMooOgyuISM7Qvli
X-Authority-Analysis: v=2.4 cv=H8NOUOYi c=1 sm=1 tr=0 ts=6ac91f84 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=522apck9F_D-Mxne:21 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=VwQbUJbxAAAA:8 a=K2jGQ8kdn3RRRsgUj50A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2OCBTYWx0ZWRfX+zU5PmotcETz
 z52aRkY5DLV5YppuNg6KpH9GpeZFH2wh29oMmHpRlRWH3jdl30aQQW1X+n4sSLzDvxaJs8Hd/q3
 w5GiEcK+RRGAZcl9QLDgGOv1GXMOl7XRSNvHZGX3jSnyGHrhds6Gg5w7rgd1OyPMWodvb8Locr4
 sGLJ4XLpMYw72Z8KdKKTnJ5gyNn9835ZLo6AUkX5p3sgXC6kjOFaG0SL1uN7Nc9IvXe2euujppy
 ZiVC0BjbhgcDgsPM7XOljXOEEKK5tmWceg+7uKvGOkX6G6Mik0AIzXPbkjctTNK8VBeucOR0JTC
 x4K79P3M/QIGXcuNgCNl6vxUMoVJ8e9I1xpQGDeGAsY2BJMjRbOhjah9JdObNfKKVkHtu+ysaHR
 aq3VoEla3Zras3BqFXLeFJQj7XqF8T5mpHv2Pgdg2YD5O5XF6ZF+dNdX7GpEi+dhE7UmCsLSJv0
 CnEz69s1Ff9QYGNBGRA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2OCBTYWx0ZWRfXysn1JeKRxtgv
 7b1m6IBE5yqSjuuT+hICG6HDN25qvDx1Y0X/R9H0yAEvflwZqODjcs5WAcoxK8oCpADMbQZosSI
 KyNli6v9xIUWeXHrbDCBae3XbnwS64A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1011 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090068

Hi Bjorn,

Thanks for cc'ing me.

On 10/8/2026 3:58 PM, Bjorn Helgaas wrote:
> [+cc Lukas, Farhan, Andreas, Mika, Yehezkel]
>
> On Wed, Sep 30, 2026 at 11:19:13AM -0300, Francisco Beltrán Millalén wrote:
>> pci_save_state() reads the standard header into dev->saved_config_space
>> and marks it valid without checking that the device answered.  If the
>> device is not accessible, every read returns all ones, the previous
>> snapshot is overwritten, and pci_restore_state() writes the all-ones
>> values back once the device answers again.  On a bridge that sets every
>> writable bit of the Bridge Control register, Secondary Bus Reset
>> included, and sets the primary, secondary and subordinate bus numbers
>> to 0xff, which cuts off everything below it.
>>
>> On a MacBookPro14,3 this happens to the upstream bridge of a
>> Thunderbolt controller that drops off the bus while the system is
>> suspending: after resume the bridge answers again, but with bus numbers
>> ff/ff/ff and Secondary Bus Reset asserted, and the xHCI controllers
>> behind it are removed.
> Apparently this is a reproducible issue on MacBookPro14,3.  That makes
> me a little hesitant because we're not actually dealing with the fact
> that the Thunderbolt controller isn't responsive during suspend.
>
> It seems worthwhile to me to skip pci_save_state() if the device isn't
> accessible, but I don't think it's a real solution to whatever is
> going on with Thunderbolt, and I don't think we should mention it here
> as though it is.

When I had initially looked into this, I had proposed adding the 
accessibility check in pci_save_state() as well [1]. Though Lukas had 
some valid concerns around the additional overhead from adding it in 
pci_save_state(). But maybe its worth re-visiting again?

Thanks

Farhan

[1] https://lore.kernel.org/all/aOQX6ZTMvekd6gWy@wunner.de/

