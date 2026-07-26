Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992E1BA45;
	Sun, 26 Jul 2026 01:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785028975; cv=none; b=Y7aPl4Gjz++Uyar9Kpr5SQbKwM3y0E4+QKJMmfdBdTu3SnHyq3UWAZtn/YXEOkYEfjA5QOKgV3+fBAvI/3YSD24ge+dsNzqErvYBj481A9R9z4WvuE+Il6slVxzZIeiArxgydJiQ74jVKjRuGmRs1iYjo/+PDMXSnXnKnyal118=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785028975; c=relaxed/simple;
	bh=k2tg1QpWq0RX4Ly0c6GBRw8rsmZDLWtzs+noTE5sgxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dr1ehkcmSg2Suqqsx/NxarAZRzog5cQk+Q4tmXr0iss09KHKgRCzuNj8zo1Khu+pwZvOO7hleZ1oFHg34Leh12CELvLJilBifGqA+5RARh0mYXcL1QwYjlUHmVybi/OHE8pg7I742IF1lWxuBhzhP+O9M5rJDGb6AVMn843Y9Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jz8cmKZz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jz8cmKZz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D977A1F000E9;
	Sun, 26 Jul 2026 01:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785028974;
	bh=kyTCZAktriT+3XjiU8QSnJdULFe900yJhuf5hFur5jE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Jz8cmKZz9LtgeRolgwPoA+JT8I76PS1lGeJwazDa5NfE8jd+NbIiX8Ts8CIQ88atn
	 MiEzihC/mqruRUyJ5Gj0gKWm3FqxpbUNjDtjshh99mRvGGOqpDyMeGdpuKTZDRmXTV
	 nd9CyQrFjxAfNtkkMtKt3RCZq2jyUVkbcHCYQ+GhoftDKQ0WMNYbg980pLty8AJzw/
	 R448SRFS0ej86PJ6sVlGek7XjITi+oFAm5HmMIkkm6ABEsF8CKPthna5LdfPv6z9H4
	 8osFUyiMr+R9A7FdmwRMrE7b4tewj4yQn0Y2fy/1A//toM+xXdhx5vUEpth8TN7BI5
	 9EYruvy6mibaQ==
Date: Sun, 26 Jul 2026 10:22:52 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, 
	Baoquan He <baoquan.he@linux.dev>, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Simona Vetter <simona.vetter@ffwll.ch>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Dave Young <ruirui.yang@linux.dev>, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, kexec@lists.infradead.org, 
	driver-core@lists.linux.dev
Subject: Re: [PATCH v2 0/3] mm,kernfs,proc: Unmap mmaps of removed files via
 file->f_mapping
Message-ID: <20260726001049.GA2219014@rocinante>
References: <20260725210549.3716546-1-kwilczynski@kernel.org>
 <20260725143737.daa698b50289257fbaa9c6f1@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725143737.daa698b50289257fbaa9c6f1@linux-foundation.org>

Hello,

> > The PCI resource files in sysfs and the /proc/bus/pci device files swap
> > their f_mapping to the shared iomem address space at open time, so that
> > revoke_iomem() can unmap userspace mappings when a driver claims a
> > region, see commit 636b21b50152 ("PCI: Revoke mappings like devmem").
> > 
> > Their VMAs are therefore attached to the shared address space, which
> > neither removal path reaches: kernfs_drain_open_files() unmaps the
> > sysfs inode's own mapping, which contains none of them, and
> > proc_entry_rundown() does not unmap anything at all.
> > 
> > As a result, userspace mappings of PCI BARs survive device removal,
> > and also survive a BAR resize on the sysfs side, keeping stale PTEs
> > into physical address space that the kernel may have reassigned since.
> > A mapping made before the device is removed still returns the previous
> > register value after the device has been released, through both
> > interfaces.
> 
> Thanks.  Can we please have full description of the userspace-visible
> effects of this?

Definitely.  From the PCI side, to put this into perspective:

Without this series, a process that maps a BAR keeps a fully working
mapping after the device is removed or its VFs torn down.  The same
applies when a BAR is resized, as the resize removes and recreates the
resource groups.  Nothing faults, so the process cannot tell the device
has gone.  A read returns the register contents as they were, because
removal clears Bus Master but leaves Memory Space Enable set, so the
device still decodes its BARs, and, as these attributes are writable,
a write is still accepted and reaches it.  Those addresses are released
on removal and can be assigned to another device, which a BAR resize
does explicitly, and the mapping then reaches whatever occupies them.

On the sysfs side this most likely has been a regression as the
kernfs_drain_open_files() unmapped these mappings correctly until
commit 636b21b50152 ("PCI: Revoke mappings like devmem") swapped
f_mapping to the shared iomem address space, after which the drain
walked an interval tree the VMAs were no longer on.  The procfs side
never unmapped anything, so there the behaviour is new.

A read here returns another device's register contents, and as read to
clear registers are common, it can also acknowledge an interrupt or clear
an error the owning driver has not seen.  A write can be worse, as an
offset that was a control register on the old device may be a doorbell,
a reset bit or a DMA descriptor address on the new one.

With this series the mapping is torn down as part of the removal, and
the next access raises SIGBUS, so userspace gets an error instead of
silently reading stale or unrelated registers.  Both interfaces behave
the same way afterwards.

Tested on 7.2-rc1 with and without the series applied.  In each case
the file is mmap'd, the device is removed while the mapping is held,
and the mapping is then accessed:

  - sysfs resource read after removal:
       before: returns 0x18140241, the value read before the removal
       after:  SIGBUS

   - sysfs resource written after removal:
       before: the write is accepted and reads back 0x00000000
       after:  SIGBUS on the write

   - sysfs resource mmap, fd closed, then read after removal:
       before: returns 0x18140241
       after:  SIGBUS

   - sysfs resource mmap, moved with mremap and split with munmap, then forked, both read after removal:
       before: parent and child both return 0x18140241
       after:  SIGBUS in both

   - two sysfs resources of different devices mmap, one device removed, both read:
       before: neither is unmapped, both return their values
       after:  the removed device raises SIGBUS, the other still returns 0x48140240

   - /proc/bus/pci used to mmap resource, read after removal:
       before: returns 0x18140241
       after:  SIGBUS

I hope this helps!

> AI review might have found a few things:
> 	https://sashiko.dev/#/patchset/20260725210549.3716546-1-kwilczynski@kernel.org

I have seen the reviews.  Will reply to each.

Thank you!

	Krzysztof
