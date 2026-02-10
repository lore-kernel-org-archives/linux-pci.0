Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A74832A3FF
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 20:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770754983; cv=none; b=i98NssISEG85UunYPrDEAm9Oe75CEfNEklKtV+IOLJFrBG7k02cvC44nmkN2XpmVw+k0gUbDZfn7+lWmwqshXw4MZ1BAT72JGuRxQbT2YE9LoxHKtAEb3CIrCQB/4zVhado4adHrGgbAco3s6eZjpDODf6QDGuBm9zQi4Za7/AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770754983; c=relaxed/simple;
	bh=g/UViQ7V8Xmfvcwcs74DsYCjjOiNzblHyilHxxBT5Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5iCsr41T7tptVY0MGnF7VpljRzGb27GjoO/R5sRChLsD2IwewwuKctkc9YEGUHAnOj5raQ1iS51YlB7Bmp3QO9k2hqSjUT7MTnnf1kA04ZrHaYYLvnsxUan593P6RRLJrIv6lgEM9D8QEuCeo4dn6cOlwQJ58lqDi3KmKjT9Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1o8kSJr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1o8kSJr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD73C116C6;
	Tue, 10 Feb 2026 20:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770754983;
	bh=g/UViQ7V8Xmfvcwcs74DsYCjjOiNzblHyilHxxBT5Yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h1o8kSJrRLkaDHCxd00dGZhyWZAnN5yAdbnOS3IkC+kyliJsFycKyq89T6jQBiFwB
	 UTTMllkNjx7l18oZ2oI8+5Fxvc8/zglUaEAFZdCvD+WgAE94/yVBhEbtjWIqI8IAZQ
	 ZmHN0HVtgo6RK+8TxynW3mG7MjzrTtr6iavGq4BN5OU9iZb0dmCVvB1RhkkhzR2tGE
	 tkoaOgReNjj7hA4A7oj/igb9LkTP9JKhQsOOpB+6ep1CHHwnQXwBgU0AGmP3qSgkD/
	 xftS4B2+Z9vtyKJatk8lxQtAN+uuZC/OcFBKv2Yw+WzJRDkWR7ClWbVIL613WyiOmT
	 m++/RW8t8Wbcg==
Date: Tue, 10 Feb 2026 21:22:58 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <aYuToukP3STMF6Tj@ryzen>
References: <20260210181225.3926165-2-cassel@kernel.org>
 <20260210193205.GA41950@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210193205.GA41950@bhelgaas>

On Tue, Feb 10, 2026 at 01:32:05PM -0600, Bjorn Helgaas wrote:
> IIUC, the sequence is like this:
> 
>   - nvmet-pci-epf calls pci_epc_raise_irq() leading to
>     dw_pcie_ep_raise_msi_irq()
> 
>   - dw_pcie_ep_raise_msi_irq() reads PCI_MSI_ADDRESS_*, maps msg_addr,
>     and saves it in ep->msi_msg_addr
> 
>   - host updates PCI_MSI_ADDRESS_*
> 
>   - nvmet-pci-epf calls pci_epc_raise_irq() again
> 
>   - dw_pcie_ep_raise_msi_irq() reads PCI_MSI_ADDRESS_*, notices that
>     msg_addr has changed, and WARNs and returns -EINVAL
> 
> and this patch makes it so the second time through
> dw_pcie_ep_raise_msi_irq(), we notice the msg_addr change, remove the
> old mapping, and map it again with the new address.

Correct.


> 
> Isn't there still a race between host updates of PCI_MSI_ADDRESS_* and
> endpoint reads of those registers?  We can't prevent the host from
> updating PCI_MSI_ADDRESS_* between dw_pcie_ep_map_addr() and the
> writel(), so maybe it's impossible to prevent the theoretical race
> there, and all we can really do is mitigate what we expect to be a
> single change at boot time of the host?

Normally, the MSI target address is not changed during runtime.

The spec allows changing the MSI-X address/data pair when the corresponding
vector is *masked*, and classifies the behavior as undefined if address/data
pair gets changed while the vector is *unmasked*.

AFAICT, it does not mention anything for MSI, so I do not think it is allowed
to be changed during runtime.

The only reason why it is changed here is because UEFI/BIOS will have one
MSI target address, and then once Linux boots, it will use another MSI target
address. (So it only changes once.)


> 
> Even for that single change, it looks like the host could update
> PCI_MSI_ADDRESS_* simultaneously with dw_pcie_ep_raise_msi_irq(), 
> leading to mapping a half-updated msg_addr.  This part we *could*
> prevent by re-reading PCI_MSI_ADDRESS_* to detect a partial update.

The problem that commit 8719c64e76bf ("PCI: dwc: ep: Cache MSI outbound iATU
mapping") fixes is that the DWC controller does not handle when the outbound
iATU is re-programmed when there are ongoing outbound transactions.

What commit 8719c64e76bf ("PCI: dwc: ep: Cache MSI outbound iATU mapping")
did was to map it once on startup, that way we don't re-program the outbound
iATU on every pci_epc_raise_irq() call. Before this commit, every
pci_epc_raise_irq() call could potentially cause ongoing outbound transactions
to be sent untranslated. Often the transactions that were sent untranslated
did not appear to be the MSI writel() itself, but other transactions performed
by the eDMA.

So even with this patch, since we are still not mapping + unmapping the MSI
target address on every pci_epc_raise_irq(), it should just be a single time
where we might trigger this problematic behavior (when MSI target address
changes, UEFI -> Linux). (Which is still much better than possibly triggering
this problematic behavior on every pci_epc_raise_irq().)


> 
> Probably unrelated question: the pci_epc_raise_irq() path doesn't seem
> to check PCI_MSI_FLAGS_ENABLE or PCI_MSIX_FLAGS_ENABLE.  Is that
> intended?

I guess we could improve pci_epc_raise_irq() to check those bits, in a
separate patch.

Mani, thoughts?


Kind regards,
Niklas
