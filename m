Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4705172618;
	Tue,  7 Jul 2026 12:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427151; cv=none; b=jkE64U6bSWwjNNQojmEEYQn67JRjMz908QGDcOQJxy3q4glTfTSRwQAW6HAU0UnBbgIdOB+fxmEUOJFeilkve5qL5gULuA+6XvajWI4nM7yJoAI1uBvzoxjXDW+8aqekzvrcxjU8xx2CspYnDHnwleHAxfJQga+vlaTOc6snQFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427151; c=relaxed/simple;
	bh=UYvNxijBe/3Ivk8Yo9dubW0mvGYvgBmWfX496CK+Cgg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XV9Dd6VOue/Eb8yCsGfnHDZHrk6fQPzfNSYe/gPYXFRhLqDGvjnoC0yyXMLdTv49IlbZO65hQKIFBMLEvu3it5Hv4rihGNy4MA8SsNuNZoE/pID0VncD/qBN/7vq+d/apXniBZDYIyagZngYvm2c4kFBwO5VM4gST42k5YtKGjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+ifYoZw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+ifYoZw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01DC1F00A3A;
	Tue,  7 Jul 2026 12:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783427150;
	bh=EKSWpzh6lCKrvS0lzypcJqlfMI3yNPxs82RMjbFJpZw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B+ifYoZwnS0JTwf136Z5N6Der2pj7ZDax9hbXmwZWhSPa0BWypJYRkItghLWeLJMr
	 vfL7fvhbPzlxexO0jF0bWnjOnRsgzsOjSdgKC//N5P48L3xJd+fhWO5hKJk0/9u8E5
	 nY27ogBeuM2QM5XY8P+Wf6zt9QTW+FCRTrHN/JOWH8DfKXNd5IMn13WRAMU5bM7/bh
	 4bsjfAU0OLK/LxsM62fETc81vt+p+WwWyLmua/c41UbCWcmlzxdiktF7MMYju5bfUs
	 jZfDAtK8hEQEJO+yFgPQXxyZGfC6AzpA0F2Ihh+Fn6SGGiEN9POVqNpS+8oUdGEhtt
	 9+kENIipCjdug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ACPI: PCI: Clear driver_data on all error paths in
 acpi_pci_root_add()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen Pei" <cp0613@linux.alibaba.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260707121258.11640-1-cp0613@linux.alibaba.com>
References: <20260707121258.11640-1-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 12:25:49 +0000
Message-Id: <20260707122549.C01DC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The acpi_pci_root_remove() function frees the acpi_pci_root object=
 but fails to clear device->driver_data, leaving a dangling pointer.
- [High] Lockless access to `device->driver_data` causes a TOCTOU Use-After=
-Free race during hot-add failure and hot-remove.
--

--- Patch [1]: [PATCH] ACPI: PCI: Clear driver_data on all error paths in a=
cpi_pci_root_add() ---
commit 9ff3c7d0724a7259ad865b11b68825024947383a
Author: Chen Pei <cp0613@linux.alibaba.com>

ACPI: PCI: Clear driver_data on all error paths in acpi_pci_root_add()

This commit addresses a dangling pointer issue in acpi_pci_root_add() by
ensuring device->driver_data is set to NULL on all error paths before
freeing the root object. This prevents use-after-free conditions during a
failed hot-add operation.

Link: https://sashiko.dev/#/patchset/20260526025118.38935-1-cp0613@linux.al=
ibaba.com

> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 4c06c3ffd0cbb..f6cddd11075cb 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c

[ ... ]

> @@ -765,6 +764,7 @@ static int acpi_pci_root_add(struct acpi_device *devi=
ce,
>  	if (hotadd)
>  		dmar_device_remove(handle);
>  end:
> +	device->driver_data =3D NULL;
>  	kfree(root);

[Severity: High]
This isn't a bug introduced by this patch, but does this lockless cleanup
introduce a use-after-free race with concurrent readers?

If acpi_pci_root_add() publishes the root pointer early:

        device->driver_data =3D root;

and a concurrent thread (e.g., AER or CXL probe) calls
acpi_pci_find_root() and locklessly reads this pointer:

drivers/acpi/pci_root.c:acpi_pci_find_root() {
        ...
        root =3D acpi_driver_data(device);
        ...
}

Could that concurrent reader dereference a freed pointer if
acpi_pci_root_add() subsequently encounters an error, clears
device->driver_data, and executes kfree(root) here without an RCU
grace period or locking to synchronize the read and the free?

[Severity: High]
This is also a pre-existing issue, but while we are fixing the error paths
here, does acpi_pci_root_remove() have the same dangling pointer
vulnerability that this patch fixes for the add path?

Looking at acpi_pci_root_remove(), it appears to free the acpi_pci_root
object but fails to clear device->driver_data:

drivers/acpi/pci_root.c:acpi_pci_root_remove() {
        ...
        kfree(root);
        ...
}

If a PCI root bridge is hot-removed and another subsystem later calls
acpi_pci_find_root(), could it locklessly read the dangling pointer
and dereference it?

>  	return result;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707121258.1164=
0-1-cp0613@linux.alibaba.com?part=3D1
