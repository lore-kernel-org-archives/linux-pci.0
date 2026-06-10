Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA7E275870;
	Wed, 10 Jun 2026 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781107255; cv=none; b=Kqx0Yvc5awlucey9B/oJuScqw1XecmtdBMykPZm5vmPiwexu5xbR2bJgbYDjKwU1wCH45O29jeVziJiqeslyS3+iU8rXb5coKvpTQAeIlVh5B4t0mGN2lHa28V94fnrX6wGGcb6FZ4TgJ6Sm98xwYTXiZeMYqmOty5jvIyFZito=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781107255; c=relaxed/simple;
	bh=u0cfWQHO4BqT4UOku7Xois919JN2h7T81+Y0jfGvg2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMBoudZeREPb+xRpJ6qq5GQW15dOFQ9Gt8a9Lx3Z+iaGzcnxHVGG+rHPvm1atfJL2ILlj4eeX6+BjrXSeHVxk507BK5WV5ZFo+ld1RWIyfh1Hn9BXpyBH3vk9wuWyFwVcEHBX9352VpMvknYIW2sI0CcG1gV43rRS3G6EEB0ZXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=bB0PRaIM; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="bB0PRaIM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1781107251;
	bh=eDEkk4f7S76uj36wByzSVbCn2IDwUfz2uxF1LUdS/0Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bB0PRaIM4+jrYgnE3WcqtZCosNRTn/dSy2m0AXX+ymW/8IYLTa6cRUe8zxHtEFQAD
	 ekpOcPyLvQEddGX9u07/sC5TMCQ430i5e03rRXfswTAd09MloYA/i4/ZUA8Wxu77eZ
	 L7QoCI2PIOqKG7EnVRSjbclfVXwcpIjR8kBDaPWvry8DpAfjNQDTIz4jxE9h+L+5Oj
	 ZYVROtNv2VyhvQdQVHoDwt3UF+8PrD2cNa6ICcjDtk5NHo/GRPy9byWtLrapYHhnU1
	 HbcWbcePG9H1w4vZ95R189BPokROy+dyqpHNfzkw9/I+i13lgt9vQOCnrPZXRy/QH5
	 h0WAye/RMrEUw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4gb9VN0LRgz4wCj;
	Thu, 11 Jun 2026 02:00:43 +1000 (AEST)
Message-ID: <39e5e731-bfa2-484d-ad29-a9e173ccc6d1@ozlabs.org>
Date: Wed, 10 Jun 2026 17:00:38 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
Content-Language: en-GB
To: Pranjal Shrivastava <praan@google.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex.williamson@nvidia.com>, Matt Evans
 <mattev@meta.com>, Leon Romanovsky <leon@kernel.org>,
 Alex Mastro <amastro@fb.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260527102319.100128-1-mattev@meta.com>
 <20260527102319.100128-2-mattev@meta.com>
 <20260527150946.312b3042@nvidia.com> <20260529230553.GE3195266@nvidia.com>
 <aimCfaCM-m4TS2g9@google.com>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <aimCfaCM-m4TS2g9@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Praan,

On 10/06/2026 16:27, Pranjal Shrivastava wrote:
> On Fri, May 29, 2026 at 08:05:53PM -0300, Jason Gunthorpe wrote:
>> On Wed, May 27, 2026 at 03:09:46PM -0600, Alex Williamson wrote:
>>> This deserves a /* CONFIG_PCI_P2PDMA */ reference like the previous
>>> long span, though potentially a better solution would be to split the
>>> core code out to a separate file with shared header.  I asked opus to
>>> see what this would look like and it generated the patch below
>>> (unverified, compile tested only).  Bigger diff, harder to follow
>>> blame, but the shape of the core is much more apparent.  You're welcome
>>> to take or leave it.
>>
>> I think it is a good idea, it will make it easier to add more stuff to
>> these different aspects.
>>
>> Really they are now two different things with one layered on top of
>> the other.
>>
> 
> A little late to this party. I agree with this split per status quo.
> Although, one observation from me, I've posted a concurrent RFC [1] that
> implements ZONE_DEVICE P2P registration for VFIO. That work relies on
> pci_p2pdma_add_resource(), which requires ZONE_DEVICE and the full
> CONFIG_PCI_P2PDMA stack rather than just the CORE part.
> 
> I guess I can be careful to guard the ZONE_DEVICE P2P registration 
> feature in VFIO with the full PCI_P2PDMA config. Apart from that, this
> split provides a clean foundation for both series to coexist.

Thanks for the heads-up/Cc.

From your description, I agree, just depend on/select CONFIG_PCI_P2PDMA
as usual.  The only new thing in this split is the
CONFIG_PCI_P2PDMA_CORE allows the subset, but the default case (as used
by a couple of other drivers) stays the same.

I just posted a v3 including this split so you can see it in practice.
(I'd done part of it manually anyway so just finished it off, not
character-identical to Alex's patch but does the same thing.)

Thanks,


Matt


> 
> Thanks,
> Praan
> 
> [1] https://lore.kernel.org/all/20260610151853.3608948-1-praan@google.com/

