Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6501843B3D0;
	Mon, 20 Jul 2026 22:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784587276; cv=none; b=ngA4U8o3eMl6Y61fVqCj/KT2/wTZuje0mGrCR+9dpj487uxdD9x3ViYlY/VJXs+JwMnZBPXbuNUOYLP1Q08cZMntaWs4j5Tmf3en6EFqgHOeO1gc0Zih0RFYxe+8ivrbuPgdI2dnJ6V0tRJyR/+in9NuEvKYdDQ1SZkWqq8s4gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784587276; c=relaxed/simple;
	bh=HdLiaSUr5CZ95+pJOJVTPuGcUHpIKsVthb5FBj4xx2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fqbB5j6iXAiGU6Y8BHfprVZla7M0wHXTxeWlXcJY+ysGfgG+T7z1D4rzJHRWch5MrLq79Lydo1ik+cAyAoNTEA4EWYRkBfLC3QbdB1jdGUrbM7vJUL+Pu2XZT3w9m4HDEu0IKhPHqkW+KGQ/ScgRQ6oTQeuYgilq4kmm/GZAlFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omJg84Lt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omJg84Lt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE93D1F00A3A;
	Mon, 20 Jul 2026 22:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784587275;
	bh=ZFz9wEVRQePTYfBVsfFD+D6XtCHD2/34dR9ImbWwSAI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=omJg84LteEruXoXoWLvViggbQtcqeubCRluxMkTfRvcIBqvQLDeKRQZPWfdEW1dEj
	 yCdJYh2KUUepV8x2hj/wigM6ialRArbzQL5rZwzs+1BfuhkhkqJ9torN7nfFGOo4vg
	 VMqicqrG/VY+PFOooCBq+qHbqTVfqThyGCMdu0iCh66rNHx84rfo39FQWc5LvBmB5P
	 lakdsJWdO4JEuP80NGQd2Vvck8L7sOziv0NwskqVz1rWGceUQnFPy0Stso6qC95wem
	 r6zhUNNEoSa5bsP1/NwJaeujxSHgqjeVEs1+mjPVz1TkWjQUFjgZ/Bz+hkqfTbGVm1
	 9ikG/P4idd1IA==
Date: Mon, 20 Jul 2026 23:41:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>,
 "Dave Jiang" <dave.jiang@intel.com>, Ira Weiny <iweiny@kernel.org>, Len
 Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Robert
 Richter <rrichter@amd.com>, <linux-acpi@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, "Alejandro Lucero" <alucerop@amd.com>,
 Alison Schofield <alison.schofield@intel.com>, Ankit Agrawal
 <ankita@nvidia.com>, Ard Biesheuvel <ardb@kernel.org>, "Ben Cheatham"
 <Benjamin.Cheatham@amd.com>, Borislav Petkov <bp@alien8.de>, "Breno Leitao"
 <leitao@debian.org>, Davidlohr Bueso <dave@stgolabs.net>, "Fabio M . De
 Francesco" <fabio.m.de.francesco@linux.intel.com>, Gregory Price
 <gourry@gourry.net>, Hanjun Guo <guohanjun@huawei.com>, Jonathan Corbet
 <corbet@lwn.net>, Kees Cook <kees@kernel.org>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, Li Ming
 <ming.li@zohomail.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Oliver O'Halloran <oohall@gmail.com>,
 Shiju Jose <shiju.jose@huawei.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>, Smita Koralahalli
 <Smita.KoralahalliChannabasappa@amd.com>, Tony Luck <tony.luck@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ashok Raj
 <ashok.raj@oss.qualcomm.com>
Subject: Re: [PATCH v18 05/13] PCI/AER: Introduce AER-CXL protocol error
 kfifo
Message-ID: <20260720234106.27e7857d@jic23-huawei>
In-Reply-To: <20260717222706.3540281-6-terry.bowman@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
	<20260717222706.3540281-6-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jul 2026 17:26:58 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

Hi Terry.

This is a rather length patch description.  Might be worth
a parse to see if key details can be covered in something that folk
are more likely to read!

