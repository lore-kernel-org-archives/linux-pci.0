Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CAF30E828
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 22:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787265495; cv=none; b=VEkBBDjKphano29c/mwQ0XkPfzoJmfB183BVojxbPirz7hUFx5rwVW1qU7nN40lIcBh08xS3aAqSbaZbsSVNV5fj8V0fsJfU76ndT6zhlXo9weJXOojvJkjwfqEn1qDGfa/+15Ai9LOCbzw/QAiq3yrGl+74fmUtGlmZEz5GND0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787265495; c=relaxed/simple;
	bh=yabC/1m9rU3BxLqsOh0lGz3jSO1b8DVmJZcPdMujCH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKJQQq77rYhn9M6J+/RnhkemFYaBLRvok3PYdtoEYM2iO18HlKnXp4yHXalEMmUpd5tDKH7WYrmaPM9E/m+R0eJ5BHSnMnA3Rcy4P6w92sVix2wQOp0FjSQmJ6qSMfKQQjQoNHQM2e9TnCA7XY/gZIwQFO2wxFfJmiQBmQ1ankQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UIq1gfkt; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UIq1gfkt"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d3b445a84fso8665ad.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 15:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787265493; x=1787870293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q+/PK6LE/htDAQTsaEW8S/zdG4qnwoWFvJEsyzFkeQU=;
        b=UIq1gfkty0PMbzt8NJ+/6tWhsF7Ieplq8xu5VgRsNn4HW5ScgFTGTSh2QIdVdgM0Qb
         fE3rz9DEWLEtUgVWZXWTnOnGBdIFYVAL+y/VYPa0HfZl5KOMGhPaAsc8qIG4T+RxMqfi
         OlzMk3uJuPvmpg4MoQ6mBwabM52g5jcZbo4/nv27XS+4jpEQhCGqIirPax/FrSH0Z4mK
         IhJF59IPvd4tbv+nvKTM1wu1k7EbE0kBjOybjWbdbpM/WjAb7eCFWU0zfoG3t91Lbcdu
         oENLZ64qMJCJc/wEzCDt7zurrPQnKkVT7/zuAHs4M8/59psCMQ0OjoOFLT3BuDA4luSr
         FobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787265493; x=1787870293;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q+/PK6LE/htDAQTsaEW8S/zdG4qnwoWFvJEsyzFkeQU=;
        b=ngykW0QxO6+mUYuvcTVASMV2BNk5ufS2ptEuPoJJKo/MWo124bY4mAPJDKUeikpcZa
         r9SrnQbtZKgyjTLUTNWSKwzQH0TXiKrisOlKZ6bd1yM4DJl8YjxSXXrfLezN3H4sSsph
         QKeoHRIzYY5bxlSCSeqpBcyirsVDKg3g8fu6YNd8o8YAsPqvgq5IhqN8dvaVJZHhV32w
         liKpuSmgmJ8yUAMQnuHohcFGqB1lQ8DQWgMhFcAmGc1AYclzyzpD8fYMAwVikWWepx/2
         n148EnCJ/vSiyeQ3nICnT9IAOe6rE5fx+EltaCyvFVvzghjF8xzQKurgS8luvuzl93AD
         rCfg==
X-Forwarded-Encrypted: i=1; AHgh+RoMjLMifqpqV4rAYhgR9+pU1aX99dGBnpis+wzpAXryQqlNadCSckI2USnXQlNQ4zJOK5F01aEKLIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJYUsV31B4yixfL7igL4PXhf4QdPAfSMQ7bXqbkLb9+JQL+HA6
	wmmQ3M2NsLN1un5E8qcNQc7Ivy/ybq449rlDIGPPNRPCB7FGLd1HGE3tSoNF/zPc0w==
X-Gm-Gg: AR+sD10mCddQKzs8KUY/AHxk+bclV7ti7Z+vKshcFBMJWuasLFPfPOTOS5GOXmYO5S7
	JZBGz0TOsViVV8FawrMhJlTv+/ivgiheABlahccUrdDLN2CTaF1xc7SzrYTCQwQX7Z/hCJRzk1C
	2mNNkOJAKY+EWslULceD4qxKYDl1rk3m0piQGTuvieyoxf8dRt2nKWGppao9/DG22SpF8YTY4Bd
	G/QQlqi4yx5aYRqi2D039jvDZ/uvwZBeV1PaondKqquTDon/rpgws70YvvemYLacZuT0N3bw6SY
	jB5iJkxbC/tVP0RFszEa951TUW5PzCLSeiIa8TsU9WR9yHKVuHyAtedgCtSx3ZsRbaCheEj4WpN
	6/6mtS610PF2wz7CuxH6u9P+D0FEIUA7WSeVZNZZPjyYfjwb6EvN7BuqsZjRo/gn1KnmhlVGMbL
	N4OVLIHVQc8ZK2zVVTghZ3oiJXciLdmcR9h/zef7qO13WtkVHK5GxAuUFGGdARCt764gGipA6rn
	FTuq62wI9m6CEbvAW9YvcY336MX5nf4fCzyHuF2n0fll3ixLwDzs5MCBZQ=
