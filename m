Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDB83839AA
	for <linux-pci@vger.kernel.org>; Thu, 27 Aug 2026 18:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853803; cv=none; b=HcY6H7ar1n+5Zm4OPgnqB8eAg3mgZtoJ1yeTq+Voapz3hzf0jhL7VDIJSFOUbe3q62IobolSGcPRQQX5VfkYpRutHaBl3PkFrSgQ1oIVOLl+aTLd/IrE+8DW9bX5o4fh8ROzp75vtyNAPMWwbWEcsXlvBAxgSWIJcaaWdrApo2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853803; c=relaxed/simple;
	bh=aVJvper34EDrUAZdd4lOfHj1wCc4uQDuLNlXgq1p1YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCftx8qJqz5ROBUzXLq9OmauA/jRYEYTSevvjxqS4PZDpgKGtgRG+HGa0I5RtA8rXsJ+YGYXd87R5T7GYX3aLlEEtZpXhaLaBVHYi5J0dQkiyIlgqQrT1TveFwkC69rppbK+sC+1PVZ2Qx2Q50kOAkDpjd4Bttt/HxsxIMi0+Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bqa79GVU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bqa79GVU"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cede6375caso14675ad.0
        for <linux-pci@vger.kernel.org>; Thu, 27 Aug 2026 11:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787853801; x=1788458601; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KoGSjfHeCXk5ZMZawIjFrD2nA/EHJWwuQY/vd3YWCZ4=;
        b=Bqa79GVUVZJc0oroeM3AzdPpJtHhs/mwHewHAduY4gHIDgkKtR2k/3ddHratw1HBEG
         Vq3zGH2ZX/RVdNd+UnMBwgcXUaiOxYcB9BZ0IyPUoQJ7GZq7vKezITaTgjeUmX5JBgfJ
         /bP7jDiI005+pXBl05eUtrrxwkzQlje/NUedUcXi81pQfP+vqT8ONA/3RheQ1+7EZlCD
         rhUvjC7vuox2dgeyODGH/EspWiSnShrEFB5zDdcaUggUVbdLAWAny3OQ6HDXZP/cwW0c
         gb/pDPsJTjdB02SoN3WKXzbxPD0CFnSEtLzcGgCyUGaEow+9zJc1TmOLaZttfqv6ADuY
         Z14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787853801; x=1788458601;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KoGSjfHeCXk5ZMZawIjFrD2nA/EHJWwuQY/vd3YWCZ4=;
        b=FD0XuMHY/2FFUV6nwaGf33c3u+XzX9uGiDuORC6Vyomj86x+497dROAkd31F5O1VfP
         iCdiAZ98Z3VkRlPLQ9spn0sM5D13smKgYlJW+/l6W4VJyjVjiEbBk14VBYVI8a4nEuyy
         cJEfVE66krNA32rD3RD+r8AuAXwbNmJuHG28UD8SR4SUzvEB816Ci4y9JaFgErbAWNO7
         sEuxPGnvc8ap+F+87E6qMJQ+t9CNFbK5heuL3ED4Sq5okXt0JJO+BenXIoxUE321hhYz
         WhnzAGl12nA3IFX7YX17hyk1oyugI1v21TtbooV4bo73yre83k5mBYwueqUjSaAz2M85
         UiUA==
X-Forwarded-Encrypted: i=1; AHgh+RphC7g1La0W3nHEaJPycRiCVoBJ9uBC1D191o4C0Hjxz6jOF+QCUFygwt7472bJf9XhZdhGEI32JE0=@vger.kernel.org
X-Gm-Message-State: AFuF++l7JwW+j2ZUXFxiIoxiRhwxUY9Cc1aXBcZ3vcS7Wr571yislSDC
	Hn6Jctbtpz4mYyYqIx8f+9JGtBVA+X3yPHVdjYdpMSeor25IrQYutflNCYd2mUJgjQ==
X-Gm-Gg: AR+sD10C6EaUs7Tnmk5sW0oSxgRtHSPxXWeBwButGJU3Z6JGxm13EIglGAH+jMY3/Sg
	+/veO9po0aBo9RT7vMyXW/Cm6UeMQBfXJwDtKtWZKHhKN7uietTeKpIKcK6xsg84a+TUAFVXAr7
	1D090EMOTO5/rzUTgCXTw5sv9PGep3T1dD1RS1K7Z9+oyEeX+nqwERQbOMXCA4FcWqw80UzqO75
	cb3RvxBJOrCZvi415muoF7lHIlVctXSHQeIeL44wwSr6c5gEWzGkjfLtXGHuKf+0dRSw+NqFN+Q
	FZF8rnMc5EMb200Sb5i/JRUE4bBIJySCeyBWRCITzIczr23JBA2zNA0j/NQIkDoZF/rIy6K1X5O
	2zBUsQ4mcxXs2F4Ik1KkRG21iqWPikynjfw40OrIZ/VRyRumMYEEF+mV2KKmrujUyiMObvAatpK
	nuMUw1kkD4KUulxg4NkSX8LlEbX2EXauKWpMmmmfNow7YueRtURP5jlkdWUEmFgBtV2YAxfUPlo
	VoBOLGHfIIZ4CcQHePm2id4aznkeqg4OK7bOTivyCXrdh3VWsJRWLPNH28=
