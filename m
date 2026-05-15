Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01953E559F
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778842180; cv=none; b=mtBzvPmyYPnRtJtwg4qf4YhGfgDX3PRvLNmDlZ8ClZZKq0rloqUKnwnwKkSTSD+SF5h2cV2ckXpTJaf/Iei0MqXKTp1gr3/jK+vF2rLO1bqO+utExokWuJhAAFxKExk+l8v4kQ9G8+QsVagJCenWR8Ry/o359DetfXHN+Kc5crk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778842180; c=relaxed/simple;
	bh=XqUdTAkSve7WyZ7mVuh7pq/+tHCaMWZwBX2GQO9snYo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ECUib1IEMaviyp7WqQEil8n3KkD5Ra0p7IiFA8iXi1lXlTYp7zEaZJ73UsGfyP6v577/kqhko2ueU8eY+6dX7S+pCni70X9BnfcvC7X6fbLR3XTx5ZylmhUG7ERFi7leyOGLmtGDLbE6j8Ig7UuwbCrvrBFKQfsQHoTbwElLmh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2b79FHR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2b79FHR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D6BC2BCB0;
	Fri, 15 May 2026 10:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778842180;
	bh=XqUdTAkSve7WyZ7mVuh7pq/+tHCaMWZwBX2GQO9snYo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=U2b79FHRpoSXufatEZBu277BHNza13ZQBFxDDJu8nsj6FXKEQbPgqZKHlZGhiGy1N
	 HvI80uoh3XskiIQYkmfhBwumito3PmOrSGkkmlrAhtQW4O4lWn10h1ksTEdBySwY57
	 +nVaC+N/NgtjXgbUOJoxsDGhGPQiEr1Kk3e3Ul5ySfGbUyjhdScnlFjLzOVqi3ut9j
	 w57Rr0QF1SKpcaO6DDOX2mLoY3R1qjFLeI7sOrrRMDzJAovKawU7fUgEMa+C8Ttnhy
	 8C1njQlh9gvcDx6U/JvsuQTj1nlxm6eVSRwYtXBwmAM7bEmO4vtNb0y+5SR7u5xpU6
	 tK+K/OhY9RXXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/5] PCI/TPH: Add pcie_tph_enabled_mode() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260515094040.38496-4-fengchengwen@huawei.com>
References: <20260515094040.38496-4-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 10:49:39 +0000
Message-Id: <20260515104940.79D6BC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The pcie_tph_enabled_mode() helper returns 0 both when TPH is di=
sabled and when it is actively enabled in No ST Mode, causing an unresolvab=
le API ambiguity.
- [Medium] Lockless multi-variable read of TPH state without memory barrier=
s leads to inconsistent state and TOCTOU vulnerabilities.
--

commit 1855ec2d0c286906dabaf853860c8045f63a2d5f
Author: Chengwen Feng <fengchengwen@huawei.com>

PCI/TPH: Add pcie_tph_enabled_mode() helper

Add a helper to query enabled TPH mode on a PCI device. This is useful for
drivers like VFIO-PCI that need to validate TPH state before allowing
access to steering tag tables.

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index ba31b010f67ad..91c1e83410a3e 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
[ ... ]
> @@ -451,6 +451,18 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
>  }
>  EXPORT_SYMBOL(pcie_enable_tph);
> =20
> +/**
> + * pcie_tph_enabled_mode - Get current enabled TPH mode
> + * @pdev: PCI device
> + *
> + * Return the enabled TPH mode (IV/DS) or 0 if disabled.
> + */
> +int pcie_tph_enabled_mode(struct pci_dev *pdev)
> +{
> +	return pdev->tph_enabled ? pdev->tph_mode : 0;

Will this return value be ambiguous when TPH is enabled in No ST Mode?

Since No ST Mode (PCI_TPH_ST_NS_MODE) is defined as 0x0, returning 0 when
disabled makes it impossible for a caller to distinguish between TPH being
completely disabled and TPH being actively enabled in No ST Mode.

Could this return a negative error code (such as -ENODATA or -EINVAL) when
TPH is disabled, to avoid collisions with valid mode values?

Also, can this lockless read of pdev->tph_enabled and pdev->tph_mode see
an inconsistent state if pcie_enable_tph() runs concurrently?

For example, if VFIO allows userspace to trigger pcie_enable_tph()
concurrently with querying the enabled mode, could the CPU or compiler
reorder the load of pdev->tph_mode before pdev->tph_enabled?

This might result in seeing tph_enabled =3D=3D 1 but an old or uninitialized
value for tph_mode.

> +}
> +EXPORT_SYMBOL(pcie_tph_enabled_mode);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515094040.3849=
6-1-fengchengwen@huawei.com?part=3D3
