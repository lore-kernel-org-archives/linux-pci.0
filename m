Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795000744;
	b=G8zIw1CkJvGwojMNlqgMAxtpESmu1vn7ZJpKxUaSKIClqF2GRy1DvFVMGC5gitN3YOnP
	 4okWSodSkO9OfFSIKv9xAp+CZk3NTp+6N9wdlE0QOl3AO+/TVkGiGNeG9Oi4NfdcO2UOF
	 GJYPmfeQ7VtoUI3Q+X2uGRejZOJmc0LziAzqIZCuoU9mEgmcNn3cinGdGVlHmCqK6ubAY
	 ZvjpmrRj9jks0xRK+lDAv6/OlHrw5sgIaNZeyMDLAq00LNq8KJm74L6nA18dIVvnZ/Y66
	 od2LYJx8W+kqJz0gFRmmQGvXXhovwr5OcE2ViT5rV6574WdXQmsUY8yfKnSy58FLDyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795000744;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fSnOovw7lUzI6PEZFMsDtQCyuPYp3fOnR17TlbMzKlw=;
	b=rckNiANEo7GwbXs7niO6mVlbh1X1UrZ4//sY797ZDg50FDWiYTqjUaInlbFgv2fN7ESx
	 y5RJh6FcWbor4qFJjyBJyC8NO9bb7yJ/2nizAVuvGJV/FMMWniLzyjco+vB/YqNydHsWh
	 t3pGQnWE0TpWQtjXv+WZKq61KfPyVITrlUU6zO7nOPO0T59UAf7MsdP10vj+ZVa8wIqUX
	 wJJDV4rI3jSf6nKGuZCr/gBKmvzMsWPjx2B4pu30C2gI09LkCmdynHs7g51Fjob5YMqTB
	 +xAl9vkJACN9C6xSjJMbKqIGIMiluZ2XRBTZsV/6gXyRbVVDiDld39lR2XpuLg80ycQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EzdfX+MD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C47606A31C
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 11:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EzdfX+MD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218971F000C5;
	Wed, 18 Nov 2026 11:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795000744;
	bh=fSnOovw7lUzI6PEZFMsDtQCyuPYp3fOnR17TlbMzKlw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=EzdfX+MDS9jqHg8KtMtQWbSw00KG+vqxcx2JAlIskWUaga0Xc4vksft4qTQaUcYj+
	 BrsJvP9fHtB+N/6LjNMzrwmSM5tUk/IOkz6qWrBEh9rlA7mvSPqfAWoGr03ShY8/MI
	 cHeWjMM0vPQmFXU7O0zwG0ca5sfH7jYa6jbpombrFtfvzix0C03z9DaBr+0cSSSouZ
	 gFGn5IaQOLX22lM4rn7dqaZCOnc3BsGlXzmO4sLXVORQfBtYH5hJLD5PTm3yr+B+Ox
	 5BNit4wyj836DYoNJhilIPaegpOfF9x6O27YFj1x7EuXYtxQ9/xU4VCN1/NoUcBUri
	 m+vZoTpWH+FcA==
Message-ID: <sashiko-outbox-220816@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/7] PCI/AER: Enable baseline capability error
 reporting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Wunner" <lukas@wunner.de>, linux-pci@vger.kernel.org
In-Reply-To: <40e4bd7f25b37af1bdc48a13be140bdd8e7d81ab.1794997749.git.lukas@wunner.de>
References: <cover.1794997749.git.lukas@wunner.de>
 <40e4bd7f25b37af1bdc48a13be140bdd8e7d81ab.1794997749.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 11:19:03 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] PCI/AER: aer_get_device_error_info() misclassifies fatal
  errors when !aer
- [Medium] PCI/AER: aer_stats_attrs_are_visible() exposes rootport attrs
  when !aer_cap
- [Medium] PCI/AER: RsvdP PCI_EXP_AER_FLAGS in VF PCI_EXP_DEVCTL breaks
  VF baseline AER
--

commit 9287c85cae40e6093499911042f25e70c5543c73
Author: Lukas Wunner <lukas@wunner.de>

PCI/AER: Enable baseline capability error reporting

This commit enables PCIe baseline capability error reporting on devices that
do not implement the Advanced Error Reporting Extended Capability, using the
Device Control and Device Status registers.

Link: https://lore.kernel.org/r/20260826212619.GA1566339@bhelgaas/

> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 9bb8e2127849e..3c28afca5d037 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -403,21 +403,22 @@ void pci_aer_init(struct pci_dev *dev)
>  {
>  	int n;
> =20
> -	dev->aer_cap =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
> -	if (!dev->aer_cap)
> +	if (!pci_is_pcie(dev))
>  		return;
> =20
>  	dev->aer_info =3D kzalloc_obj(*dev->aer_info);
> -	if (!dev->aer_info) {
> -		dev->aer_cap =3D 0;
> +	if (!dev->aer_info)
>  		return;
> -	}
> =20
>  	ratelimit_state_init(&dev->aer_info->correctable_ratelimit,
>  			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
>  	ratelimit_state_init(&dev->aer_info->nonfatal_ratelimit,
>  			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
> =20
> +	dev->aer_cap =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
> +	if (!dev->aer_cap)
> +		goto enable;

[Severity: Medium]
Does allocating dev->aer_info for all PCIe devices cause
aer_stats_attrs_are_visible() to expose the aer_rootport_total_err_* sysfs
attributes on Root Ports and RCECs that lack an AER Extended Capability?

drivers/pci/pcie/aer.c:aer_stats_attrs_are_visible() {
	...
	if (!pdev->aer_info)
		return 0;

	if ((a =3D=3D &dev_attr_aer_rootport_total_err_cor.attr ||
	     a =3D=3D &dev_attr_aer_rootport_total_err_fatal.attr ||
	     a =3D=3D &dev_attr_aer_rootport_total_err_nonfatal.attr) &&
	    ((pci_pcie_type(pdev) !=3D PCI_EXP_TYPE_ROOT_PORT) &&
	     (pci_pcie_type(pdev) !=3D PCI_EXP_TYPE_RC_EC)))
		return 0;
	...
}

Those counters are only updated from PCI_ERR_ROOT_STATUS in the AER
capability and Documentation/ABI/testing/sysfs-bus-pci-devices-aer states
that they only appear under AER-capable Root Ports or RCECs, so
aer_stats_attrs_are_visible() should also require pdev->aer_cap for them.

[ ... ]

> @@ -1204,8 +1206,11 @@ static bool is_error_source(struct pci_dev *dev, s=
truct aer_err_info *e_info)
>  	if (!(reg16 & PCI_EXP_AER_FLAGS))
>  		return false;
> =20
> -	if (!aer)
> -		return false;
> +	if (!aer) {
> +		pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &reg16);
> +		return reg16 & severity2devsta[e_info->severity] &&
> +		       !PCI_POSSIBLE_ERROR(reg16);
> +	}

[Severity: Medium]
Does checking PCI_EXP_AER_FLAGS in dev's own PCI_EXP_DEVCTL prevent
is_error_source() and clear_status_iter() from working on SR-IOV Virtual
Functions?

Per PCIe r7.1 sec 7.5.3.4 and sec 9.5.1.2, the PCI_EXP_AER_FLAGS bits in
PCI_EXP_DEVCTL are RsvdP and hardwired to 0b on VFs, which inherit the
associated Physical Function's PCI_EXP_DEVCTL settings while implementing
per-VF status bits in PCI_EXP_DEVSTA.  Reading PCI_EXP_DEVCTL on a VF
therefore always sees 0 for PCI_EXP_AER_FLAGS, so is_error_source() never
checks PCI_EXP_DEVSTA on VFs and clear_status_iter() never clears it;
meanwhile pci_enable_pcie_error_reporting() writes 1s to those RsvdP bits on
VFs.

[ ... ]

> @@ -1531,13 +1537,22 @@ int aer_get_device_error_info(struct aer_err_info=
 *info, int i)
> =20
>  	/* Must reset in this function */
>  	info->status =3D 0;
> +	info->mask =3D 0;
>  	info->anfe_status =3D 0;
> +	info->first_error =3D 0;
>  	info->tlp_header_valid =3D 0;
>  	info->is_cxl =3D pcie_is_cxl(dev);
> =20
>  	/* The device might not support AER */
> -	if (!aer)
> -		return 0;
> +	if (!aer) {
> +		if (info->severity !=3D AER_CORRECTABLE) {
> +			pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &devsta);
> +			if (devsta & PCI_EXP_DEVSTA_URD &&
> +			    !PCI_POSSIBLE_ERROR(devsta))
> +				info->status =3D PCI_ERR_UNC_UNSUP;
> +		}
> +		return 1;
> +	}

[Severity: Medium]
Should the !aer branch check info->severity =3D=3D AER_NONFATAL instead of
info->severity !=3D AER_CORRECTABLE?

Without an AER capability, error severities are fixed to their defaults whe=
re
Unsupported Request is always Non-Fatal (PCIe r7.1 sec 6.2.7), yet
PCI_EXP_DEVSTA_URD is also set by prior Advisory Non-Fatal or Non-Fatal
Unsupported Requests (sec 6.2.5 and 7.5.3.5).  When an AER_FATAL error occu=
rs
on an AER-incapable device, reading PCI_EXP_DEVSTA accesses config space on
an Endpoint or Upstream Port whose link may be down, and any set
PCI_EXP_DEVSTA_URD bit causes aer_print_error() to misreport the fatal error
as UnsupReq and increment the Unsupported Request counter in aer_dev_fatal
(which Documentation/ABI/testing/sysfs-bus-pci-devices-aer says must remain
0).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794997749.gi=
t.lukas@wunner.de?part=3D7
