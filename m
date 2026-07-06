Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A736238837C;
	Mon,  6 Jul 2026 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348622; cv=none; b=Km7A/phmvWJW5veJDOeeWgStzmw0dvfy6sN1cQ6yk4uaPHX8aIPJXM8q2UaHsRtMQBzyc1H4K1h7IRcUvFGdn8buJG2MN/OqSW7g7xuYOohmc7PFxafL0otcVCZnvLSaP+BreOQ43yedPc1aZxrZryWfxgKUiC+FPPdQDjoCTss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348622; c=relaxed/simple;
	bh=KQBNsBb7QF4hJFGDga/HRoWAgT98irW6plMNoiaoUjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtvbw3KsBGkHRxq0C1NkwSGvLXdSQXB+xEv94a75X55dfJX4pr8vJHO7iXZpeTa7EPHWDTGQNcWHxzwlWUbN5KsqLFeUvrt1AWkjYEnJHZ3MN5L5igAj9KzM8BO3vu6tgXQaTPJ7TNf3sOUeTss3NQDKTfCazQJf3PesN+VMzmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eZEOwtz3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eZEOwtz3"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666EIeUh3919524;
	Mon, 6 Jul 2026 14:36:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=1KUxVVnd8jZajQxftW6X+ImlML2qkzKsaY+RxrlZr2g=; b=eZEOwtz3viYA
	26P9I/Dz99SOS+gan11BKruh0HJBJysDdy3BlbBtHimGV3QTuOVqqcvb7HvA0wOg
	w9eNfzJP6hJe7dQgohb7CNukS30yAj1y7e76q8B1367Mcg6xwPfVdvyd32THAT3D
	Dq9ZQqII+MipsPFp+dbwGU1XF5w4wzfJNg4FM1zw/epPSd6vhQ2fxzgr7S1hVoMe
	Do3/5NpcIrQDdRxKYGnFGXSkPOmTz+SpUjcIncqgty6nrIM8iYOipxYIkTJ07ymj
	/RRXRV2BhMlcftXgsd2x50CpzgGauFiBEh10plEPxrBRcBtUTVbDKSUQFxHf7NUU
	sE4KLb69iQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdjhqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:36:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666EYipj029930;
	Mon, 6 Jul 2026 14:36:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0h5vmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:36:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666Easma50987264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 14:36:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E762320043;
	Mon,  6 Jul 2026 14:36:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4AB120040;
	Mon,  6 Jul 2026 14:36:53 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.111.22.53])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  6 Jul 2026 14:36:53 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.4)
	(envelope-from <bblock@linux.ibm.com>)
	id 1wgkRJ-00000002B1P-2CEN;
	Mon, 06 Jul 2026 16:36:53 +0200
Date: Mon, 6 Jul 2026 16:36:53 +0200
From: Benjamin Block <bblock@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Gerd Bayer <gbayer@linux.ibm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix AB-BA deadlock between remove and SR-IOV sysfs
Message-ID: <20260706143653.GB17215@p1gen4-pw042f0m>
References: <20260705152458.291832-1-lgs201920130244@gmail.com>
 <21033e817082413fc343ad155a0c8c5458e5e254.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21033e817082413fc343ad155a0c8c5458e5e254.camel@linux.ibm.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4bbd8a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=8nJEP1OIZ-IA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=TWjroOOoPvuzJpvNKDgA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0NiBTYWx0ZWRfX0bDC6X5gE7/+
 TnuHY9YSJyr0BMy0u72uwBm4unTUhdL508yM2VisVdSKtx7kEt1JdicHJf9/4fkxCE5pw6guClG
 INJGyRhorUn1by/qlihOWHAhoIU2PBEE0OCJqcEv/Xnnz9Z068ZhpBHrws2t3eX1fKMfyBbKjPG
 wG7ttqW13HAF8AO+zV/WKSmOiFgN/nT3OSYOIXjUjC5tv++dMVeSL0cgEXNQVONINOSSmguqEns
 lVphbpl+WDXWGBsFjTF3s583wy3T/7Hn4HfzDGi1sOq9wIb/BrdzhJfaG52/yKSi9flrSznWFr5
 oMsSJRdvFXWIhsv8qxAqXeVC8D4niRNxI8dHLVyiIa2oOB3zaAL1SBQiLOMgECbuTPpmIqSCha3
 +S1lFandD+NIUSGMRA4ez0dPY+DJMJK106kVb3ak2v2PBIcwxl8JviE4Wic4aqPxbFi25790045
 peZ96KrwI2vXKs9Lqlg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0NiBTYWx0ZWRfX2OmDcOG35tvn
 8rESmAeWYgb4dJSggJjltj3+dq8rsJj7a/7raDNo+sEfEdlbeUSOnDKgGAyP6/CdmwXiulk05F0
 KMFL8fmiEwfvN7RIn5cEUYIrRHAxuVk=
X-Proofpoint-GUID: Q60lbSYPjPWtCG-W6KEv7jFf9A5zWqXX
X-Proofpoint-ORIG-GUID: -cTBhmh4PTUYtfYrChami6Fp0uHKqrYY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060146

On Mon, Jul 06, 2026 at 10:16:36AM +0200, Niklas Schnelle wrote:
> On Sun, 2026-07-05 at 23:24 +0800, Guangshuo Li wrote:
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index 5ec0b245a69b..5eae72508129 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -519,8 +519,35 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
> >  	if (kstrtoul(buf, 0, &val) < 0)
> >  		return -EINVAL;
> >  
> > -	if (val && device_remove_file_self(dev, attr))
> > +	if (val && device_remove_file_self(dev, attr)) {
> > +		/*
> > +		 * Mark the device as dead so that no new driver can bind
> > +		 * between the unbind and the removal below. Once the dead
> > +		 * flag is set, the device core will refuse any new driver
> > +		 * probe.
> > +		 */
> > +		device_lock(dev);
> > +		kill_device(dev);
> > +		device_unlock(dev);
> > +
> > +		/*
> > +		 * Unbind the driver before removing the device to avoid an
> > +		 * AB-BA deadlock between device_lock() and
> > +		 * pci_rescan_remove_lock. Without this, remove_store() takes
> > +		 * pci_rescan_remove_lock first via
> > +		 * pci_stop_and_remove_bus_device_locked(), then takes
> > +		 * device_lock() during driver release, while a concurrent
> > +		 * sriov_numvfs_store() takes device_lock() first and then
> > +		 * pci_rescan_remove_lock via SR-IOV VF removal.
> > +		 *
> > +		 * By unbinding first, the driver's .remove() callback,
> > +		 * including any SR-IOV VF cleanup, completes before
> > +		 * pci_rescan_remove_lock is acquired.
> > +		 */
> > +		device_release_driver(dev);
> >  		pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
> > +	}
> > +
> >  	return count;
> >  }
> >  static DEVICE_ATTR_IGNORE_LOCKDEP(remove, 0220, NULL,
> 
> This seems to be a complete duplicate of Ionut Nechita's patch[0] from
> April. The comments are close enough, but not identical, that I don't
> think this can really have been created independently.

Yep, +1.
This is not helpful. We still want the original patchset included (I sent a
ping a few minutes ago), but then in its complete form with the proper
authors.

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294
