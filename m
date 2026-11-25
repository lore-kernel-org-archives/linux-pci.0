Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795589159;
	b=Fpy2K9onSaegpo7lNqu0nIaTU3MkkWk9tc2rvsJNHoXngRHV/sTmBOjhAo6UAuY/Rcr9
	 JUi8C5OaVA4iXgEkmwqdN0yGv+M3YS0PMmJjST9Yxr4wPuqvhMSeEJP2a9+ZdHJpVm/lc
	 9IJ6cMxZ31JFz7GldoOapO5A3rO3ku3n3awg7j845B+85J8i25MJ6Cisf15yYbMvkPYDX
	 CjHpMiXsfbBzB+xfP/LYF+CCzKFgmrWloF6YU17V34WVQhjbBGSHxa1/gJe6z5XbXqeuB
	 pUDh0oNzi1lZ3Ep8uGhcutXhWLvd5hg3p16Xk2VnnzgqiFYiNBnyLkNQxmgUyEOvDrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589159;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VkkGbwq08SluLWGI4C9q+lJTIPO6YiHo3aEbu8U1fdk=;
	b=LvxTyFQyUetZ+ijPFV5sDvzjcezOGOSwC3PbA9BIxnxYiLDS2Nf3lWil70JlTlmwxtPW
	 AKz1t+Or3pt7dO2auvbf0Y3/krCCRQKOhhNACGYQZHIesQ46bAE1myRwG1SGocWyRDp8t
	 7x4Q3/I3h8wIANnSJKuFrHKvretTw4sHDORd7Ahfik3MCcHOsuqoJOIvLTpZZZ2dT4iN3
	 UqJ0o5nbQ3QSmYVE9WQU9WfImj6eXQmKePiwe9AjQKt2uUqIPkEBOHAUsGHK7do/kL8Do
	 mv1zriEAamdKaXm8riXGSMdQmW1ZscRdRnl3dV0pURrBw7dp+W9qtNY2EIV0T2mUGNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="OH7/5FHv";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89E6606A323
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 06:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OH7/5FHv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6672A1F000C6;
	Wed, 25 Nov 2026 06:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795589159;
	bh=VkkGbwq08SluLWGI4C9q+lJTIPO6YiHo3aEbu8U1fdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OH7/5FHvNVOtOyiLk2ugHqGmL9Yt1VWOjzblY1KwZF6BvQy6jDi2HiaYABEdSMtyF
	 MMqr4EqZodxHodLFc3mq3QWldGlbIzQXLW0ppc6XLs2xJ3AhmYnXbN5H/nWUEB0IWO
	 S3NQpnwMl5QaA6nUMzrIrrfYDA8a/8//4J9Al5IuWlehP7A6pQ9Y+SuNDuUzxdyrG9
	 f85LkqR+dNhQvrjg6IJTQa5KFre4io/LeJqe+9ZK6nOT+N3fLwgoVsTwxwv2NQvSYR
	 2Ey+x8VYG69yyP9UBmk8EuGrNM1Q7kZxSwYtBQXOhHvGrhsAclpjaOwzvAj9WyQFbv
	 N71VYcO/T8rtA==
Message-ID: <sashiko-outbox-232732@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/3] PCI/LMR: Add Lane Margining at the Receiver
 debugfs interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261125-pcie-link-endpoints-v8-2-19d49c17c05f@google.com>
References: <20261125-pcie-link-endpoints-v8-0-19d49c17c05f@google.com>
 <20261125-pcie-link-endpoints-v8-2-19d49c17c05f@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 06:45:59 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] PCI/LMR: use-after-free on port->dev in pci_lmr_release() on
  teardown race
--

commit c126cec11a02e704f7895b57855ddcc4e39ac680
Author: Priyank Rathod <rathodpriyank@google.com>

PCI/LMR: Add Lane Margining at the Receiver debugfs interface

This commit adds a debugfs interface for the PCIe Lane Margining at the
Receiver Extended Capability on Downstream Ports and Function 0 devices
below them, allowing user space to run margining sessions on links at
16.0 GT/s or faster.

