Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858C0217723
	for <linux-pci@vger.kernel.org>; Tue,  6 Oct 2026 17:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791308736; cv=none; b=EkyPufXhFLzPBgAa6JDSMbwvwlJMWeBL0e4nr+C1mkg+6aTZPMDZOmnlzlZLtXQ/kVNYkxR0ZB7iNdmXfshK3bA3NP/hWN9ZKqmTHQsmg0gqSvJ+2gg+Q2p+6PTPI2v5gR9JcZC+M6YnA31qgRsIzBnEkqgzODMaA5D9fv9wKPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791308736; c=relaxed/simple;
	bh=EHWQEoxyCR/HOfcKOGnk1zehZ97ivkjrncJNIoKXALE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ro7LKAip5hz4VckFOMjUBgA9vrVsNf8Zl+z86zzQaFwaJGi+Gbin80Ah8lZeBHU5BsVhjl/lDQts8kol0cqPZwF36MdteWs2PWeKw+AimnIN0i3G1uKJBC5oIcBssCh7bTqkUVkfHrMC+/l54cenuPKKfU3dX+qHE62CykhiYXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5ELvEBE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5ELvEBE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0355D1F0089B;
	Tue,  6 Oct 2026 17:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791308735;
	bh=QEFZpkywd47LbsIS+4HVl0H2yqgwATj3wwAgWqhZJQ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L5ELvEBEqg3HPAG0/HcoTYo6NbNH9GN+ZRRs7P5YRfz3kIQ4Otpm6GuheeBR0iO5u
	 Bku/BEmTfkSg1mVKblXfbPbnCLQq3owoITuinTtVmzqum81e7iwdmLYKISPphbsol6
	 IN2y0fa/VzJI6egjiQfR/3vnTh/jKwh6RO6prv/J+LewTjll09qjeRXlfoxOQdrFT/
	 bCLwl9A6yqEMDh7Rhaj2x2N++zhZQ+0on17Lx/lcozROcEy/7EKXXLfpUjnGfZ4LfK
	 8txNspgxFsKFJMwAvqaEnl87RQcp2V4fErJCQgtyXif3tQaockEcTMwVieEdlXI79F
	 YsyaKCTgPigXg==
Message-ID: <sashiko-outbox-162306@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] PCI/LMR: Add Lane Margining at the Receiver
 debugfs interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261006-pcie-link-endpoints-v5-1-c1e73235746b@google.com>
References: <20261006-pcie-link-endpoints-v5-0-c1e73235746b@google.com>
 <20261006-pcie-link-endpoints-v5-1-c1e73235746b@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 17:45:34 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pci: pci_lmr_reboot_notify skips lane reset on trylock failure
--

commit 1dd16e08c517390b6bc52a453ae7eeb35b21f5e3
Author: Priyank Rathod <rathodpriyank@google.com>

PCI/LMR: Add Lane Margining at the Receiver debugfs interface

This commit introduces a debugfs interface for PCIe Lane Margining at the
Receiver, enabling user-space to configure sampling point offsets and read
error counts. It also adds logic to disable ASPM and hardware autonomous
speed/width during an active margining session.

> diff --git a/drivers/pci/pcie/margin.c b/drivers/pci/pcie/margin.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/pci/pcie/margin.c

[ ... ]

> +/* Return margined lanes to normal settings before reboot or kexec */
> +static int pci_lmr_reboot_notify(struct notifier_block *nb,
> +				 unsigned long action, void *data)
> +{
> +	struct pci_lmr_port *port;
> +
> +	guard(mutex)(&pci_lmr_mutex);
> +	list_for_each_entry(port, &pci_lmr_ports, node) {
> +		if (port->state !=3D LMR_ACTIVE)
> +			continue;
> +		if (!mutex_trylock(&port->lock))
> +			continue;

[Severity: Medium]
If this mutex_trylock() fails, does this code skip the hardware restore ste=
ps?

If a system reboot or kexec is initiated while a user-space tool is actively
margining a PCIe link, the margining thread may be holding port->lock
(which can block for up to 100ms waiting for hardware responses).

When this trylock fails, the notifier silently continues, skipping both the
lane reset (pci_lmr_reset_lanes) and the restoration of hardware autonomous
width/speed settings (pci_lmr_autonomous_restore).

Because kexec does not assert PERST# to fully reset the PCIe link, could the
new kernel inherit a link with shifted margins and disabled autonomous
management, potentially leading to link instability and missing devices?

> +		if (port->state =3D=3D LMR_ACTIVE) {
> +			if (!pci_dev_is_disconnected(port->dev))
> +				pci_lmr_reset_lanes(port);
> +			pci_lmr_autonomous_restore(port);
> +		}
> +		mutex_unlock(&port->lock);
> +	}
> +
> +	return NOTIFY_DONE;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-pcie-link-=
endpoints-v5-0-c1e73235746b@google.com?part=3D1
