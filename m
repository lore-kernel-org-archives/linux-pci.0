Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F1D46D098;
	Tue, 21 Jul 2026 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784661608; cv=none; b=XvJemoUlfEu0uMl1Qjuk/+LmAEM7aN57Q85BwfYFSZbKWgXSF0Lu4jKdLZpjb8jikZIVUKkboCLPCHPIBn0TMXU/mkOXrTDVYdhnwjDk8zElKimJaOs8b2ekN1pT4CLCgZJ/5LBDlaEKQx19HznBWugECxNMHoSxyZN7yglmYTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784661608; c=relaxed/simple;
	bh=xQzt3WwJsdoZtGbrTwm4s06+DrP9+JWWwyjCpo0qjnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Upw7x5FnFkiylQd/tYaX2RtfSsI3/mA5JNgLml2EqQWyNHil/ScqRxSol92nDI1AGOXrhkBskWfRm+fzn/A016cab6e6GxFt7vsCqD8yHuQi+zC+Pwk89GfeR1LaOnYvy8XsgpZAa6XJclSNsJ9/3tIslZv0aEX1fzwwQook00w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYK1MxMD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYK1MxMD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36DF1F00A3A;
	Tue, 21 Jul 2026 19:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784661607;
	bh=fbtv0vw1LlTZUCiZD8t3HdgT+DZEZ+c4X5oV0q2qGp0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SYK1MxMDQ4Ju4xurEh0nrhuHZHxv4A0QZ1Bge1pFLQOi9VrJbPQfw3EqoddRVH9IO
	 6qInYd0gsSaFvE9ucIK/mVz1sGl/97DH+imBNDenFeN7hpzhC120OKnvcYr2t1IyWa
	 nIzrT1Ud8MvuGarRrIfFx7677btQhuLafF+A+z7w8x55g4FkmQfrt42NQW/Slyu49P
	 22gtk6y36rTnkTapLdn/0cWqAdHD5ECZom4JJCrIS+zi/+YqPRDqBrpBegikW7jyIC
	 FT9IrELkmXzXY+JvPJ4YvLcfCJYg1V3xYawMu/U2m+vpNvLzDUeyZPcZ/BL7uX0fBH
	 YRPirVPljhpIA==
Message-ID: <5a43053d-8d08-4fda-82e3-bda10ca79c92@kernel.org>
Date: Tue, 21 Jul 2026 21:19:59 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: Add unmap_mapping_file() helper
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 "Liam R . Howlett" <liam@infradead.org>, Dan Williams <djbw@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Simona Vetter <simona.vetter@ffwll.ch>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>,
 linux-pci@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev,
 Christian Brauner <brauner@kernel.org>
References: <20260721185252.1670958-1-kwilczynski@kernel.org>
 <20260721185252.1670958-2-kwilczynski@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260721185252.1670958-2-kwilczynski@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/21/26 20:52, Krzysztof Wilczyński wrote:
> Currently, unmap_mapping_pages() and unmap_mapping_range() unmap
> a page offset window of an address_space, and teardown paths such
> as kernfs_drain_open_files() rely on them to remove the mappings
> of a file that is going away.
> 
> Files with f_mapping swapped to a shared address space at open time,
> such as PCI resource files using iomem_get_mapping(), have their
> VMAs attached to the shared mapping instead of the file's own inode
> mapping, so a teardown that unmaps the inode's address space cannot
> reach them, and they stay live after the file is removed.  As such,
> the only correct discriminator for these VMAs is the originating
> struct file recorded in vma->vm_file.
> 
> Add unmap_mapping_file(), which walks the VMA interval tree of the
> file's f_mapping under i_mmap_lock_read() and zaps every VMA with
> vm_file set to the given file, using the same per-VMA zap teardown
> as unmap_mapping_pages().
> 
> Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
> ---
>  include/linux/mm.h |  2 ++
>  mm/memory.c        | 26 ++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 485df9c2dbdd..e882a03eaddd 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3183,6 +3183,7 @@ extern int fixup_user_fault(struct mm_struct *mm,
>  			    bool *unlocked);
>  void unmap_mapping_pages(struct address_space *mapping,
>  		pgoff_t start, pgoff_t nr, bool even_cows);
> +void unmap_mapping_file(struct file *file);
>  void unmap_mapping_range(struct address_space *mapping,
>  		loff_t const holebegin, loff_t const holelen, int even_cows);
>  #else
> @@ -3203,6 +3204,7 @@ static inline int fixup_user_fault(struct mm_struct *mm, unsigned long address,
>  }
>  static inline void unmap_mapping_pages(struct address_space *mapping,
>  		pgoff_t start, pgoff_t nr, bool even_cows) { }
> +static inline void unmap_mapping_file(struct file *file) { }
>  static inline void unmap_mapping_range(struct address_space *mapping,
>  		loff_t const holebegin, loff_t const holelen, int even_cows) { }
>  #endif
> diff --git a/mm/memory.c b/mm/memory.c
> index ff338c2abe92..f9cfb88ac4f7 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4423,6 +4423,32 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
>  }
>  EXPORT_SYMBOL_GPL(unmap_mapping_pages);
>  
> +/**
> + * unmap_mapping_file() - Unmap all mmaps of an open file.
> + * @file: The file to unmap.

We are unmapping pages/folios, not really mmaps.

"Unmap folio from all mmaps of a file." ?

> + *
> + * Unmap every VMA with vm_file set to @file, regardless of the address

Again, we are not unmapping VMAs, we are unmapping pages/folios within all VMAs
that map the file.

> + * space it is attached to.  This also covers files with f_mapping
> + * swapped to a different address space at open time, since such VMAs
> + * cannot be found through the file's own inode mapping.

God this is confusing :)

Sorry for the stupid question, but why can't we call

	unmap_mapping_range(file->f_mapping, 0, 0, 1);


What is a bit annoying is that you now do in the caller:

	if (of->file->f_mapping != inode->i_mapping)
		unmap_mapping_file(of->file);
	else
		unmap_mapping_range(inode->i_mapping, 0, 0, 1);

Shouldn't we just have one function that takes care of that internally ... so
it's harder to get wrong?

-- 
Cheers,

David
