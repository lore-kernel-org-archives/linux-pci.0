Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515B43A873B
	for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 03:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779765122; cv=none; b=Vdn9zT4G8uOi+7IwtYCoRdUpV6ADXJooxVtPCgqjddz9LL3r8Dc8T5bZVnKRnfqsXW+A7uorUK5N8JVgQWp7g2BCcEh8aUuQz4iI6o7+eEMyqOvgIb5EC4u/deYakRdaI1xpPSzHf2tb/Juuer2Px9xO626NGiO8OY44lRmxXiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779765122; c=relaxed/simple;
	bh=CuUdkwIzArnudW+SNmXdBm1exvaNbX+pPlCcw9dYpk4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SYdNnHK4xe1UhxTBPqQmC6tZqp3e3mnmoO8nxglRG5sE8wtwTOrkL1GRlL9lnT5jTXVXLEmSNJVnEnqra+REVrqa7G3eCmcVs2rXu0g3kABkOk9IYc7Rje5RtiMWH+AaDlHU//l1l2jYr0U5MP6lvtCs13INUb9M2l/4NopHzqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtJgNocd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtJgNocd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19341F000E9;
	Tue, 26 May 2026 03:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779765120;
	bh=zG5gY09pj4RukzHlpdn1ItI97cOyxSCK1M82wlDnw80=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UtJgNocdobsMo7q/Q/ZBbBPKBSHAMFQSA68DWjYWj2uPwaRkowfXNaAU2bZf1Efta
	 +2ext/0rD4WNhgY/8JZxKfZRlQxkpo2bL6+PjBCFaXdOZbEhi4ptiLjy5CNp4Lb9O5
	 Y58AuGzKRHGkcgazlcxl9sL2MQ4MdQ5M+cH5xkyt8UoeTgJW+/PueALKCswTCr0J/6
	 BHNCvatH0FrgMlNXPXFaV3d5BFVWxxhRe8ZjMnhT5364+MHoKdiZ6990r/f2yLq2l2
	 tuPLsd4B1f0/vjoPHncGTUSflXuxI0ycDsp2Roo2WiR0B4uB8ba8ZNF98CblrSpHTd
	 Ej3hOq8gq4C6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] ACPI: PCI: Clear _DEP dependencies after PCI root
 bridge attach
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen Pei" <cp0613@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260526025118.38935-2-cp0613@linux.alibaba.com>
References: <20260526025118.38935-2-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 03:12:00 +0000
Message-Id: <20260526031200.C19341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] acpi_pci_root_add() leaves a dangling pointer in device->driver_da=
ta on the dmar_device_add() error path.
--

commit c50bc9cc7a48e4b92d2f6107b97e5bdf5d2b47a4
Author: Chen Pei <cp0613@linux.alibaba.com>

ACPI: PCI: Clear _DEP dependencies after PCI root bridge attach

This commit clears _DEP dependencies at the end of acpi_pci_root_add(),
allowing consumers like ACPI0017 CXL root devices to safely enumerate
once the PCI root bridge has been attached.

> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index a0ba64e45e8ab..4c06c3ffd0cbb 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -755,6 +755,10 @@ static int acpi_pci_root_add(struct acpi_device *dev=
ice,
>  	pci_lock_rescan_remove();
>  	pci_bus_add_devices(root->bus);
>  	pci_unlock_rescan_remove();
> +
> +	/* Clear _DEP dependencies to allow consumers to enumerate */
> +	acpi_dev_clear_dependencies(device);
> +
>  	return 1;
> =20
>  remove_dmar:
>  	if (hotadd)
>  		dmar_device_remove(handle);
>  end:
>  	kfree(root);

[Severity: High]
This is a pre-existing issue, but does the dmar_device_add() error path
leave a dangling pointer in device->driver_data?

Earlier in acpi_pci_root_add(), the allocated root object is assigned to
device->driver_data:

	root->device =3D device;
	root->segment =3D segment & 0xFFFF;
	device->driver_data =3D root;

If dmar_device_add() fails during a hot-add, the code jumps to the end
label and frees the root pointer via kfree().

However, it doesn't explicitly reset device->driver_data to NULL, unlike
the later pci_acpi_scan_root() error path. Since the ACPI core does not
automatically clear driver_data on an attach failure, could subsequent calls
to acpi_pci_find_root() by other subsystems fetch and dereference this freed
pointer?

>  	return result;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526025118.3893=
5-1-cp0613@linux.alibaba.com?part=3D1
