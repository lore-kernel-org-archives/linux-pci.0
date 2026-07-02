Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE6C44DB9D;
	Thu,  2 Jul 2026 12:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997059; cv=none; b=ZOTIvkfkgJXhO7rHBuS0f50l9xFhkVhn7AP0BsDsSm2trY9OhA3rSl/AoHPx7iRATe9aUrZz7hmxFfyvSofyNs0mFlhQ8IXjJe5bm7SJyEjFC0zKNprytjcCHN/SRNIq875FykNqL1qe9S50gVreleUfZsKxyFhcrzq/BvZOeuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997059; c=relaxed/simple;
	bh=AFGrmbdwfAancnPNa47KCabUjnx7lBo3Tag/UyQamOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JSSWJHRkVjSj3KrSvqOEHPOehOze3d5tGLcylbMFsygxJuyN09Pu8o/KXBnx8LQus0P4bfVIQy2Ny/J2L/U97lNW/VDzLYnXcYeARKZqzzLyNoTp4w0DQtHbXSXRgYd2AlMXCs1g9PRXZLZDyyt15ORD6WVAJ2+JyahN2ckL4J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=kaBZ3mrS; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="kaBZ3mrS"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=x9nas2A+rwUxt0f16upR266zlbt3y7eWx//PaGMmbR8=;
	b=kaBZ3mrSIzWD1PhmPG8iYso0k6u8e9lRj7V7OkFJ0Pru0V3mzrDusDaXyCYBgaTojQd2XiFLO
	b5tVZOrjVbP5kJ6ettzJgqJGdAzM5HXlqWXlLTCcHaOB3N72TG7kDurUDtvyrp3S/7FkTahwKH2
	nrUft61udGfJk1Pad4SJ9/8=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4grcB52Mrnz1cyP0;
	Thu,  2 Jul 2026 20:48:13 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C7374057C;
	Thu,  2 Jul 2026 20:57:22 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Jul 2026 20:57:21 +0800
Message-ID: <9734e383-476e-4c04-a5d7-3c30d309866c@huawei.com>
Date: Thu, 2 Jul 2026 20:57:21 +0800
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
 <9105ceef-5e27-4e3c-8903-d46aef52a2bd@huawei.com>
 <20260626092232.53ed3a7c@shazbot.org>
 <5b389fb6-7d0e-8fea-1fd9-b873efc028c3@huawei.com>
 <20260629094326.779ab0ff@shazbot.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260629094326.779ab0ff@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo500009.china.huawei.com (7.202.194.199)

