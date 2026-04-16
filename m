Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95C22E424F;
	Thu, 16 Apr 2026 17:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360661; cv=none; b=n5K10PE/CiLqmxYAZmVn/mad8V9asjX03HSzpV7eoUxhemccOEnUdG1eDlTGWNTznzynFrJ3a5mr4rfe0jP39ait3/fJdxUk0tgM2IZqRPJ0iHdYdYxbbtbp5PUYVUKPCenp9F0mdjMYkM+6Dru2Jb11e9FWrQuQAjAwhSDCk9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360661; c=relaxed/simple;
	bh=vGNw0uxuy2/Dir37UhfQwUgLTRlb/4/Oq7Jd0D0d6lo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gQP0BawMQTAaVIFXQQTnKQKy4AWooXJBt2JKHPZClA6sqrcmmOqfnKuYTLNIFDIHjxxgMpfBPeUpfNmrri1K/6v8FthQnnzyU0W9WljqXoHZ6dGUhPCmysgUpqqG6fGVvvLCKIhiVFfYwAZDqIRXpe/S51DFcu96Zmrdfq2JrGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgXm2Nc0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgXm2Nc0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE8BC2BCAF;
	Thu, 16 Apr 2026 17:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776360661;
	bh=vGNw0uxuy2/Dir37UhfQwUgLTRlb/4/Oq7Jd0D0d6lo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tgXm2Nc0oTKwPuU96QTpoy5h6bdCnb3EqRE/aG2JxxfL+EP/0rTRkZIqrvyMb8/eX
	 34k9XCYKXuABtjW5tCDx/2j0ICV33OJjGDnzcR+GyHjBVoklegYQinm0K5UUXvoutt
	 o+OLfPym8f2yqXZkAnLfrvaz44LWGZgB5Wb8Lr9VCZeTdlTQCY6rCwKkTyeCWwK5SZ
	 AOuc/OoZ7JyLXuUURB4rIarcEiMaw7aB9iqFwSy2zfkL5FRlXHvbteXzvHzEa7OOO9
	 gIMIPU6m8XtExNPmXp7EQfrW/RjI/S+fuh4jXtvSSJ5BdBS+XahtOL9tvk4uZMCnJv
	 4CXPi9gSF8aSA==
Date: Thu, 16 Apr 2026 12:31:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "yuan.gao" <yuan.gao@ucloud.cn>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alex Williamson <alex@shazbot.org>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH] PCI: Avoid FLR for NVIDIA 5090 GPU
Message-ID: <20260416173100.GA13378@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260416070707.3242381-1-yuan.gao@ucloud.cn>

[+cc Alex, Jason]

On Thu, Apr 16, 2026 at 03:07:06PM +0800, yuan.gao wrote:
> When passing through the NVIDIA 5090 GPU to a vm, there is a certain
> probability of encountering an flr timeout during vm shutdown, which
> subsequently leads to a soft lock of the host cpu.

If possible, would like confirmation of device erratum from Nvidia.
If there's no known erratum, there might be something wrong in the
Linux FLR and wait.

> As described in this post
> (https://forum.level1techs.com/t/do-your-rtx-5090-or-general-rtx-50-series-has-reset-bug-in-vm-passthrough/228549).
> 
> And in dmesg:
> 
>  [401106.011979] vfio-pci 0000:d8:00.0: not ready 1023ms after FLR; waiting
>  [401108.700074] vfio-pci 0000:d8:00.0: not ready 2047ms after FLR; waiting
>  [401112.412204] vfio-pci 0000:d8:00.0: not ready 4095ms after FLR; waiting
>  [401118.620399] vfio-pci 0000:d8:00.0: not ready 8191ms after FLR; waiting
>  [401128.860788] vfio-pci 0000:d8:00.0: not ready 16383ms after FLR; waiting
>  [401147.293518] vfio-pci 0000:d8:00.0: not ready 32767ms after FLR; waiting
>  [401185.694859] vfio-pci 0000:d8:00.0: not ready 65535ms after FLR; giving up
>  [401195.372583] vfio-pci 0000:38:00.2: Relaying device request to user (#0)
> 
>  [401208.274941] watchdog: BUG: soft lockup - CPU#11 stuck for 21s! [CPU 22/KVM:30337]
> 
>  [401209.887848] CPU: 11 PID: 30337 Comm: CPU 22/KVM Kdump: loaded Not tainted
>  [401209.887854] RIP: 0010:pci_mmcfg_read+0xaa/0xd0
> 
>  [401209.887866] Call Trace:
>  [401209.887872]  pci_bus_read_config_dword+0x43/0x70
>  [401209.b887876]  pci_find_next_ext_capability.part.20+0x65/0xc0
>  [401209.887879]  pci_restore_state.part.39+0x6d/0x3f0
>  [401209.887883]  vfio_pci_disable+0x22b/0x4d0 [vfio_pci]
>  [401209.887886]  ? __dentry_kill+0x118/0x160
>  [401209.887888]  vfio_pci_release+0x5a/0xb0 [vfio_pci]
>  [401209.887891]  vfio_device_fops_release+0x18/0x30 [vfio]
>  [401209.887894]  __fput+0x98/0x240
>  [401209.887897]  task_work_run+0x6a/0xa0
>  [401209.887899]  do_exit+0x375/0xb10
>  [401209.887900]  do_group_exit+0x3a/0xa0
>  [401209.887902]  get_signal+0x140/0x7d0
>  [401209.887906]  arch_do_signal+0x2c/0x260
>  [401209.887909]  exit_to_user_mode_prepare+0xc0/0x120
>  [401209.887912]  syscall_exit_to_user_mode+0x27/0x180
>  [401209.887915]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> The flr seems to have some issues on the NVIDIA 5090 GPU,
> so I’ve added flr-related quirks for these devices.
> 
> And with this patch in place, the host kernel doesn't exhibit these
> problems. The vm starts up and works as expected with the passed-through
> NVIDIA 5090 GPU.
> 
> Signed-off-by: yuan.gao <yuan.gao@ucloud.cn>
> ---
>  drivers/pci/quirks.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 48946cca4be72..71f833f3e2d84 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5618,6 +5618,9 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x7901, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MEDIATEK, 0x0616, quirk_no_flr);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x2b85, quirk_no_flr);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x2b87, quirk_no_flr);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x2b8c, quirk_no_flr);
>  
>  /* FLR may cause the SolidRun SNET DPU (rev 0x1) to hang */
>  static void quirk_no_flr_snet(struct pci_dev *dev)
> -- 
> 2.32.0
> 
