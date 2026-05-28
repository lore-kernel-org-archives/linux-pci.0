Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51732E7381;
	Thu, 28 May 2026 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779990979; cv=none; b=PT7vRw0Bd6xWKm/KB3a0q+E35gHv4XlyiFWouUuB/2wKJ1E23zHRf5VSQdE4ewqGIqjjAlAWbCy8mKaBeBOUXhfIUzfloD8R4133vyOA3WsuJhC0E7xEaPGh8Igr88fZZnv+Y2aiNifYr2zcs4kQb1trvIqScoqulFg8MvBRqPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779990979; c=relaxed/simple;
	bh=5IAd/d86LGDJmiGwKf94grwTTmzqJARx9yHiBU//my0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IRONkT5vb9ayn+zDPcXJiVkc2R0ZyjuR9LgHoaWgrH8c28LwdAhiD9UfbPr7KSuO6c+now8pcLkyRyEgUAyo2csRn70fPyBOaQwcKNa7Z2xSDNrGm5T68ETMohSD0TMn2M6l8zDl79EhlSsIsAj7y6DRLndoDAiRDXTTpzwYF9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=U5b8X6TW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s9kDh4xd; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="U5b8X6TW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s9kDh4xd"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DF8B81400039;
	Thu, 28 May 2026 13:56:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 28 May 2026 13:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779990975;
	 x=1780077375; bh=xhdRneveyKRi4yHcO3iqq3pnUZtlH2liMhHlRhXnA0Y=; b=
	U5b8X6TW6/mRwVCLpOChvT0k1k1QzHmVrFEzS/hjAI0rwststC41Yv25lRmFuyvO
	hOhnag/lzB1wIXyzGveTSFmAksgeukCGtGdQBvI3sLI2yew3jTNHc0koq1QnBbRn
	sW9yABS/RG2gujsA6HUoxHCKNSfOdXmJALBFbfDUgsfwCFae+femUG+v13WBxZYH
	DyecqNnvFriz+3qTWvF7EdVX6bHA+BD0Jp0mixf2CdZK+lomAU0AuA5zuDtu1xUG
	HawyHfiFqbjlj1K1oUGI7G+r1SwG4fFKO4i5Qg+8K1pcYnWDcaKiUrNTdnHbsoqD
	UwkmurZB99o8W/ZDrn6BJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779990975; x=
	1780077375; bh=xhdRneveyKRi4yHcO3iqq3pnUZtlH2liMhHlRhXnA0Y=; b=s
	9kDh4xdhlfozXI1QMU03sC+FCHnJH8hfoa+aoSZZQ7aJsIrjUawKdzuVjjkec73b
	/wM60wxFtit3KBq6Blj+YSjhc6BDvvA7OrsBIcTh/SxB0ZWL2Z2Ey+ex4KeLEq/L
	2RQ+qcmwEQByYsYct6ziIdKef5NIuB652gXHTv0wgZwihSJamnuJsrBavyehkI7e
	SYl84r5QkuAWLlK7mxUfIis251SgZY4ZIC5c0j+iF4OOqF0ToUQhJPqWcSM96EkW
	FZLoTMDb7uWvJLfRQh1BTq84KeU3eaDWa9BSJ6fISwIaYfsywEbRTmJqFTbDi6Rj
	XBsJgTMOnmAecUtYnF9jA==
X-ME-Sender: <xms:v4EYaiTilyCCC3TszYpzNwYh2iObnl4WUsqiBuWJFNspCyx43Qb0GA>
    <xme:v4EYatwYCuAiGhYYgMfx6t4jRV5l_IbiFcOI-gRgr-E2ja3HrfiUpUI0ddipAjGIi
    IPrXzGP__kq7-uLt7yjpnDfbKTP0OWOloB2VNAZlfLoPnNPBV0w>
X-ME-Received: <xmr:v4EYaqqmMr20NKnzCZpiW2GHTgVMyz9eBHHmkMMzUzW5MmQtc79meqmG0-o>
X-ME-Proxy-Cause: dmFkZTGA7+e1nJ1HX9UeCel4mN6+q+8r4YO/idRUFSnYVbZsNnYtC7QCAtx81d87OgaOir
    IbdMySc9qWfxObwF3Stohx7T1d7dnVbgXA6B9H2I0YgtkeZlCiMkeSFisx6RZwGlUtEs9l
    XFrGJI1iLNdHLNfXmBHhnsnBa+UEIjJaX+gowTkyhy9H0fAs6HXgZzBP1Rh80ZaBtoiIfu
    IOlGpi4SWnlTNVfI7FqfNHOIDHYo8asj4cgBXOF5fLaNwI4ec0bCwzGPw4y64T1K3X6D4e
    mk0kUvMvWCoAw6Yy9WcsezdeUMixvoWa49cns0/NqxlNXugDQ/vZK90M3vo11NFHxhctZH
    HK5r07gj9lMDRuJ1NnjQwCWiasochE105a2AA8/SQOoO1qtSpGCVL4e8nKQR2UV8wGYFoi
    pxI9g0wUo1mGLyEHoBPr41efVEzcYZHaMUy8F1UODHZmX7x5Hoe2PZgw1oOIc7DkLI4+Xi
    B21g89ykhixr8r8Pn7/ezhevbiyx8mY2XXinpWEA1HwRzhnjX4WhefjZ4/ynQwfrbN6sqD
    OA/yYOYg4Toq3R9SQNwros+7tA++Si0xYsJGfl8QBe/Ej+6OhanrulXNKjV9UB+WwbqxWP
    BKtl+jZAfkEFCJ9MshdUrhTpSJNX/lNCds4WPwNiko14QKK4bh4NPVFd7sXA
