Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D03E49483D
	for <linux-pci@vger.kernel.org>; Wed,  7 Oct 2026 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.183.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791380180; cv=none; b=IYa5JvRsaZ8jH/9G+Y/3eEyxLz+eMxA+evpZBjdPOY9Aa4SY2w20zMP3iCVJMcMNeqQT6inJhID3DHG6pragMuzi90MwKXf4s3BEkTjtSZL600YztzPBql18AowgpvOsdFk7Xxh4JuPgbMIwr8NC27+8eLv+h5CMr+VfR8xli3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791380180; c=relaxed/simple;
	bh=gOeiPCRD26TrJcn5uuzCNDnB50CUF2AFYplNKXK8TA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ARW2Rd2IWIIBc/qhoe/9kwgqIXJgiu/JuSGhOGHeMu78nXL1tbCida2CZpBoNyGDjURfKCp1loaaUyqGDe3u27bBozMvT/Sq0CFVW58xqfc0q70mSZo4gGsf6NRy2BgdTF38xgNqQmvkvXBZ/lfrLadxEAbhasaBOPnuGfxNVEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=Zrd5M88y; arc=none smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="Zrd5M88y"
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BZEcH1375329;
	Wed, 7 Oct 2026 13:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=p1; bh=R7DCtYv
	ARmreahqy6+JMgfKCa/OSGJKeKgOHenavO2s=; b=Zrd5M88yuTI9iMOKXlpaqHs
	sbQzGDZ/UplVLLu6QLT7r+KttYIeLOORf8MKPHH/NH2qmty13KF2GGD0rXWug6cA
	evvFKld6EpmxLYlhExFsiClnPTnrt0v8/8nFvpOVZ90hB6gIquAiBujjjNwo04X1
	gN666Ck7jq4b9/Kad4xeRaUpnJPzBBnpVEDWMSjjMmTj0UGJ/B/+UG43eB69Mj16
	f/VF4U/6k04/pLZYG1ZjRmlluNo24e6+40nNaGFK/ezb4TzqSDW3ST/uGy5l64R+
	7TgEufNhphNNvowG0U9N8+eZqNN4avZ53DznXCJw7fPxe2c6+geUXGaLzonxDsQ=
	=
Received: from usculxsnt02v.am.sony.com (usculxsnt02v.am.sony.com [160.33.194.233])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4h2rjx5b09-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 07 Oct 2026 13:35:51 +0000 (GMT)
Received: from pps.filterd (USCULXSNT02v.am.sony.com [127.0.0.1])
	by USCULXSNT02v.am.sony.com (8.18.1.11/8.18.1.11) with ESMTP id 697DP1Gs2234239;
	Wed, 7 Oct 2026 13:35:50 GMT
Received: from usculxsnt13v.am.sony.com ([146.215.230.187])
	by USCULXSNT02v.am.sony.com (PPS) with ESMTPS id 4h2rydf72p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 13:35:50 +0000 (GMT)
Received: from pps.filterd (USCULXSNT13v.am.sony.com [127.0.0.1])
	by USCULXSNT13v.am.sony.com (8.18.1.11/8.18.1.11) with ESMTP id 697D9495085260;
	Wed, 7 Oct 2026 13:35:50 GMT
Received: from us842f57abef3e.eu.sony.com ([10.10.10.214])
	by USCULXSNT13v.am.sony.com (PPS) with ESMTPS id 4h2ryext0g-1
	(version=TLSv1.3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256 verify=NOT);
	Wed, 07 Oct 2026 13:35:50 +0000 (GMT)
From: Maciej Grochowski <maciej.grochowski@sony.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC PATCH 1/2] PCI: Add pci=hpreserve= to reserve memory windows for a hotplug bridge
Date: Wed,  7 Oct 2026 15:35:16 +0200
Message-ID: <20261007133516.49748-1-maciej.grochowski@sony.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <8b41ee8a-8138-cfe7-8e58-19de2f1baee9@linux.intel.com>
References: <20261002193111.51637-1-maciej.grochowski@sony.com> <20261002193111.51637-2-maciej.grochowski@sony.com> <8b41ee8a-8138-cfe7-8e58-19de2f1baee9@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Sony-BusinessRelay-GUID: V6Qci0UyT6C9NkjtxIjPphkK4U4yauul
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Sony-EdgeRelay-GUID: IWB001lM6k0ZMzP5ksiberihFiWAhR3o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA1NCBTYWx0ZWRfX8pePpJzaKI7i
 MIfJnu4IWgcTLvqKJoUzrFx9gK8VGsK9Lv3c6P3k5wKvOZCN+cTH9grHOIETKSeBK66H2Nh4NaX
 oogQT1ULEBsFxnx+OeD4gvjaHMk70vSAu39/IGunsqbwOOxlIQ0z
