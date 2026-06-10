Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F32131353C;
	Wed, 10 Jun 2026 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781120649; cv=none; b=fnirrFflrc1m+tLXpXLMgJMAQCNIX9UqhNm00TBfSFl8f1lzFQNv+QgrjspgMtLuXUGdHUwCJbKlrnf/XhjBNCs81CpgOdpWqsh+mxfYKyUDqcpB+ea61iVQ3wq3MoumCBEUVRJkvbIp0ijq2ftyi2KYeeegm3ITaoDJnCcWpS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781120649; c=relaxed/simple;
	bh=BWDbjNa1WE5Q2Z2tB1zNIlaSkfrry4lRawCOq0FzDFM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=obfD8FJ5az8DQ1froZwMJnGUtdyXUgZOg55l8xa63c4ocvM8pkNnzHLoXQzVXOUTxKvVGu5fjc6WpJIgUHHVydyyJykAh/0cj3Jfxg905Itss6up+5BuoRfBYWQ/hqlIHaoGnb/8shANgK+eFUxQECH34yez82OZSd4mk6QIrl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNQjHrcg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNQjHrcg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8535F1F00898;
	Wed, 10 Jun 2026 19:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781120647;
	bh=mG+wED3l5wlplzMXNlL5QenF8gBL6SpO7QMnsXWHsns=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=LNQjHrcgeUZjxTcStsMmm6+s7AEWrfhqoL3SszM3ycv25lO4BgsngZv0h2clvEElY
	 7mbDFHWL73NCYeeObk1jRJxi6o+e2KOkhcEeAo8ZiytQ5nr3eVXjC2AIxXERjMSMfj
	 ggOuebsRCS+HyPQpZSk6Viy6o2i/99XVG0c9b7l0NT+NxhG1CRZRL+Usp1oQ3D8+Rn
	 +pb0SCEx0HY6pNsmHY7ioW8cPx2QW6GMTDW6qh7/pCmhS2p5hMlioFxn+4QsWBO9w5
	 Q5bMxVgU858eq+FL8IPLfPrZEEHNDBEzQux4JpLCppLdLgjB7zvrRniCetdSFddHAR
	 hMoXxT8cenRTQ==
Date: Wed, 10 Jun 2026 14:44:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yuanhe Shu <xiangzao@linux.alibaba.com>
Cc: linux@roeck-us.net, lihaoxiang@isrc.iscas.ac.cn, tglx@linutronix.de,
	bhelgaas@google.com, jgross@suse.com, hans.zhang@cixtech.com,
	himanshu.madhani@oracle.com, roger.pau@citrix.com,
	chrisl@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/MSI: add iounmap in msix_capability_init()
Message-ID: <20260610194406.GA380991@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610091951.1073318-1-xiangzao@linux.alibaba.com>

On Wed, Jun 10, 2026 at 05:19:51PM +0800, Yuanhe Shu wrote:
> On Mon, 16 Mar 2026 at 10:22:12 -0700, Guenter Roeck wrote:
> > Does msix_setup_interrupts() already unmap this region? If it fails,
> > msix_setup_interrupts() calls pci_free_msi_irqs(), which appears to already
> > call iounmap(dev->msix_base) and sets dev->msix_base to NULL.
> >
> > If dev->msix_base was already set to NULL by pci_free_msi_irqs() during the
> > msix_setup_interrupts() error path, does this result in iounmap(NULL)?
> 
> Confirmed. We hit this on Intel Emerald Rapids (192 CPUs) when running
> tools/testing/selftests/kexec/test_kexec_jump.sh.
> 
> The commit message of 1a8d4c6ecb4c states:
> 
>   "msix_capability_init() fails to unmap the MSI-X region if
>    msix_setup_interrupts() fails."
> 
> This is incorrect. There is no leak on this error path.
> 
> When msix_setup_interrupts() fails, the call chain is:
> 
>   msix_setup_interrupts()
>     -> __msix_setup_interrupts()
>          struct pci_dev *dev __free(free_msi_irqs) = __dev;
>          ...
>          return ret;  // __free cleanup fires on error
> 
> The __free(free_msi_irqs) cleanup calls pci_free_msi_irqs(), which
> already handles the unmap:
> 
>   void pci_free_msi_irqs(struct pci_dev *dev)
>   {
>       pci_msi_teardown_msi_irqs(dev);
>       if (dev->msix_base) {
>           iounmap(dev->msix_base);   // already unmapped here
>           dev->msix_base = NULL;     // and set to NULL
>       }
>   }
> 
> So dev->msix_base is unmapped and NULLed before msix_setup_interrupts()
> even returns to msix_capability_init(). The original "goto out_disable"
> was correct -- it skipped iounmap because the cleanup was already done.
> 
> Commit 1a8d4c6ecb4c changed it to "goto out_unmap", adding a second
> iounmap() call on an already-NULL pointer, which triggers:
> 
>   WARNING: CPU#44 at iounmap+0x2a/0xe0
>   Workqueue: nvme-reset-wq nvme_reset_work [nvme]
>   RIP: 0010:iounmap+0x2a/0xe0
>   ...
>   RDI: 0000000000000000
>   ...
>   Call Trace:
>    <TASK>
>    msix_capability_init+0x317/0x3f0
>    __pci_enable_msix_range+0x21d/0x2c0
>    pci_alloc_irq_vectors_affinity+0xa9/0x130
>    nvme_setup_io_queues+0x2a8/0x420 [nvme]
>    ? __pfx_nvme_calc_irq_sets+0x10/0x10 [nvme]
>    nvme_reset_work+0x151/0x340 [nvme]
>    process_one_work+0x197/0x3a0
>    worker_thread+0x1ab/0x320
>    ? __pfx_worker_thread+0x10/0x10
> 
> RDI=0 confirms iounmap() is called with NULL.
> 
> This commit should probably be reverted. The out_unmap label and its
> iounmap() are redundant with the __free(free_msi_irqs) scoped cleanup
> in __msix_setup_interrupts(), which already takes care of unmapping
> dev->msix_base on any error path.

Thanks a lot for testing and verifying the issue!

I guess it's 1a8d4c6ecb4c ("PCI/MSI: Unmap MSI-X region on error")
that you think should be reverted?  Can you or Haoxiang send a patch
to do that so this is unambiguous?

It looks like Thomas applied 1a8d4c6ecb4c, so I'll leave it up to him
to handle any revert.
