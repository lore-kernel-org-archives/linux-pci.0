Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A87B3859D4;
	Fri, 18 Sep 2026 03:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789702364; cv=none; b=HgGqKsgLD6BXxR/yWqHmu5nmA76/0hx6gIKTE5HgwXYAUSZ4XN4Fviu7ItJRiNiRwAaG4yfNmVTxG49H3nkM2n1ry3wJLk7LBV+7pEaLiHc1zBzbV5LtOhl0jiX+CwHB6jjhCjpQrzRbiqSgUp3oAmkghGq0peIYlYinNCZwxAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789702364; c=relaxed/simple;
	bh=QXkvYEWif64QiUarS4NBf0jJCdTAi0/F8OOAM9D7jp8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ho4dJVCFg8yB2/m4iUbrv7Dqik46mvV8mlROMOKom/rh3xNUDsk1Fhs3o+PGVs1k41bHR3pTCE2B2ZRtkuJKKAeu/JC0znJ6d4KV1/QYE4VRFghPh9kaksyoti/67UbLx2saHRp1KvZvGUEE7yfk9igwoLIQYW8GBYnxfTmEbF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4KepfVB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4KepfVB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BE61F00893;
	Fri, 18 Sep 2026 03:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789702362;
	bh=9171z1+EyEClcZZF9Cnmp7lwOoxbC75GOp0RO15OMFU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X4KepfVBKdrsTiqNXwjF8VVBMV3ta5PYOgsNlNXZkgWutYEuzaiF6ej8Ca53MTMHW
	 Xzj49eFmLpcvCiY9hz/dRArK5PXmWDw0D5iG1NHCQteWoF5Zqm6A4bTZNkPCFNJOrR
	 W5mLQQqUSbnfxxRGqm0OBKranEjW+Aik78wPC/RCroAUnO5+sN2f+0O2M808goUkDn
	 EuQ7jJmM7ZJa9/lU6bNeFy9KoA7Wi8OUVg7RRh7jE8MWqFlbfo8GGYuaxsJM6lJ/sa
	 gLqkBYwax2HcjiQ2oEYKk2KrWWdFA7sRBb/PuiTN8fImrXmuZ31eoCuse9/yloTU4v
	 hVy9RC75vN5KA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/11] PCI: dwc: Add a host op to run before iMSI-RX
 status is read
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org
In-Reply-To: <20260918032038.2216471-5-den@valinux.co.jp>
References: <20260918032038.2216471-1-den@valinux.co.jp>
 <20260918032038.2216471-5-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 03:32:41 +0000
Message-Id: <20260918033242.55BE61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] PCI: dwc: NULL pointer dereference in dw_chained_msi_isr()
--

commit 3a93530b14d46331da98ba1bc4fa4fde8fc72e4b
Author: Koichiro Den <den@valinux.co.jp>

PCI: dwc: Add a host op to run before iMSI-RX status is read

This commit adds a pre_msi_irq host callback invoked from the generic chain=
ed
handler before the MSI status is read. Returning true skips the MSI handlin=
g,
which prevents stalls when DBI accesses are issued right after an unexpected
link down.

> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/=
pci/controller/dwc/pcie-designware-host.c
> index f5a38e6fd8d79..ad013dd0a1662 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -95,7 +95,8 @@ static void dw_chained_msi_isr(struct irq_desc *desc)
>  	chained_irq_enter(chip, desc);
> =20
>  	pp =3D irq_desc_get_handler_data(desc);
> -	dw_handle_msi_irq(pp);
> +	if (!pp->ops->pre_msi_irq || !pp->ops->pre_msi_irq(pp))

[Severity: High]
Does this introduce a NULL pointer dereference when pp->ops is NULL?

Some glue drivers (like qcom_pcie_ecam_host_init) explicitly bypass
dw_pcie_host_init() and do not provide a pp->ops structure. On these platfo=
rms,
pp->ops is left NULL since the structure is zero-initialized via devm_kzall=
oc().

When the chained MSI interrupt handler fires during normal system operation,
evaluating pp->ops->pre_msi_irq would unconditionally dereference the NULL
pointer and crash the kernel.=20

Would it be possible to add a safety check for pp->ops before checking for
the pre_msi_irq callback?

> +		dw_handle_msi_irq(pp);
> =20
>  	chained_irq_exit(chip, desc);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918032038.2216=
471-1-den@valinux.co.jp?part=3D4
