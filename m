Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC05B360EF9
	for <linux-pci@vger.kernel.org>; Thu, 27 Aug 2026 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787852218; cv=pass; b=eZkrnr7jB9jGhL9YB0W5Qmb4LbAcZb88e3P0V5jTGfKeYe/u8cTIxP9Nc2DqNT/qG/UO4kMtRybasQx2orOGka5/937gD7lo9iFfSnsGKurRCYMA6ZhxDBIIbAjqy3y/jiEC96vNfmA1LWDOIIo+/VrzK+Vc+XvFJprLeucHwAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787852218; c=relaxed/simple;
	bh=zx9m3UJWLQKbi0/pNDNNX6lZqJj4z+ajiJa/RVGEIzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bNy2vGs5ngOm9voBV/LNIABD3tAJRp9C86b6IZyinT/AmsefBDD3bZP3SyWqrZemcitliX4T2mMZwIyB1yBgTnScQ0GNWE1EpwOWt/U2Pf8xqynMZ+ZY/ipnv6YmomNHF0+hhZaqOmXlPQQHYoSLhvjhO1/EJ7YdoPN7BohKm08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dRpFwvYo; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dRpFwvYo"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c247f6687dcso16483066b.2
        for <linux-pci@vger.kernel.org>; Thu, 27 Aug 2026 10:36:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787852215; cv=none;
        d=google.com; s=arc-20260327;
        b=Y6lSEuEzm5V9rdBb47mFQF/nJajJ/PuwqIFuiPIBy3ExXWUpFhgvKSxm8AF1WThG7K
         JNkDvM8pCmAQNyqcHJW0M8wREMlUm39UOnoe0hcAG/fw7K/wx0l22mhJpBtHbMjnrE22
         Jp3YD0rxVpYtuauMkA1soCg711TVuBF/AErL4+ZuODhzN4CI3r6Vvbyy5F4b6eKNzXrq
         CQcelEmC4MWHjdmrSB9EwFSuogrVmj5uWHqUNji3ppQdKRHoSAo+yDAdAIITaQrB70wu
         x53fUu0OCNgTfK7DlLdWBAJiRZFIeFWV2m7cPoauN+2vPCPxsyXnwTOSvWFZ5ZaAPV+h
         ujEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cU2IdGj8HYn85rF2dapXdYr5omVVmX8wN53COGpvOpk=;
        fh=HiIhkd2mEZWCxS5+BCihaAcnmMvhqIK6q7AifLH8Mew=;
        b=cJfKMMeopQiB5nUyxn/IgPQ1VH+a3KYW00a11WAO3RlkxTI9euCDo77CRa1PlqsF8O
         dG9dKWbyJqkJ6xsKgr3GiCzh047C9NaE8YCcC8cYULT6t39M8zW92lgJW9ulCf037bvL
         fk8lEMgw/79U6TX4HMgIY6uNcueTxcEttug3FWU5X+w/dd7cFWSxecDz3v1VZONcWUqK
         bMkRoC0VGSGU1W6pmKN318748hnvFpbWwRhpw1LXmEEhwaTDIsLpA1tTFMtyiaRpOlsZ
         Jpei/3ai7UXmif3Rb70aihFv7ZEeulXQRHEgGt7I75z8rWGUwRKC+msAvprbTc0V+N0E
         c+TQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787852215; x=1788457015; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cU2IdGj8HYn85rF2dapXdYr5omVVmX8wN53COGpvOpk=;
        b=dRpFwvYowfHdgT2R3A2rEgri01cWtOoql7/+z4P+JGuCPkW6uhZ702+jG81ptJD7pK
         tw6hdnoTMv1m26ICN3AoDlqhnZLyXV0Cosq3B3seSvii/+pANCwqbYMJYO5lcJByvDCl
         VxviYCNos7qw2yCHuWbfpXT6lRtcwlBKtVNjehrLVz8tBXzWAVC5GHJVQRUC8WZ6thPx
         8B2jlg9pRxOhQym05r5E22An8PcC5oyFvhLULhY+KCpZE9svlMiZI799eGtsXImOEI3E
         Ba6po+4qHH7Sx4LFJZ4wRePK9pgcoKX5f0NYa5IsAdrluh/q7rokPB7Kw8zvCAqRqOqI
         v0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787852215; x=1788457015;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cU2IdGj8HYn85rF2dapXdYr5omVVmX8wN53COGpvOpk=;
        b=ds2oCCxPVxUzRqdN+1jBtwCuleqGCFvPUsLoWr0VmxuVJtRC9pUYZZ9OukRiX3Bejn
         5OE4KE5YDDoa4OENZP31cEJOSbEN4WjGh+pPNPa3c14SZ80xBHXOyfhJS77A9w5uNWIW
         fu6T1n548lwvvU59vJKZptuPlarMetArN77TAitRaUwM/EymsSaAthGEHRxqQhdIzziD
         dl5HNaNCRoIwc5S1HHXod36nOQV76E5EC0wX74cLD+O74OXASCHkpw8jrTfd13C8cpVt
         EHgNibUo7VLQzPHIrep7/o3Fp6JjJrz+YAS7vdcjXWZFEHrn0L8q5h6kWupXmtSEacTx
         SgkQ==