X-Received: by 2002:a17:902:f552:b0:2c7:f688:f22f with SMTP id d9443c01a7336-2d650dacb5cmr1084755ad.13.1787265492587;
        Thu, 20 Aug 2026 15:38:12 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62d555374sm12045265ad.16.2026.08.20.15.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 15:38:10 -0700 (PDT)
Date: Thu, 20 Aug 2026 22:38:07 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Alex Williamson <alex.williamson@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, "Tian, Kevin" <kevin.tian@intel.com>, 
	kvm <kvm@vger.kernel.org>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-pci <linux-pci@vger.kernel.org>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 1/5] PCI: Refuse function reset of an SR-IOV PF with
 enabled VFs
Message-ID: <aod22_H66eUth9av@google.com>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
 <20260812045325.2733631-2-alex.williamson@nvidia.com>
 <an5JbIzz40svS3xe@google.com>
 <20260814083737.66bb83fb@nvidia.com>
 <20260817121810.GC933791@ziepe.ca>
 <CO1PR11MB48354AC2854C4D8E9984FD8E8CA62@CO1PR11MB4835.namprd11.prod.outlook.com>
 <20260818140304.GC5482@ziepe.ca>
 <20260818143906.1f58aecb@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260818143906.1f58aecb@nvidia.com>

On Tue, Aug 18, 2026 at 02:39:06PM -0600, Alex Williamson wrote:
>On Tue, 18 Aug 2026 11:03:04 -0300
>Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
>> On Tue, Aug 18, 2026 at 07:07:20AM +0000, Tian, Kevin wrote:
>> > 3) resetting a PF due to ad-hoc FW error
>> >
>> > e.g. pdsc_check_pci_health() calls pci_reset_function() when FW
>> > reports broken PCI. Sounds a similar condition to AER.
>> >
>> > but as it calls pci_reset_function() this series causes a regression
>> > in case of active VFs. Is it desired?
>>
>> mlx5 does something similar. RAS flows require detecting the PF has
>> blown up and resetting it to bring it back.
>>
>> This has to work while VFs exist and bound to kernel drivers or vfio.
>>
>> In the VFIO KVM case I would expect the VM to experiance a RAS error
>> on its vPCI device and trigger a VF flr
>
>This would need to be a device level RAS flow as we're sorely lacking
>on forwarding reset notification to VF drivers or providing any
>mechanism for recovery from the vfio error eventfd.
>
>> But we have to sort all this out through the hypervisor to not crash
>> the machine or otherwise :)
>
>In general guarding the high level pci_reset_function() family on
>(pci_num_vfs() == 0) seems to have more pros than cons and the
>restriction matches the scoped intent of the interface.
>
>The low level __pci_reset_function_locked() interface remains
>untouched, and as the prefix implies, relies on the caller to do
>necessary verification and preparation.  A "reset the PF regardless of
>VFs" seems like an underscore prefix sort of operation.  We'll need to
>export the pci_dev_save_and_disable() and pci_dev_restore() functions
>to provide handlers the full suite of tools they need to replace the
>existing function and port those we find (maybe also questioning the
>author's intent on VF reset and recovery).
>
>Of course making the guard parameterized with wrappers to expand this
>family of calls is also an option,
>pci_reset_function_locked_with_vfs()...
>
>The mlx5 driver doesn't actually seem to be affected by these changes,
>doing its own link toggle or a PCI bus reset, not a
>pci_reset_function() call.
>
>On the other improvements, triggering a pci_reset_function_locked() on
>unbind after SR-IOV is disabled, when needs_reset is indicated, looks
>pretty trivial.
>
>The blocking domain operation looks like it might be simplest to
>implement in the IOMMU core.  We can set a flag for a default blocking
>domain on the IOMMU group when we take_dma_ownership of the group.  Then
>release_dma_ownership picks the blocking rather than default domain.
>
>This is then unwound in use_default_domain, called via dma_configure,
>attaching the device to the default domain in probe of the next driver.
>Therefore until probe by another driver, a device used by vfio would
>remain in a blocking domain even while unused and unbound.

The devices are expected to be attached to the default_domain even when
these are unbound and the use_default_domain assumes that, and it only
checks the ownership and doesn't switch the domain to default_domain. I
guess we should add a WARN in use_default_domain() if that is not true.
I will probably send out a patch for that separately.

I think we can move the device back to default_domain after reset after
unbind, maybe it can be done in pci_dma_cleanup() based on
driver_managed_dma?
>
>Does that seem reasonable (Cc +iommu)?  Thanks,
>
>Alex
>

Thanks,
Sami