> CXL VH RAS handling requires a path for the AER driver to hand off
> CXL protocol errors to cxl_core for logging and recovery before PCIe
> AER recovery tears down the device. Add
> drivers/pci/pcie/aer_cxl_vh.c to implement this handoff via a kfifo-backed
> work item.
> 
> Introduce is_aer_internal_error() to identify CXL protocol errors
> from AER internal error status bits across both correctable and
> uncorrectable severities.

Already existed. Just in a different location. 

> 
> Introduce is_cxl_error() to gate the VH kfifo path.

Feels like to much detail to me given not really anything to say
about it other than the obvious.

> 
> Introduce struct cxl_proto_err_work_data to carry the error source
> PCI device and severity through the kfifo. Encapsulate the kfifo,
> per-producer spinlock, registration rwsem, and work pointer in struct
> cxl_proto_err_kfifo. Initialize the embedded kfifo via INIT_KFIFO()

Can we cut this down a little where we don't use useful info. e.g.
"Initialize the kfifo from a subsys_initcall() to it is ready before
any producer or consumer runs."

> from a subsys_initcall so its metadata is populated before any
> producer or consumer runs.
> 

> Introduce cxl_forward_error() to enqueue a CXL protocol error. A
> reference is taken on the PCI device; the consumer releases it via
> for_each_cxl_proto_err(). On enqueue failure the reference is
> released immediately, the error is dropped, and the consumer is
> scheduled to drain existing entries.

We don't need to cover error paths in the patch description unless
they are really complex and need explanation. Even then probably belongs
more in comments.

Anyhow you get the idea..

> A subsequent patch wires
> cxl_forward_error() into handle_error_source() where correctable and
> uncorrectable status clearing is left to pci_aer_handle_error().
> 
> Introduce cxl_proto_err_flush() to synchronously wait for the
> consumer worker to drain the kfifo. A subsequent patch wires this
> into handle_error_source() for UCE events so the CXL plane completes
> error handling and panic policy before pci_aer_handle_error() drives
> PCIe recovery.
> 
> Introduce cxl_register_proto_err_work() and
> cxl_unregister_proto_err_work() for cxl_core to register and
> deregister its work handler. On unregistration, pending kfifo entries
> are drained and their pdev references released before
> cancel_work_sync() runs. Export these and for_each_cxl_proto_err()
> via EXPORT_SYMBOL_FOR_MODULES restricted to cxl_core.
> 
> Protect the work pointer with a rwsem to correctly serialize
> registration, deregistration, enqueue, and dequeue against concurrent
> AER IRQ threads. Serialize concurrent kfifo writers with a spinlock.
> 
> Add MAINTAINERS entries for aer_cxl_vh.c and aer_cxl_rch.c under
> the CXL entry so CXL maintainers are CC'd on changes to the AER-CXL
> bridging code.

Various things inline.  The one potential thing I'd like to highlight is
the loss of tracking assume panic isn't appropriate.  My paranoid hat
says always go the other way.  If we don't know we didn't lose an
uncorrectable error panic.  Maybe it's worth us considering when this
might happen in a real system?

