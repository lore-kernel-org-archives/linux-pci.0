Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C983C1082
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 10:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781086638; cv=none; b=OXHoQh71dfk9Enm65AmtLjxNvTReE+APcGJnxhhvQOsqQTDaMcZ30b/iASCYBXv6vrtQTO7yUii9akCOHtv43G5H7XcUi7t7bvYXQVBCDvQ/rVx3CliLSeRKB7FI7UPkGqT9gRlpqvqfJH/Cgp5u4YaUuEMm9Qod50PySunRur0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781086638; c=relaxed/simple;
	bh=vYnVDYPsBrJKMCuPcaNLEt0enZ+r2U+/XWxZg/7EhWM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gvi36TA44xaWZ0zS/EgIgAjC7k86xnTast5+kHHdZWL9LqB6v7I4/iSNwv2ak438OjJKC63RFPc/jzXKmobuJ3SBH+n5BwVFC1PvNnR19Sur4lwIidk4GoT2cj5RMm514VV4hhI7THSQ1/kH1975v0dQEfIrmwLviMPWOy1hPqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOx2iGwi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOx2iGwi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CD01F00898;
	Wed, 10 Jun 2026 10:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781086636;
	bh=iq4ownzHNxA4yip9rPsROTZhFZl/HML0CO5bcinRI28=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dOx2iGwicVRbXErh8LetZMOvXyLQYUF179v9dN9R9NHE6C89MSpyFRxVn0yzC0j+Y
	 2UWqN37tx8z5pxGKXKLXR1nv6vnmsb6JiAbn/zBZwfFsfHxO8K6efdG6qy7cnJWpr5
	 TI6eIOsysqv97CX/Qn+c+d81XlSQ2APyFvVa9DI5MWa9GNwiWD7Eyh3rSUkTXZ6Jyf
	 vunlQc7DZArRoOJr2CQ5K9dQvwLExBs5HKSzmY36mi5VKRy2iIfs8WlGkaU6aHZ/z/
	 tJj84g4MO/o+nRfaxBSAl4aR63V1L1Sny+s3wOycVLzxgc/AiftAhgGRD8rJ1ob3UC
	 BaoYwMNvtX09w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/4] PCI: endpoint: Add DOE mailbox support for
 endpoint functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aksh Garg" <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260610100256.1889111-3-a-garg7@ti.com>
References: <20260610100256.1889111-3-a-garg7@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 10:17:16 +0000
Message-Id: <20260610101716.95CD01F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] A sticky `PCI_DOE_FLAG_CANCEL` flag causes spurious aborts of vali=
d requests following an idle mailbox abort.
- [High] Potential hard deadlock due to acquiring non-IRQ-safe xarray spinl=
ocks in hardirq context.
- [High] A TOCTOU race between `pci_ep_doe_submit_task()` and `pci_ep_doe_d=
estroy_mb()` causes `queue_work()` to be called on a destroyed workqueue.
- [High] Clearing the `PCI_DOE_FLAG_CANCEL` flag unconditionally can silent=
ly erase a concurrent DOE Abort signal from the host.
--

commit 0a3d7b35451c74090ea52cb3095ab14d0e4a6a56
Author: Aksh Garg <a-garg7@ti.com>

PCI: endpoint: Add DOE mailbox support for endpoint functions

This commit implements Data Object Exchange (DOE) for PCIe endpoint devices.
It provides framework APIs to register mailboxes and handle DOE requests
using workqueues. Discovery protocol support is built-in.

