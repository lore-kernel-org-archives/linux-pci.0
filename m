Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C757330D3F3;
	Wed, 22 Jul 2026 04:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784693722; cv=none; b=WK6TxG7BzkYJzX2xq8IX2371rE6oUxYcIquQzpYElmD0hp6mR2gsitiQcht8GdiS83XcIBlcjdFT7xEfHd9bpzuBS0p2kFmBJMLFcq56naDuant+Q0vdtzxM3NBD/fOpsw42+7B8ns55O0VO/5aCvF4UxCrjB099uYmRmbyaPIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784693722; c=relaxed/simple;
	bh=AINbtM6dRjBD+zuHQrrw88Zzfww+Gix8XKHI3FSbr5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J06kcqcifKjbwV9bfTRKjjNX0PsXz5coLfNFGAe418gU7DZHAIn8z+CDkCzqOW+w010txKpmRP2u7RuyDthqKtD8R0r3ifJkfy617U8ScNZezHo/AUpSbAFvjrvmU05RcSfEP9hzpog36B+hK8Vt1cRp3u8zEHtfp95H/zug3u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fm62kkMp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fm62kkMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C870A1F000E9;
	Wed, 22 Jul 2026 04:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784693721;
	bh=sjWoXeUsuihxAtS7FsL2okB6tKsuwtAGig0KCI2ANJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fm62kkMp8EGXL0Bk2nd8liF0rcgGYvmNHL2xGKQfTLZL2kSPA8y1n/abjhkfNeM76
	 lX6Xsr8MYRgisl+17CNTa4FPyTHAcdfrDKI1ChOwvf3wOdKAPsY0n0lSl6TjtX7RTs
	 YnZCYrvJ8m/GVM4GdAwXhp0Z0X+WtVsPfSrvJo0eX8t4hwb2fnJwFdJysGk3XL6Pj4
	 BoqYQwXRBoUJSsH+EaCmkpYMFKzM+R0v/Avjz2UnnDS1EVVN8mf0Rp1KpvShzKxvlT
	 Ge0rZLZwY9SUMUTejgeT0I9HqBpG6z/HXFAgB5kK15w3Ez2nzYEwcv2LPuowLBy/wQ
	 XM0p4eY5PHmsg==
Date: Wed, 22 Jul 2026 13:15:18 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, 
	Dan Williams <djbw@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Simona Vetter <simona.vetter@ffwll.ch>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, linux-pci@vger.kernel.org, 
	linux-mm@kvack.org, driver-core@lists.linux.dev, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 1/2] mm: Add unmap_mapping_file() helper
Message-ID: <20260722030916.GA2513661@rocinante>
References: <20260721185252.1670958-1-kwilczynski@kernel.org>
 <20260721185252.1670958-2-kwilczynski@kernel.org>
 <5a43053d-8d08-4fda-82e3-bda10ca79c92@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a43053d-8d08-4fda-82e3-bda10ca79c92@kernel.org>

Hello,

> > + * unmap_mapping_file() - Unmap all mmaps of an open file.
> > + * @file: The file to unmap.
> 
> We are unmapping pages/folios, not really mmaps.
> 
> "Unmap folio from all mmaps of a file." ?

Got it.  I will make sure that v2 has the wording improved.

> > + * space it is attached to.  This also covers files with f_mapping
> > + * swapped to a different address space at open time, since such VMAs
> > + * cannot be found through the file's own inode mapping.
> 
> God this is confusing :)

Sorry about that!  I am not very familiar with the inner workings of
mm/, so please bear with me here a little. :)

> Sorry for the stupid question, but why can't we call
> 
> 	unmap_mapping_range(file->f_mapping, 0, 0, 1);

Since commit 636b21b50152 ("PCI: Revoke mappings like devmem") the PCI
resource and legacy files swap their f_mapping to the shared iomem
address space returned by iomem_get_mapping(), so that revoke_iomem()
can zap existing mappings when a driver claims a region.

That address space holds the VMAs of every resourceN file of every PCI
device, the /proc/bus/pci mappings, and every /dev/mem mapping in the
system.

So, calling unmap_mapping_range(file->f_mapping, 0, 0, 1) from
kernfs_drain_open_files() would then zap all of them on any
single device removal as a side effect.  This is not ideal.

I have tried exactly that, to be sure: mmap resource0 of two different
devices, then remove one of them.  The mapping of the other device was
torn down as well, and the next access through it got SIGBUS, even
though that device was alive and bound.

Hence the new helper, especially since kernfs does not know which
physical range belongs to the file being removed.  Only the PCI side
does.  The struct file in vma->vm_file was the only thing I could
think of to use as a filter.

> What is a bit annoying is that you now do in the caller:
> 
> 	if (of->file->f_mapping != inode->i_mapping)
> 		unmap_mapping_file(of->file);
> 	else
> 		unmap_mapping_range(inode->i_mapping, 0, 0, 1);
> 
> Shouldn't we just have one function that takes care of that internally ... so
> it's harder to get wrong?

The idea was to introduce as little change under mm/ as possible, keeping
things inside kernfs, which is the de facto consumer of the API from mm/,
so I wanted to make it obvious at the call site what needs to be done, so
to speak.

I will change it, such that in v2, kernfs will simply call
unmap_mapping_file(), and the helper will take care of both cases
internally.

Thank you for the review!

	Krzysztof
