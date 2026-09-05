Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F4035677D
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 02:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788573626; cv=none; b=UNJISGQ5cH7YRXf4m+tKH8YW0Zf58ujaJgV776RNSkt2m+UtO3H+aDadBFLG2/evfK7IOzwQtsxGj5LCKwUXxWtOPVBytMYiewjLl3i/NxtvUw+W3iUWHQTBt07LN7cVLZY+13H6vtwsS2wjqlwIFIEQDT6ZV4TVM2TgPLzcDD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788573626; c=relaxed/simple;
	bh=AfsDvfy0Q0LyajnxrGJjgQ9NhTgRrfCerNe52uLIq8U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pDIRntE9aNFBaUM27bzCjzhI6zcQEBYixx+/v5SA7R6l4zhB23Luee/xHJtVx52dj8rzdoFkc2fnzvjnE+j9E2qPjdO4l5hpmsOvB0G+wYqPKgW0JFeBLLMRABSVEsoW8b3LqojTYX67O05uNVQYJov7w7LSFEfDBRtGMhrR1fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGRbspr9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGRbspr9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7901F00A3D;
	Sat,  5 Sep 2026 02:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788573624;
	bh=raOxzQWmyZDhSMRsXrJp371O3QKRmgizTnmO+yzElrc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KGRbspr9GFGXZ2hKaxh6XNY7BF5nZHaeHrg6QI0gccjBsu4s+neAnRyT+PZEGfw5H
	 lHxkHTj8edj4uZE28zzF9TdMbQbpsOBymO5nt9lmZvhIvE0fJ0n2wg2nvXtM3EAmh5
	 kTtuiK79H2I03N8/pSdYZq7IQyGafenw/Dwf+kD9x0TxtQ/fyNGzqYXgqmkFvgWQ2J
	 tNwimHcs+1bRqcsIKxhtSyrqEKPZfrJK95gzN97y8ftK2We4kz3KVNuRpdAGyfEqcA
	 eZIVSL6j4FxtNOc95OYOwwI5PytWWq4D1opz6K8FUMAecA7TiA9WsLNwwbkMSdxjzS
	 AWc/n+JWwRb5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Free doorbell IRQ on
 unbind and deinit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fan Wu" <fanwu01@zju.edu.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260905014525.420764-1-fanwu01@zju.edu.cn>
References: <20260905014525.420764-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 02:00:24 +0000
Message-Id: <20260905020024.AB7901F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] pci_epf_test_disable_doorbell() does not check the new doorbel=
l_irq_registered flag, allowing a malicious host to trigger a NULL pointer =
dereference or double-free.
- [High] Module exit routine destroys workqueue before unregistering the dr=
iver, leading to a Use-After-Free.
--

commit dc35dc30c72a974fd9de8195ba6c7cac69c49ed9
Author: Fan Wu <fanwu01@zju.edu.cn>

PCI: endpoint: pci-epf-test: Free doorbell IRQ on unbind and deinit

This commit resolves a missing IRQ teardown in the endpoint teardown paths.
It introduces a new doorbell_irq_registered flag to ensure the doorbell IRQ=
=20
is correctly freed on unbind and deinit, preventing EBUSY on subsequent=20
doorbell allocations.

> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/=
endpoint/functions/pci-epf-test.c
> index d4905aa8e4c01..ab8df91891cec 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
[ ... ]
> @@ -772,6 +774,7 @@ static void pci_epf_test_enable_doorbell(struct pci_e=
pf_test *epf_test,
>  		goto err_doorbell_cleanup;
>  	}
> =20
> +	epf_test->doorbell_irq_registered =3D true;
>  	reg->doorbell_data =3D cpu_to_le32(msg->data);
>  	reg->doorbell_bar =3D cpu_to_le32(bar);
> =20

[Severity: Critical]
This is a pre-existing issue, but since this patch introduces the
doorbell_irq_registered flag, could it also be used in
pci_epf_test_disable_doorbell() to prevent a crash?

A PCIe host can write a valid BAR index directly to reg->doorbell_bar and
issue COMMAND_DISABLE_DOORBELL without a prior successful
COMMAND_ENABLE_DOORBELL.

When this happens, pci_epf_test_disable_doorbell() reads the bar value
directly from host-writable memory:

drivers/pci/endpoint/functions/pci-epf-test.c:pci_epf_test_disable_doorbell=
() {
	enum pci_barno bar =3D le32_to_cpu(reg->doorbell_bar);
	...
	if (bar < BAR_0)
		goto set_status_err;

	free_irq(epf->db_msg[0].virq, epf_test);
	...
}

Because the host provided a valid index, the sanity check is bypassed.

Since epf->db_msg is only allocated during enable, it remains unallocated.

Does unconditionally dereferencing epf->db_msg without checking
epf_test->doorbell_irq_registered allow a malicious host to trigger a NULL
pointer dereference or double-free?

Since a PCIe endpoint must robustly handle host inputs, could this lead to a
locally triggered remote DoS?

[ ... ]
> @@ -1374,6 +1381,10 @@ static void pci_epf_test_unbind(struct pci_epf *ep=
f)
>  	struct pci_epc *epc =3D epf->epc;
> =20
>  	cancel_delayed_work_sync(&epf_test->cmd_handler);
> +	if (epf_test->doorbell_irq_registered) {
> +		free_irq(epf->db_msg[0].virq, epf_test);
> +		pci_epf_test_doorbell_cleanup(epf_test);
> +	}
>  	if (epc->init_complete) {
>  		pci_epf_test_clean_dma_chan(epf_test);
>  		pci_epf_test_clear_bar(epf);

[Severity: High]
This isn't a bug introduced by this patch, but there appears to be a
use-after-free risk during module unload related to this teardown path.

In the module exit routine, the workqueue is destroyed before the driver
is unregistered:

drivers/pci/endpoint/functions/pci-epf-test.c:pci_epf_test_exit() {
	if (kpcitest_workqueue)
		destroy_workqueue(kpcitest_workqueue);
	pci_epf_unregister_driver(&test_driver);
}

If an interrupt fires or a delayed work reschedules itself before
pci_epf_unregister_driver() fully unbinds the endpoints, could the system
attempt to queue work to a freed workqueue?

Unbinding also issues cancel_delayed_work_sync() here.

Could this access invalid timer state since the workqueue was already
destroyed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905014525.4207=
64-1-fanwu01@zju.edu.cn?part=3D1
