Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A3B31F990;
	Thu, 30 Jul 2026 08:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785399862; cv=none; b=uIEkysgaNRa7eW5Zrh/3gb0lVOrcs74ISjctd0S8Fsbfyupz3pzv4ZTebWyYYlqbzu9x/B/g1HyL9f8EDHlJHL33LIDYHAOazosEg/k6rfLzxujxKREnd4s+9V55JfH8FWW/ApVYaDC2kZrtUHuOz9vecokRmDMRyjluHxmW1nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785399862; c=relaxed/simple;
	bh=mPkyEzGy4nzPfbLXduTY8moq3y4EYaSZcpWZjw3q2Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVHpmtsyxvZyWIvQQ/4sJ5+FQyLHtsGSlkD9bLOV7LHg2XXtxhctD6aeAiuKYcEElZecyzWnD+MfXDNTDcPYqk+uR+J9CEHQJKlw7jG/pH8r2gVxvc4S+idtLRY3LNu+7vD9VgkPJonea1qpZz9ITrGeRw41WROTYCEiJSpaqc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChBSdYm3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChBSdYm3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDFE1F000E9;
	Thu, 30 Jul 2026 08:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785399861;
	bh=VXQZIQoVKxftmgxSpsfIIxOpHqOtOFC0MrEElaZfb68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ChBSdYm3VX7ZR8sCoLMTJcd3DQNuh7j0CXjLFvbLn+a+u1rJQcv051pGJ3Gh7onak
	 EjI4HcBfmFntcRanNhQ7fX1sACnhGJlyFu7xRwX8y13yNrOrxknwpaS7HbyRjgDZCR
	 EuIX5Czn+o72EjyfAMLyCKqWXb8M6Tn17jc7Lk2j7QaObnD42gQxrLhW+tl4HnaZNK
	 6v7pTRi0VcQDJFd1/QJDvwH7CdFCl8nCBLqt7cuow2NyHpCW/yWFM1i+MVQTBZBxrv
	 EgWn5f/ieaBn+l6gNk0KXMinAIZqPDl/bhZHxtyME403gUTL3pBcp5S9lWsO64aazr
	 DXS5f/gwAp32w==
Date: Thu, 30 Jul 2026 09:24:00 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, 
	Baoquan He <baoquan.he@linux.dev>, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Simona Vetter <simona.vetter@ffwll.ch>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Dave Young <ruirui.yang@linux.dev>, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, kexec@lists.infradead.org, 
	driver-core@lists.linux.dev
Subject: Re: [PATCH v2 0/3] mm,kernfs,proc: Unmap mmaps of removed files via
 file->f_mapping
Message-ID: <amsJ_T3qTJ-TJcwk@lucifer>
References: <20260725210549.3716546-1-kwilczynski@kernel.org>
 <20260725143737.daa698b50289257fbaa9c6f1@linux-foundation.org>
 <20260726001049.GA2219014@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260726001049.GA2219014@rocinante>

On Sun, Jul 26, 2026 at 10:22:52AM +0900, Krzysztof Wilczyński wrote:
> Hello,
>
> > > The PCI resource files in sysfs and the /proc/bus/pci device files swap
> > > their f_mapping to the shared iomem address space at open time, so that
> > > revoke_iomem() can unmap userspace mappings when a driver claims a
> > > region, see commit 636b21b50152 ("PCI: Revoke mappings like devmem").
> > >
> > > Their VMAs are therefore attached to the shared address space, which
> > > neither removal path reaches: kernfs_drain_open_files() unmaps the
> > > sysfs inode's own mapping, which contains none of them, and
> > > proc_entry_rundown() does not unmap anything at all.
> > >
> > > As a result, userspace mappings of PCI BARs survive device removal,
> > > and also survive a BAR resize on the sysfs side, keeping stale PTEs
> > > into physical address space that the kernel may have reassigned since.
> > > A mapping made before the device is removed still returns the previous
> > > register value after the device has been released, through both
> > > interfaces.
> >
> > Thanks.  Can we please have full description of the userspace-visible
> > effects of this?
>
> Definitely.  From the PCI side, to put this into perspective:
>
> Without this series, a process that maps a BAR keeps a fully working
> mapping after the device is removed or its VFs torn down.  The same
> applies when a BAR is resized, as the resize removes and recreates the
> resource groups.  Nothing faults, so the process cannot tell the device
> has gone.  A read returns the register contents as they were, because
> removal clears Bus Master but leaves Memory Space Enable set, so the
> device still decodes its BARs, and, as these attributes are writable,
> a write is still accepted and reaches it.  Those addresses are released
> on removal and can be assigned to another device, which a BAR resize
> does explicitly, and the mapping then reaches whatever occupies them.
>
> On the sysfs side this most likely has been a regression as the
> kernfs_drain_open_files() unmapped these mappings correctly until
> commit 636b21b50152 ("PCI: Revoke mappings like devmem") swapped
> f_mapping to the shared iomem address space, after which the drain
> walked an interval tree the VMAs were no longer on.  The procfs side
> never unmapped anything, so there the behaviour is new.
>
> A read here returns another device's register contents, and as read to
> clear registers are common, it can also acknowledge an interrupt or clear
> an error the owning driver has not seen.  A write can be worse, as an
> offset that was a control register on the old device may be a doorbell,
> a reset bit or a DMA descriptor address on the new one.
>
> With this series the mapping is torn down as part of the removal, and
> the next access raises SIGBUS, so userspace gets an error instead of
> silently reading stale or unrelated registers.  Both interfaces behave
> the same way afterwards.
>
> Tested on 7.2-rc1 with and without the series applied.  In each case
> the file is mmap'd, the device is removed while the mapping is held,
> and the mapping is then accessed:
>
>   - sysfs resource read after removal:
>        before: returns 0x18140241, the value read before the removal
>        after:  SIGBUS
>
>    - sysfs resource written after removal:
>        before: the write is accepted and reads back 0x00000000
>        after:  SIGBUS on the write
>
>    - sysfs resource mmap, fd closed, then read after removal:
>        before: returns 0x18140241
>        after:  SIGBUS
>
>    - sysfs resource mmap, moved with mremap and split with munmap, then forked, both read after removal:
>        before: parent and child both return 0x18140241
>        after:  SIGBUS in both
>
>    - two sysfs resources of different devices mmap, one device removed, both read:
>        before: neither is unmapped, both return their values
>        after:  the removed device raises SIGBUS, the other still returns 0x48140240
>
>    - /proc/bus/pci used to mmap resource, read after removal:
>        before: returns 0x18140241
>        after:  SIGBUS
>
> I hope this helps!
>
> > AI review might have found a few things:
> > 	https://sashiko.dev/#/patchset/20260725210549.3716546-1-kwilczynski@kernel.org
>
> I have seen the reviews.  Will reply to each.
>
> Thank you!
>
> 	Krzysztof

Thanks for the details, be good to put this concisely in the cover
letter/relevant commit messages on respin.

Cheers, Lorenzo
