Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0291D377034
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 01:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790041656; cv=none; b=MEkBSPSqwuI7r31g8wFE0boJu5UxzA/wRycChCXDhGo6fA/KGCLf0ca/7/uIz5fUvr3leLiOAO3am7DR8D1seg5BLaI82ADTfbR8HkCS4dU92jMhZypLqxd1MtZfrQpnkh97E5C6vMkbQyWHD2vwd/dqbvc85qQLqO0S7Z8frms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790041656; c=relaxed/simple;
	bh=JRet0lN6fAyPGKcEZAkelJe6hquf64NfYxR4H5/x8y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GG1Wj6wepPADTvuvYgESZMQDDagYpI/hzEGyeG2TSgJj9JJVdH4aBc3zEv/CftXTLD9DM7SWCTB4nZGl5ECLECMb2bSazF2XN3fwjZOyAOxumeYYioRKr/ZL+osuehBc3Y6X6Va3NthO+0wumyL3wwhcrN8fcEYrOS3NdPtF2NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cPoqgfDA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cPoqgfDA"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d3b445a84fso31815ad.1
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 18:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790041654; x=1790646454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i6+2inLQAeVlBcJ3LlCplkJMtCvXJB/NM/8WbN3/bwA=;
        b=cPoqgfDAxj97Oo9a6bbkse48nLAf0Wkeai8frA62+SXicakUQaQ9zVgTI3sKQ2ZbNr
         9nRpjgbi2zSJjmJcurXDMInCWSL3quqv5r/5A43TtJ8zJ22Qc/5ZTU+IYpHV5lGpdhp8
         pGegpqUoE1Rz4UUbnmDdgb4FTwRXAXoxMNprqwKtZOZFnJ3j19vo10mvg9Mho3zUyaRh
         AKPPqMPFgL7yT+jZGQGO/WM4MqJV4NFWV8bugHsVkY+ysnST03IpPB2UbB3zVIMPnEOK
         PI3OzSWt50V8LLYMfEOViN1evuImrB5W6MG7Eikp4S3EmQA92fMC8nY9mHvzbqyRUqYy
         4gDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790041654; x=1790646454;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i6+2inLQAeVlBcJ3LlCplkJMtCvXJB/NM/8WbN3/bwA=;
        b=fg4FnBmo7UPFSlSyzrIId384FHeT4Ag7jsX3GS8Q3pKJqKP5FI+l6VhyHgZ0LclERw
         RUs0Z9t8+jLYRRTBevZp9U7D92gIzc3zLJiupdUBhsrM44J9s6PiIkuIG6Z6VNXu2g+6
         7wUU8tPGg/yNIEFfMLbhvCyqDuKFaLmCyQkzaAJ7tjuLPyyGbng88hWX5a5/a0XfiHNo
         1Fm/19lkKql6Byq/msJhVNi0kXbZ13ZMgLVlvqRCe4Dqbs5U2KJ53BEY0RICYXwBMUi1
         Ofod6FgtPlrRkU4lPVjsuHMUCCTqYLfMXvJJtwiZjmMI5WEFEdMhkqUFKts4jhZieYlp
         c7Tw==
X-Forwarded-Encrypted: i=1; AKwUvBxgA32a+sCrX9wCp7WNwhiCEQoYF120CIcPYycv4m1UlvclZR4ZK6bjmdiP6l4zlYVZ3Xm2VWe4ERk=@vger.kernel.org
X-Gm-Message-State: AFuF++l18SWXiMrc/e+rBlHZvLIDlNHDkqp7ySGJoZ3cygjH1wzNKLGr
	80MXk0h9KsQsUEGNU8fm0VcsfNZeUTaTkJP63dgSGYQmOg4mS29ps2SCurzdpEwHYA==
X-Gm-Gg: AYBFou1u5pI97j1B9mnLPLQgru54Rp3Pp9iokNYI0TQv/kdwzmNYG6tixSD5+VGSdsh
	AEojTqwGutzVIk8XKRh2o670KInFejlCZpTUu9C7n+mo/mvW52CsRL41cAUZ5T+WPZsw5F2jsPd
	8ibvbHFFiMqvIEDHlb4g9xnphPyaROOeTP84HausXGLIdaNY5FG26Etts3vL9ecMOyWfbMsUfVk
	CHRtKXGcmAFSuomSIDpkPf7HKPeG4rtRmHmCS1bnr6F7b3ox/ONhxKOHnweaFFM7/iaU9ca1WC7
	Nkdm/DKrozmRpnPc70IMSjxauBHVBoP0vN2ADY3CpxdQetKtBcs4kQCM5Ml26leDIrWn7EyniFk
	+rsiWxm+zSw7jok0jURpoYAVyUWVJVZrLHNAnL3Dld+AgDUfMXUtR/zxQVluTPEmkhEFmaYaWtS
	wN3Jh7DEBlHQeF85vq3B8XDnaYCMEi7axrtT1AzDepP4pum1p0gQ3gEnvf2id/EGnk7cJ+7+WWj
	zsliCjDDz56ep6fFMcEK5fsUUvnTb8WH8KJsBJpIc/DowEMa8CGUvZdr3KWJtUImypvrwA3nyLz
	vtsS
X-Received: by 2002:a17:903:2f4d:b0:2c7:f688:f22f with SMTP id d9443c01a7336-2df5b835b4amr3114135ad.13.1790041653508;
        Mon, 21 Sep 2026 18:47:33 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06e5751f2sm342687a91.9.2026.09.21.18.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:47:32 -0700 (PDT)
