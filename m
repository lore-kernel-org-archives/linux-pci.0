Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793419758;
	b=gR8JC2DD82VCdd9IaIsXnqlisejXKiBiIRMXduC5txE3JKONUHlMmmhR0HYjOkOtxmY2
	 6q4nT6EIxp0vbD0GUglnTwvJJGv24n0oJf2gTrRCkwRCKubBqUFtZieVnhDZeiC8TicLG
	 Oy8cuq4MyuqvscD0nILJKT4ZUDha9mHNrryWUTLZbb1vGF1lZ4S3Cs4YpI3550Q8S5Boa
	 RQ+A1yQ/9vpmaFslONi/+b5C8s2aaMeqbLpfdeVAF062oiD7PZF0A57Z1rJiG+14myzRr
	 0G4bJK/mCaCLwxhOPWBAVmbxw235g9kdUSs7nROQu002Hlv5jlh1OiIswPzEOvswLVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793419758;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	bh=La4vgolm7+vvTK9sKBHNEhDWpqoKDcVCZH3sqhU3vzE=;
	b=1tUwAV3wdxf0Ol2OkHbaNVHL7XNw7ZZouMRQGfDvhwFAp/Q+U+Upuq+ch9UI+7Nm/Vm2
	 9SZxJTKFZ/AKSnYFIdwvP9SN/Fb5HBGYVaa/PQ9Z5gZnazsVXoF+E9vhRfjuMr8SDpYES
	 hHgXFvZiZN1UJPB4AzW//N5h4m6i2pHoEOq7Mxyr4uukcpRtFRROn5uNvef84McwjDnjX
	 esQgaN96Ar0wwdMYnBKfBABOfx7N4GxnUHbb07fHKegfhW378Zo3Q0L+WsepReL0VMu1g
	 BcAgVLEo6EFiMad5yB7+zspEwmPPC1ipDpvWv4OADP60U67BLh+i49a8zIrbX9UtqVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=VyujayAR;
	arc=none smtp.remote-ip=113.46.200.224
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB089606A31A;
	Sat, 31 Oct 2026 04:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB089606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=VyujayAR
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=La4vgolm7+vvTK9sKBHNEhDWpqoKDcVCZH3sqhU3vzE=;
	b=VyujayARs+t3vamx5pSNgV/neWxILRBNlcQM09rgiIHvz/EuQkvRQPCoUbuEDnihduH/aQrQb
	eF0RB22R8Yi48c6rD30gHV+7yiGbO9u8mZyCdi39wKum6cyCHmCBRq1XfEJUu8Fp7tUXYfkMjef
	3o0ke0UemIRYMzSSEgoCQog=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4jGkxB1z7yz1cyPs;
	Sat, 31 Oct 2026 12:09:02 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id C15CA4048B;
	Sat, 31 Oct 2026 12:09:10 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sat, 31 Oct 2026 12:09:10 +0800
Message-ID: <22e74fbc-f6f2-4fbc-b721-2be06646029a@huawei.com>
Date: Sat, 31 Oct 2026 12:09:09 +0800
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
Subject: Re: [PATCH v20 00/16] vfio/pci: Add PCIe TPH support
To: Alex Williamson <alex@shazbot.org>, <linux-pci@vger.kernel.org>
CC: <jgg@ziepe.ca>, <helgaas@kernel.org>, <wathsala.vithanage@arm.com>,
	<wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
	<wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>
References: <20260714104325.54444-1-fengchengwen@huawei.com>
 <6d86dd9c-83ad-4884-915e-6509995c5ba3@huawei.com>
 <20261030100050.16df202b@shazbot.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20261030100050.16df202b@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500009.china.huawei.com (7.202.194.199)

On 10/31/2026 12:00 AM, Alex Williamson wrote:
> On Wed, 21 Oct 2026 09:43:05 +0800
> fengchengwen <fengchengwen@huawei.com> wrote:
> 
>> Hi Alex,
>>
>> Quick follow-up from our LPC discussion on the VFIO TPH patchset.
>>
>> The P2P TPH path carries significant verification complexity, as it builds
>> on the PCI P2PDMA stack which is still under active upstream revision.
>>
>> Meanwhile there is clear real-world demand for the device-to-host scenario.
>> AMD recently posted their debugfs series exposing CPU-to-ST mappings [1],
>> and we also have strong use cases for D2H TPH enablement.
> 
> You might be working ahead of the industry.  The debugfs interface
> provides evidence that the feature is coming, but is perhaps still
> working through implementation pains.
> 
> The lack of community participation in the vfio interface actually
> suggests to me that there isn't a great real-world demand for this
> feature, yet. 
> 
>> I'd like to propose a phased upstream approach:
>> land device-to-host support first, and defer P2P TPH to a follow-up series.
>>
>> We can add P2P support cleanly on top once the interface and verification
>> are solid. This way we can deliver usable TPH functionality sooner, while
>> keeping the path open for full P2P support later.
>>
>> Let me know your thoughts on going ahead with device-to-host support first.
>> If you're okay with this, I'll post v21 accordingly.
> 
> As above, the demand is not apparent based on the lack of community
> participation in these threads.  I'm reluctant to commit to a uAPI
> that's largely been proposed by me, as the maintainer, trying to fill
> gaps in the narrow scope of the original proposal.
> 
> This needs support from the community and validation across broader use
> cases.  I think that's the actual barrier, rather than ordering versus
> Zhiping's series.
> 
> Despite the LPC talk, there still hasn't been much engagement on the
> question of whether device ownership grants the user the ability to
> target specific cache levels and how we handle cases where the
> driver:cpu association isn't static.  Thanks,

Thanks for your thoughtful feedback. I understand your concern about
community consensus on the uAPI model and broader use-case validation.

To add some context: there are existing upstream patches related to
user-facing ST programming. ARM previously posted a VFIO patch series
for similar ST programming support [1], and AMD has posted the debugfs
series exposing CPU-to-ST mappings. These show cross-vendor interest
in this space, even though those prior works take different forms.

I agree that the ownership model and CPU offline lifecycle contract
need wider review. My next step is to reach out to the relevant AMD
and ARM developers, and invite them to join this uAPI discussion.
We will focus on the D2H-only scope and defer P2P TPH for later.

I will proceed with the D2H-focused v21 series, while running this
cross-vendor discussion in parallel. The discussion can feed revisions
to future versions of the series.

Thanks,
Chengwen

[1] https://mails.dpdk.org/archives/dev/2025-June/318908.html

> 
> Alex

