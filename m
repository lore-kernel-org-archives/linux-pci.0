Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B223ACF0A
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772031600; cv=none; b=sEkrepJ81af/DjNgZD9wWRnDomqYSuDCesajid9WMNqnlp9sti2kNxpiqiJR23rOm/R26D7TSWPwYHh27H5CPsTW00+YtQms287l+5E3SJq1iCYp50RN4Fu4H1peCnOBLohGMSQiTfMxxBPBG8QDykxCT5d3v0Ufh42h3t8Eh5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772031600; c=relaxed/simple;
	bh=cfuIhRMmPy5mKdx+B/bkRcqFvLi3iTrgyzImk6G8P7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqnx1bR6V5D4fRhJNzi237zpgEQF1ILi4H1BNqGWrqfgFzLkMJ2MWhrHYuT377c3jvpcT+EU18kFYTA5zMTxZeY47Ot21ImY7T6/Yi1K8oGqeNHOvGMXCpFT55TeBfesnqCtTAFmW4jB+3s/ckXGAURbhvoK7MPKUaCE7JBQKcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsROKgTJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsROKgTJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E96CC116D0;
	Wed, 25 Feb 2026 14:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772031599;
	bh=cfuIhRMmPy5mKdx+B/bkRcqFvLi3iTrgyzImk6G8P7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NsROKgTJpvVxVaUxHaFRrXX9eTlYJukPvfisgTvEeK3sF3BpBqWcEJfn8AqlK09yq
	 g52DcSRKMLrYISlqQB1+W9QvlD12cgivnXycrpb3HAeFawV3wCPf2o/7Y0ZXcDAvFL
	 Vx97WpUcH3KJ8ivUWhF4ODeGS76P3m55RT3siLiahujYQ0/6ZGGD7xfcaSwloet2Br
	 6EDptk4StQTggF/s7Yj+/Lk8XqLozAJNQXzW/+7yCutr7U23xJ47IYnzv6KJkwuNS6
	 MumFgslYy5T51OT7Jz7pB5xxDGrzyy4LZSSNghhQmCDSRBKv0l2/4zsLPpe2gVNPmc
	 Dqz1MpvlXdLow==
Date: Wed, 25 Feb 2026 20:29:51 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Koichiro Den <den@valinux.co.jp>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Fix regression in
 dw_pcie_ep_raise_msi_irq()
Message-ID: <p3p6m3fadboxxwtwyvuwiompfe2apvjzctprvoo2lg4556f2vb@p63lgfcp5kho>
References: <20260210181225.3926165-2-cassel@kernel.org>
 <20260210193205.GA41950@bhelgaas>
 <aYuToukP3STMF6Tj@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYuToukP3STMF6Tj@ryzen>

On Tue, Feb 10, 2026 at 09:22:58PM +0100, Niklas Cassel wrote:
> On Tue, Feb 10, 2026 at 01:32:05PM -0600, Bjorn Helgaas wrote:
> > IIUC, the sequence is like this:
> > 
> >   - nvmet-pci-epf calls pci_epc_raise_irq() leading to
> >     dw_pcie_ep_raise_msi_irq()
> > 
> >   - dw_pcie_ep_raise_msi_irq() reads PCI_MSI_ADDRESS_*, maps msg_addr,
> >     and saves it in ep->msi_msg_addr
> > 
> >   - host updates PCI_MSI_ADDRESS_*
> > 
> >   - nvmet-pci-epf calls pci_epc_raise_irq() again
> > 
> >   - dw_pcie_ep_raise_msi_irq() reads PCI_MSI_ADDRESS_*, notices that
> >     msg_addr has changed, and WARNs and returns -EINVAL
> > 
> > and this patch makes it so the second time through
> > dw_pcie_ep_raise_msi_irq(), we notice the msg_addr change, remove the
> > old mapping, and map it again with the new address.
> 
> Correct.
> 
> 
> > 
> > Isn't there still a race between host updates of PCI_MSI_ADDRESS_* and
> > endpoint reads of those registers?  We can't prevent the host from
> > updating PCI_MSI_ADDRESS_* between dw_pcie_ep_map_addr() and the
> > writel(), so maybe it's impossible to prevent the theoretical race
> > there, and all we can really do is mitigate what we expect to be a
> > single change at boot time of the host?
> 
> Normally, the MSI target address is not changed during runtime.
> 
> The spec allows changing the MSI-X address/data pair when the corresponding
> vector is *masked*, and classifies the behavior as undefined if address/data
> pair gets changed while the vector is *unmasked*.
> 
> AFAICT, it does not mention anything for MSI, so I do not think it is allowed
> to be changed during runtime.
> 
> The only reason why it is changed here is because UEFI/BIOS will have one
> MSI target address, and then once Linux boots, it will use another MSI target
> address. (So it only changes once.)
> 
> 
> > 
> > Even for that single change, it looks like the host could update
> > PCI_MSI_ADDRESS_* simultaneously with dw_pcie_ep_raise_msi_irq(), 
> > leading to mapping a half-updated msg_addr.  This part we *could*
> > prevent by re-reading PCI_MSI_ADDRESS_* to detect a partial update.
> 
> The problem that commit 8719c64e76bf ("PCI: dwc: ep: Cache MSI outbound iATU
> mapping") fixes is that the DWC controller does not handle when the outbound
> iATU is re-programmed when there are ongoing outbound transactions.
> 
> What commit 8719c64e76bf ("PCI: dwc: ep: Cache MSI outbound iATU mapping")
> did was to map it once on startup, that way we don't re-program the outbound
> iATU on every pci_epc_raise_irq() call. Before this commit, every
> pci_epc_raise_irq() call could potentially cause ongoing outbound transactions
> to be sent untranslated. Often the transactions that were sent untranslated
> did not appear to be the MSI writel() itself, but other transactions performed
> by the eDMA.
> 
> So even with this patch, since we are still not mapping + unmapping the MSI
> target address on every pci_epc_raise_irq(), it should just be a single time
> where we might trigger this problematic behavior (when MSI target address
> changes, UEFI -> Linux). (Which is still much better than possibly triggering
> this problematic behavior on every pci_epc_raise_irq().)
> 
> 
> > 
> > Probably unrelated question: the pci_epc_raise_irq() path doesn't seem
> > to check PCI_MSI_FLAGS_ENABLE or PCI_MSIX_FLAGS_ENABLE.  Is that
> > intended?
> 
> I guess we could improve pci_epc_raise_irq() to check those bits, in a
> separate patch.
> 

Yes, this looks like bug which should be fixed in separate patch(es).

- Mani

-- 
மணிவண்ணன் சதாசிவம்
