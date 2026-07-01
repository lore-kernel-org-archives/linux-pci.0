Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29693947AC
	for <linux-pci@vger.kernel.org>; Wed,  1 Jul 2026 07:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782892038; cv=none; b=Wyhb1oYxBXgosHriMGuJJU41DHBvrLytzsJkiDOsG6B7YO4rglI6wtywcCyIQ/hwOOY1cJwhyryuyiWjpNNzjp3XV4HUjkEcFoJImhxFeGv0Bt2D3X7PNlXr9olxhbR6xKiYOXCNCKsUIbOCjcdYnO1+LmLeb+5RBCSnlqU3nSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782892038; c=relaxed/simple;
	bh=YBGJmubolQg3jsInZogIto910llrMZIsbVxL/yAordA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iINTKSaL5Tdo8WUCPai6q/9RYA5togj8KVKqocFlIqI18tTDh1GjnBK0v5nGJzb/ty3d7efeVEtPPRTh8NRNS5xr/juRDlV37bCzZw1uOmQtASgW2isRlm2y17MOYh+oVB79hGsiWHAvsiqBaA6eLod3cEy33RYjeDCaisJBVos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7v5MTXo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7v5MTXo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292BA1F000E9;
	Wed,  1 Jul 2026 07:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782892037;
	bh=/VNYIb3JOtuInMqP8XSQFPzveYogy0fT4vT9KkVmdzc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l7v5MTXo0PubtK7/MCI4oEpmYZ7wTHqH2vUneCKX3N0D/5hKAVtOkW/Pl//5zqp7C
	 0ATPr1vHrcs3ofMpQm10DIKyx5JxQ5bUDWBOWXepWvhHVUcEfjqyteOJW52GxJQGb2
	 uQ/M9u7wbjXlApRCIcfS0DZm6KrotFEhNQ1ou8iQFMjFYIl/RVUvxaIKWGrewzE+2p
	 +j7tVXGcIV5duB7YvFEvRnwSf+SicDLvnrUqikMY3i4L1WWXCH2AE+AsoYtO9TIMvJ
	 ZS81awpe4Ae5t4tX3vWJn2/XyDoeHvqwzo1krpJMqe80ZmFZ3FRA/YpJ01n2x4pOBj
	 RZhAkGeosXKtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/3] PCI: cadence: Add LGA IP debugfs for LTSSM
 status
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260701073513.1101559-4-18255117159@163.com>
References: <20260701073513.1101559-1-18255117159@163.com>
 <20260701073513.1101559-4-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 07:47:16 +0000
Message-Id: <20260701074717.292BA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the `to_pci_epc(=
)` macro is incorrectly applied to the platform device's `dev` object in `c=
dns_pcie_ep_disable()`, resulting in type confusion and bogus pointer deref=
erence.
--

commit 21d2761732f07216945992f2fa129395035e6bda
Author: Hans Zhang <18255117159@163.com>

PCI: cadence: Add LGA IP debugfs for LTSSM status

This commit extends debugfs support to LGA-based Cadence PCIe controllers.
It makes the ltssm_status file work for both HPA and LGA IPs by selecting
the appropriate register access based on the is_hpa flag.

> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/p=
ci/controller/cadence/pcie-cadence-ep.c
> index c0e1194a936b3..370b19f4d38fb 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -655,6 +655,7 @@ void cdns_pcie_ep_disable(struct cdns_pcie_ep *ep)
>  	struct device *dev =3D ep->pcie.dev;
>  	struct pci_epc *epc =3D to_pci_epc(dev);

[Severity: High]
This is a pre-existing issue, but does this code pass the correct dev to
to_pci_epc()?

Because ep->pcie.dev represents the parent platform device rather than the
device object embedded inside struct pci_epc, the container_of calculation
inside to_pci_epc() yields an incorrect address.

Will this garbage pointer subsequently passed to pci_epc_mem_free_addr()=20
and pci_epc_mem_exit() cause an invalid memory access during device
teardown?

> =20
> +	cdns_pcie_debugfs_deinit(&ep->pcie);
>  	pci_epc_deinit_notify(epc);
>  	pci_epc_mem_free_addr(epc, ep->irq_phys_addr, ep->irq_cpu_addr,
>  			      SZ_128K);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701073513.1101=
559-1-18255117159@163.com?part=3D3
