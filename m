Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D062F25F9;
	Mon, 23 Feb 2026 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868038; cv=none; b=Z9LIQ7gvR8ZD5Dx0L4hE3X1Lw/E4AeychF9MS3as+5SlEYpKXSGHtRtJhAlqZJZXBj2/k0w52lrwuPKFRVaueFLCKEjj3KkSnO9cc8XaXQW3ZTmb3nXhYOxHrMYpDB1jqKsluj45x706Op6wb9yY6ZHZZ+fLb/iv47jNSgiPeJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868038; c=relaxed/simple;
	bh=66tFpzR7gZoL8kFJYLYG6MOFafhfx6k8LbUyY96QF74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLW3axxOhNu9Bi/EQ0nKxyLYEWbC4U6T98Lq41g81YcBB3PO5pz/x6ywwAJTmKT3iyPQEMKInWS4TmuMANAKi7dVpfk0qXWSmntPcOVDjkRbCp/9sjVXYG7QUjVqwgtE2jbGxoeGwxmZK7dfQFLRciEezMr8jC8mC47+o5TIexE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cMZMMO4g; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cMZMMO4g"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N8XQPf733353;
	Mon, 23 Feb 2026 17:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=LjkTNmYmzXcdT/euvw5waUBvjzbDaf2zcVvJs+/B+/g=; b=cMZMMO4gJzPi
	YScZU/3ODGhRhGnE18IPDrnUuv6VLmp0lR6vaGdc8TS/U2qVEq9YSvHqq7hlR1xo
	CpfFqXrOuyh5qNXRvENWZJo7HlQQgMEhc3AiLctVqDszV8MGuOog+3O65qvu3bQr
	BSbu/wLZTYUgZroa6XJ65pIxtgNdOxQRj/a2uqRbuza72rKWTrfSCZfJSMfDDWPa
	5dXMqgiTqW4oB2leJ19LQFpH7GCXBYZianjQ85Fc62ac7EivysAePoDcOR5hrFqn
	RPvOx1PU4ub1GITBgOeCLRSu4boi8aKtRwF8+GtbbhXJuodZ7HnuFaHZl/Rzlqgo
	J0x3tOBUwA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf24g7xqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 17:33:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61NG1dB7001674;
	Mon, 23 Feb 2026 17:33:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfr1mwmj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 17:33:51 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61NHXlS051052880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 17:33:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69B0920043;
	Mon, 23 Feb 2026 17:33:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E38120040;
	Mon, 23 Feb 2026 17:33:47 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.87.131.234])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 23 Feb 2026 17:33:47 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1vuZoY-0000000BILs-2VUN;
	Mon, 23 Feb 2026 18:33:46 +0100
Date: Mon, 23 Feb 2026 18:33:46 +0100
From: Benjamin Block <bblock@linux.ibm.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <kbusch@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Bjorn Helgaas <helgaas@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
        "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Subject: Re: [PATCH v3 0/2] PCI/IOV: Fix deadlock when removing PF with
 enabled SR-IOV
Message-ID: <20260223173346.GD25740@p1gen4-pw042f0m>
References: <20260203004810.GA14073@bhelgaas>
 <0cd079ce-b658-4058-9d75-0e79987611de@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0cd079ce-b658-4058-9d75-0e79987611de@nvidia.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TNRIilla c=1 sm=1 tr=0 ts=699c8f80 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=8nJEP1OIZ-IA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=VnNF1IyMAAAA:8 a=ID6ng7r3AAAA:8 a=FleQEYvnWxhSTc8CUksA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=FdTzh2GWekK77mhwV6Dw:22
 a=AkheI1RvQwOzcTXhi5f4:22
X-Proofpoint-GUID: 6zQYE4N5o0eoTTPTvEZwrEalVHrBlqsD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE0NyBTYWx0ZWRfX0dmjDSiJUIrD
 cqQwacy3vwQGjIH58Ai5doj0tj7j8tQkM9jIG6zFDy95H+4VIfhv1CGRugPGGFz6OY00enIiTNP
 HWbDR0WxDulERWJG6d5GhRA4hdW4G6gk1mi+a3LeP1fZfFI14hF/aAnqeIeubnhH/iN2di30Ufu
 OL84TSC3xeL1HmQPOX+CLOFbQhw6Dq2YWGnqbuJGWvVRlWU7mdtNyFu7K3kbSad+yFekJVUUaxG
 oXA3qCPmLxBIYBkCq9eC4SUGPttr979tMqlBPGM5c/IiNHqUflFSh29hpdatVe8pRYSKZIIQ+UV
 DZzhIKeSLK3H6Wjl3YsaNmIMSEFsTXAMPnQdBQI9CR4mtGIrqnIxP++iT+8OapgMJraepRSPfWv
 +3/V0dwRpUjX3KGm3lZYe0r+qs5NzQyvuXFN/Z/oACK1eIvbFs4UWIdZ43ZRg/5ny81a4WWjiP8
 cWqCiBVA0jxPHvNUTPQ==
