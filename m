Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F392882DE;
	Sat, 25 Jul 2026 21:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785015460; cv=none; b=bYFn7NAWNw/3cg9WtJNUNQbwXEdrz4tJ1G620xFeD1zrJy1RDQ9gAWHVSzdYSdAfwfCm9DAHxXAh+5XnhJpq2jZctis74+DDjng42wIt43g1H7FUiLtQGwl8YamqRQVTUZQcGpVETz9Efm0vwNZ5/EIa2heCYe8VxP1ushSEZ5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785015460; c=relaxed/simple;
	bh=Bgf9WpomuPSb6sSHVIGtyG2FCkXLktxqUYNRjbKn/sQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=buK2dJQxbG5w/6wejAwVs2jnft0Xq0XQ1HG+YN1xYHwK1ZezbBrtm9y01BZDoK8uWgnUtbJq/3wjBI86nQDjIQL8IsmrS7dCcQeEA8VvHrdEi81yzpWuVJRlL6XyE6FUfC4SPRpOTrvyK0fc5jcC1W9DyNWrB+cUZY3B9s5K/po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aeUZK1Ye; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aeUZK1Ye"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAD91F000E9;
	Sat, 25 Jul 2026 21:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1785015459;
	bh=VW4Itax4uaoOUozvRTGW+C9GkAjA2igtg5x/nUSArMo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aeUZK1YeDV5CnqM+wNZjzhm24RcMioMzbLfMV/YltypRgeB+j417/pVDmBUIgRG1q
	 +WmUeKXEas44pAsguF1wIvjbr+ffU9aQUbnHE/NfzNKzdpH2C1+0AWjA3eiu2KcPEG
	 pyxSopA9mMB4fC6Ioy0JHbR2Ra8b8s8l32khIajc=
Date: Sat, 25 Jul 2026 14:37:37 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kwilczynski@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 "Liam R . Howlett" <liam@infradead.org>, Baoquan He <baoquan.he@linux.dev>,
 Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Simona Vetter
 <simona.vetter@ffwll.ch>, Suren Baghdasaryan <surenb@google.com>, Vlastimil
 Babka <vbabka@kernel.org>, Dave Young <ruirui.yang@linux.dev>,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-sound@vger.kernel.org,
 kexec@lists.infradead.org, driver-core@lists.linux.dev
Subject: Re: [PATCH v2 0/3] mm,kernfs,proc: Unmap mmaps of removed files via
 file->f_mapping
Message-Id: <20260725143737.daa698b50289257fbaa9c6f1@linux-foundation.org>
In-Reply-To: <20260725210549.3716546-1-kwilczynski@kernel.org>
References: <20260725210549.3716546-1-kwilczynski@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 25 Jul 2026 21:05:46 +0000 Krzysztof Wilczyński <kwilczynski@kernel.org> wrote:

> Hello,
> 
> The PCI resource files in sysfs and the /proc/bus/pci device files swap
> their f_mapping to the shared iomem address space at open time, so that
> revoke_iomem() can unmap userspace mappings when a driver claims a
> region, see commit 636b21b50152 ("PCI: Revoke mappings like devmem").
> 
> Their VMAs are therefore attached to the shared address space, which
> neither removal path reaches: kernfs_drain_open_files() unmaps the
> sysfs inode's own mapping, which contains none of them, and
> proc_entry_rundown() does not unmap anything at all.
> 
> As a result, userspace mappings of PCI BARs survive device removal,
> and also survive a BAR resize on the sysfs side, keeping stale PTEs
> into physical address space that the kernel may have reassigned since.
> A mapping made before the device is removed still returns the previous
> register value after the device has been released, through both
> interfaces.

Thanks.  Can we please have full description of the userspace-visible
effects of this?

AI review might have found a few things:
	https://sashiko.dev/#/patchset/20260725210549.3716546-1-kwilczynski@kernel.org

