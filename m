Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E62C35E1B1;
	Wed, 15 Jul 2026 14:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124571; cv=none; b=TiiagYfWdxCrIRoFnlUL8wHpL1UOz5eeFpqgyeM+7F0Sp9bsn4nCr0FwEgxST7+abxVbUIsfYqgLBcwKsZKTs1dNXqLjkEucTS7rwYHIEjjkVQQczag/YrZV7OX1IJFu9buTsU6gQhfpv473MFZcSRacoaW6dZiI/Mptr4RZ1o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124571; c=relaxed/simple;
	bh=M4Jem1LZ25shuyCknWPEWFS9wuoe0XDyY9ZFE1Ag6Bs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rCEPIJrdLAluYktkYUoVKDB7bEOuwpwSkz0PasssyeNqGIbzIBWZqacRBNQuLSGFBjliNVqZpPEpuTa5AZaPuQhtnqgwgCHsZlsUM/bt0zWq1Ol8NGMZGdhcJcULbvfBJUEwGkZFF6859RPyFrLynNEMvLmR7zcS5c2cg5j5LqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6GfIdNi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6GfIdNi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A08B1F000E9;
	Wed, 15 Jul 2026 14:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784124569;
	bh=FBD/7eQnjK8rzn8PSfUS5k0D+AJUQRdOEewTAalPnWU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K6GfIdNiZ4ebU8dgVFsgAZSR5DdsIOUVs+mgg+QRsiWQnSsQReSsETw1uTvXebIZu
	 EyZzq8S7y/VuBtdCSEQfjYeeik+TfqOktpwOsJUi4yN11pCgl8W5MaWCBv7p5T7rzg
	 g3DLTzDA7KmYUpWPIcLrPe9ssSCzPksYG9KAc2dMyEDkUWPy7n3sMy0zgPC0/Xd/aU
	 GbfYiRt7jzxIoE4cm7DpVsJxlimZyThKa2+owBDZoLvE8zELtdV+cZcg/XsqdChTec
	 MG+bWv3qtWKr6ZzJninzt+wseZXBKqnmGBMaINyC3Yidl1KIg1vH246i3gXh8BvgpJ
	 XNjWhTDkg6eew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] ACPI: PCI: Clear driver_data on all paths that free
 the acpi_pci_root
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen Pei" <cp0613@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260715135048.3278-1-cp0613@linux.alibaba.com>
References: <20260715135048.3278-1-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 14:09:29 +0000
Message-Id: <20260715140929.9A08B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Clearing `device->driver_data =3D NULL` followed immediately by `k=
free(root)` leaves a Use-After-Free race window for concurrent lockless rea=
ders.
- [High] Publishing `root` to `device->driver_data` before full initializat=
ion and without memory barriers allows readers to see uninitialized fields.
--

--- Patch [1]: [PATCH v2] ACPI: PCI: Clear driver_data on all paths that fr=
ee the acpi_pci_root ---
commit df0768c14918e7decb436f5ec80561fb6dbd2aed
Author: Chen Pei <cp0613@linux.alibaba.com>

ACPI: PCI: Clear driver_data on all paths that free the acpi_pci_root

This commit fixes dangling pointers in the ACPI PCI root code by ensuring
device->driver_data is cleared to NULL before the root bridge structure
is freed in both error and removal paths.

Link: https://sashiko.dev/#/patchset/20260526025118.38935-1-cp0613@linux.al=
ibaba.com
Link: https://sashiko.dev/#/patchset/20260707121258.11640-1-cp0613@linux.al=
ibaba.com

> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 4c06c3ffd0cbb..408ba12362a79 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -725,7 +725,6 @@ static int acpi_pci_root_add(struct acpi_device *devi=
ce,
>  		dev_err(&device->dev,
>  			"Bus %04x:%02x not present in PCI namespace\n",
>  			root->segment, (unsigned int)root->secondary.start);
> -		device->driver_data =3D NULL;

[Severity: High]
This isn't a bug introduced by this patch, but does the earlier assignment
of device->driver_data =3D root allow readers to see uninitialized fields?

Earlier in acpi_pci_root_add(), the pointer is published to
device->driver_data before critical fields like root->bus are initialized
later in the function:

acpi_pci_root_add() {
    ...
    device->driver_data =3D root;
    ...
    root->bus =3D pci_acpi_scan_root(root);
    ...
}

If a concurrent caller (such as bus_for_each_dev iteration in
cxl_acpi_probe()) fetches the root object, could it observe a NULL root->bus
and dereference it before initialization is complete?

Furthermore, without memory barriers, could the CPU reorder the
initialization such that readers observe partially written state?

>  		result =3D -ENODEV;
>  		goto remove_dmar;
>  	}

[ ... ]

> @@ -765,6 +764,7 @@ static int acpi_pci_root_add(struct acpi_device *devi=
ce,
>  	if (hotadd)
>  		dmar_device_remove(handle);
>  end:
> +	device->driver_data =3D NULL;
>  	kfree(root);
>  	return result;
>  }

[Severity: High]
This is a pre-existing issue, but does clearing device->driver_data
immediately before kfree(root) leave a use-after-free window for concurrent
lockless readers?

If a lockless reader like hisi_pcie_handle_error() or add_host_bridge_uport=
()
calls acpi_pci_find_root(), it reads device->driver_data without taking a
lock:

acpi_pci_find_root() {
    ...
    root =3D acpi_driver_data(device);
    ...
}

If the reader fetches the pointer just before device->driver_data is set
to NULL, and then this code proceeds to kfree(root), wouldn't the concurrent
reader dereference freed memory?

> @@ -788,6 +788,7 @@ static void acpi_pci_root_remove(struct acpi_device *=
device)
> =20
>  	pci_unlock_rescan_remove();
> =20
> +	device->driver_data =3D NULL;
>  	kfree(root);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715135048.3278=
-1-cp0613@linux.alibaba.com?part=3D1
