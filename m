Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285694;
	b=xGDTjvOANvzADEPQfC5AQlJGY3JPSsVYD57iKr1aC/hdkuTGPut7nYt9JigLDg5HmMVq
	 ED/tvaflJLXjQ2A3yxHZN3yaxIuxZ57QMHikZlNWbQY2JrUXrpgc9pLXxN/X7oxKuAFkO
	 ujoKkPP2mX3aFPEdT6KbDG5ZCEbgybidLl1nRRdWPlmVksoPtpYTnrCgut9wR6PhYq3mR
	 Td17hMIWxfhLAtUrFGNQwJLzXtnwWb59mSN+EnNGUip9eZTIIXOYdQerZgvPyIFa6DXzC
	 xwIhgRB/RLy8ZbvgxBaZTBOaJbfXbOWao+dZvpWfW12a63g+4MPj8OUZf0Tfu/5DrWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285694;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ALQCwy/nS/pIirsIerHgJ39MIlwngejSW8OASRTqRno=;
	b=b7MRXKtbYo5FSmNTiKbX50MyCOrYgTqoNH6S2zL758B7C/wx4kP1bKlndQSmW1LerCH1
	 wlPBI/hJQ9DtOAjM13VT6ihAo42e7S4EhcwxaRQuS4Q1z4rV+4Fi7Kfv4Mv9HwTqaQuDH
	 2qeEcAr2kWWuhhtmxxYsSPQ8ii/F1c6p73QD5/6mIjw3fVkjkI5wSigF3DRuMrynKLsM0
	 5Tayi5YUdiBuviMp5WCfRbpikzb9+AGLSXC49yY9SurXAnTSG1OQQ7wNNeITe/1pN1/Cz
	 XCVNyeKy5/6Qj2PfgoTOjgYOt/WkxzD7HDB4Y+oj4fjj3IMvyo8Ap7GZCeIhrgRx/Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lDo/mwpi";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF68606A321;
	Tue, 10 Nov 2026 04:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lDo/mwpi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887091F0089F;
	Tue, 10 Nov 2026 04:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794285693;
	bh=ALQCwy/nS/pIirsIerHgJ39MIlwngejSW8OASRTqRno=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lDo/mwpiB0QC9/CyZXpcfKpk/aJFQLGnvBSkI+j4GYLW9CeL+H1thPCcw/F8D9wJG
	 gv0jtROUDKVRWQWnbBjNE7L56UhUekhlnL6FhsZrlTEfB48tJm5Q3PUj2H4AC52MkW
	 vcvkTnb4nIJZkr52CaPbYi1QO8W016Uv5wSXg0/GurWl1pY49vflJEHyFl9KSZk8Xf
	 CvSgejFGRfh2l4HGchGraofpSa0DewxfS8m7vt6hkwQN0shUps7n3+708LBl6Az1wv
	 YLSp9MsRPwmizuEtLPLBZR/udl06eAV3z8xUAv/BkS+DDweAnK3WC5BkSaF6oRqwXR
	 VMMwJi1HbNTlA==
Message-ID: <sashiko-outbox-206226@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/25] PCI/CMA: Add a PCI TSM CMA driver using SPDM
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261110041832.1730924-13-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
 <20261110041832.1730924-13-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:41:33 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] PCI/CMA: pci_cma_tsm_probe() misattaches subordinate and
  sibling functions
- [Low] PCI/CMA: write-only static variable pci_cma_tsm_dev in
  pci_cma_tsm_init()
--

commit 8928bf8b82ed0687cad0e8da916dd5dcfd9c6e73
Author: Alistair Francis <alistair.francis@wdc.com>

PCI/CMA: Add a PCI TSM CMA driver using SPDM

This commit adds a PCI TSM driver for Component Measurement and
Authentication (CMA-SPDM) over PCI DOE mailboxes, enabling device
authentication via SPDM.

> diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
> new file mode 100644
> index 0000000000000..3f0c989b52c5d
> --- /dev/null
> +++ b/drivers/pci/cma.c
[ ... ]
> +static struct pci_tsm *pci_cma_tsm_probe(struct tsm_dev *tsm_dev,
> +					 struct pci_dev *pdev)
> +{
> +	struct pci_cma_tsm *cma;
> +	int rc;
> +
> +	if (!pdev->doe_cma || pdev->is_virtfn)
> +		return NULL;
> +
> +	cma =3D kzalloc(sizeof(*cma), GFP_KERNEL);
> +	if (!cma)
> +		return NULL;
> +
> +	rc =3D pci_tsm_host_constructor(pdev, &cma->host, tsm_dev);
> +	if (rc) {
> +		kfree(cma);
> +		return NULL;
> +	}
> +
> +	cma->spdm =3D spdm_create(&pdev->dev, pci_doe_transport, cma->host.doe_=
mb,
> +				PCI_DOE_MAX_PAYLOAD, NULL);
> +	if (!cma->spdm) {
> +		pci_tsm_host_destructor(&cma->host);
> +		kfree(cma);
> +		return NULL;
> +	}
> +
> +	return &cma->host.base_tsm;
> +}

[Severity: High]
Can pci_cma_tsm_probe() attach subordinate or sibling functions without
authenticating them, and bind sibling functions' pci_tsm_host contexts to
function 0?

pci_cma_tsm_probe() succeeds for any physical function with pdev->doe_cma
set, even when called from probe_fn() for a subordinate function where
pci_cma_tsm_connect() is never run:

drivers/pci/tsm.c:probe_fn() {
	...
	pdev->tsm =3D ops->probe(dsm_dev->tsm->tsm_dev, pdev);
	pci_dbg(pdev, "setup TSM context: DSM: %s status: %s\n",
		pci_name(dsm_dev), pdev->tsm ? "success" : "failed");
	if (pdev->tsm)
		link_sysfs_enable(pdev);
	return 0;
}

When a TEE-capable function 0 or upstream switch port is connected to
pci_cma_tsm (via pci_tsm_connect() -> pci_tsm_walk_fns()), or when a
sibling PF or downstream device is later initialized via pci_tsm_init()
while function 0 or the upstream port is connected, probe_fn() populates
pdev->tsm without calling spdm_authenticate().  Because authenticated_show()
reports the TSM device name whenever pdev->tsm is non-NULL, sysfs reports
those unauthenticated functions as authenticated and hides their tsm/connect
and tsm/disconnect attributes.

In addition, once function 0 is connected to pci_cma_tsm, is_dsm(pf0) is
true even on a non-TEE multi-function device:

drivers/pci/tsm.c:find_dsm_dev() {
	...
	if (pf0 && pf0 !=3D pdev && is_dsm(pf0))
		return pf0;
	...
}

When a sibling PF is then connected via pci_tsm_connect() ->
pci_tsm_host_constructor() -> pci_tsm_link_constructor(), find_dsm_dev()
sets the sibling PF's base_tsm.dsm_dev to pf0 instead of the sibling PF
itself.  That breaks the struct pci_tsm_host invariant (dsm_dev =3D=3D pdev=
),
causing to_pci_tsm_host() and pci_tsm_doe_transfer() on the sibling PF to
use function 0's lock and DOE mailbox, hiding the sibling PF's disconnect
attribute, and causing __pci_tsm_destroy() to tear down the sibling PF via
pci_tsm_fn_exit() without holding tsm_host->lock.

[ ... ]
> +static struct tsm_dev *pci_cma_tsm_dev;
> +
> +static int __init pci_cma_tsm_init(void)
> +{
> +	struct tsm_dev *tsm_dev;
> +
> +	tsm_dev =3D tsm_register(NULL, &pci_cma_tsm_ops);
> +	if (IS_ERR(tsm_dev))
> +		return PTR_ERR(tsm_dev);
> +
> +	pci_cma_tsm_dev =3D tsm_dev;
> +	return 0;
> +}

[Severity: Low]
pci_cma_tsm_dev is assigned in pci_cma_tsm_init() but never read anywhere,
which triggers a -Wunused-but-set-variable warning under W=3D1.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110041832.1730=
924-1-alistair.francis@wdc.com?part=3D12