X-Forwarded-Encrypted: i=1; AHgh+RpwPaHY2pC40HsSMRTPdiCiIl+oMjAfroQ9Aj/fgexAB/vaTWm93/ZyGd1thPB6T8Efm9mo+xXFKJE=@vger.kernel.org
X-Gm-Message-State: AFuF++muXG6lK9y4VdBjk4q8oOM3Z780BawrUff88i7LtGJaiOsiQUHJ
	DbctWx3fQtGdorJGZzxGxTDfr0Td50TGTRzxjX4+zniqP/SLHigqRnEKd8QRaydWo/lkbVBpdzb
	jFMzf6vA9K1y2MZoCOBSxGHep8ckpHcHxoZNGbfb9
X-Gm-Gg: AR+sD13jzyahiEkjSyFBd6wEmq1BqpS1oNl7BHhjhsJX+tiC0OwIRP7vZOvlB7xDF92
	6iArjYBTUIqN50uObUY97jFdvH2va/hsiXQ98Au6LHtwVnmhBqA28wvMNFpOVCH2AbEmasaUzRg
	SqDl3CVnLycxiDAdn4oWBwgaGBibsIwQdOliZWJgksnk7rsNmsJQgVGSfp1DEzg9QlopRElyTMp
	rbtPgJFRxanoUxRkAyArtbJnR5rEM3xXq6QSv/JyjTUZLQqp+nBqcouAXB05UMTbLjT7M3J73dd
	53yQO4duuXu5thajEZncUWThARToyRxwL+A26STV0+oqrw==
X-Received: by 2002:a17:906:628b:b0:c1f:8021:deef with SMTP id
 a640c23a62f3a-c2556c61defmr29002166b.10.1787852213404; Thu, 27 Aug 2026
 10:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821193502.92431-1-vipinsh@google.com> <ao3nr1-t0DxANAyC@google.com>
 <CALzav=f5wUUt4mKZn0tvQez6_1iYPcb8eX5q-XjabTNy03JiNg@mail.gmail.com>
In-Reply-To: <CALzav=f5wUUt4mKZn0tvQez6_1iYPcb8eX5q-XjabTNy03JiNg@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 27 Aug 2026 10:36:25 -0700
X-Gm-Features: AcwNN1XNPft5Ueou-qlSyAtHB2c_Ktuq8wp3SGgI-T0tZ93zrinbZgmtLF9T5Xs
Message-ID: <CALzav=cEmjnYAZDS8Le_FkaZW1xE+pP1B+mks0Of85YWG-3_vg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] vfio: circular locking dependency in pci_dev_reset_iommu_prepare()
To: Vipin Sharma <vipinsh@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	jrhilke@google.com, skhawaja@google.com, tatashin@google.com, 
	Will Deacon <will@kernel.org>, kvm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 1:27=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Tue, Aug 25, 2026 at 12:06=E2=80=AFPM David Matlack <dmatlack@google.c=