> 
> Co-developed-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> ---
> 
> Changes in v17->v18:
> - Remove correctable status clear from cxl_forward_error(); the AER core
>   clears all status bits via pci_aer_handle_error() info->status writeback
> - Schedule consumer on kfifo overflow so existing entries can be drained
> 
> Changes in v16->v17:
> - Reword "kfifo semaphore" to "kfifo spinlock" to match fifo_lock.
> - Defer the handle_error_source() is_cxl_error() switch to the patch that
>   registers the kfifo consumer to keep each commit bisect-safe.
> - Rename rwsema to rwsem
> - Change CPER exports to use EXPORT_SYMBOL_FOR_MODULES.
> - Add work cancel function.
> - Replace kfifo_put() with kfifo_in_spinlocked() for multiple producers
> - Add fifo_lock spinlock for concurrent producer serialisation
> - Initialize the embedded kfifo with INIT_KFIFO() in a subsys_initcall so
>   kfifo->mask, ->esize and ->data are set before first use.
> - Clear PCI_ERR_COR_STATUS in cxl_forward_error() after enqueue so the
>   device is acked for correctable events even when the consumer drops the
>   event. Uncorrectable status is left for cxl_do_recovery() to clear after
>   recovery completes, mirroring the AER core convention.
> - WARN on double-registration in cxl_register_proto_err_work() to make an
>   unintended second consumer visible at runtime.
> - Add direct rwsem.h, cleanup.h and workqueue.h includes for symbols used
>   in aer_cxl_vh.c
> - Add MAINTAINERS entries for drivers/pci/pcie/aer_cxl_*.c
> - Update message
> ---
>  MAINTAINERS                   |   2 +
>  drivers/pci/pcie/Makefile     |   1 +
>  drivers/pci/pcie/aer.c        |  10 --
>  drivers/pci/pcie/aer_cxl_vh.c | 221 ++++++++++++++++++++++++++++++++++
>  drivers/pci/pcie/portdrv.h    |   6 +
>  include/linux/aer.h           |  24 ++++
>  6 files changed, 254 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/pci/pcie/aer_cxl_vh.c
> 


> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
> new file mode 100644
> index 0000000000000..93bed07936100
> --- /dev/null
> +++ b/drivers/pci/pcie/aer_cxl_vh.c
> @@ -0,0 +1,221 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2026 AMD Corporation. All rights reserved. */
> +
> +#include <linux/aer.h>
> +#include <linux/atomic.h>
> +#include <linux/cleanup.h>
> +#include <linux/init.h>
> +#include <linux/kfifo.h>
> +#include <linux/rwsem.h>

Check these.  I'd expect at least spinlock.h to meet the rough include what
you use aim.

> +#include <linux/wait_bit.h>
> +#include <linux/workqueue.h>
> +#include "../pci.h"
> +#include "portdrv.h"
> +
> +#define CXL_ERROR_SOURCES_MAX          128
> +
> +struct cxl_proto_err_kfifo {
> +	struct work_struct *work;
> +	void (*flush)(void);
> +	struct rw_semaphore rwsem;
> +	spinlock_t fifo_lock;

Ideally add a quick comment to every lock to say what data it covers.
Kind of obvious for this one but in general it is good practice and
reduces chance of later scope confusion.

> +	atomic_t flush_inflight;
> +	DECLARE_KFIFO(fifo, struct cxl_proto_err_work_data,
> +		      CXL_ERROR_SOURCES_MAX);
> +};

> +/**
> + * cxl_forward_error - Forward a CXL protocol error to the CXL subsystem via kfifo
> + * @pdev: PCI device that reported the AER error
> + * @info: AER error info containing severity and status
> + *
> + * Producer side of the AER-CXL kfifo. Enqueues a CXL protocol error work
> + * item and schedules the consumer workqueue. Takes a reference on @pdev
> + * that the consumer releases after handling.
> + *
> + * Return: true if the caller must flush the kfifo before AER recovery,
> + * false if no CXL error handling was initiated due to early return on
> + * error.
> + */
> +bool cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info)
> +{
> +	struct cxl_proto_err_work_data wd = {
> +		.severity = info->severity,
> +		.pdev = pdev,
> +	};
> +
> +	guard(rwsem_read)(&cxl_proto_err_kfifo.rwsem);
> +
> +	if (!cxl_proto_err_kfifo.work) {
> +		dev_err_ratelimited(&pdev->dev, "AER-CXL kfifo reader not registered\n");
> +		return false;
> +	}
> +
> +	/*
> +	 * Reference discipline: the AER caller (handle_error_source())
> +	 * holds a ref on @pdev for the duration of this call and releases
> +	 * it on return. Take a fresh ref here so the pdev stays live while
> +	 * queued in the kfifo; the consumer (for_each_cxl_proto_err())
> +	 * drops that ref after handling. On enqueue failure below, drop
> +	 * the ref we just took to avoid a leak.

Most of this is useful. The what we do in error handling (given so local)
probably not.

> +	 */
> +	pci_dev_get(pdev);
> +
> +	/* Serialize concurrent kfifo writers: multiple AER threaded IRQs */
> +	if (!kfifo_in_spinlocked(&cxl_proto_err_kfifo.fifo, &wd, 1,
> +				 &cxl_proto_err_kfifo.fifo_lock)) {
> +		/* Dropped; no panic - UCE unconfirmed without RAS read */

Hmm. That's interesting.  To me it fails the normal ras thing of assume
the worst if we lost track. I'd panic. But I'm open to other views on this!

> +		dev_err_ratelimited(&pdev->dev, "AER-CXL kfifo add failed\n");
> +		pci_dev_put(pdev);
> +		schedule_work(cxl_proto_err_kfifo.work);

Shared with below. Maybe just drop out of the if unless this gets more
complex in later patches.

> +		return true;
> +	}
> +
> +	schedule_work(cxl_proto_err_kfifo.work);
> +	return true;
> +}


