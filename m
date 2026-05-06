Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537D43382E1;
	Wed,  6 May 2026 22:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104899; cv=none; b=n/x+o28gJBSRCuxxOSNZ5lVuvHL+K5SfkCoS7L8C3jAtV04b/Cr7jUTXwHdZffx9sKfp9ISTOEqwrMudQZ2akcX/Nja2p8C7gqlYvCE1K0mu7a4V+Zf0OEWcq1osRpC76MvqsVstwq3oYjpGs0NztE8k65c0Opvb34huM16JdxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104899; c=relaxed/simple;
	bh=z/37yJDtREHQAtFfBrCnE7k5pqS/ap8EnXJEtB175xI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=q43MzZoMvFCWvJFpmyJKn+n45U7zto9gf4V8SOBr1elOd7gjmPddUFrthGjdxeUyQ+Ul//htdpcA+ptS/sQhI8/JkTadaiWaT7rlbq9Dp7u+uZ6VXvfrTOsNesoGTJ9+DM3eC4EGB0l02MTxM6T0PBa04uowiU124KrLqkCiVsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dohrXIoZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dohrXIoZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16477C2BCB0;
	Wed,  6 May 2026 22:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778104899;
	bh=z/37yJDtREHQAtFfBrCnE7k5pqS/ap8EnXJEtB175xI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dohrXIoZPeRO8ll/lm1uBtuRlluS528kduQMh2kQmRzeGzv3WboVot4QXusdH6ftF
	 gVYDElPR5OWyGiN6Gmhf+D8RG/Hyx/gpEECAQboWqh4EYoUNDxAEnuzxjKbhYvF2Ur
	 zFrlrPh0e3Wufj7OKmC3eAraRzgObLePnaCUuXON8NH4CfJ+HVoOoN42+IFg5IcVGq
	 kX2asQOI7eQW/RGTE67SSL3sVV9dIr6s/+gyxwX6U6F0az+jSoMXmvHvzvFffLfmzO
	 rzt/boYqiOtC5rVDv9lCKpSGq527EaWZC7pQUEBQ6KOToo68EEdt7LAt1eHuM8rZ2N
	 AV4tOHg9HgTAw==
Date: Wed, 6 May 2026 17:01:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Danilo Krummrich <dakr@kernel.org>,
	Bandan Das <bsd@redhat.com>, Gui-Dong Han <hanguidong02@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Williamson <alex@shazbot.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Init temporary pci device in new_id_store()
Message-ID: <20260506220137.GA881374@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505234327.716630-1-skhawaja@google.com>

