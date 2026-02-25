Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3520133BBAA
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 22:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772058874; cv=none; b=GOuvsw+a5aSD1PcfnFMFBHAG8CKtSd/XdiDLN1Y0Z7DlyD8AgwRE/Q2CkMlYM714BS6o1srwegNMPlE5RA3C3MEouUA6eJTvSXMTvT4OngL4vkO3JAaWqK/otOaOBDCTq4PzxoZ6/MrgmPHAI9e1v4e3LoNrKkPdp94/2qH+gj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772058874; c=relaxed/simple;
	bh=wgBpk7KVh1+2gLjOocjyx8WzDY1ZuxqItW5ZTBtTQoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Va7WUxnTLXm4fyYj/obUdtl6xF9M5tHwaKzRH6qMlxQ3Z8a8fT4AWAC4TmTh2R/WPegh1XM+5Scs1hDEKVLDvB1JalOF1kNlIsBdo+zqycV7JLlehEF1RSAqCG+6l6pPBKCKmHAFRMbrblhc6EjAL4ISPNSweWmA1kFTeJqRrsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izxjYaZT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izxjYaZT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9306DC116D0;
	Wed, 25 Feb 2026 22:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772058873;
	bh=wgBpk7KVh1+2gLjOocjyx8WzDY1ZuxqItW5ZTBtTQoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=izxjYaZTbRi3519SUlWd8wbyjKjNbQmkW/U9bERzUj5y1UpLOfjwT33lo4k0wTK2g
	 raleOs8pPMj6V/xDqNj4hKSL7TqhqE/bjEbO7ys260JOUKUFL828tw9ABvxQyaNnD3
	 vsNWuo9x/V2zdjNw5YNsUjGUyGKtUeZg8vnKIjHAivp12yGReIxzc+fBb8crc9lXhn
	 oARhuzG1iWLkGgagnp0zaJHmTIgSdVN2vAy33MpCRnFw2zXt6TECKKH8uE9wZu0w1X
	 VyD2JL+GO5km38V1eBdh9WbXMsgAw/K524cSsktv7JVctXcJZUy07hruewwxVqi6AE
	 Fhy6AlZRwsznQ==
Date: Wed, 25 Feb 2026 23:34:27 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Koichiro Den <den@valinux.co.jp>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Flush before unmap in
 dw_pcie_ep_raise_msix_irq()
Message-ID: <aZ948_L1pE-YzBVO@fedora>
References: <20260211175540.105677-2-cassel@kernel.org>
 <20260225214440.GA3786788@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225214440.GA3786788@bhelgaas>

On Wed, Feb 25, 2026 at 03:44:40PM -0600, Bjorn Helgaas wrote:
> On Wed, Feb 11, 2026 at 06:55:41PM +0100, Niklas Cassel wrote:
> > When running e.g. fio with a larger queue depth against nvmet-pci-epf we
> > get IOMMU errors on the host, e.g.:
> > 
> > arm-smmu-v3 fc900000.iommu:      0x0000010000000010
> > arm-smmu-v3 fc900000.iommu:      0x0000020000000000
> > arm-smmu-v3 fc900000.iommu:      0x000000090000f040
> > arm-smmu-v3 fc900000.iommu:      0x0000000000000000
> > arm-smmu-v3 fc900000.iommu: event: F_TRANSLATION client: 0000:01:00.0 sid: 0x100 ssid: 0x0 iova: 0x90000f040 ipa: 0x0
> > arm-smmu-v3 fc900000.iommu: unpriv data write s1 "Input address caused fault" stag: 0x0
> > 
> > The reason for this is that the writel() is immediately followed by a call
> > to unmap(), which will tear down the outbound address translation.
> > 
> > PCI writes are posted, i.e. don't wait for a completion. Thus, when the
> > writel() returns, might not have completed yet, and could even still be
> > buffered in the PCI bridge, at the time unmap() is called.
> > 
> > Flush the write by performing a read() of the same address, to ensure that
> > the write has reached the destination before calling unmap().
> > 
> > This will add some latency, but that is certainly preferred over corrupting
> > the host memory.
> > 
> > The same problem was solved for dw_pcie_ep_raise_msi_irq(), in commit
> > 8719c64e76bf ("PCI: dwc: ep: Cache MSI outbound iATU mapping"), however
> > there it was solved by dedicating an outbound iATU only for MSI. For MSI-X,
> > we can't do the same, as each vector can have a different msg_addr, and
> > because the msg_addr is allowed to be changed while the vector is masked.
> > 
> > Fixes: beb4641a787d ("PCI: dwc: Add MSI-X callbacks handler")
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> 
> beb4641a787d appeared in v4.19 (2018!) so it doesn't strictly qualify
> as a post-merge window fix, but I do understand that it fixes a
> problem similar to the 8719c64e76bf bug that we added in v7.0.

Yes, the problem has been there a very long time.
(And I am basically the guilty one, as the commit that implemented
dw_pcie_ep_raise_msix_irq() basically copied dw_pcie_ep_raise_msi_irq()
which was originally written by me.)

However, the problem is extremely easy to reproduce with nvmet-pci-epf.

Just do a fio --rw=randread --bs=4k --iodepth=32
and you trigger it within a few seconds.

While pci-epf-test has a read and a write test case, these test cases
only raise a single IRQ at the end of the test.

nvmet-pci-epf raises an IRQ after each I/O is completed.

The problem is easier to reproduce the more IRQs you trigger.
E.g. when you run fio with --iodepth=1, you don't trigger the bug.


At least I am glad that we have finally discovered and fixed this bug
after all such a long time.

We have the pci-epf-mhi driver, the pci-epf-ntb, and the pci-epf-vntb
driver, but since this problem has not been discovered before, it is
obvious that they don't raise as many IRQs as nvmet-pci-epf.
And if you look at those EPF drivers, pci-epf-mhi and pci-epf-ntb only
raise an interrupt once after link up.

pci-epf-vntb appears to do it on each doorbell_set(), but that is
probably also not using interrupts nearly as much as nvmet-pci-epf.


Kind regards,
Niklas