X-Authority-Analysis: v=2.4 cv=RNAmjIi+ c=1 sm=1 tr=0 ts=6ac64ab7 cx=c_pps
 a=z+s+ENbgstUlBMk8+ywv3Q==:117 a=z+s+ENbgstUlBMk8+ywv3Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KAb5x4SsHD3PzxGk7EmX:22 a=b20fedWF67CaGdYoUt4Y:22 a=z6gsHLkEAAAA:8
 a=T9BPO_MPyQJMQ75lomcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA1NCBTYWx0ZWRfX71yDjWeg2i9V
 YgnvzD8zwcprtCy9qucoPVFNVO3+j/k/Pk0ptMtrO1GWLIZMFM05ZFe83WARO2w8ELuFxLxdJU9
 j/VntA3Z7Fbd+0Nh3Vk7AjnynBP/DWh+wvCi9sEjh7UlhTaxEfcibqb+yuwUPnBfp7e3UdKuWeh
 gCAUjaiDCzsO08t+Oz236f5xWZGRwv5xCCp0sIXeDnVDE8ksWePOuMYDFqv/cD6xKP2eArZ3TXW
 IaArH277t6/4wzSgcq9o/vL3ymaIRVbfhSCXrBf55oMHO5P3Bh/ZGE80ZG42SCzgFKY46BCmJHt
 fHnImSOe5AJVvWKS5DHT3f2rsh1WEJuHgMrbMPg9Ks3iM/j9anqULd8xE+cg3n3jen37tygo3eE
 if3JI1oGXXhSQF2sbgODD+a3aJ5wvWHnXqQv4DAUtnx/O3V9UkGbvRz1HYFw6VVVGToEpeht3lO
 LLiR0Vp0+DPGPmDNlzg==
X-Proofpoint-GUID: 3C5nfKpOj4sMw8MBFKPJAtnxJHsIgzLx
X-Proofpoint-ORIG-GUID: 3C5nfKpOj4sMw8MBFKPJAtnxJHsIgzLx
X-Sony-Outbound-GUID: 3C5nfKpOj4sMw8MBFKPJAtnxJHsIgzLx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01

On Mon, 5 Oct 2026, Ilpo Järvinen wrote:
> > Add "pci=hpreserve=<reservation>@<pci_dev>[; ...]" to request a minimum
>
> Why is this a new parameter instead of adding the per device functionality
> into hpmmio{,pref}size=x ?

Hi Ilpo,

Mainly to avoid giving one option two meanings.  As I read the
allocator, on the hotplug path (pci_assign_unassigned_bridge_resources())
hpmmio{,pref}size is only an optional size: it is passed as add_size, so
it lands on the realloc list, the required-only retry can drop it, and
pci_bridge_distribute_available_resources() then sets each empty
hotplug port's window to an equal share of what remains of the parent
window.  It also has no alignment of its own.  This case needs a required, aligned size
on one specific port, so I kept it separate rather than have
"hpmmioprefsize=1032M" mean "best effort" globally and "must fit" per
device.  I also wanted the bus number reservation in the same entry.

That said, the separation isn't essential, and I'd be happy to fold it
into the existing options for v2, e.g.:

  pci=hpmmioprefsize=1032M@0000:80:01.1/00.0/03.0,hpbussize=11@0000:80:01.1/00.0/03.0

where a bare value keeps today's global, optional meaning and a value
with a device specification applies only to the matching hotplug
bridges.  "[; ...]" would also cover the cover letter's grouping
question (same size for several paths), at the cost of repeating the
path once per option.  A couple of questions before I respin:

1. Should a per-device size be required, as in this RFC, or optional
   like the global one?  My understanding is that optional is not enough
   here, since the retry can drop it and distribution hands each empty
   port only an equal share of the parent window.  I haven't isolated
   this in a test with valid bus numbers; the run I did with the global
   "hpmmioprefsize=1032M,hpbussize=11" failed earlier on bus numbers
   (hpbussize is a per-bridge minimum, so the first ports drained the
   pool).  If you'd rather keep the semantics uniform, I could make it
   optional and teach distribution to honour it, but I expect that to be
   a bigger change.

2. How far should the @<pci_dev> form reach?  This case needs it only
   on hpmmioprefsize and hpbussize; I'd add hpmmiosize too.  hpiosize and
   hpmemsize are a few more parser branches, but nothing here exercises
   them.  Add them anyway, or only the knobs with a real need?

> > Tested-by: Maciej Grochowski <maciej.grochowski@sony.com>
>
> The usual assumption the patch submitter has actually tested the patch so
> normal custom is to not include self tested-bys.

Understood, I'll drop it.

Thanks,
Maciej