On Tue, May 05, 2026 at 11:43:27PM +0000, Samiullah Khawaja wrote:
> When setting new_id of a PCI device driver using sysfs a lockdep splat
> occurs. This is because the new_id function new_id_store() checks for
> driver_override by creating temporary pci_dev structs.
> 
> Since the newly added driver_override spinlock is not init for temporary
> pci_dev structs, the lockdep splat complains about it.
> 
> Initialize the temporary pci device to fix this.
> 
> [    4.464296] INFO: trying to register non-static key.
> [    4.466207] The code is fine but needs lockdep annotation, or maybe
> [    4.468487] you didn't initialize this object before use?
> [    4.470486] turning off the locking correctness validator.
> [    4.472494] CPU: 2 UID: 0 PID: 177 Comm: liveupdate-iomm Not tainted 7.0.0+ #9 PREEMPT(full)
> [    4.472497] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [    4.472498] Call Trace:
> [    4.472501]  <TASK>
> [    4.472503]  dump_stack_lvl+0x5d/0x80
> [    4.472508]  register_lock_class+0x77e/0x790
> [    4.472512]  ? check_prev_add+0xf4/0xd30
> [    4.472513]  ? check_prev_add+0xf4/0xd30
> [    4.472515]  __lock_acquire+0x3b4/0x1b80
> [    4.472518]  ? raw_irqentry_exit_cond_resched+0x20/0x50
> [    4.472556]  lock_acquire+0xbf/0x2e0
> [    4.472558]  ? pci_match_device+0x24/0x180
> [    4.472563]  _raw_spin_lock+0x30/0x40
> [    4.472567]  ? pci_match_device+0x24/0x180
> [    4.472569]  pci_match_device+0x24/0x180
> [    4.472571]  new_id_store+0x189/0x1d0
> [    4.472574]  kernfs_fop_write_iter+0x14f/0x210
> [    4.472578]  vfs_write+0x263/0x5e0
> [    4.472583]  ksys_write+0x79/0xf0
> [    4.472585]  do_syscall_64+0x117/0xf80
> [    4.472587]  ? clear_bhb_loop+0x40/0x90
> [    4.472590]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [    4.472592] RIP: 0033:0x7fe7bc0beeb2
> [    4.472595] Code: 18 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75 1a 83 e2 39 83 fa 08 75 12 e8 2b ff ff ff 0f 1f 00 49 89 ca 48 8b 44 24 20 0f 05 <48> 83 c4 18 c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 10 ff 74 24 18
> [    4.472596] RSP: 002b:00007ffcdbb1ed80 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> [    4.472598] RAX: ffffffffffffffda RBX: 00007fe7bc2415c0 RCX: 00007fe7bc0beeb2
> [    4.472599] RDX: 000000000000000a RSI: 00005580955433c0 RDI: 0000000000000001
> [    4.472600] RBP: 000000000000000a R08: 0000000000000000 R09: 0000000000000000
> [    4.472601] R10: 0000000000000000 R11: 0000000000000202 R12: 000000000000000a
> [    4.472602] R13: 00005580955433c0 R14: 000055805932493e R15: 0000558095545490
> [    4.472605]  </TASK>
> 
> Fixes: 10a4206a2401 ("PCI: use generic driver_override infrastructure")
> Fixes: 8895d3bcb8ba ("PCI: Fail new_id for vendor/device values already built into driver")
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> 
> ---
> 
> v2:
>  - Use device_initialize instead of spinlock init
>  - Set release cb and call put_device to release
>  - Add Fixes tag for the commit that added temporary pci device without
>    initialize.
> ---
>  drivers/pci/pci-driver.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index d10ece0889f0..e3f59001785a 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -179,6 +179,11 @@ static const struct pci_device_id *pci_match_device(struct pci_driver *drv,
>  	return NULL;
>  }
>  
> +static void _pci_free_device(struct device *dev)
> +{
> +	kfree(to_pci_dev(dev));
> +}
> +
>  /**
>   * new_id_store - sysfs frontend to pci_add_dynid()
>   * @driver: target device driver
> @@ -214,11 +219,13 @@ static ssize_t new_id_store(struct device_driver *driver, const char *buf,
>  		pdev->subsystem_vendor = subvendor;
>  		pdev->subsystem_device = subdevice;
>  		pdev->class = class;
> +		pdev->dev.release = _pci_free_device;
>  
> +		device_initialize(&pdev->dev);
>  		if (pci_match_device(pdrv, pdev))
>  			retval = -EEXIST;
>  
> -		kfree(pdev);
> +		put_device(&pdev->dev);

The commit log says new_id_store() checks for driver_override, which
is technically true because it uses pci_match_device(), which calls
device_match_driver_override().  But I don't think it's relevant in
this path because dev->driver_override.name is not set in the
temporary device.

I wish we had a lower-level function to match a simple struct
pci_device_id against the driver dynids list.  Then we could use that
here instead of faking up this temporary pci_dev and using
pci_match_device(), and we wouldn't need to mess with
device_initialize() and put_device().

And maybe pci_match_device() could be built on top of it for the probe
and bus match paths that already have a struct pci_dev for a real
device.

But I don't know whether that would all be feasible, and it would be
far out of scope for this patch anyway.

Applied this on pci/for-linus for v7.1, since 10a4206a2401 appeared in
v7.1-rc1.

>  		if (retval)
>  			return retval;
> 
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> -- 
> 2.54.0.545.g6539524ca2-goog
> 
