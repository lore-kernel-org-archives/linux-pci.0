Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43A83A450A
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 17:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788195615; cv=none; b=m27ZcFWb4niWaGzxygto4tiCqqjDBql3fTP0IO5YQi5Yr/2jUdkiD/Vax4RysqYepnvCViZDg1FGjecn7qMwUz2WbmDryXPdbG1zFDEqBQ7krMCPVWo4lDKl9YJ1CnjZwCOyEEOBYBQ4fABwuy4b2rllSGST9tIw0tBzdYOW9ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788195615; c=relaxed/simple;
	bh=m0CzPQo/nJfH6dE5cS9dxQLq7UsIVfId+GlcA8b7/FM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=emE9vAvDdfFl/eIBRSk2H+P6X6C2/vhIp6fKgP4pPyuv5iHMPAUTu+2dnqv7e7en3g5SfNkBrOY6eBHnBauhFgBrHGehFxxVyYYkQLV3nyYx5ehMFR+ur5mVOgbdNVmgOuCG3wgmtPRmHKkEY7ftj1kpXM+uOcQevl4680RdoEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6FT434K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6FT434K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DB51F000E9;
	Mon, 31 Aug 2026 17:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788195614;
	bh=gIyxOoToC35hO8lSJG/pKcuysVGKqqdklJrwigeC5CA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d6FT434K5A0+bjL1uND4/lY86hjzEgEujvG+wutXHZi+PPl7+4GeiaNY1eKcM92aT
	 6W/ygqC85E/J3sOpPs/5MgsXqlj6HqvyJbqVaWfhHbK3IsqfSd0poy/X2WAikcxSW/
	 qBeClceozJda+uSGgGNQUiLR5C/zg99s/KqktKqfkB2Tj24BF9q7Hbcp/nBURlgfK1
	 kL373mm7m76JzsVkdDyFPbCRjlD2NPJZ1cbjwf1g8I0/FtR80XT6xhKUFVkxGe5Sok
	 18XpKJUgWFL6toQZw1YsVF1qddkEGkOIK0dRR146qOioFUKqMzjZOKtM5el3rcZ6bE
	 /q2SbmaBZlIEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] PCI/sysfs: Use kstrtobool() to parse
 the ROM attribute input
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260831133314.4125787-534-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-534-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 17:00:13 +0000
Message-Id: <20260831170014.28DB51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unlocked read-modify-write of the `rom_attr_enabled` bitfield in `=
struct pci_dev` exposes a data race.
--

commit ede1ff2652bff89ab4ad252e8e7e79bb533b4702
Author: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
PCI/sysfs: Use kstrtobool() to parse the ROM attribute input

This patch modifies pci_write_rom() to parse sysfs input using kstrtobool().
It ensures that the ROM attribute is properly disabled even when a trailing
newline is missing from the input, and it rejects invalid inputs with -EINV=
AL.

Link: https://patch.msgid.link/20260612182448.552406-1-kwilczynski@kernel.o=
rg

> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1336,18 +1336,19 @@ void __weak pci_remove_resource_files(struct pci_=
dev *dev) { return; }
[ ... ]
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
This is a pre-existing issue, but does this unlocked assignment expose a
data race?

In include/linux/pci.h, rom_attr_enabled is declared as a bitfield:

    struct pci_dev {
        ...
        unsigned int rom_attr_enabled:1;
        ...
    };

This bitfield shares a 32-bit machine word with other dynamically updated
fields like is_probed and irq_managed.

Since C bitfield assignments compile to non-atomic read-modify-write
operations on the underlying machine word, could a concurrent write to the
rom sysfs attribute race with updates to these other bitfields?

If a privileged user writes to the rom sysfs attribute concurrently with the
device being probed (where is_probed is toggled) or its IRQs being
configured, could this silently corrupt the word and result in deadlocks in
VF probing or IRQ resource leaks?

> =20
>  	return count;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-534-sashal@kernel.org?part=3D1
