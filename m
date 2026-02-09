Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5040B366056;
	Mon,  9 Feb 2026 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770632042; cv=none; b=LwYyDKYyWC0cpdj0+SsRaGeewElYqYqFSBzsPg4x2+GJkxSkkCjKXnclRb2zRLuIAZE/M6O7e4Bl4nm8iYZ89q/l/sS8zVwEI/Vx+ZhcSB/sEWtCQgDjb7asDySzY33clLy9SJhRczz6bkbmmqh7UKPXYRMe/IP4TgICJLtyz0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770632042; c=relaxed/simple;
	bh=WH0iTerE/1Dec4EcpJS3ttG3Pv7sZSp2RZuCcsNInuI=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=gk90bQod8cwGScux4SaTfuy2xYXGOZGqQBjQsFWSe9B4hXstcqxlHabomO/ry31heNB7MHGLhiXmAxR94Im0FVwZZanhq6y6DDRcwC87SAOxLfRAF5hS3zftKD3KWNJYEV5Keulyakq3lIXrEJcPSOx+gIp1TDNKeEWjR2VXaEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s2NTjhrt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s2NTjhrt"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6190FJXL539487;
	Mon, 9 Feb 2026 10:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UEvWJG
	NCY/FN9Y7f8ASJ9+TXrfwNCoUdIhBkEjKEiAc=; b=s2NTjhrtfjS974olPTldkZ
	8F0UCna4fBcV41BRXq4BA4uaejaRNsyC30DDVZvSaPuU7Yr+AUbmPmSkj5wi6Pp6
	Dg0skYm/vRA1eCHRMd03/OfO2EUjpGj9YklkTx/FoDtJxd9oJSB1wArZTn2+qWkt
	uYHM8vPgxYl0RwAaCysoFFqJ5Bm1Vl0RudpDxulfw8UgBuuqTtSffCY55b5Q8DwN
	InTLxTXmbZrlId+kfqDGD7xZuS8E5iig16k71I7kxbKf0ufbefB74aUtXF7sq8jd
	2hUZWlgA/wwL3YZwbobHJy8YMax7ezVcaX290FJvHil6SMEZEDe/j0GQ625A8Y4Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696vxgun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 10:13:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6197TQuQ002631;
	Mon, 9 Feb 2026 10:13:41 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6fqscv5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 10:13:41 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 619ADdqq30212734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Feb 2026 10:13:40 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADCE158053;
	Mon,  9 Feb 2026 10:13:39 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 407DB58063;
	Mon,  9 Feb 2026 10:13:37 +0000 (GMT)
Received: from [9.111.63.233] (unknown [9.111.63.233])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Feb 2026 10:13:37 +0000 (GMT)
Message-ID: <2b6a844619892ecaa11031705808667e0886d8b2.camel@linux.ibm.com>
Subject: Re: [PATCH] PCI/IOV: Fix recursive locking deadlock on
 pci_rescan_remove_lock
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Ionut Nechita (Wind
 River)" <ionut.nechita@windriver.com>,
        Benjamin Block <bblock@linux.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Clark
 Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-rt-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, Ionut Nechita
	 <ionut_n2001@yahoo.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Julian Ruess
	 <julianr@linux.ibm.com>
In-Reply-To: <20260209082553.1pnF4lr0@linutronix.de>
References: <20260209075706.16367-2-ionut.nechita@windriver.com>
	 <20260209082553.1pnF4lr0@linutronix.de>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Feb 2026 11:12:36 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=YeCwJgRf c=1 sm=1 tr=0 ts=6989b356 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=t7CeM3EgAAAA:8 a=_LHkK0FJViVh7UxAcSUA:9 a=QEXdDO2ut3YA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: OgZZAH1NtEyLY5jSioFPmMQTMvFOYO5c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDA4MSBTYWx0ZWRfX3lL/ybkzV/Sd
 rSgW+KvEst37ukT0+Peae9Lnhtcbf1fVLKMSsuFDkcrSoooxE4ZPD4cNpk5xAP+7ekzZ3CJ38kH
 9SVOAvMo9ViAWosA/N+/gujvWnfDakzPr8cu902X0vQUhCufDMmxOF3TTTUu1trNRJYGIPpl648
 jkzx+XAXzZDchUL0LyUlwuLXHggVQE791hl63mbZFh/VfkBAjrHYzLPcTWP+cbBh5O8Y8cuJgsA
 DCqPHL6qAS+MsDdcI+ewkb9/PAUMvdnILM4bc4cWOmhjTI5c3myNL0n83idxhTiYM0ktVMFeWQV
 fGHM4aW+eqi7Dx04SVNrDieyHJU2M+h+Fb/04cbe1eP4E4YVaEdVRR8k3xbs4spUjxCgLsIALIp
 D7gNFrYHnn74FpAcOhGr9W7wRH4pW28NI3XmAAkPkBbkslyvZ+4j6n3jCmmCyy7/h4KwaA5Ix6A
 o18uqRAXQ0EH4AwE9Lw==
