Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A631429D;
	Wed,  3 Jun 2026 01:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780449941; cv=none; b=mdsyfJFtEEN+44q/PyJ7Cl2BNEclPiOM8h5n9imVp0BJFOXJxZ9aYy0s60MoSZKjyEKlE1ZS70FYhYbDKGy7wcdu1/Wfxt+4jB2K+uG37WhqBltLwnDQImVAXx29+k391x6DuVhKm2ZQmJGneYpf/DHJtM3FXY+QnRbBYvwJS6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780449941; c=relaxed/simple;
	bh=AvEoZgT1O5goIrofI6SLhGiHhHOstW9nOOS+eVtRsxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bVsCPhQBWG+OU3GRzb6avg947P1vHssKgzXnfzD/IgxLFsgT3UZDwzPgGa+QznMjHDQ3KznWy1yGK4WCIIBtpFSa5lNS4spk1iMbLkAGCzqXSnZXO8rsJn5OEDRDilDVgrenti/Z2OQMGsxe23WGH34n8zdsw3xSxPlG2f9GHiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=r5qFW3V3; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="r5qFW3V3"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7/bDDg8HI1nW+jG2OBjTqnitI5mSSLNPDwEMCufdfPw=;
	b=r5qFW3V37qy+wyY9yfcMOoMvyyrSHNxM5pyz/pdKeGlclyD2OlfH3FIYM57XMDUUxo/kPKXnl
	b8v3caCA7d6BL5CUinSPckgjHjodKvJEhMlvXCIKr5skKOGnD4QQiI5dxFgQFyKwPuvIxGgy5UU
	ugKBhBb/0IiJ177TclbOkrU=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gVVDj64WyzKm5F;
	Wed,  3 Jun 2026 09:17:41 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 13C4D4055B;
	Wed,  3 Jun 2026 09:25:34 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 3 Jun 2026 09:25:33 +0800
Message-ID: <88302c97-894d-41f8-8e01-f4da6e812cbc@huawei.com>
Date: Wed, 3 Jun 2026 09:25:33 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 0/8] vfio/pci: Add PCIe TPH support
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Alex Williamson <alex@shazbot.org>, <wathsala.vithanage@arm.com>,
	<helgaas@kernel.org>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20260528124649.14732-1-fengchengwen@huawei.com>
 <20260601095840.3aaaa508@shazbot.org>
 <59c82855-59a7-4f0e-b534-d35535d04b93@huawei.com>
 <20260602170847.75bd159d@shazbot.org>
 <3f8d1722-6749-4f3a-b630-c96303cec284@huawei.com>
 <20260603004524.GL2487554@ziepe.ca>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260603004524.GL2487554@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk500009.china.huawei.com (7.202.194.94)

On 6/3/2026 8:45 AM, Jason Gunthorpe wrote:
> On Wed, Jun 03, 2026 at 08:34:53AM +0800, fengchengwen wrote:
> 
>> This translation helper is required to handle varied TPH configurations,
>> including cases where ST entries live inside device private registers
>> instead of MSI-X or TPH capability space.
> 
> I thought we agreed vfio had to block that feature in config space due
> to security concerns? That's what enable_unsafe_tph is about, right?

Exactly. All ST related uAPIs are fully hidden and blocked when
enable_unsafe_tph is off, complying with our earlier security agreement.

> 
>> Prior discussion with Jason (
>> ref: https://lore.kernel.org/all/20260414151125.GF2577880@ziepe.ca/)
>> indicated VFIO-PCI is the correct component for per-device TPH
>> implementation.
> 
>>> The host-only opt-in issue above also doesn't appear to be addressed or
>>> rebutted.
>>
>> enable_unsafe_tph host opt-in already fully gates all new TPH ABI:
>> TPH cap + feature ioctl are completely hidden from userspace when off,
>> no userspace opt-in needed.
> 
> I agree in general that the presence of enable_unsafe_tph VFIO has to
> report the per-device steering tags to userspace so it can program the
> device specific registers, nothing else can do this.
> 
> But I don't really get what is going on with all the new uAPI
> proposed.
> 
> I don't understand what VFIO_DEVICE_FEATURE_TPH_ST_CONFIG is supposed
> to be for, userspace should not be able to directly program registers
> that are kernel controled. In this case it is 'safe' and it should be
> only programmed by specifying abstract information like TPH_CPU_ST
> does.

Two separated feature ops are defined for clear layered programming model:
- TPH_CPU_ST: Query corresponding ST index via given CPU ID;
- TPH_ST_CONFIG: Write ST value, only valid for ST stored inside PCI
  config space or MSI-X table.

Userspace workflow: Fetch ST via TPH_CPU_ST first, then pick proper
interface to set ST based on device ST storage location, lastly enable TPH.
Since the full device is bound to VFIO without in-kernel driver control,
letting userspace manage TPH/ST entirely is reasonable.

> 
> I'm also wondering why it needs a shadow entry, that doesn't seem
> normal for config space tables..

Shadow table serves two key purposes:
1. Align with core PCI TPH API constraint which requires TPH enabled
   before any ST programming, enabling consistent userspace programming
   sequence;
2. Backup configured ST values to roll back hardware state during
   device close for cross-session cleanup.

Thanks

> 
> Jason

