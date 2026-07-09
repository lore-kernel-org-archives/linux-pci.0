Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4229E40E8EA;
	Thu,  9 Jul 2026 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783613890; cv=none; b=W78ZXQp0srKH33xuSooc7NGKRzjMQ8LhduOF5xkygixXUbcAsFI/bQ/m+4zvlmxA8bO8QY6rShAqnfLpcIL5Eu+QXFAgxtinPM2qsY9dzl1M7AdR6hKDYE6d/fyLwVfE+ugET5cRpd29Rulm7isoPDK3Ltngh3rM+NJ7l2WY/8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783613890; c=relaxed/simple;
	bh=26QO1saLv8ZoRnBa78PUqXxlwIBVXIp54cOe7XNelCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dTN12LfCNCm5CpXvU45BCsj8GrzZVDhb50kKWEzR8En1RImV9GepXj62qBvPIxOVLgqAAaPeK6+XgHXbi/sbb/iQ5XtXZQLuXnoaUzrqH60c9gHl1W6nsjkagxOrW60oYJ2fJoERr0ncUBCmbY/rFCe1639+/qwpjPACV0OfHNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=tWglgtXm; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="tWglgtXm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1783613884;
	bh=OArR/KeoVpNI247WLRI2TAI/hbwe5M9v3yfS72f/EYE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tWglgtXml7pWfbHECxp6rv6+pl7o+Z6pl8u4VKyh8ZZ2F8rVizDEv5FLgaz1ZsN7Z
	 rxppfO+k24cGHc1gPzlsY3LGNqJoFRKoYox17ybUVU+RhbrrjwQCEO/xSNnNeeTcPK
	 XYU4vK05nZCRVvkpoWsPQd93LGdruEmDya+3aTut0o82rCsaIi7YWNeZODo4qFSWcU
	 5/Hk3Un9hUHlxhmvNDUjMYjAIDBICgHjy0Tea/lIvsoB1DrREnpx0nGmgQ7JvSvoMl
	 LiZSCSDCanrPhDrI6JqUArQm72BlLoJIH2OZ5fo9nok0p9/2Ft7cQjuQcQWe0ozzuS
	 9lEMaOemERv9Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4gx0Vs2Qmmz58fn;
	Fri, 10 Jul 2026 02:17:56 +1000 (AEST)
Message-ID: <e0ccdfd7-2379-44ae-b579-a0da045d7f1b@ozlabs.org>
Date: Thu, 9 Jul 2026 17:17:53 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
Content-Language: en-GB
To: Logan Gunthorpe <logang@deltatee.com>, Alex Williamson
 <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Kevin Tian <kevin.tian@intel.com>,
 Pranjal Shrivastava <praan@google.com>
Cc: Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260701171245.90111-1-matt@ozlabs.org>
 <20260701171245.90111-3-matt@ozlabs.org>
 <26f74cf0-8892-4672-b0e1-1f1a385c42bb@deltatee.com>
 <aecbbc66-c154-4439-a6ae-84dc012b0f8d@ozlabs.org>
 <1cd1b832-082c-4f9c-ab68-706110ddcb25@deltatee.com>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <1cd1b832-082c-4f9c-ab68-706110ddcb25@deltatee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Logan,

On 02/07/2026 21:34, Logan Gunthorpe wrote:
> 
> 
> On 2026-07-02 10:44 a.m., Matt Evans wrote:
>>> So maybe at this point it's fine to enable this on 32bit systems and we
>>> can remove this requirement. However, I think we should do that
>>> explicitly in its own patch, not hide it in this refactoring patch.
>>
>> Your question does prove it's too stealthy as-is. :)  PCI_P2PDMA still
>> can't be enabled on 32-bit systems because of its ZONE_DEVICE -> 
>> MEMORY_HOTPLUG -> 64BIT dependency.  So we're not enabling 32-bit 
>> support for PCI_P2PDMA here, but it's not obvious and so I'll re-add the 
>> `depends on 64BIT`.  At least then it won't be enabled without intention 
>> if someone enables ZONE_DEVICE on 32-bit systems...
> 
> Ok, that all makes sense to me. I would be good with removing the 64BIT
> dependency (as it is is a bit confusing as is) but I think adding
> another patch would be appropriate with some of the commit message notes
> you mentioned in your emails.
> 
> Besides that, I think you can add to this patch:
> 
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks for that.  On second reading, just want to check with you:

I'm intending to repost _retaining_ the 64BIT dependency (i.e. revert
its removal) for simplicity's sake.  Then we can follow up separatey
(outside this series) with a cleanup patch to remove 64BIT, explain,
examine other dependencies etc. as you suggest.  Works for you?

(I want to reduce the diff in this series, and revert since this isn't
truly necessary && wasn't entirely obvious.)

Cheers,


Matt

