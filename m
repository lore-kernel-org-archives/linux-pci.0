Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531481DA23;
	Wed, 17 Jun 2026 01:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781659122; cv=none; b=PhGrFsVilQOAVj4enWhQqN9zuJZX5/K826ttcFQ5Mue72y7fAkrG/JmC1xpHlYmdTYLvCoI1PJawQ99TWHpEDzgha/IvhawCkE0dXWxC2FAOjp8eA/0axzXlIyQrT2NtHAJLzZdbckjcFsrfJojyVOkr5LSkr8JIkQm5S32j6SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781659122; c=relaxed/simple;
	bh=EMQC/IPy5blZSyqbLNjYT822eRMkjbmmYQa/W7oiUe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XRaXNfzJM+nPNkaxhp07Lqj8jjktfJU8ozOzY16KrfDu96HCdsly1h0gTlctNv66x3r4fsJFqmB1QtS74S+e4i40UM6DDK6J2IkQVRebJiaOvtLCPfyctdUmmmfPPB2XWxGeo7mxexOrwksRKUo70u1c97QVRjDo0V2IZEq9rfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HvoKJO2j; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HvoKJO2j"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6KWzGmH0c2p57Ix3HhUpAbUiwEYrPouy2AzAXJlFwCQ=;
	b=HvoKJO2jgedlYJFu3C0f9x+qOALBikCzm26NU/IF6FmDwT2h9dbvOpfiewuqq2DAEt53GOcXI
	esDpK30PNl5zuySpckK6KC6AggMJOAhCN6+b6+esA0r4I6npKzB2J3kkDOKtqlgrMzLJM2QVGND
	S4o9nMAmbZHBG3Y8Z0BjKhI=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gg5P507tPz12LDV;
	Wed, 17 Jun 2026 09:09:45 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E87F40363;
	Wed, 17 Jun 2026 09:18:36 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 17 Jun 2026 09:18:35 +0800
Message-ID: <c913116a-35b4-4934-b78b-8fa0a08a00ae@huawei.com>
Date: Wed, 17 Jun 2026 09:18:35 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 08/12] PCI/TPH: Add sysfs binary file to export CPU to
 steering-tag mapping
To: Jason Gunthorpe <jgg@ziepe.ca>, Alex Williamson <alex@shazbot.org>
CC: <helgaas@kernel.org>, <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>,
	<zhipingz@meta.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20260616104621.41915-1-fengchengwen@huawei.com>
 <20260616104621.41915-9-fengchengwen@huawei.com>
 <20260616144224.GB3577091@ziepe.ca> <20260616105754.784be22d@shazbot.org>
 <20260616172728.GC3577091@ziepe.ca>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260616172728.GC3577091@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Hi Jason, Alex,

On 6/17/2026 1:27 AM, Jason Gunthorpe wrote:
> On Tue, Jun 16, 2026 at 10:57:54AM -0600, Alex Williamson wrote:
> 
>> IMO, this implementation in sysfs more so proves that vfio is the wrong
>> place for the interface.  vfio has a use case to consume STs, but it
>> doesn't produce them or own any of the mechanism by which they're
>> generated.  
> 
> I would argue only a VFIO user can consume this information so putting
> it in general sysfs is overkill.
> 
>> The weak point is whether this bin attribute, exposing an array of
>> structures, fits within the socially acceptable norms of sysfs.  
> 
> I'm pretty sure this style of sysfs is not accepted and
> counter-examples are things that are ancient or slipped through.

After weighing all feedback, I'd like to propose a lightweight single text sysfs node
design to resolve both your concerns, without introducing binary binattr or masses
of per-CPU files:

1. Only create a single r/w text attribute “tph_cpu_st” on Root Ports, no
   hundreds of separate per-CPU sysfs files;
2. Usage flow: echo target cpu_id into the file first, then cat it to fetch
   formatted human-readable ST/XST text line (cpu_id vm_st vm_xst pm_st pm_xst)
   for that CPU, e.g.
      echo 10 > /sys/bus/pci/devices/<BDF>/tph_cpu_st
      cat /sys/bus/pci/devices/<BDF>/tph_cpu_st
      and the output will like: 10 2 20 100 120
   In the case of concurrent access, users can determine whether the first value
   (cpu_id) is the one they expect by making a judgment.

This design avoids heavy dynamic per-CPU directory/node management, eliminates
the controversial binary sysfs ABI.

Let me know if this single interactive text node approach works for you two,

Thanks

> 
> Jason

