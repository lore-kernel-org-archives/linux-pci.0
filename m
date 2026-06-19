Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151902F8E98
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 09:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859904; cv=none; b=mfiWSXzdfwnmz0EHu3yJohIHepsJIYKrdf55TYzAymbF67IebkliU8Hg/3raz6B1Md7HXStwMka6NhXQXMhIpjfHq753jnLcBNiPawAiYgL0tsDkj5wmq3JjCrIc9pd9XNSRe0edg5VTgUbRywUZ0m10yCZexM7VxgdUewFvAEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859904; c=relaxed/simple;
	bh=j7hlcMQDuoWFlhfxDUAGimMhA7PO6M1FlM48PmoOYxg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IreGJr9jdPONUclsoDyBPyfE0m+10laa9TsI6SIJ4EbM3U0ti2eKLnIZgAhqKHZGyxyY1AQjB/cCsgwdxua6AOHMPvsAQ40ArGcKx97VaobF8fcGw461eAH9+BPOm4h9BWQbjGXFhtDOlmUENwG8BiBqG10PE2KTT2JfzmmlGfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ynmo3bg4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ynmo3bg4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D261B1F000E9;
	Fri, 19 Jun 2026 09:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859903;
	bh=XY1SwA8s5VUxlTGj1gPedCEUoOfkwcE8Rt+EOpHAvhY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ynmo3bg4LJS8xunBDm1vA1S05MkT6T/eh/2naLKpVdiPZcQhxfY+zzBaOTa4hlzZN
	 W+AHDIako3EHIoJ5hLmEHKP064Ot1B9eiHfIP/2rWYfyOFPpyg7plTaOswFZbGsJN5
	 3PQSTWr/QfeliW2YBmRHVrEPgcUWmyam6knHFskVnF7i2X2VllcNKCrqtfY9MbcOxs
	 xD4Z9yfc6ibCuJ3CLaig6hizUsQwrZqEqLrJaAFfp1rFGNoNkVby0DvZygrKhSJh6o
	 EmiccY7qjtuOSjgKjcCXz3MR5dMnu6NtoLLEkxIrmS3qAMiYY2IKH06zxTWIO2X2Az
	 TKQOX8N661n6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 11/25] alpha/PCI: Add security_locked_down() check to
 pci_mmap_resource()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260619085200.3729431-12-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
 <20260619085200.3729431-12-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 09:05:02 +0000
Message-Id: <20260619090502.D261B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Legacy PCI memory and I/O sysfs files lack lockdown checks, allowi=
ng userspace to bypass LOCKDOWN_PCI_ACCESS.
--

commit 332567893d71a88b42f9b02db5e578329ecec29f
Author: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

alpha/PCI: Add security_locked_down() check to pci_mmap_resource()

Currently, Alpha's pci_mmap_resource() does not check
security_locked_down(LOCKDOWN_PCI_ACCESS) before allowing userspace to mmap
PCI BARs. The generic version has had this check to prevent DMA attacks
when the kernel is locked down, so this commit adds the same check to
Alpha's pci_mmap_resource().

> diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
> index 3048758304b57..2324720c3e83f 100644
> --- a/arch/alpha/kernel/pci-sysfs.c
> +++ b/arch/alpha/kernel/pci-sysfs.c
[ ... ]
> @@ -71,7 +72,11 @@ static int pci_mmap_resource(struct kobject *kobj,
>  	struct resource *res =3D attr->private;
>  	enum pci_mmap_state mmap_type;
>  	struct pci_bus_region bar;
> -	int i;
> +	int i, ret;
> +
> +	ret =3D security_locked_down(LOCKDOWN_PCI_ACCESS);
> +	if (ret)
> +		return ret;

[Severity: High]
This is a pre-existing issue, but since we are adding lockdown checks here
to prevent DMA attacks, do we also need similar checks in the legacy PCI
memory and I/O sysfs handlers?

For example, arch/alpha/kernel/pci-sysfs.c:pci_mmap_legacy_page_range()
allows mapping PCI memory/IO but doesn't seem to check kernel lockdown
status.

Additionally, the generic legacy handlers in drivers/pci/pci-sysfs.c
(pci_write_legacy_io(), pci_mmap_legacy_mem(), and pci_mmap_legacy_io())
also appear to lack security_locked_down() checks. Can a privileged user
bypass kernel lockdown using these legacy interfaces?

> =20
>  	for (i =3D 0; i < PCI_STD_NUM_BARS; i++)
>  		if (res =3D=3D &pdev->resource[i])

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619085200.3729=
431-1-kwilczynski@kernel.org?part=3D11
