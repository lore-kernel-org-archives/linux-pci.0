Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6786C1DB95E
	for <linux-pci@vger.kernel.org>; Tue,  5 May 2026 00:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777941508; cv=none; b=ECdyK7TCkeaKXiNCGCDCC9xA3CHMblfrmbpYBcTsqaSSbcl2+FuDbfzrPbEzDMi8xofj/07T5cVBoXGp2F13RAB0ZCuSNKkyyZQ+TW5CbW1SYkDbrs56tFpXCYO/oJnkqo3QSG49wovh25l3Gat9W5uISPzeFGNWd8SWxIz51z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777941508; c=relaxed/simple;
	bh=0pP64HI45M5VV349dPPSmJKCr2mtvivDYsYx9tyTM3E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pdgr6kYOqUZRlsb/xnkdBZ8scaBtEkJA3oltHXI+2ZCPX1bpMr0t09zQdBEEUgfgwt7Z1WG1KothsgT0OGd3q3FPBcLOIArw0M4/6DJkPtynHWyYo12dIXbPYMfjllcgeV/QxpD7UIov+y2O8NMgpr6wKHpn8j5nXwQiUOaJdVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7y//r/0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7y//r/0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F0CC2BCB8;
	Tue,  5 May 2026 00:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777941508;
	bh=0pP64HI45M5VV349dPPSmJKCr2mtvivDYsYx9tyTM3E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=G7y//r/0HzyUqvoAVn9xJtkQXKx/4Mlq0tdMU8SR27xOqedVamX0x7gTiiqOoyilZ
	 6I2w/4/QPiEZQPyhYId3aVId0f5cPHOme01DmoHdMQJOTWUsluKNuFT/a8NfeW2wAA
	 DX7Fci+cAaN2vnc3WYXSVAZS3ycz4HnI/ljOg/SQSdJHY9blfKpKclfz7Zo2vYQ6V3
	 hk3+Pm4b7XBOmOh+3mU+LC2Go9BHbVmdjouszV86G4RLVW0L0p4cg8I0m+p7kp825L
	 9TtFIHjlfkL+BpkdZl7lLJ7jknkeoHt7SA10n+xxoZ97kWwAJWnoWjo3pwuPTAE6+H
	 Z1bZlK1N6nDxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Export pci_parent_bus_reset() for drivers
 to use
Reply-To: sashiko@lists.linux.dev
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2605050051390.46195@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2605050051390.46195@angie.orcam.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 00:38:27 +0000
Message-Id: <20260505003827.D2F0CC2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unprotected list traversal and data race in `pci_parent_bus_reset(=
)` exposed to external drivers.
- [High] Exporting `pci_parent_bus_reset()` creates an unsafe API that bypa=
sses mandatory PCI core state management and synchronization.
--

commit 73a6ae560868e4a44decb13db21d60108f4c09f1
Author: Maciej W. Rozycki <macro@orcam.me.uk>

PCI: Export pci_parent_bus_reset() for drivers to use

This commit removes the static modifier from pci_parent_bus_reset(),
adds kernel doc comments, and exports it using EXPORT_SYMBOL_GPL()
so that external drivers can trigger a secondary bus reset via the
device's immediate upstream bridge.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4820,7 +4820,21 @@ int pci_bridge_secondary_bus_reset(struct pci_dev =
*dev)
[ ... ]
> +int pci_parent_bus_reset(struct pci_dev *dev, bool probe)
>  {
>  	struct pci_dev *pdev;
> =20

Internally, pci_parent_bus_reset() traverses dev->bus->devices using
list_for_each_entry() locklessly.

Reading this list typically requires holding pci_bus_sem to protect against
concurrent modifications from hotplug events.

Since pci_bus_sem is an internal lock and not exported to modules, drivers
utilizing this newly exported API will not be able to acquire the required
locks prior to calling it.

Does exporting this function introduce a regression regarding list
corruption or use-after-free?

> @@ -4837,6 +4851,7 @@ static int pci_parent_bus_reset(struct pci_dev *dev=
, bool probe)
> =20
>  	return pci_bridge_secondary_bus_reset(dev->bus->self);
>  }
> +EXPORT_SYMBOL_GPL(pci_parent_bus_reset);

Unlike higher-level APIs like pci_reset_function(), this newly exported
function does not save and restore the PCI configuration space or prepare
the IOMMU for DMA reset.

Additionally, pci_bridge_secondary_bus_reset() expects the bridge
configuration access to be locked, and emits a warning if it is not:

pci_bridge_secondary_bus_reset() {
    if (!dev->block_cfg_access)
        pci_warn_once(dev, "unlocked secondary bus reset via...");
}

Could drivers utilizing this export trigger system instability or
uncorrectable errors while DMA is active, since it bypasses state
management and locking steps like acquiring pci_dev_lock() on the upstream
bridge?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/alpine.DEB.2.21.260=
5050042390.46195@angie.orcam.me.uk?part=3D1
