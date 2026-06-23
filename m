Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D9E84039
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 09:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782206498; cv=none; b=dI/5NBB/HeCKPJDcSHzgEvY56e1zyt7gNnJdnBqsolfq1BDwxsqkt6dmMA629k8gepEFGJF4dvXwdBq7d+BqPvn4SoYPhClNgq8YCmlVNPwHhjcQCkobpuDdHnJVljjRUKqHRBrxxjF2q3oyZ7IB7oqv8+Dd0sXPsINe2I80xNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782206498; c=relaxed/simple;
	bh=eXYYE96/2u2mYUftqFyMJTi+MdMlVLRaBH3kTrQwlUg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mRxfl6yJNpgnb4cTgwnCLO6PjpzUNFvelEeWJs923v/5eI2dsUghRlA92kuX76TCyiZhE9eFV7iNXQ6/67Zd7aMwFHXpqyUG9l7E51PPhumsXqKk2N/ZM/t0D+bmPzxcFENR1f/yPhvY4XJi1ojxxLUvqOKt63/zV0bZz8l+20A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvB9cRYf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvB9cRYf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4AB1F000E9;
	Tue, 23 Jun 2026 09:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782206496;
	bh=C6+O2SwumAcexLc/nZLJ0oN9lGd9/vDocLXJJ9BZIPU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hvB9cRYfKtHG/WOvLm2mwqD0QnLqqdeWepCmiqbXgY03ZOd6HYerFDJ7/13mk5ju+
	 PEhGdQ2sCWm3DA2MnTT57VMPArWMNVe6QRdIhQ11zcQGQHqXgeAOulPvq4ETu/fjoE
	 bmUEYdOnHGYGnf7JrSvJ+XfnEWLjHv6Tqq1j0q7lClKmvZLAIKB+cTfCbXfP/qKCI8
	 hEd1wjEImoUuSLN3vPZxypTPieWhPeoIM+Eu5nJV8sS2+KMphsAExxYPHiC2B1HMWb
	 o1tZP/SGRFiEhGJWfr+Hg+4bKIUTEDLmcJzjVi2KIETL7cFHyBdUgskALdf/s3khfw
	 Ftri+ql0RdQKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/4] PCI: endpoint: Add DOE mailbox support for
 endpoint functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aksh Garg" <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260623090737.711656-3-a-garg7@ti.com>
References: <20260623090737.711656-1-a-garg7@ti.com>
 <20260623090737.711656-3-a-garg7@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 09:21:36 +0000
Message-Id: <20260623092136.BE4AB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The `pci_ep_doe_process_request()` fallback stub leaks the request=
 buffer when `CONFIG_PCI_ENDPOINT_DOE=3Dn`.
- [High] Flawed DOE Abort mechanism causes a state leak of the `CANCEL` fla=
g, silently dropping valid requests.
--

commit b18fff73f747154acf71d1ff81a4731b89d384ad
Author: Aksh Garg <a-garg7@ti.com>

PCI: endpoint: Add DOE mailbox support for endpoint functions

This patch adds Data Object Exchange (DOE) support for PCIe endpoint
devices. It implements framework APIs for the EPC core driver and controller
drivers to register mailboxes and process DOE requests from the host.

> diff --git a/drivers/pci/endpoint/pci-ep-doe.c b/drivers/pci/endpoint/pci=
-ep-doe.c
> index 0000000000000..b2832253eaca6
> --- /dev/null
> +++ b/drivers/pci/endpoint/pci-ep-doe.c

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

[ ... ]

> +int pci_ep_doe_abort(struct pci_epc *epc, u8 func_no, u16 cap_offset)
> +{
> +	struct pci_ep_doe_mb *doe_mb;
> +
> +	doe_mb =3D pci_ep_doe_get_mailbox(epc, func_no, cap_offset);
> +	if (!doe_mb)
> +		return -ENODEV;
> +
> +	/* Set CANCEL flag - worker will abort queued requests */
> +	set_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags);

[Severity: High]
Can a race condition here cause the CANCEL flag to be permanently set,
silently dropping the next valid request?

If the host sends a DOE Abort just as a task completes, the controller
driver could evaluate the busy state and call pci_ep_doe_abort().

Concurrently, the worker thread might finish processing, invoke
signal_task_complete(), and clear the flag:

worker thread in signal_task_complete():
    clear_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags);

If pci_ep_doe_abort() then executes on the controller thread:

controller thread in pci_ep_doe_abort():
    set_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags);

The mailbox becomes idle but still has the CANCEL flag set. Would the
next valid request then be immediately cancelled when doe_ep_task_work()
checks the flag?

> +
> +	dev_dbg_ratelimited(epc->dev.parent,
> +			    "DOE mailbox abort initialized: PF%d offset 0x%x\n",
> +			    func_no, cap_offset);
> +
> +	pci_ep_doe_put_mailbox(doe_mb);
> +	return 0;
> +}

[ ... ]

> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 5844deee2b5f1..6d3b4b779d157 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h

[ ... ]

> +#else
> +static inline void pci_ep_doe_init(struct pci_epc *epc) { }
> +static inline int pci_ep_doe_add_mailbox(struct pci_epc *epc, u8 func_no,
> +					 u16 cap_offset)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int pci_ep_doe_process_request(struct pci_epc *epc,
> +					     u8 func_no, u16 cap_offset,
> +					     u16 vendor, u8 type,
> +					     void *request, size_t request_sz,
> +					     pci_ep_doe_complete_t complete)
> +{
> +	return -EOPNOTSUPP;

[Severity: High]
Does this fallback stub leak the request buffer when endpoint DOE support
is disabled?

The API documentation in pci-ep-doe.c states that ownership of the request
buffer is transferred to the DOE EP core, which frees it. Since this stub
just returns -EOPNOTSUPP, it looks like the buffer is never freed when
CONFIG_PCI_ENDPOINT_DOE is not enabled.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623090737.7116=
56-1-a-garg7@ti.com?part=3D2
