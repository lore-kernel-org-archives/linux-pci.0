Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4115A246781
	for <linux-pci@vger.kernel.org>; Sat,  6 Jun 2026 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780766458; cv=none; b=qepd42d35DU3FE4w/Ot45yoIMRYu132mk7+0cSVHTzIUMLARLrBSNDrXDOZagiOQ7kjWrvC/EipXgzj+1fsjkcbY7NlV7sokqTf9G/7zkZQYhgyai6QvdoPUysIq0GBgs1rPK12s9g67D3YiBMf8MMGQCoUXYAmnw2bLYKZOM84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780766458; c=relaxed/simple;
	bh=BhWeWaKF2GV19bOfhIw0ZfAcfl65pvR7gRGhmMCnk5g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gpi5ha5rZm0n+GxxVHdS81QAzU+7sOQ8W7WH+V2FSkUFS1cgLRpNHoBLt8JBpi7LL8qwdpjGuWoMNl+WhL5+zxzWzaB4Dr+PjWHDTNyWZIi4bv5hjmuW0nigMGrPZN5ifPIU4PSUI/dnfg3g7OwrcdUBojk7KNaqsyAZ6N15N6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oaklzdle; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oaklzdle"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADBA1F00893;
	Sat,  6 Jun 2026 17:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780766457;
	bh=oF6JLv7UDS7+7Xd1enwxf0HozS21JRcCEb6cEMGSRPk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OaklzdleDidp6xzLE75pZXoHnwGeb55X9P6xUB9IZcnH5JlHXYyVHVRcppLuqFZP7
	 al/XqhMyyJzJ+eOJtq87b6FpZZjnuQLdY9YMJcr1U+MeHTzK7xfYtuhZds/9wigLI4
	 x1bp1g75FrciSTvdCduYQ+NuJATF1uH635s5ZydBQnl5ZV+HX1f43o0DOfyzu2NVF8
	 nfskfFd6k5rPDQ05IVYeLGMi58S8/SyxlF45Q14g1aEY9fV1JvbIqKj9AzlBOsdWBt
	 gj94nmtagc/AzJhprNjzk3dQHw0d8yXR/3WxvTtf296xNd473b7ZERK2qQxuwKy0aQ
	 CvXnVEwZ1AlHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI/proc: Fix race between pci_proc_init() and
 pci_bus_add_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260606170146.673140-1-kwilczynski@kernel.org>
References: <20260606170146.673140-1-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 17:20:56 +0000
Message-Id: <20260606172056.DADBA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] TOCTOU race leading to Use-After-Free and resource leaks via corru=
pted procfs pointer
--

commit cd2e3cd5b4869787fb5b78b8cfef90b55821ad2b
Author: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

PCI/proc: Fix race between pci_proc_init() and pci_bus_add_device()

This commit attempts to fix a race condition between pci_proc_init() and
pci_bus_add_device() by lazily attaching procfs directories when buses are
created, and by protecting the device iteration in pci_proc_init() with
pci_lock_rescan_remove().

Closes: https://lore.kernel.org/linux-pci/20250702155112.40124-2-heshuan@by=
tedance.com/

> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
> index ce36e35681e8e..a33a246ec8309 100644
> --- a/drivers/pci/proc.c
> +++ b/drivers/pci/proc.c
> @@ -416,34 +416,51 @@ static const struct seq_operations proc_bus_pci_dev=
ices_op =3D {
> =20
>  static struct proc_dir_entry *proc_bus_pci_dir;
> =20
> +int pci_proc_attach_bus(struct pci_bus *bus)
> +{
> +	char name[16];
> +
> +	if (!proc_initialized)
> +		return -EACCES;
> +
> +	if (bus->procdir)
> +		return 0;
> +
> +	if (pci_proc_domain(bus))
> +		sprintf(name, "%04x:%02x", pci_domain_nr(bus), bus->number);
> +	else
> +		sprintf(name, "%02x", bus->number);
> +
> +	bus->procdir =3D proc_mkdir(name, proc_bus_pci_dir);
> +	if (!bus->procdir)
> +		return -ENOMEM;

[Severity: High]
Can this direct assignment overwrite a valid pointer with NULL if a concurr=
ent
creation fails?

If an asynchronous probe runs concurrently without holding
pci_rescan_remove_lock(), two threads might both observe bus->procdir as
NULL. If one successfully creates the entry, the second could fail due to a
name collision and return NULL, unconditionally overwriting the valid
bus->procdir.

Could this cause subsequent child devices to erroneously create their proc
files in the root of /proc?

> +
> +	return 0;
> +}
> +

[ ... ]

>  	sprintf(name, "%02x.%x", PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
> -	e =3D proc_create_data(name, S_IFREG | S_IRUGO | S_IWUSR, bus->procdir,
> -			     &proc_bus_pci_ops, dev);
> -	if (!e)
> +	dev->procent =3D proc_create_data(name, S_IFREG | S_IRUGO | S_IWUSR,
> +					dev->bus->procdir, &proc_bus_pci_ops,
> +					dev);
> +	if (!dev->procent)
>  		return -ENOMEM;

[Severity: High]
Does this assignment introduce a risk of a use-after-free and resource leak?

Similar to the bus directory, if concurrent threads call
pci_proc_attach_device() for the same device, one might overwrite a
valid dev->procent with NULL when proc_create_data() fails.

Later, pci_proc_detach_device() would call proc_remove(NULL) which does
nothing. The procfs file would be leaked, and because the file's data points
to the freed pci_dev struct, subsequent reads from userspace could trigger a
use-after-free.

> -	proc_set_size(e, dev->cfg_size);
> -	dev->procent =3D e;
> +	proc_set_size(dev->procent, dev->cfg_size);
> =20
>  	return 0;
>  }

[ ... ]

>  static int __init pci_proc_init(void)
>  {
>  	struct pci_dev *dev =3D NULL;
> +
>  	proc_bus_pci_dir =3D proc_mkdir("bus/pci", NULL);
>  	proc_create_seq("devices", 0, proc_bus_pci_dir,
> -		    &proc_bus_pci_devices_op);
> +			&proc_bus_pci_devices_op);
> +
>  	proc_initialized =3D 1;
> +
> +	pci_lock_rescan_remove();
>  	for_each_pci_dev(dev)
>  		pci_proc_attach_device(dev);
> +	pci_unlock_rescan_remove();

[Severity: High]
Is this lock sufficient to serialize against lockless async probe paths?

Paths like the VMD driver (vmd_probe() -> vmd_enable_domain() ->
pci_bus_add_devices()) or platform drivers can run asynchronously and do not
always hold pci_rescan_remove_lock().

If an asynchronous probe adds devices to the global pci_bus_type list before
calling pci_proc_attach_device(), and pci_proc_init() iterates the list
under the lock, could both threads still find the new devices and call
pci_proc_attach_device() concurrently?

> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606170146.6731=
40-1-kwilczynski@kernel.org?part=3D1
