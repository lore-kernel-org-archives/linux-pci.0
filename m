Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7069A357D1A;
	Tue, 12 May 2026 07:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778569603; cv=none; b=dRWeyQzMH7hRzeBTdCDeF5VWzmcjDhxYejug0hD76t+0RRurSuvSBzPKwL1l/Pn0m9vbYCVDzUjIJaGJLwJD8DAK91L84vnNxPU8LhpqUcPiy2zRQJdo93Q0Ij1TCO2IuAwdOapgR0lwvDqc4FmJPaKPjq9Z8IGazpcisoBn09U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778569603; c=relaxed/simple;
	bh=BhCGMXthM490YD4xzinIOMo/2c8IueFjTOa1u9cdKkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQwnxcSV+Z35/WcL5AiDW83TlOqGv7Wsam66DCaixciIHz6rsXmkEFmLE5Lu5A7O96oxcC5haV1rE98wrbQggDic71h0kIdRx48xGOiKHZtYrCqXJhsekS7GnsL7vmTrtRkkjiVq5dKkc0jI8Zdx+1PTo1cYk6lPZvinAs52md8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPYtYhVT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPYtYhVT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D60C2BCB0;
	Tue, 12 May 2026 07:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778569601;
	bh=BhCGMXthM490YD4xzinIOMo/2c8IueFjTOa1u9cdKkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BPYtYhVTtLZnJjfmq2PHT5GHNdbkf0EicE5AO/ybMSA2ZjYuVIkmLqiOKC+WrwpjA
	 DYqk+E/wsaZj96qyDDL0b8n3vFg6WzZEhB5DmituDpncgxXk5RcSAy8UxrTv09r3x/
	 GslVxQMM1BF8rr5RAchuiFk2GBLlJKakMsvXpu7w7dFk4dGRbMeddthExf+L2UGY/y
	 Mf1Kzi4H/ZgDWfOkFCpt32XG5nPu9VVQRl0U1W3+4bkOwPyxub9N+CheKrvs6mEVq5
	 GjfPI6GvELsdeNNkJwnRysLM/6Dpt/+jPRsxTDIlbS6wiFt4L50aOlxlM7ndtRka0x
	 MK59gNzLtx5dQ==
Date: Tue, 12 May 2026 12:36:35 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: quirks: Advertise D3cold capability for UPD720201
Message-ID: <4ypz3dxqwnkiohjo6nkvvqbnu4fe3q6r52m7mna76nj3fuvb3i@lyowr5bd2axu>
References: <20260430211443.GA440215@bhelgaas>
 <f8d71952-b814-4865-a1cf-77dd47380e7d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8d71952-b814-4865-a1cf-77dd47380e7d@oss.qualcomm.com>

On Tue, May 12, 2026 at 11:09:22AM +0530, Sushrut Shree Trivedi wrote:
> 
> On 5/1/2026 2:44 AM, Bjorn Helgaas wrote:
> > On Thu, Apr 30, 2026 at 10:12:18AM +0530, Sushrut Shree Trivedi wrote:
> > > PCIe-to-USB bridge UPD720201 does not advertise D3cold
> > > support until firmware is loaded post pci enumeration.
> > > This results in upd blocking D3cold entry during system
> > > suspend and causing overall failure to enter XO
> > > shutdown.
> > I think you're saying that the PM Capability in config space changes
> > when the firmware is loaded.  That makes me worry about what *other*
> > config space changes might happen when the firmware is loaded.
> > There's all sorts of stuff we do during enumeration that depends on
> > what's in config space.
> 
> Yeah, that's a valid concern here but we checked with renesas also and
> they have confirmed this is the only delta in PCI config space before/after
> firmware loading.
> 
> > 
> > > Hence, add a quirk to advertise D3cold PME capability
> > > since the HW actually supports and advertises it post
> > > firmware loading.
> > > 
> > > Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
> > > ---
> > >   drivers/pci/quirks.c | 10 ++++++++++
> > >   1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index caaed1a01dc0..c32617ed33aa 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -6381,3 +6381,13 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
> > >   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
> > >   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
> > >   #endif
> > > +
> > > +/*
> > > + * Renesas PCIe-to-USB bridge UPD720201 does not advertise D3cold
> > > + * capability by default until firmware is loaded post-enumeration.
> > There are several mentions of "Renesas UPD720201/UPD720202 USB 3.0
> > xHCI Host Controller" in the tree.  I assume this is the same device?
> > If so, I think it'd be worth using similar terminology, i.e., "USB
> > xHCI host controller" instead of "PCIe-to-USB bridge"
> ACK'd.
> > 
> > > +static void quirk_enable_d3cold(struct pci_dev *dev)
> > > +{
> > > +	dev->pme_support = dev->pme_support | (1 << PCI_D3cold);
> > > +}
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_RENESAS, 0x0014, quirk_enable_d3cold);
> > How do we know that FINAL fixups happen after firmware loading?
> FINAL fixups would actually happen before firmware-loading because firmware
> is loaded as part of xhci host controller driver probe. That shouldn't be an
> issue
> because we know post successful firmware loading, D3cold is supported by
> the xHCI controller. In the odd scenario that FW loading fails, xHCI
> controller
> functionality will be completely broken and it makes sense to put it in
> D3cold.
> 

This patch has nothing to do with firmware loading. The issue is, these Renesas
devices only expose the proper PME capability (PME from D3Cold) after loading
the firmware and their Reset value of the PME capability is wrong.

So when the PCI core reads the PME capability in pci_pm_init() (which happens
way before driver loading), it caches the wrong value and it stays like that
even after the device updates the capability with firmware loading.

And this quirk directly updates the cached value with device's actual
capability.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
