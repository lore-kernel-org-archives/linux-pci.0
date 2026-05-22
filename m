Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6532BEC2E
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 06:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779430276; cv=none; b=ProWiyew1B5/JZBzpxxECoxp7+X+s9fpCLhnoPL+v+uznFlVx9F7VD6T6JOSQoJm+1GX802MoMSTamk7zYUTqluFmCKS/kcYXSuJRmEXGbGv0VaQUUqBXFsYvdw5e96dQR9zi2EvEH73J/oqKY03InBahwBTypf/7qhKmxTZyWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779430276; c=relaxed/simple;
	bh=pBi9itZ99FeBcGog20GStD0dDYcD43p6YB+y+oOEyBU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qi1TtnmHJtASvfKp+m6aJ/hWp9EhDdVZfS9GKdzuRj1w4dR23Uw6VafzGA1liewtGs6++ICzDcvLrNccGuEgstoLsrrFGfX1v8e8GKSfWiEGrBwB7OAjSH/V+76M8wO7CSJFzRp5fyftIFb5iIHW16Oiv63r0VtjI6pIS/fKPGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRxt5jdm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRxt5jdm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0ABA1F000E9;
	Fri, 22 May 2026 06:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779430274;
	bh=4d94Tl9+irqUBZuFfzpDFwxCd+7BdX/6yvEAvgRnRZ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WRxt5jdmswQqs2NUNmpP3BB/2WL0OTj7eXs0J0ItV6RdxhQ7YdrCyOGIWZk3MZj15
	 ZNyo9ysyCLxpzE9IDbchO6cjAaCzmjw6QRC9E0xiSm5CYA0AgRxEH+9xDq+6mBm7U8
	 /Fp14maX9aWnVr+d0rbFfEkHEB/EGWFV9ydHYbFnxNIavoBqx+Otq8QbiE/h/f0QVt
	 KLOXuCMD7HPYLa9SVv4dWPafZrHKJju3BkNwrBxyV0UOTDU301rpNSaX+jo354RrLW
	 RaNIGmsArfgikil0iQXptSPcI1J8PH8foMpevc2n7FGNMdZ3ZJFZwxsmzSQc3ZRBqN
	 Y7QhIEEnzJSAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] PCI: endpoint: Add DOE mailbox support for
 endpoint functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aksh Garg" <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260522052434.802034-3-a-garg7@ti.com>
References: <20260522052434.802034-3-a-garg7@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 06:11:14 +0000
Message-Id: <20260522061114.D0ABA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] `pci_ep_doe_process_request()` uses `GFP_KERNEL` for memory alloca=
tion, which can sleep and is unsafe to call from hard IRQ contexts.
- [High] `pci_ep_doe_abort()` calls `flush_workqueue()`, which blocks and s=
leeps, leading to kernel panics or deadlocks.
- [High] Returning `-EINVAL` for an out-of-bounds index in the DOE Discover=
y protocol violates the PCIe Base Specification.
- [High] Missing `pci_ep_doe_remove_mailbox()` API leads to memory leaks, U=
se-After-Free panics, and `-EBUSY` errors upon module unbind.
- [High] Lack of lifetime protection for `doe_mb` and unsafe iteration in `=
pci_ep_doe_destroy()` leads to Use-After-Free vulnerabilities.
- [Medium] The protocol handler signature lacks context parameters, and sup=
ported protocols are hardcoded in a global static array.
- [Medium] `task->request_pl` is freed before the completion callback fires=
, violating the documented API contract.
- [Medium] Unratelimited logging in the DOE task worker allows a malicious =
Root Complex to flood kernel logs.
--

commit 0c1884caaad038c32cdf6616156028f360cc90e8
Author: Aksh Garg <a-garg7@ti.com>

PCI: endpoint: Add DOE mailbox support for endpoint functions

This commit adds Data Object Exchange (DOE) support for PCIe endpoint
devices. It introduces framework APIs to register mailboxes, handle
requests using workqueues, and process the internal Discovery protocol.