> diff --git a/drivers/pci/endpoint/pci-ep-doe.c b/drivers/pci/endpoint/pci=
-ep-doe.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/pci/endpoint/pci-ep-doe.c
[ ... ]
> +static struct pci_ep_doe_mb *pci_ep_doe_get_mailbox(struct pci_epc *epc,
> +						    u8 func_no, u16 cap_offset)
> +{
> +	struct pci_ep_doe_mb *doe_mb;
> +	unsigned long key;
> +
> +	if (!epc)
> +		return NULL;
> +
> +	key =3D PCI_DOE_MB_KEY(func_no, cap_offset);
> +
> +	xa_lock(&epc->doe_mbs);

[Severity: High]
Does acquiring the plain xa_lock spinlock here pose a deadlock risk?

Both pci_ep_doe_process_request() and pci_ep_doe_abort() call this function,
and these are intended to be executed from a controller's hardware interrupt
handler. Because xa_lock() does not disable interrupts, if a thread is
accessing the xarray in process context (like in pci_ep_doe_add_mailbox() or
pci_ep_doe_destroy()) and is preempted by a DOE interrupt on the same CPU,
attempting to acquire the lock in the interrupt handler will deadlock.

Could this be resolved by using xa_lock_irqsave() or initializing the xarray
with XA_FLAGS_LOCK_IRQ?

> +
> +	doe_mb =3D xa_load(&epc->doe_mbs, key);
> +	if (doe_mb && !refcount_inc_not_zero(&doe_mb->refs))
> +		doe_mb =3D NULL;
> +
> +	xa_unlock(&epc->doe_mbs);
> +
> +	return doe_mb;
> +}
[ ... ]
> +static void signal_task_complete(struct pci_ep_doe_task *task, int statu=
s)
> +{
> +	struct pci_ep_doe_mb *doe_mb =3D task->doe_mb;
> +
> +	task->complete(doe_mb->epc, doe_mb->func_no, doe_mb->cap_offset,
> +		       status, task->feat.vid, task->feat.type,
> +		       task->response_pl, task->response_pl_sz);
> +
> +	/* Clear the CANCEL flag for next DOE request */
> +	clear_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags);

[Severity: High]
Can this unconditional clear_bit() unintentionally erase a concurrent DOE
Abort signal?

If the host issues a DOE Abort interrupt while the task->complete() callback
is still running, pci_ep_doe_abort() will set the PCI_DOE_FLAG_CANCEL bit.
However, once the completion callback returns, clear_bit() is unconditional=
ly
called here, erasing the concurrent abort signal. As a result, subsequent
queued requests might be processed instead of being aborted.

> +
> +	kfree(task->request_pl);
> +	kfree(task);
> +
> +	/* Release the mailbox reference acquired during process_request */
> +	pci_ep_doe_put_mailbox(doe_mb);
> +}
> +
> +/**
> + * doe_ep_task_work() - Work function for processing DOE EP tasks
> + * @work: Work structure
> + *
> + * Process a DOE request by calling the appropriate protocol handler.
> + */
> +static void doe_ep_task_work(struct work_struct *work)
> +{
> +	struct pci_ep_doe_task *task =3D container_of(work, struct pci_ep_doe_t=
ask,
> +						    work);
> +	struct pci_ep_doe_mb *doe_mb =3D task->doe_mb;
> +	pci_doe_protocol_handler_t handler;
> +	int rc;
> +
> +	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags)) {
> +		signal_task_complete(task, -EIO);
> +		return;
> +	}
> +
> +	/* Check if request was aborted */
> +	if (test_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags)) {

[Severity: High]
Is it possible for a newly submitted request to be erroneously aborted here
due to a stale CANCEL flag?

Because pci_ep_doe_abort() simply sets the PCI_DOE_FLAG_CANCEL flag and
returns, the flag is only cleared by signal_task_complete(). If an abort
occurs when the mailbox is entirely idle, no worker will execute to clear
the flag. When the host eventually sends a valid request, this worker will
see the old CANCEL flag, drop the new request with -ECANCELED, and only
then clear it, breaking the expected request sequence.

> +		signal_task_complete(task, -ECANCELED);
> +		return;
> +	}
[ ... ]
> +static int pci_ep_doe_submit_task(struct pci_ep_doe_mb *doe_mb,
> +				  struct pci_ep_doe_task *task)
> +{
> +	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags))
> +		return -EIO;
> +
> +	task->doe_mb =3D doe_mb;
> +	INIT_WORK(&task->work, doe_ep_task_work);
> +	queue_work(doe_mb->work_queue, &task->work);

[Severity: High]
Could a Time-Of-Check to Time-Of-Use race here cause queue_work() to be
called on a destroyed workqueue?

If the executing thread is preempted immediately after the lockless
test_bit(PCI_DOE_FLAG_DEAD, ...) check evaluates to false, another thread
running pci_ep_doe_destroy() could mark the mailbox DEAD and call
destroy_workqueue(). The mailbox structure itself is kept alive by its
reference count, but the workqueue pointer would point to freed memory.

When the preempted thread resumes, it would blindly call queue_work() on
the freed workqueue, resulting in a use-after-free panic.

> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610100256.1889=
111-1-a-garg7@ti.com?part=3D2
