Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E6417BEBF;
	Mon, 18 May 2026 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779133562; cv=none; b=jUxokk1JHEeqgWtFY0/XlV+NRZtECTPb92kRJk8UUnTIjNgpD4/FKdhNP5LpfEgaezfYBOPklklI0rCfgpFnNjNDH11riRSUkBjy8zfe+NstDIkooSBtYW8/p7wuz2y8R3HKPBguEcR4zdKi2QxRfYLOFKju7+yIHTvkWdssyks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779133562; c=relaxed/simple;
	bh=/8YSBrRHGiN9TZSfVSy7ETaMMvs5S8MZ8hnM6mNYJQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRMW/fDqT+C6dKLv14gzXw84e1EN0FIaHPzIVf9JBZRGH+hL3nfmbBQaeU2p0q5Mov5/EBIGhmAu17AcOKgtU7IOzLR6Oq3SujI3eFQ3s+luCa87wD/I2himyfvawE5E6UF1/4SILQMFk5fyBg3Uh/BwvFrxkjqw/RefQHRJcvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id EB09236D;
	Mon, 18 May 2026 21:45:50 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id CC49F6183639; Mon, 18 May 2026 21:45:50 +0200 (CEST)
Date: Mon, 18 May 2026 21:45:50 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Marco Nenciarini <mnencia@kcore.it>,
	Michal Winiarski <michal.winiarski@intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Eric Chanudet <echanude@redhat.com>,
	Jean Guyader <jean.guyader@gmail.com>,
	Alex Williamson <alex@shazbot.org>, Sinan Kaya <okaya@kernel.org>,
	Mario Limonciello <superm1@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 2/2] PCI: Wait for device readiness after D3hot ->
 D0uninitialized transition
Message-ID: <agtsbplSM7ozZcHF@wunner.de>
References: <20260518191220.636213-1-bhelgaas@google.com>
 <20260518191220.636213-3-bhelgaas@google.com>
 <CAJZ5v0iU=0SHXK9RngiYCwz5XZ0mJ+L5iy-FSWhytNgJbCam0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iU=0SHXK9RngiYCwz5XZ0mJ+L5iy-FSWhytNgJbCam0A@mail.gmail.com>

On Mon, May 18, 2026 at 09:38:12PM +0200, Rafael J. Wysocki wrote:
> On Mon, May 18, 2026 at 9:12 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > +++ b/drivers/pci/pci.c
> > @@ -1341,10 +1352,19 @@ int pci_power_up(struct pci_dev *dev)
> >         pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, 0);
> >
> >         /* Mandatory transition delays; see PCI PM 1.2. */
> > -       if (state == PCI_D3hot)
> > +       if (state == PCI_D3hot) {
> >                 pci_dev_d3_sleep(dev);
> > -       else if (state == PCI_D2)
> > +               if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET)) {
> 
> Hmm.  The pmcsr value here is from before the pci_write_config_word(),
> so AFAICS it should be updated after the write.

The No_Soft_Reset bit is RO (PCIe r7.0 sec 7.5.2.2), so its value should
never change when writing zero to the Power Management Control/Status
Register.

Thanks,

Lukas
