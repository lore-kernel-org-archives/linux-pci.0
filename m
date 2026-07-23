Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E6A37F006
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784833831; cv=none; b=IauL4JZNIegI4XOBULHfgF3wrKbrZP/Snv+wQ6QlDPL4ae7vRzKY2/6fDFrVGE8+dBDrahaLL6yo9eysEyD5IZKgXMiPr8qyubFbxs7aUhl6RNkOeTAPsgFTHXQMG5vWK1gBqYzBFLbzWD0yAtGdDr+PQVn/Ktu+OKmog5U/a5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784833831; c=relaxed/simple;
	bh=myWfweHgK6D5XxHWqXGpkcjhqe4N2uXUvtkPrCZw3G4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=awGD76egWNk5tZSwY71OrFiDWfGlhwcIRl8a4Ev0k8HB5gNv9KuZ6xxiu5Cgis7GKM8DyzMUA65WWBlrO4mQU22ere0WFWo1NOdXxr9ZJWF1TSOGJ8BG6eLraDSL7HSZ9+RKxFCME6lhd/e7U59a3M36KrsWQrhhm4L9q2rBUhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF151F00A3A;
	Thu, 23 Jul 2026 19:10:27 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] pci_crash: capture PCI config space at panic time
Reply-To: sashiko-reviews@lists.linux.dev
To: hangej <hangej@amazon.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260723185216.1089927-1-hangej@amazon.com>
References: <20260723185216.1089927-1-hangej@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 19:10:26 +0000
Message-Id: <20260723191027.3DF151F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] An out-of-bounds write corrupts the crash capture buffer if a de=
vice's cfg_size is not a 4-byte multiple.
--

--- Patch [1]: [PATCH v4] pci_crash: capture PCI config space at panic time=
 ---
commit 453754eacce8780b38337ecf239a5ffdf63c4b25
Author: Johannes Hange <hangej@amazon.com>

pci_crash: capture PCI config space at panic time

This commit introduces a facility to capture PCI configuration space during
a kernel panic. It allocates a snapshot buffer updated via bus notifiers and
fills it using non-blocking config reads when a panic occurs. The resulting
buffer and pagemap are exported through VMCOREINFO for crash analysis.

> diff --git a/kernel/pci_crash.c b/kernel/pci_crash.c
> new file mode 100644
> --- /dev/null
> +++ b/kernel/pci_crash.c
[ ... ]
> +static void pci_crash_read_config_space(struct pci_dev *pdev, u8 *ptr,
> +					unsigned int cfg_size)
> +{
[ ... ]
> +	if (!pci_crash_endpoint_reachable(pdev)) {
> +		memset(cfg_data, 0xff, cfg_size);
> +		return;
> +	}
> +
> +	for (offset =3D 0; offset < cfg_size; offset +=3D 4) {

[Severity: Medium]
Could this loop write out of bounds if cfg_size is unaligned?

Since this code executes during a panic where memory corruption is common,
pdev->cfg_size could potentially be corrupted to a value that is not a
multiple of 4. If that happens, the loop will unconditionally write 4 bytes
on its final iteration, which could overflow the allocated payload slice
for this device.

This might either corrupt the adjacent record's header or cause a double
fault if the final write crosses a vmalloc page boundary.

Would it make sense to align cfg_size down to a 4-byte boundary before
iterating, or clamp the final write to prevent it from going past the end
of the buffer?

> +		if (pci_bus_read_config_dword_trylock(pdev->bus, pdev->devfn,
> +						      offset, &val)) {
> +			put_unaligned_le32(0xFFFFFFFF, &cfg_data[offset]);
> +			continue;
> +		}
> +		put_unaligned_le32(val, &cfg_data[offset]);
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723185216.1089=
927-1-hangej@amazon.com?part=3D1