X-ME-Proxy: <xmx:v4EYag3Dd-NmQM8BldDFKzxoj8y7jhEZeN-FU5-xFGaKcVzjIBxUHQ>
    <xmx:v4EYaqx8shKaaRaubqV-xI-05Vg1eSgniPn89SHxuVwMYzXtOchAgg>
    <xmx:v4EYakgjCss8-9hsqHREDl1CHwfup6hDa8HGcgxX4AAEHvufi8gZEg>
    <xmx:v4EYalr5sXxwHkV2gXMswNtHsaSv_37mBN3aX7JpSp2wWpMqqhtPsQ>
    <xmx:v4EYamtjZXs6hr2IbNiPGyPyIeyi2rYMH09X2HAXh8g85Sma-_joFU3l>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 13:56:14 -0400 (EDT)
Date: Thu, 28 May 2026 11:56:13 -0600
From: Alex Williamson <alex@shazbot.org>
To: Ankit Agrawal <ankita@nvidia.com>
Cc: <kvm@vger.kernel.org>, <jgg@ziepe.ca>, <yishaih@nvidia.com>,
 <skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <bhelgaas@google.com>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 alex@shazbot.org
Subject: Re: [PATCH v7 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU
 readiness check via CXL DVSEC
Message-ID: <20260528115613.63f1b178@shazbot.org>
In-Reply-To: <20260528093840.4018-1-ankita@nvidia.com>
References: <20260528093840.4018-1-ankita@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 May 2026 09:38:40 +0000
Ankit Agrawal <ankita@nvidia.com> wrote:
...
>  drivers/vfio/pci/nvgrace-gpu/main.c | 144 ++++++++++++++++++++++++++--
>  include/uapi/linux/pci_regs.h       |   1 +

Bjorn, I assume you don't object to this trivial addition:

> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 14f634ab9350..718fb630f5bb 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1357,6 +1357,7 @@
>  #define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)		(0x1C + (i * 0x10))
>  #define   PCI_DVSEC_CXL_MEM_INFO_VALID			_BITUL(0)
>  #define   PCI_DVSEC_CXL_MEM_ACTIVE			_BITUL(1)
> +#define   PCI_DVSEC_CXL_MEM_ACTIVE_TIMEOUT		__GENMASK(15, 13)
>  #define   PCI_DVSEC_CXL_MEM_SIZE_LOW			__GENMASK(31, 28)
>  #define  PCI_DVSEC_CXL_RANGE_BASE_HIGH(i)		(0x20 + (i * 0x10))
>  #define  PCI_DVSEC_CXL_RANGE_BASE_LOW(i)		(0x24 + (i * 0x10))

>  2 files changed, 136 insertions(+), 9 deletions(-)

Replying to the sashiko comments in thread to keep all the reviewers in
the loop...

On Thu, 28 May 2026 10:22:14 +0000
sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] TOCTOU race in lockless device readiness checks causes unexpected -EAGAIN or VM_FAULT_SIGBUS errors instead of waiting for the device.
> - [High] The 256-second device readiness polling uses uninterruptible `msleep()` loops, which can trigger hung task panics and renders user tasks unkillable.
> --
> 
> commit a85819b2171b67b275d15e9b87eb7447b4dd63a4
> Author: Ankit Agrawal <ankita@nvidia.com>
> 
> vfio/nvgrace-gpu: Add Blackwell-Next GPU readiness check via CXL DVSEC
> 
> Adds a CXL DVSEC-based readiness check for Blackwell-Next GPUs in addition
> to the existing legacy BAR0 polling. The device readiness is determined by
> polling the Memory_Active bit outside the memory lock for up to 256 seconds.
> 
> > diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
> > index fa056b69f899a..04fcc0d088f54 100644
> > --- a/drivers/vfio/pci/nvgrace-gpu/main.c
> > +++ b/drivers/vfio/pci/nvgrace-gpu/main.c  
> 
> [ ... ]
> 
> > +static int nvgrace_gpu_wait_device_ready_cxl(struct nvgrace_gpu_pci_core_device *nvdev)
> > +{
> > +	unsigned long deadline = jiffies + msecs_to_jiffies(POLL_QUANTUM_MS);
> > +	bool active_phase = false;
> > +	u32 status;
> > +	int ret;
> > +
> > +	for (;;) {  
> 
> [ ... ]
> 
> > +		if (time_after(jiffies, deadline))
> > +			return -ETIME;
> > +
> > +		msleep(POLL_QUANTUM_MS);
> > +	}
> > +}  
> 
> [Severity: High]
> Will this uninterruptible sleep trigger hung task panics?
> 
> Since the CXL device readiness can take up to 256 seconds and msleep() places
> the task in the TASK_UNINTERRUPTIBLE state, processes accessing the device
> during a reset will become unresponsive and immune to signals (including
> SIGKILL) for up to 4 minutes.
> 
> With the default Linux hung_task_timeout_secs at 120 seconds, blocking here
> is highly likely to trigger the hung task detector and cause a kernel panic
> on systems with hung_task_panic enabled. Would it be better to use an
> interruptible sleep and abort on pending fatal signals?