> diff --git a/drivers/pci/pcie/margin.c b/drivers/pci/pcie/margin.c
> new file mode 100644
> index 0000000000000..df73fed885fa5
> --- /dev/null
> +++ b/drivers/pci/pcie/margin.c
[ ... ]
> +static struct pci_dev *pci_lmr_teardown(struct pci_lmr_port *port)
> +{
> +	struct pci_dev *partner =3D port->partner;
> +	bool removing;
> +
> +	lockdep_assert_held(&port->lock);
> +
> +	if (port->state !=3D LMR_ACTIVE)
> +		return NULL;
> +
> +	removing =3D !pci_dev_is_added(port->dev) || !pci_dev_is_added(partner);
> +
> +	if (!pci_dev_is_disconnected(port->dev))
> +		pci_lmr_reset_lanes(port);
> +	pci_lmr_autonomous_restore(port);
> +	if (!removing)
> +		pci_lmr_aspm_restore(port);
> +	else
> +		port->aspm_inhibited =3D false;
> +
> +	pci_lmr_forget_rx(port);
> +	scoped_guard(mutex, &pci_lmr_mutex) {
> +		port->partner =3D NULL;
> +		pci_lmr_set_state(port, LMR_IDLE);
> +	}
> +
> +	return partner;
> +}
> +
> +static void pci_lmr_release(struct pci_lmr_port *port, struct pci_dev *p=
artner)
> +{
> +	pm_runtime_put_sync(&partner->dev);
> +	pm_runtime_put_sync(&port->dev->dev);
> +	pci_dev_put(partner);
> +}
[ ... ]
> +static void pci_lmr_end_sessions(struct pci_dev *dev)
> +{
> +	struct pci_lmr_port *p;
> +	struct pci_dev *ended;
> +
> +	for (;;) {
> +		scoped_guard(mutex, &pci_lmr_mutex)
> +			p =3D pci_lmr_find_session(dev);
> +		if (!p)
> +			break;
> +
> +		scoped_guard(mutex, &p->lock)
> +			ended =3D pci_lmr_teardown(p);
> +		if (ended)
> +			pci_lmr_release(p, ended);
> +		pci_lmr_port_put(p);
> +	}
> +}
> +
> +/**
> + * pci_lmr_exit - End margining on a device that is being removed
> + * @dev: PCI device
> + *
> + * Called from pci_destroy_dev() for every device.  Removes the debugfs
> + * directory of @dev, waiting for file operations in progress, and ends
> + * every session that involves @dev, whichever end of the link hosts it.
> + */
> +void pci_lmr_exit(struct pci_dev *dev)
> +{
> +	struct pci_lmr_port *port;
> +
> +	scoped_guard(mutex, &pci_lmr_mutex)
> +		port =3D pci_lmr_find_port(dev);
> +
> +	if (port)
> +		debugfs_remove(port->dir);
> +
> +	pci_lmr_end_sessions(dev);
> +
> +	if (!port)
> +		return;
> +
> +	scoped_guard(mutex, &pci_lmr_mutex)
> +		list_del(&port->node);
> +	pci_lmr_port_put(port);
> +}

[Severity: Medium]
Can pci_lmr_release() use port->dev after it has been freed if another
context tears the session down concurrently with pci_destroy_dev(port->dev)?

Neither pci_lmr_init() nor pci_lmr_start() takes a pci_dev_get() reference
on port->dev, and port->kref only pins struct pci_lmr_port.  Because
pci_lmr_teardown() sets port->state to LMR_IDLE before its caller drops
port->lock and runs pci_lmr_release(), pci_lmr_exit(port->dev) does not
wait for pci_lmr_release() to finish:

CPU0                                  CPU1
pci_destroy_dev(partner)
  pci_lmr_exit(partner)
    pci_lmr_end_sessions(partner)
      p =3D pci_lmr_find_session(...)
      pci_lmr_teardown(p)
        p->partner =3D NULL
        p->state =3D LMR_IDLE
                                      pci_destroy_dev(p->dev)
                                        pci_lmr_exit(p->dev)
                                          debugfs_remove(p->dir)
                                          pci_lmr_end_sessions(p->dev)
                                            /* state is LMR_IDLE, returns */
                                          list_del(&p->node)
                                          pci_lmr_port_put(p)
                                        device_del(&p->dev->dev)
                                        put_device(&p->dev->dev)
      pci_lmr_release(p, ended)
        pm_runtime_put_sync(&p->dev->dev)  <-- use-after-free

Taking a pci_dev_get(port->dev) reference for the lifetime of the session
(or of struct pci_lmr_port) and keeping the session non-idle until
pci_lmr_release() completes would prevent pci_destroy_dev() from tearing
down and freeing port->dev early.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-pcie-link-=
endpoints-v8-0-19d49c17c05f@google.com?part=3D2
