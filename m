Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1857D3090C5
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 20:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778101106; cv=none; b=AtmJjj5HqMQC+LawsjOSnBsJhTRCbDKAMeXz8Hnno0m94qpe/tiflzAKNFJxX/arFcCZVmGqYbFDpDMORbe+nt0F2C582ijKM40+PskbCroENjT+O4/BEKiBMv5V+0ieS1MPWQUPPpL3D+m8YkizjD6CATIhA5pq6gSlQx4eBoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778101106; c=relaxed/simple;
	bh=ig6L4eW/nZJHHaHXCE13Nn6bPRdVuNCTrChrJNiLXlE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rVuv875flGawgxamxtiFxurp46vGMtXsrV0zXDxQBv4FsomwBo3TIZYq+C35SKGpVm4xTgEj1jGMzITPAYf2C+XqJ4sv9OnsSHZNHBkWvQlSkCn5aT17Z921lctbGtzXQQVUQJPw9h92efPb5cz6rhwq6sv2ZGnbK+GD2iXg6Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYwcVjKo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYwcVjKo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75DDC2BCB0;
	Wed,  6 May 2026 20:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778101105;
	bh=ig6L4eW/nZJHHaHXCE13Nn6bPRdVuNCTrChrJNiLXlE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=PYwcVjKoShgEksb1rhkrhRPO1MVAqBjQmnUg5NYSVtxCrvtFW7bW2vGUzIk9gfmW2
	 7HZtnvL2dTKzisORebrEefVVvZAFCa6HyXZothZPtQX7Hu94dWB1LtbneWABlgkccv
	 JZFp0DLJLXJcjjubTLRJXAvoNkNkC/R66HJPyaTVwVqiI43iJk50pWE0DShXQ1D8cS
	 JsCEkhXnOipO5/H9QI2i2QFKL6pGkz7Kc20WkEfAis6es7Js2KjrtgNpdn8ugl0+aG
	 VXK0CW8rCqI9JLTAdWjBz/sGeW+kbLuVLWseyfQ3FauUYsfVg6upWHuaCNQbMRw6+P
	 cTjgj8UtkP6kQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: pciehp: Disable link and turn off slot power while
 removing
Reply-To: sashiko@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260506164353.1278571-1-mario.limonciello@amd.com>
References: <20260506164353.1278571-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 20:58:25 +0000
Message-Id: <20260506205825.C75DDC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Unconditional slot power-off in `pciehp_release_ctrl()` abrupt=
ly cuts power to active devices, causing kernel crashes.
- [Low] Dead code in `pciehp_power_off_slot()` due to `pciehp_link_disable(=
)` always returning 0.
--

commit 5574c68659aab56ef2cf2ec6acc4c999a6afa1fc
Author: Mario Limonciello (AMD) <superm1@kernel.org>

PCI: pciehp: Disable link and turn off slot power while removing

This commit adds code to pciehp_power_off_slot() to disable the link
before turning off slot power. It also introduces a cleanup sequence
in pciehp_release_ctrl() to disable the link and turn off slot power
during driver removal.

> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pcieh=
p_hpc.c
> index 4c62140a3cb44..6705dcaf1ad0c 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
[ ... ]
> @@ -558,6 +563,12 @@ int pciehp_power_on_slot(struct controller *ctrl)
> =20
>  void pciehp_power_off_slot(struct controller *ctrl)
>  {
> +	int retval;
> +
> +	retval =3D pciehp_link_disable(ctrl);
> +	if (retval)
> +		ctrl_err(ctrl, "%s: Can not disable the link!\n", __func__);

Since pciehp_link_disable() calls __pciehp_link_set() which unconditionally
returns 0, will this error path ever be executed?

> +
>  	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_OFF, PCI_EXP_SLTCTL_PCC);
>  	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
>  		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
[ ... ]
> @@ -1096,6 +1107,8 @@ struct controller *pcie_init(struct pcie_device *de=
v)
>  void pciehp_release_ctrl(struct controller *ctrl)
>  {
>  	cancel_delayed_work_sync(&ctrl->button_work);
> +	if (POWER_CTRL(ctrl))
> +		pciehp_power_off_slot(ctrl);
>  	kfree(ctrl);
>  }

If the pciehp driver is unbound manually or encounters an error during
probe, could this unconditionally cut power to active devices?

Since pciehp is a port service, unbinding it removes hotplug monitoring
but does not detach the active child PCIe devices (such as NVMe drives)
from the PCI core.

If pciehp_release_ctrl() is called while child drivers are still bound and
running, does this lead to unexpected link down events and unsupported
requests?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506164353.1278=
571-1-mario.limonciello@amd.com?part=3D1
