Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6FB32ED22
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 20:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770755991; cv=none; b=ZLWUdOa6bh8Mrj/Pje4HviY3Eb/+lmast+8VhXRLkRo7ma1oYVV/M2TFqPjUlQTVn4oxpB9ee5/z9WEmzl3A2IssbAiQtCK+yrsq5j53rPa3lvmaGlSp+6m/QiGbArLeECLz2CdUeNxajOTgvxo4kVmCb7bWOXX6sU0v3Uxdc78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770755991; c=relaxed/simple;
	bh=XWhQd1kdQDBHVububbxyqQujR9Soe5f5Gfd12ETvRZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MxfQUbwrv1lijizYX/cU/RSiR6hncEEpznL3ITV3rR7xEEeENNyAZvTcRP8lWoAE1WFG5AiCuTGKZA5gcxadh+F4n4jqFcGqzhoIWxCzmZsZn8vF19KkxQNG5fPvzGHYkttJ/gvjuWotnfzhkVDFq/3LiX/CmG1kaEsjuaDutWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8175rFo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8175rFo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17E4C116C6;
	Tue, 10 Feb 2026 20:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770755990;
	bh=XWhQd1kdQDBHVububbxyqQujR9Soe5f5Gfd12ETvRZQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=j8175rFoV5tYwQHUYxS8zhRFcwxURx0zzz3IbOLj3+qZbLZqu15eLJCBlqB1YFOKg
	 I7MyHi6hawHBSUez5uroY+0R8Bfw3vrcr0U0llr+9SaE02dEjqCD0+SczTFrB3V0kK
	 SCQu8M4LJrUHUFsctOHHCa/Nk0LaVjEamL94rGPKnBpPdOGptstRNiWfnh16xRVJAb
	 o4ZsB9cGJrvW/5fWuUbf6wsCEFr5XDN54GILHQNl3i1QSYokfERxlHZB2qCuHp0oyy
	 PAtd7oBojr3MVFFa4Q8hSqUpbVdPi3Ozo7fEUFjfR1QItTb42cW9e82t2foJgbfcqU
	 Ih75ImLkIWHyQ==
Date: Tue, 10 Feb 2026 14:39:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Koichiro Den <den@valinux.co.jp>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Fix regression in
 dw_pcie_ep_raise_msi_irq()
Message-ID: <20260210203949.GA47027@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYuToukP3STMF6Tj@ryzen>

On Tue, Feb 10, 2026 at 09:22:58PM +0100, Niklas Cassel wrote:
> On Tue, Feb 10, 2026 at 01:32:05PM -0600, Bjorn Helgaas wrote:
> ...

> > Isn't there still a race between host updates of PCI_MSI_ADDRESS_*
> > and endpoint reads of those registers?  We can't prevent the host
> > from updating PCI_MSI_ADDRESS_* between dw_pcie_ep_map_addr() and
> > the writel(), so maybe it's impossible to prevent the theoretical
> > race there, and all we can really do is mitigate what we expect to
> > be a single change at boot time of the host?
> 
> Normally, the MSI target address is not changed during runtime.
> 
> The spec allows changing the MSI-X address/data pair when the
> corresponding vector is *masked*, and classifies the behavior as
> undefined if address/data pair gets changed while the vector is
> *unmasked*.
> 
> AFAICT, it does not mention anything for MSI, so I do not think it
> is allowed to be changed during runtime.
> 
> The only reason why it is changed here is because UEFI/BIOS will
> have one MSI target address, and then once Linux boots, it will use
> another MSI target address. (So it only changes once.)

Yes, hence "we expect a single change at boot time of the host" above.

> > Even for that single change, it looks like the host could update
> > PCI_MSI_ADDRESS_* simultaneously with dw_pcie_ep_raise_msi_irq(),
> > leading to mapping a half-updated msg_addr.  This part we *could*
> > prevent by re-reading PCI_MSI_ADDRESS_* to detect a partial
> > update.
> 
> The problem that commit 8719c64e76bf ("PCI: dwc: ep: Cache MSI
> outbound iATU mapping") fixes is that the DWC controller does not
> handle when the outbound iATU is re-programmed when there are
> ongoing outbound transactions.

The scenario I'm asking about is the following, where the single
change of MSI target as the host boots is concurrent with
dw_pcie_ep_raise_msi_irq()::

  - host writes PCI_MSI_ADDRESS_LO

  - dw_pcie_ep_raise_msi_irq() reads PCI_MSI_ADDRESS_LO and
    PCI_MSI_ADDRESS_HI

  - dw_pcie_ep_raise_msi_irq() maps msg_addr built from an old
    PCI_MSI_ADDRESS_HI and a new PCI_MSI_ADDRESS_LO

  - host writes PCI_MSI_ADDRESS_HI

This could be mitigated by re-reading PCI_MSI_ADDRESS_* to detect the
tearing.
