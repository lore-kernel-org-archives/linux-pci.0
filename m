Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEA03F483D;
	Mon,  6 Jul 2026 08:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783325871; cv=none; b=ODDsAvdmEwqMLLoGLZ29YO8Lin5JP7yNTsN0Dv8X+/unOvzwXf4f927UEAvNPILSQf98JXTE3nvK7RjxaS9Y5TV4aHCziWkEEkOQ4aS7cY9Ke70YrMw80gnb0vvgcSKmTvyeGhxN7mK2Emd68E4RZ7VgECQkjf5fUxGRnN5erBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783325871; c=relaxed/simple;
	bh=iLZ6867iJq+73XmcRz4F82yQUT2LS5YRsUSkvTe2BGc=;
	h=Message-ID:Subject:From:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=KDFZSsUraGeRAF2gFWBIAQ9P4GwZA59n35nXVc0WQj+a1eNGNRkwFeevCx+Te6h+Zf8j8Rg9jEvrtoMXaAjX5dMB0ecU5m4GaEPuMjqIAkToc2h0nnwHo4L8DJfqRkxUsuvZI+KvQa1F3n2VBLT8KwtkWHYJswqdJcceUpw9dkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P75fNvx6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P75fNvx6"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665MIBis2303828;
	Mon, 6 Jul 2026 08:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lLxNi+
	rPvdjMC3kupvIL1aindd1Ek8O6hKVx9pKGc1w=; b=P75fNvx6GcsYjl8s5wYysv
	1H1JYvp8RC4+Clr4cTvT/QwTYGC1vyLQeBrybRCLfVW1P1gniaXgb1cN4UXq0Cyg
	3beRTiBcpB+cDC/HKhT/MucyHX/ZnaoRTUXNGMwaVPu5JXzGgeyA/uMgT7NRiNQX
	u2nxRR3Cw/gZ694bVxz+GjNIITGa+3rt/WqmoFsi5X/DYoAPbVWmgA7t9yLTm7VW
	J/dk4pkRiVfto2R26lbmFgG/MI+07/t/BOn3rIJaEMnik83VFW4YkxghwRkElY6Q
	btCmBDQoexyYZi46O2WGmJNdozju7p4stMZpaW7EY0yH/JGeToLj3plRaUAzTagQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3ger1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:17:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66684o3l032057;
	Mon, 6 Jul 2026 08:17:40 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgjvqe2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:17:40 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6668Hclw1180188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 08:17:38 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F8275805C;
	Mon,  6 Jul 2026 08:17:38 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A52358051;
	Mon,  6 Jul 2026 08:17:37 +0000 (GMT)
Received: from [9.111.73.154] (unknown [9.111.73.154])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 08:17:37 +0000 (GMT)
Message-ID: <21033e817082413fc343ad155a0c8c5458e5e254.camel@linux.ibm.com>
Subject: Re: [PATCH] PCI: Fix AB-BA deadlock between remove and SR-IOV sysfs
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Guangshuo Li <lgs201920130244@gmail.com>,
        Bjorn Helgaas	
 <bhelgaas@google.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Gerd Bayer	
 <gbayer@linux.ibm.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260705152458.291832-1-lgs201920130244@gmail.com>
References: <20260705152458.291832-1-lgs201920130244@gmail.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 10:16:36 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4b64a5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=pGLkceISAAAA:8 a=Fa2UgvNqkNpMOhHjAtwA:9 a=QEXdDO2ut3YA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA3NyBTYWx0ZWRfX3xHGQH+Px1YE
 5ycmCZHuH69XeC+YO+sBiG7NuaQJTpvTPkJYGk5J9m81PK+ag0ZdRZIyISvvIyRzjv9P3Xl3lnQ
 PZDdma8df7mNP1zl9gwbFyBr4ENJ3VQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA3NyBTYWx0ZWRfXzDL0xR3hzWhF
 FTPqMCPY0vW6mXIHNrWdRAbUIKFAijvLcA1NGtOE0BvqdgklG/PsI3bGk+UM9FROzY3zswawaUz
 qUT6FrtBs79ABZg9VrpFYKC3SRI6yfPphLZohihCqvxyURayqSq5RRdS97PJDoX0nX+bphR8RYE
 GRZuL2vt8furLrm97k3jx/zZ6KjF0DIQHnIgqJFuNGLBjbh9C24YwsXftwIKtiA9Eaqi/EwZzHP
 lTpMIONXo2oO5WHfD1uc3TxiBcncuh2+/8KSAbMouAAwxbRxIHBCuCkPt8MCImJhevRj/zbYZdh
 2OPKNOaZa6Gn4uP2SJ38xcjwUuMcrxKL/DjsnJ21w+TjZPz8sBHiQvtAPd+qIeCK3oBdDakfAxA
 w0QKOrAm7LeDBUUKGXfOb+oxxO4l0wITyeiU/KGwsGfTV3Abx4X3jw2tWN1l8d5MQxgm43ZgyhV
 caQLrxqwiDSNfy7mfbA==
