Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C314399D8
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785783205; cv=none; b=XICQvSZFdiSQXU2nhaqpz79ZEU+fiCvX2DYKjQfaVdskxVTRqn2jhB/aK6hc/q7L5aSgc3pn0VozA9dyqG8kUybwNGauT6xxlKcQPFYtSVFsEldbjqzxHWOU6fLwY+tCj71tYhQznMWCQJkoKHgUKDln4CZoMS7TbNTCZhBgtLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785783205; c=relaxed/simple;
	bh=cJczj5HN4MY91KnAKJn1guEEsfDS+hkAPO8DXdpegwc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M+ws6U1ENZZsR+eluQazCF8YLFMR/f0dQpkGPnOZyO6R3iC3iW5KyvijpoINYjyN11qRv8cAGrh/OaVPNPsHGC2J5OlFAZK3uMOz+W+m6OdFzRuODRAHVRZxIhnl+hQiLu/Q7GkBS9VyNYOXdC1UltMZHzY7CyatHjjDFKwtT7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASGBLWHJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASGBLWHJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F68E1F000E9;
	Mon,  3 Aug 2026 18:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785783203;
	bh=Khaz4gkPqhrAdKNEwcwG6h9B6o1L7Kn9TSZXrJVL5a4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ASGBLWHJTK3tBZ5dGr2M0VhzvuwDo3tcB6oDqxurCR0uf9I1q4XlTw4xUgDYiRaSh
	 /2/T0VxRrTq/cL16ynGXpkKm7TuGqZV/lEj/vqzpDDtRaQy65Zb/MyZRyrt5yN0cha
	 R8jaVp0lQ3aO53w5D52fyuz0THJIjUrsiFGXzt8RPMtmaOJd+jPDzF3DKOcX+UcqvY
	 z4yWpdeRkhTJe3PGmVhHtngjXefmICrc1zQnCOBAcsc1gAONldo06Pag3U2olF6hGd
	 jB/iAtkdqLhvcRsg8S4qCNkUlsNZu3RwFxG1YIIaMST2I12/Fr2M6WOXKY2ze2jRS1
	 NJZxk0js6Kg3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/AER: Fix memory leak in aer_recover_work_func()
 when pci_dev is missing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260803183853.432459-2-rathodpriyank@google.com>
References: <20260803183853.432459-2-rathodpriyank@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 18:53:22 +0000
Message-Id: <20260803185323.5F68E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory allocated from `ghes_estatus_pool` for `aer_regs` is leaked=
 in `aer_recover_queue()` when `aer_recover_ring` kfifo is full.
--

--- Patch [1]: [PATCH] PCI/AER: Fix memory leak in aer_recover_work_func() =
when pci_dev is missing ---
commit 6bb7331494c5c24e65c258479be47a6a7424c240
Author: Priyank Rathod <rathodpriyank@google.com>

PCI/AER: Fix memory leak in aer_recover_work_func() when pci_dev is missing

This commit fixes a memory leak in aer_recover_work_func() by ensuring
that memory allocated for entry.regs is freed via
ghes_estatus_pool_region_free() unconditionally, even when
pci_get_domain_bus_and_slot() fails to find a matching PCI device.

> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index c4fd9c0b2a548..555f39b60b14d 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c

[ ... ]

> @@ -1242,13 +1241,15 @@ static void aer_recover_work_func(struct work_str=
uct *work)
>  		ghes_estatus_pool_region_free((unsigned long)entry.regs,
>  					    sizeof(struct aer_capability_regs));
> =20
> -		if (entry.severity =3D=3D AER_NONFATAL)
> -			pcie_do_recovery(pdev, pci_channel_io_normal,
> -					 aer_root_reset);
> -		else if (entry.severity =3D=3D AER_FATAL)
> -			pcie_do_recovery(pdev, pci_channel_io_frozen,
> -					 aer_root_reset);
> -		pci_dev_put(pdev);
> +		if (pdev) {
> +			if (entry.severity =3D=3D AER_NONFATAL)
> +				pcie_do_recovery(pdev, pci_channel_io_normal,
> +						 aer_root_reset);
> +			else if (entry.severity =3D=3D AER_FATAL)
> +				pcie_do_recovery(pdev, pci_channel_io_frozen,
> +						 aer_root_reset);
> +			pci_dev_put(pdev);
> +		}
>  	}
>  }

[Severity: High]
This is a pre-existing issue, but while reviewing this fix for the memory
leak in the consumer (aer_recover_work_func), I noticed a similar leak
could occur in the producer (aer_recover_queue).

In drivers/acpi/apei/ghes.c:ghes_handle_aer(), aer_info is allocated from
the ghes_estatus_pool:

	aer_info =3D (void *)gen_pool_alloc(ghes_estatus_pool,
					  sizeof(struct aer_capability_regs));
	/* ... */
	aer_recover_queue(pcie_err->device_id.segment,
			  pcie_err->device_id.bus,
			  devfn, aer_severity,
			  (struct aer_capability_regs *)
			  aer_info);

If the aer_recover_ring kfifo is full (e.g., during an AER storm with more
than 16 errors), kfifo_in_spinlocked() fails in aer_recover_queue():

drivers/pci/pcie/aer.c:aer_recover_queue() {
    ...
	if (kfifo_in_spinlocked(&aer_recover_ring, &entry, 1,
				 &aer_recover_ring_lock))
		schedule_work(&aer_recover_work);
	else
		pr_err("buffer overflow in recovery for %04x:%02x:%02x.%x\n",
		       domain, bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
}

Since aer_recover_queue() returns void, the caller ghes_handle_aer() does
not know if the queueing failed. The else branch logs a buffer overflow but
does not call ghes_estatus_pool_region_free() to release the memory.

Could this exhaust the finite ghes_estatus_pool during an AER storm,
preventing the system from handling future hardware errors like fatal MCEs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803183853.4324=
59-2-rathodpriyank@google.com?part=3D1
