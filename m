Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1AC389104;
	Tue,  3 Mar 2026 19:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772566375; cv=none; b=t9b6HqPc+hT2sXF6tv0s0gKAidKCDnJt7KNIeHEHAjPzOH9DfYz1KgwgLGXT/auF8Y0wxEuX8e/VZc7QLGqlxVmUJRRE3tiIQhefI3i/H+YSp336zcF1lyWJ7W0wlAt+1Cs82cpGzQUQS9/2OBxzp3Wb3bBkpgLjtVE2u+wd++U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772566375; c=relaxed/simple;
	bh=DMZROmFSkIGDEI1y04ldWBDaV3WHjK4Ob5U2DM7kc+c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=A6Vf3hvHxhmHZqS6tCJNlCk/3mc3gc7zHttFOUNJm7LmV3c5q5gvOqPP/tWiG4pK+iOSZ6PXmbuDphF9jQQWvGPoEmimfNLkwxhi111/Ju4qty8t0Hv+pAEFYv2usfCKFR+jbIvcyDST3ddK61hEfNjoRVuF/6BlxzB+jyIZJwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzQFCH9K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzQFCH9K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5432CC116C6;
	Tue,  3 Mar 2026 19:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772566375;
	bh=DMZROmFSkIGDEI1y04ldWBDaV3WHjK4Ob5U2DM7kc+c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pzQFCH9K+OwDpU9aZsUGMpmdobL9UUblBWz1f4iy5uxWmrCEdqw0jerdAe9P226Kn
	 cugLP7U8vKgts/s9XXjL/z8feDLwQZ54FlI6jrHngMgfn0do8SDI0uNqrvAHVE7nE6
	 o2+LFoY87I9xjzpmd92Tm/gbiaIt0m7FOpjUgcANhXG1mW9p5hOFvpLmwGLGx5qW25
	 bXB8gxtomn2/bL564DxuDX64rDXd5CgZEdPJ3bNy05ZwwvG+DoCAfXFc8F3gu4u1AH
	 mBEpAgs78DBfFgflEX8+KKcfqMaD9TlYOk22aPMQ9/f0jsi4E8dtuwu/Cf/Y2Jga1C
	 Elaa41aImbIgQ==
Date: Tue, 3 Mar 2026 13:32:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ziming Du <duziming2@huawei.com>
Cc: bhelgaas@google.com, alex@shazbot.org, chrisw@redhat.com,
	jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, liuyongqiang13@huawei.com
Subject: Re: [PATCH v4 3/4] PCI: Prevent overflow in proc_bus_pci_write()
Message-ID: <20260303193253.GA3817951@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260116081723.1603603-4-duziming2@huawei.com>

On Fri, Jan 16, 2026 at 04:17:20PM +0800, Ziming Du wrote:
> From: Yongqiang Liu <liuyongqiang13@huawei.com>
> 
> When the value of *ppos over the INT_MAX, the pos is over set to a
> negative value which will be passed to get_user() or
> pci_user_write_config_dword(). Unexpected behavior such as a soft lockup
> will happen as follows:

I think it's crazy to worry about offsets overflowing INT_MAX.  We're
doing PCI config accesses.  Config space is only 4K at most, so we
already have a much smaller upper bound on the offset.

The procfs proc_bus_pci_write() is essentially the same as the sysfs
pci_write_config().  They should share some common implementation.

>  watchdog: BUG: soft lockup - CPU#0 stuck for 130s! [syz.3.109:3444]
>  RIP: 0010:_raw_spin_unlock_irq+0x17/0x30
>  Call Trace:
>   <TASK>
>   pci_user_write_config_dword+0x126/0x1f0
>   proc_bus_pci_write+0x273/0x470
>   proc_reg_write+0x1b6/0x280
>   do_iter_write+0x48e/0x790
>   vfs_writev+0x125/0x4a0
>   __x64_sys_pwritev+0x1e2/0x2a0
>   do_syscall_64+0x59/0x110
>   entry_SYSCALL_64_after_hwframe+0x78/0xe2
> 
> Fix this by adding a non-negative check before assign *ppos to pos.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> Signed-off-by: Ziming Du <duziming2@huawei.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/proc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
> index 9348a0fb80847..2d51b26edbe74 100644
> --- a/drivers/pci/proc.c
> +++ b/drivers/pci/proc.c
> @@ -113,10 +113,14 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
>  {
>  	struct inode *ino = file_inode(file);
>  	struct pci_dev *dev = pde_data(ino);
> -	int pos = *ppos;
> +	int pos;
>  	int size = dev->cfg_size;
>  	int cnt, ret;
>  
> +	if (*ppos > INT_MAX)
> +		return -EINVAL;
> +	pos = *ppos;

The first issue here is that "*ppos" (loff_t) is long long, but "pos"
is int, so we're assigning a 64-bit value to a 32-bit container and
losing any high bits.  So an offset of 0x100000000 is incorrectly
treated as valid.

A change like this should fix that and bring this closer to the
pci_write_config() implementation:

  - int pos = *ppos;
  + loff_t pos = *ppos;

  - if (pos >= size)
  + if (pos > dev->cfg_size)
      return 0;

There's also a second issue here:

        if (pos + nbytes > size)
                nbytes = size - pos;

"pos" is a signed int, "nbytes" is size_t, which is an *unsigned* int,
so "pos" is implicitly converted to an unsigned value.  I think this
is what causes the soft lockup you reported because an offset like the
0x80800001 in your test case is converted from signed -2139095039 to
unsigned 2155872257.  "size" is dev->cfg_size, e.g., 4096, so
2155872257 + nbytes is certainly larger than 4096, so nbytes ends up
being set to some huge unsigned size_t value.

This issue would probably be avoided simply by returning early when
"pos" is out of range.  But mixing signed and unsigned in that
"pos + nbytes" expression is just asking for trouble and we should
avoid it as pci_write_config() does.

So I'd like to see something that makes the procfs accessor
validations look like the sysfs accessors.  It's a little messy
because they use different names, so the patches will be ugly.  But I
think it's worth it to make them work the same way so we don't have to
analyze them separately.

Maybe could be done in a couple steps, e.g., one to simply rename
things and a second to make the functional changes.

Bjorn
