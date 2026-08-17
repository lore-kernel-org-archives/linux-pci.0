Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5CA244687
	for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2026 05:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786946018; cv=none; b=dRSRTNnjf8FCUT/zsLJH6DHMpLJXjz23l8demRFbKT7JRfKtSWpwvm5+io4Y8ecg8gZMQBDcbH6YEYcTY3SWCw5Twc3MrSYYPfYqs7+MyjVv3RjUVaywK5wEKCZUNfRBIHKrdVD/sCkEqi21Wcxf4lMJf4OJaomuWkC0CDK+1R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786946018; c=relaxed/simple;
	bh=MhSFxBHmwO2Q1JCSvNu25PgWn7pt/PdKpvdQZj5l4kA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rRnxJj1PI14qufMpIq5/OERdGWt3z2/S76dpCoXL1ytUb3OsRF4Fbnj+C/GrOI5/u/vZJrHdZ7N5Fqie/p8xilFJzXQjYsyqP1D7xT1o3B5HZe5EUhNPKm4cSEceJZn2nP76QV4ufuAMXFOgKkpQmSxDOKKeVM7ePPYITM2d844=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khEnEmY0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khEnEmY0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4C91F000E9;
	Mon, 17 Aug 2026 05:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786946016;
	bh=0MgFVrPicX+Cmp/5yQYumuXJfJR63i/0qx7Bo7XxUmU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=khEnEmY079TE0yx0nD//RmemHFi2AA32b6wFYnK6U8uXh9Dw4dU8vNeEZgGGhU0uO
	 el92aLzIF/DCAAtl1jirS/yXbj9fvSmK69TNkLmO/BoBHpjKq2bvOQcDfBsnD2yF6d
	 usyvVs1S1x38fnZ/oNxMGkjRRvltwnMTPrPS4aHPH2EgkWgW+hBGa+/Jngzk8J1kk7
	 nPbf6yg92zoJCS3GZOfdXH5l4aNBEq0wCMktD9HDLcRfn4hZ+HCXd2VYAmAuBPoSBs
	 DZLQ/l2jp4N6shY2zTokbGrYvRacM0ule7i8cTrazTSiFBJrN8mcxqgO7gsqPHou0H
	 BcQt7EvnN2YVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: switchtec: Fix use-after-free in
 switchtec_pci_remove due to race condition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pei Xiao" <xiaopei01@kylinos.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <4cebfe41ee3985bc4f38beb42d44147a34637971.1786944920.git.xiaopei01@kylinos.cn>
References: <4cebfe41ee3985bc4f38beb42d44147a34637971.1786944920.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 05:53:36 +0000
Message-Id: <20260817055336.8C4C91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free window in the `switchtec_pci_probe()` error path du=
e to premature freeing of `stdev` while `event_irq` is active.
- [High] Use-After-Free via TOCTOU race in `switchtec_dev_write` due to inc=
orrect teardown ordering in `stdev_kill()`.
--

--- Patch [1]: [PATCH v3] PCI: switchtec: Fix use-after-free in switchtec_p=
ci_remove due to race condition ---
commit a18ebaceba03ea5f94a521c5ced89b052f121ea9
Author: Pei Xiao <xiaopei01@kylinos.cn>
Subject: PCI: switchtec: Fix use-after-free in switchtec_pci_remove due to =
race condition

This patch attempts to fix a use-after-free bug during device removal by
quiescing interrupt sources before canceling pending work items. It adds
logic to stdev_kill() to explicitly free IRQs and cancel work structures.
It also stores the IRQ numbers explicitly in the switchtec_dev structure.

Link: https://lore.kernel.org/lkml/5ce42824-488e-4040-8531-0acc8b01b13a@del=
tatee.com/#t

> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchte=
c.c
> index 41fc4b5127081..91d44acfe1193 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c

[ ... ]

> @@ -1318,6 +1318,13 @@ static void stdev_kill(struct switchtec_dev *stdev)
> =20
>  	pci_clear_master(stdev->pdev);
> =20
> +	if (stdev->event_irq)
> +		devm_free_irq(&stdev->pdev->dev, stdev->event_irq, stdev);
> +	if (stdev->dma_mrpc_irq)
> +		devm_free_irq(&stdev->pdev->dev, stdev->dma_mrpc_irq, stdev);
> +
> +	cancel_work_sync(&stdev->mrpc_work);
> +	cancel_work_sync(&stdev->link_event_work);
>  	cancel_delayed_work_sync(&stdev->mrpc_timeout);
[Severity: High]
This is a pre-existing issue, but does canceling this delayed work before
setting the alive flag allow it to be re-armed?

If userspace performs a concurrent write during device removal, it can call
switchtec_dev_write(), which does:

drivers/pci/switch/switchtec.c:switchtec_dev_write() {
    ...
    rc =3D lock_mutex_and_test_alive(stdev);
    if (rc)
        return rc;
    ...
    rc =3D mrpc_queue_cmd(stuser);
    ...
}

Because cancel_delayed_work_sync() executes outside of mrpc_mutex and before
stdev->alive is set to false, mrpc_queue_cmd() could successfully re-arm
stdev->mrpc_timeout after it was just canceled.

When stdev is subsequently freed, could this newly armed delayed work execu=
te
on freed memory?

> =20
>  	/* Mark the hardware as unavailable and complete all completions */

[ ... ]

> @@ -1513,6 +1522,7 @@ static int switchtec_init_isr(struct switchtec_dev =
*stdev)
> =20
>  	if (rc)
>  		return rc;
> +	stdev->event_irq =3D event_irq;
[Severity: High]
This is a pre-existing issue, but is there a use-after-free window in the
probe error path?

When switchtec_init_isr() requests event_irq, it uses devm_request_irq()
bound to the PCI device:

drivers/pci/switch/switchtec.c:switchtec_init_isr() {
    ...
    rc =3D devm_request_irq(&stdev->pdev->dev, event_irq,
                          switchtec_event_isr, 0, KBUILD_MODNAME, stdev);
    ...
}

If a subsequent initialization step fails during switchtec_pci_probe(),
the err_put path will free the stdev structure:

drivers/pci/switch/switchtec.c:switchtec_pci_probe() {
    ...
err_put:
    ida_free(&switchtec_minor_ida, MINOR(stdev->dev.devt));
    put_device(&stdev->dev);
    return rc;
}

Since put_device() immediately frees stdev without explicitly freeing the I=
RQ,
and devres cleanup doesn't run until the probe function returns, could an
interrupt fire during this window and cause switchtec_event_isr() to
dereference the already freed stdev?

> =20
>  	if (!stdev->dma_mrpc)
>  		return rc;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/4cebfe41ee3985bc4f3=
8beb42d44147a34637971.1786944920.git.xiaopei01@kylinos.cn?part=3D1
