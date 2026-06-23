Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42EF36A000;
	Tue, 23 Jun 2026 09:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782208622; cv=none; b=OJtL/Kb57i8G4XrgLDGe5Xa8+xYf/bFxsMcyZCJdAEkRiDKprJ3LcjC44QSFan9Shw5fDO28n44L69fuxtVhj5L+zPD+6Sym100I4Yo/lNsJUPJkVXU1hDDwX02fjYAlfNcppSYG02I5dpz47NQVOPMa1d0/jcm+6K/Z/3vQnM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782208622; c=relaxed/simple;
	bh=rz7yCimLi3oDcqrshHhsavPU+AkVytAhfXjk0166W30=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bv0PeMoMZVRdeJ1e11MQHKqGOn3XRfr+vgOr23YA74WlHBY7t0sGOyljZ+0FrVfB+el9JTd2xsn4FsPbxTZZnMup2cV1u6GmknevxzY7Qx35wZ6nmaRt2bOABjphvL3KQXNxNkX9r4LwBlMsiI/zJr1e8NbWJMDSB4Uv7UvetqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=5PuR2tf7; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=5PuR2tf7; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="5PuR2tf7";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="5PuR2tf7"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+AsrU+Femqt2z3oCnSTzOkrEomRSDjBoV+ILGZyMq28=;
	b=5PuR2tf75yCnE0sk6QmuNonRAXqCuFhSc2+3CHmvQ55bn65p+K2GpwmF9aIh6IhSmPQhSqjtC
	JlV664K/zCnjkPVi/+Np+E8q0EcPr+uPaNRTib+Ukrli7LAdUtjkMTYZhU182CHoJbkfe+BeQvG
	mu2JUooOoJcoFK0luXxcrEQ=
Received: from canpmsgout01.his.huawei.com (unknown [172.19.92.178])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gl0ch13zfzcbNC;
	Tue, 23 Jun 2026 17:48:20 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+AsrU+Femqt2z3oCnSTzOkrEomRSDjBoV+ILGZyMq28=;
	b=5PuR2tf75yCnE0sk6QmuNonRAXqCuFhSc2+3CHmvQ55bn65p+K2GpwmF9aIh6IhSmPQhSqjtC
	JlV664K/zCnjkPVi/+Np+E8q0EcPr+uPaNRTib+Ukrli7LAdUtjkMTYZhU182CHoJbkfe+BeQvG
	mu2JUooOoJcoFK0luXxcrEQ=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gl0cY12rkz1T4GM;
	Tue, 23 Jun 2026 17:48:13 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 8EB9E40569;
	Tue, 23 Jun 2026 17:56:52 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 23 Jun 2026 17:56:51 +0800
Message-ID: <9105ceef-5e27-4e3c-8903-d46aef52a2bd@huawei.com>
Date: Tue, 23 Jun 2026 17:56:51 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 08/12] PCI/TPH: Add sysfs binary file to export CPU to
 steering-tag mapping
To: Alex Williamson <alex@shazbot.org>
CC: <helgaas@kernel.org>, <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>,
	<zhipingz@meta.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
References: <20260616104621.41915-1-fengchengwen@huawei.com>
 <20260616104621.41915-9-fengchengwen@huawei.com>
 <20260616144224.GB3577091@ziepe.ca> <20260616105754.784be22d@shazbot.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260616105754.784be22d@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Hi Alex,

On 6/17/2026 12:57 AM, Alex Williamson wrote:
> On Tue, 16 Jun 2026 11:42:24 -0300
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
>> On Tue, Jun 16, 2026 at 06:46:17PM +0800, Chengwen Feng wrote:
>>> Add per-device sysfs binary attribute tph_cpu_st to expose ACPI DSM CPU
>>> to steering-tag data to userspace, resolving the concern that VFIO should
>>> not host CPU-to-ST translation interfaces.
>>>
>>> Follow PCI standard binattr framework: dynamic visible group, fixed-size
>>> 8-byte packed uapi entry, aligned offset read, root-only 0400 permission.
>>> Refactor duplicate ACPI DSM logic into shared tph_get_cpu_st_info helper.
>>>
>>> ABI: /sys/bus/pci/devices/<BDF>/tph_cpu_st  
>>
>> I'm sorry, I really dislike this :(
>>
>> Structured binary sysfs attributes are pretty much against the rules,
>> I think using sysfs at all for this interface is a bad idea.
>>
>> IMHO the VFIO version was much better.
> 
> There are some deficiencies in this implementation:
> 
>  - The ABI needs to be documented in
>    Documentation/ABI/testing/sysfs-bus-pci
> 
>  - The attribute is at the wrong place, all endpoints would just
>    replicate the root port values.  Place it at the root port.
> 
>  - Corollary, is_visible should key on whether we have CPU to ST
>    mappings (_DSM) and the root port is a TPH completer (DevCap2), not
>    the TPH capabilities of an endpoint - a userspace driver can already
>    discover the endpoint TPH requester support.
> 
>  - The 8-byte aligned read requirement should be removed, perform a
>    sub-8-byte read from the slot offset.  !cpu_possible() should be
>    filled with zeros.  This allows userspace to dump the entire bin
>    file or read only a set of fields.
> 
>  - Probably cleaner to zero-initialize the buffer rather than memset()
>    and (redundant) reserved = 0.

I’ve sent v18-resend of the PCI TPH sysfs patchset with all prior review
comments fully addressed.

I remain open to both discussed implementation options. This v18-resend
implements the sysfs binary blob approach on Root Ports as you previously
suggested.

Please kindly review v18-resend and share your thoughts.

Thanks

> 
> IMO, this implementation in sysfs more so proves that vfio is the wrong
> place for the interface.  vfio has a use case to consume STs, but it
> doesn't produce them or own any of the mechanism by which they're
> generated.  This proposal, with the above improvements, provides
> effectively an ioctl-like interface when using a properly offset and
> sized pread().
> 
> The weak point is whether this bin attribute, exposing an array of
> structures, fits within the socially acceptable norms of sysfs.  There
> is some precedent for this, for example cc_settings_bin in infiniband,
> but these might also be considered legacy.  So I don't know if this
> sort of usage is a grey area that fits social norms or if it's promoting
> legacy use cases that we don't want to repeat.  Thanks,
> 
> Alex