X-Proofpoint-ORIG-GUID: 1EfyPb7BvYLTk_b5Zb3Wn9n-GOnOFnm6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602090081

On Mon, 2026-02-09 at 09:25 +0100, Sebastian Andrzej Siewior wrote:
> On 2026-02-09 09:57:07 [+0200], Ionut Nechita (Wind River) wrote:
> > From: Ionut Nechita <ionut.nechita@windriver.com>
> >=20
> > When a PCI device is hot-removed via sysfs (e.g., echo 1 > /sys/.../rem=
ove),
> > pci_stop_and_remove_bus_device_locked() acquires pci_rescan_remove_lock=
 and
> > then recursively walks the bus hierarchy calling driver .remove() callb=
acks.
> >=20
> > If the removed device is a PF with SR-IOV enabled (e.g., i40e, ice), th=
e
> > driver's .remove() calls pci_disable_sriov() -> sriov_disable() ->
> > sriov_del_vfs() which also tries to acquire pci_rescan_remove_lock.
> > Since this is a non-recursive mutex and the same thread already holds i=
t,
> > this results in a deadlock.
> >=20
> > On PREEMPT_RT kernels, where mutexes are backed by rtmutex with deadloc=
k
> > detection, this immediately triggers:
> >=20
> >   WARNING: CPU: 15 PID: 11730 at kernel/locking/rtmutex.c:1663
> >   Call Trace:
> >    mutex_lock+0x47/0x60
> >    sriov_disable+0x2a/0x100
> >    i40e_free_vfs+0x415/0x470 [i40e]
> >    i40e_remove+0x38d/0x3e0 [i40e]
> >    pci_device_remove+0x3b/0xb0
> >    device_release_driver_internal+0x193/0x200
> >    pci_stop_bus_device+0x81/0xb0
> >    pci_stop_and_remove_bus_device_locked+0x16/0x30
> >    remove_store+0x79/0x90
> >=20
> > On non-RT kernels the same recursive acquisition silently hangs the cal=
ling
> > process, eventually causing netdev watchdog TX timeout splats.
> >=20
> > This affects all drivers that call pci_disable_sriov() from their .remo=
ve()
> > callback (i40e, ice, and others).
> >=20
> > Fix this by tracking the owner of pci_rescan_remove_lock and skipping t=
he
> > redundant acquisition in sriov_del_vfs() when the current thread alread=
y
> > holds it.  The VF removal is still serialized correctly because the cal=
ler
> > already holds the lock.
>=20
> This looks like the result of commit 05703271c3cdc ("PCI/IOV: Add PCI
> rescan-remove locking when enabling/disabling SR-IOV").
>=20
> > Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
>=20
> Sebastian

Agree, this looks related to the deadlock I later found with that
commit and that lead to this revert+new fix that has now been queued
for the v6.20/v7.00 here:

https://lore.kernel.org/linux-pci/20251216-revert_sriov_lock-v3-0-dac4925a7=
621@linux.ibm.com/

That said I do find this approach interesting. Benjamin and I are
actually still looking into a related problem with not taking the
rescan/remove lock as part of vfio-pci tear down and there this
approach could work better than just moving the locking up into the
sysfs handler. So far we haven't found a good place to take the lock in
that path that doesn't suffer from the recursive locking in other
paths. On the other hand conditionally taking a mutex is always a
little ugly in my opinion.

Thanks,
Niklas
