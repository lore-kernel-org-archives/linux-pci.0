Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A903EDAD2
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783343548; cv=none; b=MnE0LYym4Od2v56sgbyLEclCihpiql0tUH9vsabMEQmAX72SVOW2OVU0a3cCDQmVZ90HwfOuRll2nCwtV2S6e/pkJH7wmzgH6hy4MEddmuYIktM0cMrHodLD793BagQBcv7xpfDhHvRPcSuelwFa3Z+lp0X+dBi5SAm6fHEJFdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783343548; c=relaxed/simple;
	bh=q8zE/niDhrvBmh7CW6UIB9eDzUHKR5H645+nG3yKDwQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r2rosMmEGFvWaycOrMItQPaK4Fe8nI9awNKw+QestEFD/3VLXmk8m1q8kzcj7SpqMw1KScRswJEc+v1RKVxSDzH6v2PgcaPhP26E1y2lrmQVTJUyJxiZZSIw8kkANozLhaeldZPs5Rmu5ilmI7Jf+5YDB6Th/OP4E50j1DoX9f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGI+ayW8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGI+ayW8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC6B1F000E9;
	Mon,  6 Jul 2026 13:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783343546;
	bh=gLIqp45KvgqfKScCoHAJLRAwaHteq5+tRvneJIt1q/o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eGI+ayW8s6H4+t3ywNwE98bXzkKO5aB2Q15L8D/wI4esDr7Afi1KFMKCER6EWqbr0
	 liKGjuDgDGDmrZ0w+CcHnRD9SQh7x71/6vs272g3b+3tywfEgUW7EX5c8a4Kt6/OfR
	 qWZ4SWAQR8PS2GqJjqtkKwY/iacSuOTXySRk53vQi/r+I/HS/NqYYY06eMbYiXHeYx
	 2023xxW/rO5KC8oEkcCEcJLbkyZukI66cDOZkUa7NQBY9Chxx/20DzNmSFYIFqUdrp
	 WEk1zYMV6EQb+nXiMDzx+74nC7WESE/YeXrNSFQfzNKYQ9aHWUnGyUHOO0LslgBjBZ
	 zvhpbC/py/hlg==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND RFC PATCH] PCI: Get the hotplug bridge window sizes
 from DT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260706130230.546108-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20260706130230.546108-1-manivannan.sadhasivam@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 13:12:25 +0000
Message-Id: <20260706131226.4DC6B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Command-line parameters matching default hotplug window sizes ar=
e incorrectly overridden by Device Tree sizes.
--

commit a20e61c301c97bb0b8018d5f602c3d28d1cc752e
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

PCI: Get the hotplug bridge window sizes from DT

This commit allows parsing the 'ranges' property from PCI bridge device tree
nodes to define hotplug bridge window sizes based on firmware requirements.
The DT sizes apply as additional reservations for the bridge windows.
Command-line overrides are intended to continue taking precedence over the
DT settings.

> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index c0a949f2c9956..3fbd097728bd6 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c

[ ... ]

> @@ -1430,9 +1480,34 @@ void __pci_bus_size_bridges(struct pci_bus *bus, s=
truct list_head *realloc_head)
>  	case PCI_HEADER_TYPE_BRIDGE:
>  		pci_bridge_check_ranges(bus);
>  		if (bus->self->is_hotplug_bridge) {
> +			struct resource dt_io =3D {}, dt_mmio =3D {}, dt_mmio_pref =3D {};
> +
>  			additional_io_size  =3D pci_hotplug_io_size;
>  			additional_mmio_size =3D pci_hotplug_mmio_size;
>  			additional_mmio_pref_size =3D pci_hotplug_mmio_pref_size;
> +
> +			/*
> +			 * If the bridge has a DT ranges property, use that to
> +			 * override the default window sizes. Command line
> +			 * parameters (hpmemsize etc...) take precedence over
> +			 * DT.
> +			 */
> +			if (pci_bridge_of_get_window(bus->self,
> +						     &dt_io, &dt_mmio,
> +						     &dt_mmio_pref)) {
> +				if (dt_io.flags &&
> +				    pci_hotplug_io_size =3D=3D DEFAULT_HOTPLUG_IO_SIZE)
> +					additional_io_size =3D
> +						resource_size(&dt_io);
> +				if (dt_mmio.flags &&
> +				    pci_hotplug_mmio_size =3D=3D DEFAULT_HOTPLUG_MMIO_SIZE)

[Severity: Medium]
Will this correctly honor command line parameters if the user explicitly
requests the default size (e.g., pci=3Dhpmemsize=3D2M)?

The commit message states that command line parameters continue to take
precedence over DT. However, checking against the default macros here fails
to distinguish between an unconfigured state and an explicitly configured
value that equals the default size.

If a user explicitly passes pci=3Dhpmemsize=3D2M to restrict a large DT-pro=
vided
window size, wouldn't this condition incorrectly ignore their command-line
parameter and apply the DT size instead?

> +					additional_mmio_size =3D
> +						resource_size(&dt_mmio);
> +				if (dt_mmio_pref.flags &&
> +				    pci_hotplug_mmio_pref_size =3D=3D DEFAULT_HOTPLUG_MMIO_PREF_SIZE)
> +					additional_mmio_pref_size =3D
> +						resource_size(&dt_mmio_pref);
> +			}
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706130230.5461=
08-1-manivannan.sadhasivam@oss.qualcomm.com?part=3D1
