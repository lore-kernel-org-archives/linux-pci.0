Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD173BB130
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857181; cv=none; b=rPptUQCQNwpJITDPREtyyeHXPhxP5nSZqhchN9KUXPvF/UMR7KwdVKe7Udq8MkaYsG5GDvlX2p0vK2eQJYV9IkpTbAmhViA/NoSU0y2vBzTTS/WFHQ/zjRsCDSgEk3ePWWv2czBhCHV5bKIC9CBEsMGK9lE/RnZ0eJVTwB7fha4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857181; c=relaxed/simple;
	bh=iYkG/wPb5h9L8yGDULwhmR5Ww559eMxry3nrVlVqC9Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OsH1rrD3wqh/CFHE2wpK6er5pan7sdz7xFhz41SFAa1BagNqL3RqzBx3aadZFeQID2rim7QQ2c4sHehP0Ts1t2wGAMOUOC30Ff/jwDO7QxSg7Xn76IIV59JJej9bPse0rF8W2Cx9m9lX7IosqvbeE4b3vwuosAHvvUPl3U4b8B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6UGXIbt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6UGXIbt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85AAC2BCB0;
	Fri, 15 May 2026 14:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778857181;
	bh=iYkG/wPb5h9L8yGDULwhmR5Ww559eMxry3nrVlVqC9Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=l6UGXIbtSXT8FJY48mWXFPH+IjjywBfZkTwTBV7DnDWH4hntsO9BhABKnrLH3xpc0
	 4lTf71EjzN/Ki+U7BTkXkXlxG71EKCVgZ9S3hdLutzT2oSQHCvVIwNtV4lneyJdiio
	 m1Na26kdgfs0TKFvvjeSpw7vBu8I+J9X/cx1iF6FHNDUI+uJY+ReyQpJ/+5VcQuaxg
	 TpSTNOSjl4DlY7vzVSATw+bhj3SHmtIfBsYzlBxxGxt//bsqfl1LwsQh4wOtL4Ccfr
	 maWZcHQveLKjdrW4k9FieGZ7eR69aX8DqulWmOTS4yjspZSO3T9VXLZJ0hAaTIL0bJ
	 PS1/zbhMPIzKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] arm/pci: Use official API to iterate over PCI buses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gerd Bayer" <gbayer@linux.ibm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260515-priv_root_buses-v1-2-f8e393c57390@linux.ibm.com>
References: <20260515-priv_root_buses-v1-2-f8e393c57390@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 14:59:40 +0000
Message-Id: <20260515145940.E85AAC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Calling a sleepable lock from a hardware interrupt handler causes =
a 'scheduling while atomic' BUG.
--

commit f34de1e1be1288e13d00eee56b2fe60eb5f4ec85
Author: Gerd Bayer <gbayer@linux.ibm.com>

arm/pci: Use official API to iterate over PCI buses

This commit replaces iterating over pci_root_buses with pci_find_next_bus().
This change is intended to allow pci_root_buses to become private to the PCI
core.

> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index ac0e890510daf..35642c9ba054c 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -59,9 +59,9 @@ static void pcibios_bus_report_status(struct pci_bus *b=
us, u_int status_mask, in
> =20
>  void pcibios_report_status(u_int status_mask, int warn)
>  {
> -	struct pci_bus *bus;
> +	struct pci_bus *bus =3D NULL;
> =20
> -	list_for_each_entry(bus, &pci_root_buses, node)
> +	while ((bus =3D pci_find_next_bus(bus)) !=3D NULL)

Can calling pci_find_next_bus() from an interrupt handler lead to a
scheduling while atomic bug?

In arch/arm/mach-footbridge/dc21285.c, pcibios_report_status() is called
directly from primary hardware interrupt handlers, such as dc21285_abort_ir=
q()
and dc21285_serr_irq(). These handlers execute in an atomic hardirq context
where sleeping is not permitted.

Since pci_find_next_bus() unconditionally acquires the pci_bus_sem read-wri=
te
semaphore using down_read(), this introduces a blocking operation into that
atomic path:

dc21285_abort_irq() [hardirq context]
  pcibios_report_status()
    pci_find_next_bus()
      down_read(&pci_bus_sem) [sleeps]

Does this path need an alternative approach to safely iterate over the buses
without taking a sleeping lock?

>  		pcibios_bus_report_status(bus, status_mask, warn);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515-priv_root_=
buses-v1-0-f8e393c57390@linux.ibm.com?part=3D2