X-Proofpoint-ORIG-GUID: 6zQYE4N5o0eoTTPTvEZwrEalVHrBlqsD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_04,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602230147

On Mon, Feb 23, 2026 at 03:10:35PM +0100, Dragos Tatulea wrote:
> After pulling in these commits in our internal tree we can see the
> lockdep splat from below in many internal tests. We are still trying to
> find an easy repro for this. We had to internally revert both of them.
> 
> I noticed some similar discussion in another thread [1] but there it
> seems that these changes are actually fixing the issue which is not
> the case for us.
> 
> ------------[ cut here ]------------
> WARNING: drivers/pci/remove.c:130 at pci_stop_and_remove_bus_device+0x39/0x40, CPU#2: modprobe/12956
> Modules linked in: mlx5_core(-) act_tunnel_key vxlan dummy act_mirred act_gact cls_flower act_police act_ct nf_flow_table [...]
> CPU: 2 UID: 0 PID: 12956 Comm: modprobe Not tainted 6.19.0net_next_e834b5e #1 PREEMPT 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> RIP: 0010:pci_stop_and_remove_bus_device+0x39/0x40
> Code: [...]
> RSP: 0018:ffff888164c9fd10 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff888188ff2000 RCX: 0000000000000001
> RDX: 0000000000000046 RSI: ffffffff8307e068 RDI: ffff88816bf4c9c0
> RBP: ffff888188ff2000 R08: 00000000000000f4 R09: ffff88816bf4c080
> R10: 0000000000000001 R11: 0000000000000003 R12: 0000000000000000
> R13: ffff888164c9fd27 R14: 0000000000000002 R15: 0000000000000000
> FS:  00007f52364bd740(0000) GS:ffff8885a9019000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005622dbf749d8 CR3: 0000000169132004 CR4: 0000000000372eb0
> Call Trace:
>  <TASK>
>  pci_iov_remove_virtfn+0xbd/0x120
>  sriov_disable+0x30/0xe0
>  mlx5_sriov_disable+0x50/0xa0 [mlx5_core]
>  remove_one+0x68/0xe0 [mlx5_core]
>  pci_device_remove+0x39/0xa0
>  device_release_driver_internal+0x1e4/0x240
>  driver_detach+0x47/0x90
>  bus_remove_driver+0x84/0x110
>  pci_unregister_driver+0x3b/0x90

This looks pretty much like what Ionut is trying to fix in
v1: https://lore.kernel.org/linux-pci/20260214193235.262219-3-ionut.nechita@windriver.com/T/
v2: https://lore.kernel.org/linux-pci/20260219212648.82606-1-ionut.nechita@windriver.com/T/

Maybe try giving those patches a spin. I think one easy way to hit this sort
of thing is to try unbinding a PF that has 1 or more VFs attached to it from
some device driver. The "trick" is that SR-IOV has to be active.

>  mlx5_cleanup+0x13/0x40 [mlx5_core]
>  __x64_sys_delete_module+0x16f/0x290
>  ? kmem_cache_free+0x221/0x520
>  do_syscall_64+0xa8/0x13f0
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> RIP: 0033:0x7f5235f2c3fb
> Code: [...]
> RSP: 002b:00007ffc6ba11518 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
> RAX: ffffffffffffffda RBX: 00005558c4278f30 RCX: 00007f5235f2c3fb
> RDX: 0000000000000000 RSI: 0000000000000800 RDI: 00005558c4278f98
> RBP: 00007ffc6ba11540 R08: 1999999999999999 R09: 0000000000000000
> R10: 00007f5235fa5fe0 R11: 0000000000000206 R12: 0000000000000000
> R13: 00007ffc6ba11570 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> irq event stamp: 44859
> hardirqs last  enabled at (44869): [<ffffffff814af7ca>] __up_console_sem+0x5a/0x70
> hardirqs last disabled at (44878): [<ffffffff814af7af>] __up_console_sem+0x3f/0x70
> softirqs last  enabled at (44844): [<ffffffff81430312>] irq_exit_rcu+0x82/0xe0
> softirqs last disabled at (44821): [<ffffffff81430312>] irq_exit_rcu+0x82/0xe0
> ---[ end trace 0000000000000000 ]---
> 
> [1] https://lore.kernel.org/all/20260222112904.171858-1-ionut.nechita@windriver.com/


-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294