On 6/29/2026 11:43 PM, Alex Williamson wrote:
> On Sun, 28 Jun 2026 19:58:09 +0800
> fengchengwen <fengchengwen@huawei.com> wrote:
>>
>> Thanks a lot for your extremely detailed and professional design breakdown
>> for the unified VFIO TPH uAPI framework. I’ve fully gone through all your
>> design points and aligned my implementation plan accordingly. I have several
>> key implementation questions to confirm with you as below:
>>
>> 1. Plan for dma-buf TPH metadata storage
>>    I plan to add the following TPH-related fields into struct 
>> vfio_pci_dma_buf
>>    in my preparatory patch series, which can be fully reused after Zhiping’s
>>    dma-buf TPH patches land upstream:
>>        u16 tph_st_ext;
>>        u8  tph_st;
>>        u8  revoked:1;
>>        u8  tph_st_valid:1;
>>        u8  tph_st_ext_valid:1;
>>        u8  tph_ph:2;
>>        u8  tph_ph_valid:1;
>>    The tph_ph_valid bit is newly added to track whether a valid PH value 
>> is bound
>>    to the dma-buf. Is this field layout and validity flag design acceptable?
> 
> In Zhiping's design, the PH completer validity is bound to the ST
> validity.  In my proposal, the user makes a request relative to the
> namespace, EXTENDED set = 16-bit, clear = 8-bit.  Internally we do a
> .get_tph on the dmabuf based on the requested namespace and get back
> success or failure.  On success, the full PH + ST is provided to the
> user when running with DS or LITERAL capability available, otherwise the
> ST is withheld and only the PH is provided.  I don't see a need to track
> the ph validity separately.
> 
>> 2. Validation rule for VFIO_DEVICE_TPH_EXTENDED flag mismatches
>>    The VFIO_DEVICE_TPH_EXTENDED modifier you defined is an excellent design,
>>    letting users select either 8-bit base ST or 16-bit extended ST when 
>> hardware
>>    supports both variants.
>>    But a mismatch risk exists: users may set ST entries via TPH_ST with 
>> EXTENDED,
>>    then later enable TPH requester in pure 8-bit mode only, causing 
>> inconsistency
>>    between shadow config and active hardware mode.
>>
>>    My proposed solution: maintain two separate shadow ST tables inside VFIO,
>>    one for base 8-bit ST and one for extended 16-bit ST. When enabling TPH
>>    requester mode, activate the shadow table matching the selected ST width.
>>    For devices only supporting 8-bit ST, directly reject EXTENDED flag 
>> in all
>>    TPH_ST ioctl calls.
>>
>>    Should we enforce strict cross-check between EXTENDED flag used during ST
>>    programming and the final active requester ST width during 
>> enablement? If yes,
>>    is the dual shadow table approach reasonable?
> 
> We've abandoned the apply at enable-time approach in this proposal, TPH
> must first be enabled in device config space.  There is also no
> buffering of user values, they're written straight through to hardware.
> If the user has enabled only 8-bit mode, then a TPH_ST with the
> EXTENDED flag set should generate an error.  Likewise, if the user
> calls TPH_ST while Requester Enable is 00b, this generates an error
> regardless of the namespace.
>  
>> 3. Virtualization logic for TPH requester enable bits with heterogeneous
>> completer capabilities
>>    Two complex real hardware topologies need proper handling:
>>    - Case 1: Single device with multiple queues routing TLPs to host memory
>>      and P2P peer memory via dma-buf flow; root port and P2P TPH completer
>>      capabilities may differ.
>>    - Case 2: Root port has no TPH completer support, while endpoint and P2P
>>      peers fully support TPH completer.
>>
>>    I’m confused about how to virtualize the device’s TPH requester 
>> control bits.
>>    My tentative idea: take the minimum supported capability between endpoint
>>    and host root port. If root port lacks TPH completer, block TPH 
>> requester enable
>>    entirely.
>>
>>    Is this the correct approach to handle heterogeneous completer capability
>>    across different traffic paths?
> 
> In case 1, this is why it doesn't work to allow the user to buffer per
> namespace STs to be applied based on the value written to Requester
> Enable.  Register value 11b allows the requester to operate in both
> namespaces simultaneously.  The only governance we can provide is to
> disallow EXTENDED STs to be written when Requester Enable is 01b.
> 
> The peer completer's capability is provided through the dmabuf.  The
> user can ask for the requester's preferred namespace, use the alternate
> if available, or fail if there's no compatible namespace available,
> which includes no .get_tph support.
> 
> In case 2, we're gated by the Linux TPH implementation and carry it
> through to the uAPI.  The overall TPH feature opt-in needs to depend on
> both TPH support in the requester (the user's device) AND TPH completer
> support at the root port (unless the requester itself is a RCiEP).  I
> had missed elaborating on this requirement in my write-up.
> 
> I'm glad you're onboard with the design, please let me know if any
> further clarifications are needed.  Thanks,

Thanks Alex for your detailed clarification.

I've fully adopted all the design guidance you shared and implemented
the whole TPH stack accordingly in v19 patchset which I just sent out.
Key adjustments aligned with your feedback:
- Remove separate ph_valid flag, derive PH/ST validity together from
  dmabuf query
- Drop dual shadow ST table buffering, write ST entries directly to
  hardware
- Reject EXTENDED flag ST programming when requester only supports
  standard TPH
- Gate overall TPH feature availability based on combined endpoint
  + root port TPH completer capability

No further questions at this stage, looking forward to your review on v19.

Thanks

> 
> Alex

