Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0799305682
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859553; cv=none; b=bvBBfA8tfUuoLImMZp2U4O+FyEWd7g62+Ng3BuZvNa+9jqEq6QrqY0zuFg/APTs/mnDlIOZPlX4lwb1a/H+Ph6jJLDWAtDYzWzyNmZSAeW4lt1nSXDOInvORkHF2GTZ2SLliHtcGxsjusVafP32mh3Qm5aLQn6gmsJ5IJvWytvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859553; c=relaxed/simple;
	bh=sA5tMt7fYtHJTlF7/tOrwveaqGWsFzHNiETLe1O4SJE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y4fqwyFJfibJtAI7yHHWMxzimEZCAYCjxdjNK7uVN67IAWAXgXaWXy5bL9jAxWK3odW1w+U06cvWTdXrsJsc/u/sUVrEoQeJ3EpbqtI2GCjBrJsIM56yQat5uigBPpMDAVdewGjod519XDkzGr6YdbukkOSInRhdwaLOPhVDBTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SseuJ8SL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SseuJ8SL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257A8C2BCB0;
	Fri, 15 May 2026 15:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778859553;
	bh=sA5tMt7fYtHJTlF7/tOrwveaqGWsFzHNiETLe1O4SJE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=SseuJ8SLXVFEyzLqhN8Kahx9qvwyuz0TIxlwfurUwYdIWtwmqcleFufgQL48OXVwO
	 kFvxkrjxT90kBU5mmnf5X6TaYkIk+AT1yUoo3/4umYnscWbwEGE89i5g0P/37sCjfH
	 Kkf//Mt3q+8juUwbzRK5bsakkA7MN7vvJDbJRoorDUpNWjll3HjU++x9hcM7Y90WBo
	 chKZnq7REMM1w0sLR2T8OkkWlwgW7zFKFfEYLas2lc3caIozhUpfkpGzILkRPDPwha
	 3AYUNlc/YbfGTmHtiWMQJBgFzT4rjobyL0XD6cO+hac0kkGRV5hW+oE9MXjUCEffO/
	 nyWSuRGJnQ29Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/3] PCI: cadence: Add HPA IP debugfs for LTSSM
 status
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260515145747.129635-3-18255117159@163.com>
References: <20260515145747.129635-3-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 15:39:12 +0000
Message-Id: <20260515153913.257A8C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The PCIE_CADENCE_DEBUGFS Kconfig option is defined as a tristate=
 but checked using #ifdef, causing silently disabled debugfs features when =
built as a module.
--

commit 42a8fcd88891f03bce5c72c19d8d785ffffc51ae
Author: Hans Zhang <18255117159@163.com>

PCI: cadence: Add HPA IP debugfs for LTSSM status

This commit adds debugfs support for HPA-based Cadence PCIe controllers
to allow reading the current LTSSM state as a string and raw value.

> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/control=
ler/cadence/Kconfig
> index 9e651d5459735..cb010bc97aad3 100644
> --- a/drivers/pci/controller/cadence/Kconfig
> +++ b/drivers/pci/controller/cadence/Kconfig

[ ... ]

> @@ -6,6 +6,15 @@ menu "Cadence-based PCIe controllers"
>  config PCIE_CADENCE
>  	tristate
> =20
> +config PCIE_CADENCE_DEBUGFS
> +	tristate "Cadence PCIe debugfs entries"

Should this be a bool instead of a tristate?

[ ... ]

> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/=
controller/cadence/pcie-cadence.h
> index 9a464cbaf073d..2320319af83bc 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h

[ ... ]

> +#ifdef CONFIG_PCIE_CADENCE_DEBUGFS
> +void cdns_pcie_debugfs_deinit(struct cdns_pcie *pci);
> +void cdns_pcie_debugfs_init(struct cdns_pcie *pci);
> +#else
> +static inline void cdns_pcie_debugfs_deinit(struct cdns_pcie *pci)
> +{
> +}
> +static inline void cdns_pcie_debugfs_init(struct cdns_pcie *pci)
> +{
> +}
> +#endif

When configured as a module (=3Dm), Kbuild defines
CONFIG_PCIE_CADENCE_DEBUGFS_MODULE instead of CONFIG_PCIE_CADENCE_DEBUGFS.
Does this #ifdef evaluate to false and silently use the dummy stubs instead
of initializing the debugfs features?

If this were fixed to use IS_ENABLED(), could it introduce linker errors
when the host driver is built-in (=3Dy) but debugfs is built as a module (=
=3Dm)?
Changing the Kconfig definition to bool would avoid this.

[ ... ]

> diff --git a/drivers/pci/controller/cadence/pcie-cadence-debugfs.c b/driv=
ers/pci/controller/cadence/pcie-cadence-debugfs.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c

[ ... ]

> +void cdns_pcie_debugfs_init(struct cdns_pcie *pci)
> +{
> +	char dirname[CDNS_DEBUGFS_BUF_MAX];
> +	struct device *dev =3D pci->dev;
> +
> +	/* Create main directory for each platform driver. */
> +	snprintf(dirname, CDNS_DEBUGFS_BUF_MAX, "cdns_pcie_%s", dev_name(dev));
> +	pci->debug_dir =3D debugfs_create_dir(dirname, NULL);
> +
> +	cdns_pcie_ltssm_debugfs_init(pci, pci->debug_dir);
> +}
> +EXPORT_SYMBOL_GPL(cdns_pcie_debugfs_init);

Since this file can currently be built as a module, does it need a
MODULE_LICENSE() declaration? Without it, loading the module might fail
when trying to use GPL-only exported symbols like debugfs_create_dir().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515145747.1296=
35-1-18255117159@163.com?part=3D2
