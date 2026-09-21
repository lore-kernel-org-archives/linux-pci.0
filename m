Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1F148F02F
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001315; cv=none; b=J3wfVodjF0IIBS/CB3dLTAjHZLecgyPbE4QMrU39ZnwA1XT93zISVa9ITeDjHutIwQPuK/7QWrgn+yamql2fzDBGBqUkDf5SdKaprm4TfBMkleIOxIn7dYlt4N+OMtNTAals6w3HzFEJwgO4GjvwgyoaYrKDmZy8QnG084CKXOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001315; c=relaxed/simple;
	bh=D7wzkAsFsFvhObEHXC9XZoT6+8bgF/0/xIOWRn6Vdpw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LUwBuU3Fo+eLCdGguhEaE7zFw52LDebLRiVpfH1ZeWiRBMZODZbC3CNRvDVybAQ1rI5cAe3fERWzSo733+3fvyQvdZEf7wM1N3MxCC/hI2ZQnHx+2qiF+UmkL3kFNGsjxYYZ7uyRUxW3Qk/JXBZfxxEGm/ocoYVfoXBFtj48zM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmL+qez1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmL+qez1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7431F000FF;
	Mon, 21 Sep 2026 14:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790001314;
	bh=pvwTcfjpSZLOrqvkAEBWwZxf8x6KsBWPNUiH9NJqBxQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CmL+qez1QrH25dcByC5WwhQpjgRzirZPPJQBibZ20vR83+/E68+xJ/b51o2CWfIp9
	 a6rYTnbTIkOxIwFR3Ddtp3WqNMGvFKtduLK8fJBvlVIf/+r0ZV5OOgkBXcAeEiorHT
	 DWkabUfPpzQp7x2f46nxyp7ussVfSpBhbQUtD+q/nNbFCJC8ONIKdn/CS0347TQd+u
	 NfrM4kMgpe4X3r/No2TewnbQLbqiS33N7XTrcG79rkHPF3/6Ep/LB8xCo0vKd1PSZ7
	 EGTB7IyXXLBLxUBpca2IAGKtI4KQaKMuDShOmgyea1qKAq2xOYvWc8NL5616eIOvh1
	 44gogdTLczp9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: keystone: fix endpoint teardown on remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260921142147.435953-1-lgs201920130244@gmail.com>
References: <20260921142147.435953-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 14:35:13 +0000
Message-Id: <20260921143514.4C7431F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: TOCTOU race in dw_pcie_ep_deinit() causing duplicate EPC dein=
it
--

commit e6751d7bce3085ac260a82fa5b3a315cc5808621
Author: Guangshuo Li <lgs201920130244@gmail.com>

PCI: keystone: fix endpoint teardown on remove

This commit fixes missing endpoint teardown in the keystone PCIe driver's
remove path. It makes dw_pcie_ep_deinit() notify the endpoint framework of
deinitialization directly, avoiding duplicated notification code in
controller drivers. It also caches the controller mode in struct
keystone_pcie to simplify teardown.

[ ... ]

> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pc=
i/controller/dwc/pcie-designware-ep.c
> index de8ee3db43601..b785e098f7597 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -1188,6 +1188,9 @@ void dw_pcie_ep_deinit(struct dw_pcie_ep *ep)
>  {
>  	struct pci_epc *epc =3D ep->epc;
> =20
> +	if (epc->init_complete)
> +		pci_epc_deinit_notify(epc);
> +

[Severity: High]
Can this unprotected check of epc->init_complete cause a TOCTOU race leading
to a double-free?

If the endpoint controller remove function calls dw_pcie_ep_deinit()
concurrently with a hardware interrupt like PERST calling
pci_epc_deinit_notify() directly, both threads could read
epc->init_complete as true without holding epc->list_lock.

Since pci_epc_deinit_notify() doesn't verify epc->init_complete under a
lock:

drivers/pci/endpoint/pci-epc-core.c:pci_epc_deinit_notify() {
    ...
		mutex_unlock(&epf->lock);
	}
	epc->init_complete =3D false;
	mutex_unlock(&epc->list_lock);
}

Could this result in duplicate calls to pci_epc_deinit_notify(), causing
EPF drivers like pci-epf-mhi to execute their epc_deinit callback twice
and double-free resources such as workqueues and caches?

>  	dw_pcie_ep_cleanup(ep);
> =20
>  	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921142147.4359=
53-1-lgs201920130244@gmail.com?part=3D1