om> wrote:
> >
> > On 2026-08-21 12:35 PM, Vipin Sharma wrote:
> >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > Potential Solutions Suggested by AI
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > >
> > > 1. Decouple iommu_setup_dma_ops() from group->mutex in drivers/iommu/=
iommu.c:
> > >    iommu_setup_dma_ops() only requires struct device * and the domain=
 pointer
> > >    (group->default_domain); it does not mutate any fields in struct i=
ommu_group.
> > >    Moving the iommu_setup_dma_ops() calls after mutex_unlock(&group->=
mutex) in
> > >    iommu_probe_device(), bus_iommu_probe(), and iommu_group_store_typ=
e() breaks
> > >    the initial &group->mutex -> cpu_hotplug_lock dependency.
> >
> > Are there any other code paths that rely on group->mutex -->
> > mm->mmap_lock ordering? If so fixing this one case wouldn't help.
> >
> > > 2. Avoid holding down_write(&vdev->memory_lock) across pci_try_reset_=
function()
> > >    in VFIO:
> > >    vfio-pci could zap active BAR mappings under memory_lock and set a=
 state
> > >    flag / disable memory decoding, drop memory_lock before calling
> > >    pci_try_reset_function(), and then re-acquire memory_lock to re-en=
able
> > >    memory. While resetting, any concurrent user fault will see the me=
mory
> > >    disabled condition and return VM_FAULT_SIGBUS safely.
> >
> > This would change the userspace-visible behavior of faulting on a VFIO
> > device BAR from "block until reset is done and the succeed" to "fail
> > with SIGBUS". And it would allow VFIO to access VFIO device BARs during
> > the reset through vfio_pci_core_iowrite*().
> >
> > But I think we can extend this idea to solve those problems by
> > introducing a wait queue for tasks to sit on while a device is being
> > reset.
> >
> > e.g. Something like this (completely untested and partially written by =
AI):
> >
> > From: David Matlack <dmatlack@google.com>
> > Date: Tue, 25 Aug 2026 18:37:52 +0000
> > Subject: [PATCH] vfio/pci: Avoid circular locking dependency during dev=
ice reset
> >
> > Avoid a circular locking dependency during VFIO device reset by droppin=
g
> > vdev->memory_lock prior to calling PCI reset functions
> > (pci_try_reset_function() and pci_reset_bus()). Introduce an explicit r=
eset
> > state flag (vdev->resetting) and wait queue (vdev->reset_done_wq) to st=
all
> > concurrent BAR page faults and MMIO accesses during reset without holdi=
ng
> > vdev->memory_lock across PCI reset operations.
> ...
>
> This approach does not look ideal. The implementation has a bug where
> concurrent resets can lead to vdev->resetting being cleared too early.
> And from a maintainability perspective, there are more call sites that
> currently take memory_lock that would probably also have to be updated
> to wait for vdev->resetting to become false.
>
> > >
> > > 3. Refine synchronization in pci_dev_reset_iommu_prepare():
> > >    Evaluate if attaching to the blocking domain and pausing ATS durin=
g device
> > >    reset can be protected using more fine-grained locking or atomic s=
tate
> > >    flags without holding the coarse &group->mutex.
> >
> > I don't know enough about this part of the kernel to say, but this woul=
d
> > directly address the new lock ordering dependency vdev->memory_lock -->
> > group->mutex introduced by commit f5b16b802174 ("PCI: Suspend iommu fun=
ction
> > prior to resetting a device"), which is what led to this lockdep error.

I sent a proposed fix that takes this approach here:

  https://lore.kernel.org/linux-iommu/20260827173511.2322549-1-dmatlack@goo=
gle.com/