diff --git a/drivers/pci/endpoint/pci-ep-doe.c b/drivers/pci/endpoint/pci-e=
p-doe.c
new file mode 100644
index 0000000000000..63a5c1b8753a0
--- /dev/null
+++ b/drivers/pci/endpoint/pci-ep-doe.c
@@ -0,0 +1,553 @@
[ ... ]
> +struct pci_doe_protocol {
> +	u16 vid;
> +	u8 type;
> +	pci_doe_protocol_handler_t handler;
> +};
[ ... ]
> +static const struct pci_doe_protocol pci_doe_protocols[] =3D {
> +	{
> +		.vid =3D PCI_VENDOR_ID_PCI_SIG,
> +		.type =3D PCI_DOE_FEATURE_DISCOVERY,
> +		.handler =3D pci_ep_doe_handle_discovery,
> +	},
> +};

[Severity: Medium]
Is a global static array sufficient for endpoint capabilities?

Because the array is global, all endpoint functions will advertise the exact
same DOE protocols. Does this prevent multi-function setups that require
unique DOE capabilities per physical function?

Additionally, without endpoint context (such as epc, func_no, or a private
pointer) in the handler signature, how can handlers access device-specific
state like cryptographic keys?

[ ... ]
> +int pci_ep_doe_add_mailbox(struct pci_epc *epc, u8 func_no, u16 cap_offs=
et)
> +{
> +	struct pci_ep_doe_mb *doe_mb;

[Severity: High]
Is there a missing pci_ep_doe_remove_mailbox() API for symmetry?

Endpoint function drivers are typically dynamic modules. If an endpoint
function is unbound, the mailbox appears to leak in the doe_mbs xarray. A
subsequent bind to the same function number will fail with -EBUSY on
xa_insert().

Also, if the driver is removed while a DOE request is pending, could the
background worker execute the completion callback into unmapped module memo=
ry
and cause a panic?

[ ... ]
> +static int pci_ep_doe_handle_discovery(const void *request, size_t reque=
st_sz,
> +				       void **response, size_t *response_sz)
> +{
> +	struct pci_doe_protocol protocol;
> +	u8 requested_index, next_index;
> +	u32 *response_pl;
> +	u32 request_pl;
> +	u16 vendor;
> +	u8 type;
> +
> +	if (request_sz !=3D sizeof(u32))
> +		return -EINVAL;
> +
> +	request_pl =3D *(u32 *)request;
> +	requested_index =3D FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX, req=
uest_pl);
> +
> +	if (requested_index >=3D PCI_DOE_PROTOCOL_COUNT)
> +		return -EINVAL;

[Severity: High]
Does returning -EINVAL here violate the PCIe Base Specification?

The specification requires that when the Root Complex queries an index
greater than or equal to the supported protocols, the endpoint should return
a valid DOE Discovery Response with Vendor ID 0000h, Type 00h, and Next Ind=
ex
00h to signal the end of the protocol list. Failing the request might break
the host discovery loop.

[ ... ]
> +static void signal_task_complete(struct pci_ep_doe_task *task, int statu=
s)
> +{
> +	kfree(task->request_pl);
> +	task->complete(task->doe_mb->epc, task->doe_mb->func_no,
> +		       task->doe_mb->cap_offset, status,
> +		       task->feat.vid, task->feat.type,
> +		       task->response_pl, task->response_pl_sz);
> +	kfree(task);
> +}

[Severity: Medium]
Will this trigger a use-after-free if the controller driver inspects the
request buffer in its completion callback?

The kernel documentation for pci_ep_doe_process_request() states that the
framework frees the buffer "after the completion callback fires." However,
the payload is freed just prior to the invocation here.

[ ... ]
> +static void doe_ep_task_work(struct work_struct *work)
> +{
> +	struct pci_ep_doe_task *task =3D container_of(work, struct pci_ep_doe_t=
ask,
> +						    work);
> +	struct pci_ep_doe_mb *doe_mb =3D task->doe_mb;
> +	pci_doe_protocol_handler_t handler;
> +	int rc;
[ ... ]
> +	/* Find protocol handler in the array */
> +	handler =3D pci_ep_doe_find_protocol(task->feat.vid, task->feat.type);
> +	if (!handler) {
> +		dev_warn(doe_mb->epc->dev.parent,
> +			 "[%d:%x] Unsupported protocol VID=3D%04x TYPE=3D%02x\n",
> +			 doe_mb->func_no, doe_mb->cap_offset,
> +			 task->feat.vid, task->feat.type);
> +		signal_task_complete(task, -EOPNOTSUPP);
> +		return;
> +	}

[Severity: Medium]
Can a malicious or compromised Root Complex flood the kernel log here?

If a stream of unsupported requests is sent, this warning could overwhelm I=
/O
and CPU resources on the endpoint. Would using dev_warn_ratelimited() preve=
nt
a potential denial of service?

[ ... ]
> +int pci_ep_doe_process_request(struct pci_epc *epc, u8 func_no, u16 cap_=
offset,
> +			       u16 vendor, u8 type, void *request, size_t request_sz,
> +			       pci_ep_doe_complete_t complete)
> +{
> +	struct pci_ep_doe_mb *doe_mb;
> +	struct pci_ep_doe_task *task;
> +	int rc;
> +
> +	doe_mb =3D pci_ep_doe_get_mailbox(epc, func_no, cap_offset);
> +	if (!doe_mb) {
> +		kfree(request);
> +		return -ENODEV;
> +	}
> +
> +	task =3D kzalloc_obj(*task, GFP_KERNEL);

[Severity: High]
Is it safe to use GFP_KERNEL here?

Because this function is intended to be called by endpoint controller drive=
rs
when receiving DOE requests, it is highly likely to be executing in an atom=
ic
context, such as a hardware interrupt handler.

Using GFP_KERNEL might sleep, potentially causing deadlocks or scheduling
while atomic bugs. Should this API accept a gfp_t argument instead to allow
safe allocation?

[ ... ]
> +int pci_ep_doe_abort(struct pci_epc *epc, u8 func_no, u16 cap_offset)
> +{
> +	struct pci_ep_doe_mb *doe_mb;
> +
> +	if (!epc)
> +		return -EINVAL;
> +
> +	doe_mb =3D pci_ep_doe_get_mailbox(epc, func_no, cap_offset);
> +	if (!doe_mb)
> +		return -ENODEV;
> +
> +	/* Set CANCEL flag - worker will abort queued requests */
> +	set_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags);
> +	flush_workqueue(doe_mb->work_queue);

[Severity: High]
Will flush_workqueue() cause a kernel panic or deadlock here?

This function is called when the host triggers a DOE Abort, which typically
generates an asynchronous interrupt to the endpoint controller. Because
flush_workqueue() blocks until all queued works complete, calling it from an
interrupt context will trigger a scheduling while atomic bug.

[ ... ]
> +void pci_ep_doe_destroy(struct pci_epc *epc)
> +{
> +	struct pci_ep_doe_mb *doe_mb;
> +	unsigned long index;
> +
> +	if (!epc)
> +		return;
> +
> +	xa_for_each(&epc->doe_mbs, index, doe_mb)
> +		pci_ep_doe_destroy_mb(doe_mb);
> +
> +	xa_destroy(&epc->doe_mbs);
> +}

[Severity: High]
Is there a missing lifetime protection on the doe_mb structure?

pci_ep_doe_get_mailbox() retrieves doe_mb via xa_load() and returns an
unrefcounted pointer outside of an RCU read lock. If pci_ep_doe_destroy()
iterates over the xarray and frees the mailboxes, could a concurrent hardwa=
re
event call pci_ep_doe_process_request(), retrieve a freed mailbox, and
trigger a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522052434.8020=
34-1-a-garg7@ti.com?part=3D2