X-Proofpoint-ORIG-GUID: Bi2-oKP8cA9OTKRCjyq4Xxn9Zr3Ek02M
X-Proofpoint-GUID: CGEsgxnrxNnD75lqXUm1lEkyJKE1uVIr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060077

On Sun, 2026-07-05 at 23:24 +0800, Guangshuo Li wrote:
> sriov_numvfs_store() holds the PF device lock while calling the
> driver's sriov_configure() callback. The SR-IOV configure path may add
> or remove VFs under pci_rescan_remove_lock.
>=20
> The PCI remove sysfs path takes the locks in the opposite order.
> remove_store() calls pci_stop_and_remove_bus_device_locked(), which takes
> pci_rescan_remove_lock and then releases the device driver, requiring
> device_lock() on the device being removed.
>=20
> If a write to sriov_numvfs races with removal of the same PF, or removal
> of an upstream bridge that reaches the PF, the two paths can deadlock:
>=20
>   sriov_numvfs_store()       remove_store()
>   --------------------       --------------
>   device_lock()
>                              pci_rescan_remove_lock
>   pci_rescan_remove_lock
>                              device_lock()
>=20
> Avoid the reversed locking order by unbinding the driver before entering
> pci_stop_and_remove_bus_device_locked(). Mark the device dead first so a
> new driver cannot bind between the unbind and the removal. After the
> driver has been unbound, the SR-IOV cleanup in the driver's remove path
> has completed before pci_rescan_remove_lock is acquired.
>=20
> Fixes: a5338e365c45 ("PCI/IOV: Fix race between SR-IOV enable/disable and=
 hotplug")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/pci/pci-sysfs.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 5ec0b245a69b..5eae72508129 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -519,8 +519,35 @@ static ssize_t remove_store(struct device *dev, stru=
ct device_attribute *attr,
>  	if (kstrtoul(buf, 0, &val) < 0)
>  		return -EINVAL;
> =20
> -	if (val && device_remove_file_self(dev, attr))
> +	if (val && device_remove_file_self(dev, attr)) {
> +		/*
> +		 * Mark the device as dead so that no new driver can bind
> +		 * between the unbind and the removal below. Once the dead
> +		 * flag is set, the device core will refuse any new driver
> +		 * probe.
> +		 */
> +		device_lock(dev);
> +		kill_device(dev);
> +		device_unlock(dev);
> +
> +		/*
> +		 * Unbind the driver before removing the device to avoid an
> +		 * AB-BA deadlock between device_lock() and
> +		 * pci_rescan_remove_lock. Without this, remove_store() takes
> +		 * pci_rescan_remove_lock first via
> +		 * pci_stop_and_remove_bus_device_locked(), then takes
> +		 * device_lock() during driver release, while a concurrent
> +		 * sriov_numvfs_store() takes device_lock() first and then
> +		 * pci_rescan_remove_lock via SR-IOV VF removal.
> +		 *
> +		 * By unbinding first, the driver's .remove() callback,
> +		 * including any SR-IOV VF cleanup, completes before
> +		 * pci_rescan_remove_lock is acquired.
> +		 */
> +		device_release_driver(dev);
>  		pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
> +	}
> +
>  	return count;
>  }
>  static DEVICE_ATTR_IGNORE_LOCKDEP(remove, 0220, NULL,

This seems to be a complete duplicate of Ionut Nechita's patch[0] from
April. The comments are close enough, but not identical, that I don't
think this can really have been created independently. Interestingly
though your patch refers to the race with sriov_numvfs_store() while
Ionut's patch refers to an equivalent race with unbind_store().  So
this makes it odd for straight up plagiarism and I wonder if Ionut's
patches have been public for long enough that they ended up in AI
knowledge. Then some AI might have reproduced it so closely in which
case you should at least disclose the AI use. Either way the patch by
Ionut should be taken for being the original source of this fix. And
technically the fix remains valid from my point of view and my R-b on
Ionut's version stands.

Thanks,
Niklas

[0]
https://lore.kernel.org/all/b378529b4afc4f2a6e393498fe9b9b7f056f95c4.177675=
5661.git.ionut.nechita@windriver.com/
