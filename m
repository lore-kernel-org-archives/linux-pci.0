Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D62E44C66A
	for <linux-pci@vger.kernel.org>; Mon,  5 Oct 2026 11:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791198463; cv=none; b=VIg0S6uuj0/i2OhSowpBxeeSLhMY9pEDGV3S46CpyQTr6aHRWZagrjTihI6ZeKzsI6eLOueNHRtG+xg4rNzFz76nxODqWwn5RXUyBjpg2OypGiWgzx3xVNlnAmcUaDEyykzSVTTX1gZ9/rUr+0G1Olj66KZQvKz+cnVvZ4YLJPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791198463; c=relaxed/simple;
	bh=IRUuvaYY8t3wppiIM8W20lZkN+NOuEMbqlB5qyPJ7tI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=juoEQIeVMIta8cFggwtXvA6oLcVzRxlGdnotVBk464InHZ6yYjb0a0Y3z/dwIcj58BUa/nYm9gg+2F6In7JVnju6E40hx6jy6qRQJVue41FlojybG2Q8A4NgOth/9x92WSa57HhqyqKUKmImvESnI/myAVRFQq6mV2afZ8yiER4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkECahpq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkECahpq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53A31F00893;
	Mon,  5 Oct 2026 11:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791198462;
	bh=ShkZQcIw9+oQ9g4ADqDRwdH5QLOfr6Wsa63P2aaNwus=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SkECahpqri5fRBo/iEQs87CPJRF3dNOiBlfXqKTO6Tqd4bzPbrpyfmnQJVc/Lf1D/
	 WIiTWR6Nl5TzNYxxD+5AaWkRG+vvgrEkBIKi/MiUTO38DkMZrkUdws42iRjEw4ul1+
	 sba5c0BUac0l1FtoQX1xBIaimaEVw6SlYPz+W0ROQvfR7DTjPeWX7N6pp9zwFSDpRI
	 O9d58HxVq0ROoC9zv+e8/6m/rUe76DM+wGWGCoerJLQgwgEN9Jd2zsL9UGPyUKCYjd
	 Ysk8m3UG3fZfN10SGJ8J0zjye/4RAhHV39ouIZaKoYmTfOjCrCldwXO846X7Ac6fKU
	 B3AmGY9XVL84g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 1/2] PCI: Add device-specific reset for Qualcomm
 SDX62/SDX65 modems
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261005105436.83962-2-jtornosm@redhat.com>
References: <20261005105436.83962-1-jtornosm@redhat.com>
 <20261005105436.83962-2-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 11:07:41 +0000
Message-Id: <20261005110741.D53A31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: restoring PCI_COMMAND enables memory decode with 0-initialize=
d BARs
--

commit 760a69f51b8830cd55e316a784f0c3e65a321b72
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

PCI: Add device-specific reset for Qualcomm SDX62/SDX65 modems

This commit introduces a device-specific hardware reset mechanism for Qualc=
omm=20
SDX62/SDX65 modems. It uses a sequence of writes to BAR0 MHI SoC reset=20
registers to properly initialize the devices for VFIO passthrough.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index de9bbccda21fd..e72af7d2c7755 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
[ ... ]
> @@ -4230,6 +4230,45 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev=
, bool probe)
[ ... ]
> +static int reset_qualcomm_modem(struct pci_dev *pdev, bool probe)
> +{
> +	void __iomem *bar;
> +	u16 cmd;
> +
> +	if (probe)
> +		return 0;
> +
> +	if (pdev->current_state !=3D PCI_D0)
> +		return -EINVAL;
> +
> +	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> +	pci_write_config_word(pdev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
> +
> +	bar =3D pci_iomap(pdev, 0, 0);
> +	if (!bar) {
> +		pci_write_config_word(pdev, PCI_COMMAND, cmd);
> +		return -ENODEV;
> +	}
> +
> +	iowrite32(MHI_SOC_RESET_REQ, bar + MHI_SOC_RESET_REQ_OFFSET);
> +	ioread32(bar + MHI_SOC_RESET_REQ_OFFSET);
> +
> +	/* Be sure device reset has been executed */
> +	msleep(2000);
> +
> +	pci_iounmap(pdev, bar);
> +	pci_write_config_word(pdev, PCI_COMMAND, cmd);

[Severity: High]
Could restoring PCI_COMMAND here cause a system address conflict?

If the saved cmd originally had the PCI_COMMAND_MEMORY bit set (for example,
when called from a path like Xen PCIBACK's pcistub_reset_device_state),
writing it back immediately enables memory decode. Because the hardware res=
et
has just occurred, the device's BARs will have been cleared to 0.

Does this create a risk of silent memory corruption by allowing the device =
to
claim physical address 0 before the PCI core has a chance to restore the BA=
Rs
properly in pci_restore_config_space()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005105436.8396=
2-1-jtornosm@redhat.com?part=3D1