> +/**
> + * for_each_cxl_proto_err - Call a function for each kfifo work item
> + *
> + * Single-consumer invariant: this function is only called from
> + * cxl_proto_err_work_fn() via a single DECLARE_WORK.
> + *
> + * Holds rwsem_read internally; fn() must not call cxl_register_proto_err_work()
> + * or cxl_unregister_proto_err_work().
> + */
> +void for_each_cxl_proto_err(struct cxl_proto_err_work_data *wd,
> +			    cxl_proto_err_fn_t fn)
> +{
> +	guard(rwsem_read)(&cxl_proto_err_kfifo.rwsem);
> +	while (kfifo_get(&cxl_proto_err_kfifo.fifo, wd)) {
> +		fn(wd);

Like the earlier case I razed, I'd like a comment here to say where
the reference we re releasing was taken.

> +		pci_dev_put(wd->pdev);
> +	}
> +}
> +EXPORT_SYMBOL_FOR_MODULES(for_each_cxl_proto_err, "cxl_core");
> +
> +/**
> + * cxl_proto_err_flush - drain pending AER-CXL kfifo work synchronously
> + *
> + * Wait for the consumer worker to finish processing all entries
> + * currently in the kfifo. Used by handle_error_source() for UCE so
> + * the CXL plane can read CXL RAS, apply panic policy, and clear CXL
> + * state before pci_aer_handle_error() drives PCIe recovery.
> + *
> + * Snapshots the flush callback under rwsem_read and releases the rwsem
> + * before calling it.  This avoids holding rwsem_read across flush_work(),
> + * which would deadlock via the rwsem HANDOFF mechanism when a concurrent
> + * rwsem_write waiter (cxl_unregister_proto_err_work) blocks new readers
> + * including the worker's for_each_cxl_proto_err() rwsem_read acquisition.
> + *
> + * The flush_inflight counter prevents cxl_core module unload while a
> + * flush is in progress outside the rwsem. The counter is incremented
> + * under rwsem_read (mutually exclusive with the rwsem_write in
> + * cancel_cxl_proto_err() that NULLs the flush pointer) and decremented
> + * after the flush completes. cxl_unregister_proto_err_work() waits for
> + * the counter to reach zero before proceeding with cancel_work_sync().

I can't see it from just this patch so it might be useful to say if the
counter is ever not equal to 1 or 0.  If it isn't can we make that explicit
in the code?

> + *
> + * For correctable events the consumer can run asynchronously; AER
> + * does not need to call this helper for AER_CORRECTABLE.

For me this is both too much and likely to rot over time. Some stuff
feels like it belongs with the flags it is talking about rather than here.

> + */
> +void cxl_proto_err_flush(void)
> +{
> +	void (*flush)(void);
> +
> +	scoped_guard(rwsem_read, &cxl_proto_err_kfifo.rwsem) {
> +		flush = cxl_proto_err_kfifo.flush;
> +		if (flush)
> +			atomic_inc(&cxl_proto_err_kfifo.flush_inflight);
> +	}
> +
> +	if (flush) {
> +		flush();
> +		if (atomic_dec_and_test(&cxl_proto_err_kfifo.flush_inflight))
> +			wake_up_var(&cxl_proto_err_kfifo.flush_inflight);
> +	}
> +}