Date: Tue, 22 Sep 2026 01:47:28 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Alex Williamson <alex.williamson@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, kvm <kvm@vger.kernel.org>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [RFC PATCH 1/5] PCI: Refuse function reset of an SR-IOV PF with
 enabled VFs
Message-ID: <arHP3Sj19YX-J-vx@google.com>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
 <20260812045325.2733631-2-alex.williamson@nvidia.com>
 <an5JbIzz40svS3xe@google.com>
 <20260814083737.66bb83fb@nvidia.com>
 <20260817121810.GC933791@ziepe.ca>
 <CO1PR11MB48354AC2854C4D8E9984FD8E8CA62@CO1PR11MB4835.namprd11.prod.outlook.com>
 <20260818140304.GC5482@ziepe.ca>
 <20260818143906.1f58aecb@nvidia.com>
 <CO1PR11MB4835146C50242D76568724DE8CAD2@CO1PR11MB4835.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CO1PR11MB4835146C50242D76568724DE8CAD2@CO1PR11MB4835.namprd11.prod.outlook.com>

On Thu, Aug 27, 2026 at 05:35:17AM +0000, Tian, Kevin wrote:
>> From: Alex Williamson <alex.williamson@nvidia.com>
>> Sent: Wednesday, August 19, 2026 4:39 AM
>>
>> On Tue, 18 Aug 2026 11:03:04 -0300
>> Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>
>> > On Tue, Aug 18, 2026 at 07:07:20AM +0000, Tian, Kevin wrote:
>> > > 3) resetting a PF due to ad-hoc FW error
>> > >
>> > > e.g. pdsc_check_pci_health() calls pci_reset_function() when FW
>> > > reports broken PCI. Sounds a similar condition to AER.
>> > >
>> > > but as it calls pci_reset_function() this series causes a regression
>> > > in case of active VFs. Is it desired?
>> >
>> > mlx5 does something similar. RAS flows require detecting the PF has
>> > blown up and resetting it to bring it back.
>> >
>> > This has to work while VFs exist and bound to kernel drivers or vfio.
>> >
>> > In the VFIO KVM case I would expect the VM to experiance a RAS error
>> > on its vPCI device and trigger a VF flr
>>
>> This would need to be a device level RAS flow as we're sorely lacking
>> on forwarding reset notification to VF drivers or providing any
>> mechanism for recovery from the vfio error eventfd.
>>
>> > But we have to sort all this out through the hypervisor to not crash
>> > the machine or otherwise :)
>>
>> In general guarding the high level pci_reset_function() family on
>> (pci_num_vfs() == 0) seems to have more pros than cons and the
>> restriction matches the scoped intent of the interface.
>>
>> The low level __pci_reset_function_locked() interface remains
>> untouched, and as the prefix implies, relies on the caller to do
>> necessary verification and preparation.  A "reset the PF regardless of
>> VFs" seems like an underscore prefix sort of operation.  We'll need to
>> export the pci_dev_save_and_disable() and pci_dev_restore() functions
>> to provide handlers the full suite of tools they need to replace the
>> existing function and port those we find (maybe also questioning the
>> author's intent on VF reset and recovery).
>>
>> Of course making the guard parameterized with wrappers to expand this
>> family of calls is also an option,
>> pci_reset_function_locked_with_vfs()...
>
>+1 for wrappers. Maybe call it pci_force_reset_function_locked() which
>is slightly forward-looking if in future other conditions may reject the
>reset request using the base function.
>
>>
>> The mlx5 driver doesn't actually seem to be affected by these changes,
>> doing its own link toggle or a PCI bus reset, not a
>> pci_reset_function() call.
>>
>> On the other improvements, triggering a pci_reset_function_locked() on
>> unbind after SR-IOV is disabled, when needs_reset is indicated, looks
>> pretty trivial.
>>
>> The blocking domain operation looks like it might be simplest to
>> implement in the IOMMU core.  We can set a flag for a default blocking
>> domain on the IOMMU group when we take_dma_ownership of the group.
>> Then
>> release_dma_ownership picks the blocking rather than default domain.
>
>IMHO we should change release_dma_ownership() to always picks the
>blocking. No new flag.
>
>this take/release interfaces are invented for drivers which manage dma
>on their own, so it sounds reasonable to not assume the operated device
>is in a good shape after the ownership is released.
>
>Then only a clean reset can unwind it.
>
>>
>> This is then unwound in use_default_domain, called via dma_configure,
>> attaching the device to the default domain in probe of the next driver.
>> Therefore until probe by another driver, a device used by vfio would
>> remain in a blocking domain even while unused and unbound.
>>
>
>so unwinding it blindly at dma_configure time is also problematic, as the
>device may still have a bad state to hurt the kernel.
>
>Instead use_default_domain should fail in such case (in blocked with
>owner_cnt being '0') then a reset is expected to unwind it (Nicolin's
>work will carry the resetting status to pci_dev_reset_iommu_done())

Thinking about this more, it might be tricky in multiple ways,

- This will only work if drivers do reset after dma ownership is
   released. Looking at the code, vfio currently resets the device first
   and then dma ownership is released.
- For some devices with no reset mechanism, vfio-pci uses bus or slot
   resets. This will need extra care to propagate the
   reset_iommu_prepare/reset_iommu_done to subordinate devices to bring
   the device out of blocking domain.
- AFAIU looking at vfio-pci code, some devices do not have proper reset
   mechanism, not even slot/bus, so those devices would be stuck in the
   blocking domain state. Probably need a mechanism to let IOMMU know
   that there is no reset mechanism?

Thanks,
Sami
