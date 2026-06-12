Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C892F352031
	for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781289357; cv=none; b=T33uncj1ottXNd7MD/m94USM8d9bprVFTY5T4Ar9Yo4FlvPhpu/ntjCtR3osh9JjPEYK8H9igzgnY+Ft9/R7BSuTMqaIjMqlEHocBOqEpTHx3AP5bha556LvUhsQRKjTL/0Mqw8oZcfdE4UNbFgKWifKkNEokJoPMUWLPZBNof8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781289357; c=relaxed/simple;
	bh=Q+QjoteTdeII9kTYT+eL9pE62jtaxFaffxiKneuy6Yo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CrwCxadEoxU56tyzvsOfozSAT0jmX08y+YsnwpT+PV3xU8TV5JE4x9zkTjEvM1sPdnlMCLf1ntTPL54JLJdjhfcb0UJERVH6giXjw7r+MqrW0fWcYugju5tKqItEsyLCREfC659tFaeoTYHkCC9VEZumarDYsoBoTIBE+8G9ztg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9RpJneW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9RpJneW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C5D1F000E9;
	Fri, 12 Jun 2026 18:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781289356;
	bh=0lUc8uCS0GVs6NUKLZ7j5QSLJGI2u2C31lp6Hp2nyd0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f9RpJneWm2AdtiQYDidiCulUeRysgDNEnbx/Oy/aoYLjEq2KSz+LZH8ol6rqOSi7d
	 0iE9mnuGn5yyrA8f6YbZv5VMArE4Poma4IV2lEPgzSlLgCvnzLu9uGl5n7+hT8Sr59
	 L+1HgUUqodO8hnBC4y1wz0T7iPyJ88bVv9v+eSlrD+enEwQtMWlSEeUJs1oVhawMrp
	 DAPBYf7gPijH3sIHUVZpiKYsGib7LJTqTxCFDOgp9YOHes4Wn7gDxnXu+yHbP8FOIA
	 Blp+r6isgxBr/tVkuQlQW/g70jwWRui3LL0+Oc2sF8wqqBI2fJgKDHI8hOChaqAa/g
	 NfGUHx8yQSbdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/sysfs: Use kstrtobool() to parse the ROM attribute
 input
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260612182448.552406-1-kwilczynski@kernel.org>
References: <20260612182448.552406-1-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 18:35:55 +0000
Message-Id: <20260612183556.47C5D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unprotected modification of the `rom_attr_enabled` bitfield causes=
 a read-modify-write data race with other device state flags in `struct pci=
_dev`.
--

commit f2195cc9fc7471560c4231d0af873e622171b383
Author: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

PCI/sysfs: Use kstrtobool() to parse the ROM attribute input

This commit changes the sysfs PCI ROM attribute handler to use kstrtobool()
for parsing user input instead of manually checking for "0\n". It ensures
that common boolean inputs are handled correctly, with or without trailing
newlines, and rejects invalid inputs with -EINVAL.

> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index d37860841260c..1ddd6be25d956 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c

[ ... ]

> @@ -1309,18 +1309,19 @@ void __weak pci_remove_resource_files(struct pci_=
dev *dev) { return; }
>   * @off: file offset
>   * @count: number of byte in input
>   *
> - * writing anything except 0 enables it
> + * Writing a boolean value enables or disables the ROM display.
>   */
>  static ssize_t pci_write_rom(struct file *filp, struct kobject *kobj,
>  			     const struct bin_attribute *bin_attr, char *buf,
>  			     loff_t off, size_t count)
>  {
>  	struct pci_dev *pdev =3D to_pci_dev(kobj_to_dev(kobj));
> +	bool enable;
> =20
> -	if ((off =3D=3D  0) && (*buf =3D=3D '0') && (count =3D=3D 2))
> -		pdev->rom_attr_enabled =3D 0;
> -	else
> -		pdev->rom_attr_enabled =3D 1;
> +	if (kstrtobool(buf, &enable))
> +		return -EINVAL;
> +
> +	pdev->rom_attr_enabled =3D enable;

[Severity: High]
This isn't a bug introduced by this patch, but does modifying the
rom_attr_enabled bitfield without holding device_lock() cause a
read-modify-write data race with other bits in the same word?

The rom_attr_enabled flag is defined as a 1-bit bitfield in struct pci_dev
alongside other critical operational flags:

include/linux/pci.h:struct pci_dev {
    ...
	unsigned int	irq_managed:1;
    ...
	unsigned int	is_probed:1;
    ...
	unsigned int	rom_attr_enabled:1;
    ...
}

Because pci_write_rom() is invoked directly from the sysfs VFS write path,
it does not implicitly hold device_lock() or any PCI-specific synchronizati=
on.

If a privileged userspace process writes to the rom sysfs attribute while
another kernel thread is binding a driver (which modifies is_probed) or
enabling the device (which modifies irq_managed), the two CPUs might race
on the shared memory word.

Could this data race silently discard concurrent updates, potentially causi=
ng
issues like a nested work_on_cpu() deadlock if is_probed is lost, or an IRQ
resource leak if irq_managed is lost? Would it be safer to use atomic bitops
or acquire device_lock() when modifying this state?

> =20
>  	return count;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612182448.5524=
06-1-kwilczynski@kernel.org?part=3D1
