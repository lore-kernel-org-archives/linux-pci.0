Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3314248B1;
	Mon, 27 Jul 2026 16:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785170189; cv=none; b=YPGa7xPhQNZ+CuKoi12DurCnU4k1I48PYtZDzPzAdUKMEtI5BVl22UAY6SqWbxwcD4uKKSqdwQg3Yhc+kwksqcXVgALbHtyTSbJBVd8S+Sy7odWEn6fUoAud3/z3yzYkd5/KJUTkmiBmt4jYerHImgrkWZ3d1q+h1p8m1z8ZaNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785170189; c=relaxed/simple;
	bh=tRlFV30ja/8brImGjZrmJZ/1eEggANfYU0WYaHOaBsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rWU65Mhvw4ogyWBMCJ6T6EKgMkzLg/djYPoFlMiMYtMZnwTS1y1qVM+wb1I3AwCRcEAxS760L6EiOv10ivQvRcdEtD+3/fkifRSbdBhQXDEzaq+BcASxoYkw8Zrvd/McZWdOL4X9wRM06ksyJPx1Ait9o+C1a18Zktnmnvw+ovg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHC5di3D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHC5di3D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC261F00A3E;
	Mon, 27 Jul 2026 16:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785170188;
	bh=NwZp8vrcS5zNu4NMBMc7+FtncQiyjKLq2JUaAvCeOIM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DHC5di3D1bGlMzcG7F1Nm23rfd1M/xEorCZ2zg2aJ4kfE3Ia7aVAOoCnNfdnUCb7u
	 xvwTiIyUUZMVxSba/az3+UtCgzeobMK2K7uUXfMy+Fe5hcQ2pWc7ZdVLkHoR2yG5dr
	 QmlOUpofMIT5FjH1AIflWD/OKts1pPW03Q58+kqfANSl6mi8WsYfNjhTk59EMDBkvD
	 +A7BkHY1tQUPXQOU5XBIHE34ro+EVSnjYsSebzp4lUxOkDyhdHMm3ZUzOIMDbfMHw5
	 Pox+sEHGUSM1J/dSayDMcF7wZTwhgGGS6E5ymM+SFqBfPru1/PKFg3nrka9Er++OoM
	 dcORIFdnznoYA==
Message-ID: <06ead85a-59ef-4c1b-8bb6-8eee5c6a00bd@kernel.org>
Date: Mon, 27 Jul 2026 18:36:19 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mm: Add unmap_mapping_file() helper
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 "Liam R . Howlett" <liam@infradead.org>, Baoquan He <baoquan.he@linux.dev>,
 Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Simona Vetter <simona.vetter@ffwll.ch>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>,
 Dave Young <ruirui.yang@linux.dev>, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-sound@vger.kernel.org,
 kexec@lists.infradead.org, driver-core@lists.linux.dev
References: <20260725210549.3716546-1-kwilczynski@kernel.org>
 <20260725210549.3716546-2-kwilczynski@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzS5EYXZpZCBIaWxk
 ZW5icmFuZCAoQ3VycmVudCkgPGRhdmlkQGtlcm5lbC5vcmc+wsGQBBMBCAA6AhsDBQkmWAik
 AgsJBBUKCQgCFgICHgUCF4AWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaYJt/AIZAQAKCRBN
 3hD3AP+DWriiD/9BLGEKG+N8L2AXhikJg6YmXom9ytRwPqDgpHpVg2xdhopoWdMRXjzOrIKD
 g4LSnFaKneQD0hZhoArEeamG5tyo32xoRsPwkbpIzL0OKSZ8G6mVbFGpjmyDLQCAxteXCLXz
 ZI0VbsuJKelYnKcXWOIndOrNRvE5eoOfTt2XfBnAapxMYY2IsV+qaUXlO63GgfIOg8RBaj7x
 3NxkI3rV0SHhI4GU9K6jCvGghxeS1QX6L/XI9mfAYaIwGy5B68kF26piAVYv/QZDEVIpo3t7
 /fjSpxKT8plJH6rhhR0epy8dWRHk3qT5tk2P85twasdloWtkMZ7FsCJRKWscm1BLpsDn6EQ4
 jeMHECiY9kGKKi8dQpv3FRyo2QApZ49NNDbwcR0ZndK0XFo15iH708H5Qja/8TuXCwnPWAcJ
 DQoNIDFyaxe26Rx3ZwUkRALa3iPcVjE0//TrQ4KnFf+lMBSrS33xDDBfevW9+Dk6IISmDH1R
 HFq2jpkN+FX/PE8eVhV68B2DsAPZ5rUwyCKUXPTJ/irrCCmAAb5Jpv11S7hUSpqtM/6oVESC
 3z/7CzrVtRODzLtNgV4r5EI+wAv/3PgJLlMwgJM90Fb3CB2IgbxhjvmB1WNdvXACVydx55V7
 LPPKodSTF29rlnQAf9HLgCphuuSrrPn5VQDaYZl4N/7zc2wcWM7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20260725210549.3716546-2-kwilczynski@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/25/26 23:05, Krzysztof Wilczyński wrote:
> Currently, unmap_mapping_pages() and unmap_mapping_range() unmap a
> page offset window of an address_space, and code that removes a file,
> such as kernfs_drain_open_files(), relies on them to unmap the pages
> of a file that is going away.
> 
> Files with f_mapping swapped to a shared address space at open time,
> such as PCI resource files using iomem_get_mapping(), have their VMAs
> attached to the shared mapping instead of the file's own inode mapping,
> so unmapping the inode's address space cannot reach them, and they stay
> live after the file is removed.  These VMAs can only be selected by the
> struct file they were created through, which is recorded in
> vma->vm_file.
> 
> Thus, add unmap_mapping_file(), which walks the VMA interval tree of the
> file's f_mapping under i_mmap_lock_read() and unmaps the pages of the
> VMAs selected by should_zap_file_vma(), using the same per-VMA zap as
> unmap_mapping_pages().  When f_mapping is the file's own inode mapping,
> every VMA is zapped, as unmap_mapping_range() does today.  When f_mapping
> was swapped, only the VMAs with vm_file set to that file are zapped, so
> callers do not need to tell the two apart.
> 
> HugeTLB VMAs are skipped with a WARN_ON_ONCE(), as zapping those takes
> i_mmap_rwsem for write in hugetlb_zap_begin() and would deadlock against
> the read lock held over the walk.
> 
> Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
> ---
>  include/linux/mm.h |  2 ++
>  mm/memory.c        | 48 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
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
> index ff338c2abe92..4a09d7b6aa6b 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4423,6 +4423,54 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
>  }
>  EXPORT_SYMBOL_GPL(unmap_mapping_pages);
>  
> +static inline bool should_zap_file_vma(struct file *file,
> +				       struct vm_area_struct *vma)
> +{
> +	/* On the file's own inode mapping, zap every VMA */
> +	if (file->f_mapping == file_inode(file)->i_mapping)
> +		return true;
> +

I assume Sashiko complain applies only when this function would be reuse in
other context.

But I wonder if that check is even required, shouldn't below check cover this
already? I'd expect that "vma->vm_file == file" must always hold.

> +	/* A swapped mapping also holds VMAs of unrelated files, zap only ours */
> +	return vma->vm_file == file;
> +}
> +
> +/**
> + * unmap_mapping_file() - Unmap folios from all mmaps of a file.
> + * @file: The file to unmap.
> + *
> + * Unmap the folios of @file from every process that has them mapped.
> + *
> + * If f_mapping is the file's own inode mapping, they are unmapped
> + * from every VMA on that mapping, as unmap_mapping_range() would do.
> + *
> + * However, if f_mapping was swapped to a different address space at
> + * open time, only the VMAs with vm_file set to @file are considered,
> + * since that address space also holds mappings of unrelated files.
> + *
> + * Must not be used on HugeTLB files.  HugeTLB VMAs are skipped with
> + * a warning.
> + */
> +void unmap_mapping_file(struct file *file)
> +{
> +	struct address_space *mapping = file->f_mapping;
> +	struct vm_area_struct *vma;
> +
> +	i_mmap_lock_read(mapping);
> +	if (unlikely(mapping_mapped(mapping))) {
> +		vma_interval_tree_foreach(vma, &mapping->i_mmap, 0, ULONG_MAX) {

Can we just use mapping_rmap_tree_foreach() here, similar to
unmap_mapping_range_tree() ?

> +			cond_resched();

Why that? unmap_mapping_range() doesn't seem to require one so far.

-- 
Cheers,

David