The legacy path already has this same issue, but the timeout is 30s
rather than 256s.  Both locations could pretty trivially change to:

	msleep_interruptible(POLL_QUANTUM_MS);
	if (fatal_signal_pending(current))
		return -EINTR;

It's maybe worth a follow-up to address both for a little more
robustness.

> > @@ -313,6 +399,21 @@ static vm_fault_t nvgrace_gpu_vfio_pci_huge_fault(struct vm_fault *vmf,
> >  	pfn = PHYS_PFN(memregion->memphys) + addr_to_pgoff(vma, addr);
> >  
> >  	if (is_aligned_for_order(vma, addr, pfn, order)) {
> > +		/*
> > +		 * Exit early under memory_lock to avoid a potentially lengthy
> > +		 * device readiness wait on a runtime-suspended device. Any
> > +		 * race after the lock is dropped is benign as the re-check
> > +		 * inside the scoped guard below catches it.
> > +		 */
> > +		scoped_guard(rwsem_read, &vdev->memory_lock) {
> > +			if (vdev->pm_runtime_engaged)
> > +				return VM_FAULT_SIGBUS;
> > +		}
> > +
> > +		if (nvdev->cxl_dvsec && READ_ONCE(nvdev->reset_done) &&
> > +		    nvgrace_gpu_wait_device_ready_cxl(nvdev))
> > +			return VM_FAULT_SIGBUS;  
> 
> [Severity: High]
> Can this lockless check race with a concurrent device reset and bypass the
> intended polling mechanism?
> 
> If a concurrent device reset finishes and sets reset_done = true right after
> this lockless check evaluates to false, the thread proceeds without polling
> and blocks waiting for memory_lock.
> 
> Once the lock is acquired, the thread calls nvgrace_gpu_check_device_ready()
> which observes reset_done == true and invokes the fallback
> nvgrace_gpu_test_device_ready_cxl() under the lock. Because this CXL test is
> non-blocking, it immediately returns -EAGAIN, causing
> nvgrace_gpu_vfio_pci_huge_fault() to return VM_FAULT_SIGBUS and crash user
> applications instead of waiting.

This doesn't really seem to break our contract with userspace, they're
issuing a reset while the device is taking a fault, reset necessarily
disables memory, therefore a sigbus is a valid outcome.  We could make
this a bit more robust to such a race with a retry, but it would be
contingent on the interruptible msleep above or else the user could
potentially trigger endless resets during fault.  Something like this:

diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
index 01b819156c03..9e7f8a7e1abc 100644
--- a/drivers/vfio/pci/nvgrace-gpu/main.c
+++ b/drivers/vfio/pci/nvgrace-gpu/main.c
@@ -415,14 +415,21 @@ static vm_fault_t nvgrace_gpu_vfio_pci_huge_fault(struct vm_fault *vmf,
                        if (vdev->pm_runtime_engaged)
                                return VM_FAULT_SIGBUS;
                }
-
+retry:
                if (nvdev->cxl_dvsec && READ_ONCE(nvdev->reset_done) &&
                    nvgrace_gpu_wait_device_ready_cxl(nvdev))
                        return VM_FAULT_SIGBUS;
 
                scoped_guard(rwsem_read, &vdev->memory_lock) {
-                       if (vdev->pm_runtime_engaged ||
-                           nvgrace_gpu_check_device_ready(nvdev))
+                       int rc;
+
+                       if (vdev->pm_runtime_engaged)
+                               return VM_FAULT_SIGBUS;
+
+                       rc = nvgrace_gpu_check_device_ready(nvdev);
+                       if (rc == -EAGAIN)
+                               goto retry;
+                       if (rc)
                                return VM_FAULT_SIGBUS;
 
                        ret = vfio_pci_vmf_insert_pfn(vdev, vmf, pfn, order);

Note that the read/write paths also have this gap where we can wait for
the device to be ready, but the check under memory_lock returns
-EAGAIN.  The difference is that userspace will already automatically
handle the -EAGAIN vs the SIGBUS could be fatal.

I think both of the above would be good improvements, though I don't
think either is strictly necessary.  I don't spot any other must-fix
issues, any concerns from others?  Thanks,

Alex