X-Received: by 2002:a17:903:8c5:b0:2d5:db3d:1a44 with SMTP id d9443c01a7336-2d74f6efb5bmr432895ad.17.1787853800262;
        Thu, 27 Aug 2026 11:03:20 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39675867f73sm3108022a91.4.2026.08.27.11.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:03:19 -0700 (PDT)
Date: Thu, 27 Aug 2026 18:03:15 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, Alex Williamson <alex@shazbot.org>, 
	Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, Robin Murphy <robin.murphy@arm.com>, jrhilke@google.com, 
	tatashin@google.com, Will Deacon <will@kernel.org>, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] vfio: circular locking dependency in
 pci_dev_reset_iommu_prepare()
Message-ID: <apB6tsN6cHz9Iuv3@google.com>
References: <20260821193502.92431-1-vipinsh@google.com>
 <ao3nr1-t0DxANAyC@google.com>
 <CALzav=f5wUUt4mKZn0tvQez6_1iYPcb8eX5q-XjabTNy03JiNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=f5wUUt4mKZn0tvQez6_1iYPcb8eX5q-XjabTNy03JiNg@mail.gmail.com>

On Wed, Aug 26, 2026 at 01:27:20PM -0700, David Matlack wrote:
>On Tue, Aug 25, 2026 at 12:06 PM David Matlack <dmatlack@google.com> wrote:
>>
>> On 2026-08-21 12:35 PM, Vipin Sharma wrote:
>>
>> > ================================================================================
>> > Potential Solutions Suggested by AI
>> > ================================================================================
>> >
>> > 1. Decouple iommu_setup_dma_ops() from group->mutex in drivers/iommu/iommu.c:
>> >    iommu_setup_dma_ops() only requires struct device * and the domain pointer
>> >    (group->default_domain); it does not mutate any fields in struct iommu_group.
>> >    Moving the iommu_setup_dma_ops() calls after mutex_unlock(&group->mutex) in
>> >    iommu_probe_device(), bus_iommu_probe(), and iommu_group_store_type() breaks
>> >    the initial &group->mutex -> cpu_hotplug_lock dependency.

The group->mutex is needed here also since it sets up the dma_ops on the
default_domain that is currently attached to the device. And those
attachments are protected with group->mutex.
>>
>> Are there any other code paths that rely on group->mutex -->
>> mm->mmap_lock ordering? If so fixing this one case wouldn't help.
>>
>> > 2. Avoid holding down_write(&vdev->memory_lock) across pci_try_reset_function()
>> >    in VFIO:
>> >    vfio-pci could zap active BAR mappings under memory_lock and set a state
>> >    flag / disable memory decoding, drop memory_lock before calling
>> >    pci_try_reset_function(), and then re-acquire memory_lock to re-enable
>> >    memory. While resetting, any concurrent user fault will see the memory
>> >    disabled condition and return VM_FAULT_SIGBUS safely.
>>
>> This would change the userspace-visible behavior of faulting on a VFIO
>> device BAR from "block until reset is done and the succeed" to "fail
>> with SIGBUS". And it would allow VFIO to access VFIO device BARs during
>> the reset through vfio_pci_core_iowrite*().
>>
>> But I think we can extend this idea to solve those problems by
>> introducing a wait queue for tasks to sit on while a device is being
>> reset.
>>
>> e.g. Something like this (completely untested and partially written by AI):
>>
>> From: David Matlack <dmatlack@google.com>
>> Date: Tue, 25 Aug 2026 18:37:52 +0000
>> Subject: [PATCH] vfio/pci: Avoid circular locking dependency during device reset
>>
>> Avoid a circular locking dependency during VFIO device reset by dropping
>> vdev->memory_lock prior to calling PCI reset functions
>> (pci_try_reset_function() and pci_reset_bus()). Introduce an explicit reset
>> state flag (vdev->resetting) and wait queue (vdev->reset_done_wq) to stall
>> concurrent BAR page faults and MMIO accesses during reset without holding
>> vdev->memory_lock across PCI reset operations.
>...
>
>This approach does not look ideal. The implementation has a bug where
>concurrent resets can lead to vdev->resetting being cleared too early.
>And from a maintainability perspective, there are more call sites that
>currently take memory_lock that would probably also have to be updated
>to wait for vdev->resetting to become false.
>
>> >
>> > 3. Refine synchronization in pci_dev_reset_iommu_prepare():
>> >    Evaluate if attaching to the blocking domain and pausing ATS during device
>> >    reset can be protected using more fine-grained locking or atomic state
>> >    flags without holding the coarse &group->mutex.

This might not work as reset_iommu_prepare() changes the domain of the
device being reset and those things protected by the group->mutex.
>>
>> I don't know enough about this part of the kernel to say, but this would
>> directly address the new lock ordering dependency vdev->memory_lock -->
>> group->mutex introduced by commit f5b16b802174 ("PCI: Suspend iommu function
>> prior to resetting a device"), which is what led to this lockdep error.

Thanks,
Sami
