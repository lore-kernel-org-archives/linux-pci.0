Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EA034EF0C
	for <linux-pci@vger.kernel.org>; Sun, 11 Oct 2026 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791736906; cv=none; b=Pi7wAhnKO1hs/Kvje0mDLT0YAuBk0ZeEXyRidyj97+Wkicl0dBVl62FqG/GKUmFbPzl/HiT1sJuTVXoujdWS9NdRauLASiFUxyh5IzuW1OMq40iCm0NQ/jWqTS9YuI+dQ1p0Pwa8UIB2xhS/MtEbhdvacJb+lpjYCaCE/ElnE8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791736906; c=relaxed/simple;
	bh=rpen4ATHsCv26ufvg3jJ3MqhTGOAzgLWNI6W9dz8WrM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=IuLUOPXXp8hdO53vCRoqKAHoDT1aowvJoJbx1ZFJAgQ6m/5wZHd/T6gh2zYtXw1NwDjYNzpOb8Ui5ZhfMvIVxPPbNwDgJ8Lpp2UnAF5f0qpaYNQrHuWzilAASpZaagy20MbLCezqBR0mY2S0ITD3R7nPwyCS9nUCM54uAc17JZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETqUbr32; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETqUbr32"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D3F1F0089B;
	Sun, 11 Oct 2026 16:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791736902;
	bh=iaUudTsWXAVoWvAM6rBeMly7P9/8YeIJwJEV90QE0ko=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ETqUbr326FB7+kHQmfTLjDLZjuKq/wr69SEz1jpIrZ12eLgzxXSEm6/kxRyT/5FZh
	 s3SDEzl3p0bz4/JDs6aLXpYwuJ03lgybUwBNrDC5v1Pm7S598h3fUb9xY2cYOAd0iZ
	 Ewo+/iYA3u5JxVAbwbXjS9/nHkl2FKuVnfcNTfonh2GxX9BPg8YGJ+l0hw5ClPGuz+
	 oWzm3Nm3yYubSdGuXZMz6jqk97HmCaXlASy/1yDdyjML9Sh9rQfXX4UYQrj1Lk1JB1
	 Ti24hBFIh5mkxRNhSF28wedBdhPvsYt5OJm6B7F+HBZsYOE5ADsdA1HMtmJhSOtqFe
	 M2W1q4a0TVUsg==
Message-ID: <sashiko-outbox-167316@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] PCI: Don't treat ~0 as ready in pci_dev_wait()
 with RRS SV
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gruhlke" <gruhlke@mailbox.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261011163249.18479-3-gruhlke@mailbox.org>
References: <20261011163249.18479-1-gruhlke@mailbox.org>
 <20261011163249.18479-3-gruhlke@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 16:41:42 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pci: premature wait termination for VFs returning ~0 under RRS SV
--

commit 3101a5ea075ba619cd03d971d4a538bf4788ec75
Author: Alexander Gruhlke <gruhlke@mailbox.org>

PCI: Don't treat ~0 as ready in pci_dev_wait() with RRS SV

With RRS Software Visibility, pci_dev_wait() considers a device ready as
soon as reading the Vendor ID doesn't return the RRS value.  Devices
aren't required to respond with RRS while they aren't ready, so the read
may return ~0 and pci_dev_wait() stops waiting too early.

Link: https://lore.kernel.org/r/20250611101442.387378-1-hui.wang@canonical.=
com

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index aa39b4dd45aea..cf429f64bce0f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
[ ... ]
> @@ -1331,7 +1332,8 @@ static int pci_dev_wait(struct pci_dev *dev, char *=
reset_type, int timeout)
> =20
>  		if (root && root->config_rrs_sv) {
>  			pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
> -			if (!pci_bus_rrs_vendor_id(id))
> +			if (!pci_bus_rrs_vendor_id(id) &&
> +			    (!PCI_POSSIBLE_ERROR(id) || dev->is_virtfn))
>  				break;

[Severity: Medium]
Does this cause pci_dev_wait() to exit prematurely for Virtual Functions
(VFs) that return ~0 under Configuration RRS Software Visibility?

If a VF is not yet ready, its config space might return ~0 (for example, due
to a Request Timeout) instead of the RRS value. The dev->is_virtfn check
causes the wait loop to terminate immediately upon seeing ~0. This seems to
allow unready VFs to appear ready, defeating the reset delay.

Callers might then attempt to initialize the unready VF, leading to config
read/write failures or even triggering PCIe AERs if the unready VF later
responds with RRS to non-Vendor-ID accesses.

While VFs architecturally return ~0 for Vendor ID when they are ready, poll=
ing
PCI_COMMAND when the Vendor ID returns ~0 (as done in the non-RRS SV path
below) could resolve this without exiting prematurely.

>  		} else {
>  			pci_read_config_dword(dev, PCI_COMMAND, &id);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011163249.1847=
9-1-gruhlke@mailbox.org?part=3D2
