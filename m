Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C268D1A9FBD
	for <linux-pci@vger.kernel.org>; Sat,  9 May 2026 22:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778364349; cv=none; b=lgBjv0ak3a/ilOXetBRJQ4ZN0ws6BwhJtuXv0n8lYSsf7UC7kNOgWkSwmkV+jmwKSnxKS0BKDEi6tZY1CMs31HB5Q20XM7Udn6BCSuFbU0HSB2IC+EqIqtxpYZ+viLO7YI3h+7KjeaaCNkg9EoAnWE9v+ZIMH+6Zzu732vJy/ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778364349; c=relaxed/simple;
	bh=amY7drjb/Q54+72Z8fnza2OBnLxuh96synD6u1epBEc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TEzUPx7HO2GwiQ1N3u4x0NLbucXfp9M/DsB3nGn7PFisfXApwG135N4N1dNsQGfVK6nqqYB5Cz5rP4vVPiyYe9tyixPLbmspgnMd/uG3r6LbUymiJxQaB08G8ub8LsssdpwBk5OWGbDASijO3DnOf0NX9uAfFJN+5tweBhGAfh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHKyqiqj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHKyqiqj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7510C2BCB2;
	Sat,  9 May 2026 22:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778364349;
	bh=amY7drjb/Q54+72Z8fnza2OBnLxuh96synD6u1epBEc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=YHKyqiqjZZV2p5qHIVmw+km56wTTnUrJHCZ2hLlZStGuBWWwOUpFN13+2Zru7joEN
	 MLxSDf8l8LMYCU2+0vCt+ms3rceMIan/Kt32cDR2y+IXh5kenp+k84+4eehcyJfOER
	 +hbFkrvJIPl+aAt9kfzWw4zz6tF9IwqAcSaw2KC0ZHzhMvnp3g5RmjOEwvxW9RHpys
	 +5InhAQho2Vhiers3080s+cTWAywBYCU+0mEeLHm19GVAnyv9I1b3lQNtFBuyR9tz5
	 abiy0s48OKkeEhZ7O52pAfVxfkOPudYijRAmKwJy4AqZAUUG4JpmEGfrRBoiyqfjln
	 kpgOHwTWp+Y6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next] net: mana: Add handler for sriov configure
Reply-To: sashiko@lists.linux.dev
To: "Haiyang Zhang" <haiyangz@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260508220412.15138-1-haiyangz@linux.microsoft.com>
References: <20260508220412.15138-1-haiyangz@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 22:05:48 +0000
Message-Id: <20260509220548.D7510C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing `pci_disable_sriov()` in PF driver's `remove` and `shutdow=
n` paths causes resource leaks and potential Use-After-Free.
- [Medium] Missing VF assignment check in `mana_sriov_configure` causes sil=
ent failure when disabling SR-IOV.
--

commit 1f4061f22025ea097273f720b3bccac577e7d805
Author: Haiyang Zhang <haiyangz@microsoft.com>

net: mana: Add handler for sriov configure

This commit adds the sriov_configure callback to the mana pci_driver to han=
dle
SR-IOV configuration. It also exports pci_vf_drivers_autoprobe() and disabl=
es
VF autoprobe when running as a PF driver on bare metal.

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/ne=
t/ethernet/microsoft/mana/gdma_main.c
> index 3bc3fff559991..767f11d5b351b 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
[ ... ]
> @@ -2262,6 +2267,20 @@ static void mana_gd_shutdown(struct pci_dev *pdev)
>  	pci_disable_device(pdev);
>  }

Does this code need to explicitly call pci_disable_sriov() during driver
remove and shutdown?

If the PF driver is unbound while VFs are enabled, the PCI core logs a
warning but does not automatically disable SR-IOV. With the VFs remaining
active, could they interact with dead hardware or trigger host-side PF even=
ts
that rely on the freed gdma_context, resulting in a use-after-free?

> +static int mana_sriov_configure(struct pci_dev *pdev, int numvfs)
> +{
> +	int err =3D 0;
> +
> +	dev_info(&pdev->dev, "Requested num VFs: %d\n", numvfs);
> +
> +	if (numvfs > 0)
> +		err =3D pci_enable_sriov(pdev, numvfs);
> +	else
> +		pci_disable_sriov(pdev);
> +
> +	return err ? err : numvfs;

If VFs are currently assigned to a guest VM (e.g., via VFIO), the PCI core's
sriov_disable() will internally abort the teardown. Because
pci_disable_sriov() returns void, will this function return 0 and falsely
signal to userspace that the disable operation succeeded?

Should this code check pci_vfs_assigned(pdev) and return -EPERM, or use
the generic pci_sriov_configure_simple() helper instead?

> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508220412.1513=
8-1-haiyangz@linux.microsoft.com?part=3D1
