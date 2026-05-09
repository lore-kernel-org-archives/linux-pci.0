Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E970029CB57
	for <linux-pci@vger.kernel.org>; Sat,  9 May 2026 07:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778311995; cv=none; b=B4SJ1kvIetwuB+C2bn1mS7B2QmTyptYgD9hywOSxu41bbglGggDUfcPX246amnlcfNuRkSMjr5wA6GdNjMHJlOoeaVE6P77BtNB0CY3divVuDvIL6QoaADxev6cL/v6EgA5VFq7ECiz7IUSAXJKpH+5L4sLiXfXFMKo0N2DiTBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778311995; c=relaxed/simple;
	bh=WsXgQqttQr6IBvVqKvxBRYRaHQiBAFIC9t5MITEoVeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqu1cEkLJUH2GqFeiHAEr3Er4dqswYKaiVX4Io3DAGrCx7xwwNYLRyIBq/y0eDwXHg6VUHZv0BCIfi1PI+er9sNcRmtKvlYzORXWe3wuS0cJqRq1S/VofajX3ljUplWrvST8SQPlsRrbfedvPmFT60cCvTLfM7L9SyOUK3wUvb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZSShXei; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZSShXei"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-83975e992e1so1395536b3a.2
        for <linux-pci@vger.kernel.org>; Sat, 09 May 2026 00:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778311993; x=1778916793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4rrWX8PR+HWUg34CwgZ0qTRfJ+rZargOz41FLZiRD60=;
        b=kZSShXei4Ke0NduTO91R8eSghN32Rai9VSLu/a7oHud0p71W4+tTDzHlVTX2lNO8uV
         wOX5K7X5ExG+etRTbSuk1Equky+HtdN9FOG8+MFPQQDlERQvI0cWdKGGZuaIzZxp8nR7
         RhxQGIP7W1451PtK/5kNwTInXzYiR/Hvldw1S3Y/tkC3HmZEJsD8Lm/nCKmVtRh2nSB7
         el0lDMc0fw8aR6R8nB3DN8zemQET7dJNBcd3UwqgdrBqsodpt945jOpjEhS/cLfDVvr9
         UNgqt9hrs5XQ14OsqalOolDYDcMp4NHZoFgXXJV8eMff6q4iAfB5cqjL3+4OZOeuOv6d
         PkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778311993; x=1778916793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4rrWX8PR+HWUg34CwgZ0qTRfJ+rZargOz41FLZiRD60=;
        b=k8I/NvcPESpQhcExc26j5ZC4wbVtiM2hWAsCHYlCcXeh7vRMYwnOK0hpiILx5cIlpO
         ESwXwBVTnnqV3fJSix8r9RcyxesGOUa/i+P5bdNIj6j8sIgt6rTtKVLNkNg6oPDM9k1y
         mrHnDJ2PMnZ5MHDMNFb7h0LNCNb92/iYWK/0bmN2Bicc7xbUduMUOhF1LN188m+l6J4P
         6DP3ZN/+Aod0WbU6QrPgKwN3hrk1ddGaewkjVHM7d7HHE+xcuRHNFAXZoiqAwRgLBiki
         QWuZRQKZGYgUOt6EQ3qWGMC8D0pKYPRz7cMLTLsMspVHgmNezwxP4xO+MfLyw32MAxR/
         LI0A==
X-Forwarded-Encrypted: i=1; AFNElJ8SbP6kTEImqHfKRYkT9vtNSnViu/piWFAe/4b+HkqVFqNRO1zfgSjcaw4cW1LZxBGaLSHTalvWVVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe/OUrtllaD8cj9A5QIG4F/IsQ0bgB0tJHlVzevlQV2ZkIZ2Zx
	RspYCa10lHAISlD0MIyZyaoa3gGtopjh3Jw2MTAAFDSEz2rJf1xcjm9D
X-Gm-Gg: Acq92OHBhAs2DlpO+XznsihWWZmUN61TFwkuIv2GI5rqXimsq07yB/ilbV67Z4GdKBP
	23jF3uxURDi83PyvkYt/yKT+bxens2HP10yNy1slIb+kYpz0QmUmpS62yqNuIxyLE7G3zC+rLCU
	tZwWcmumgrpUFRx2b9JzeDRASGP7lBH+blNA5d3+jKGcBGlWPVkVor51RqTIiHyFErvj5cPMWVW
	boCAy3SiFPiZ2C+iqpM2AxNTggetyL6BzzRd7kzsT1cgKIjXpxIbG6o35AG7pt9D+SQY3DoUnQN
	QxsThvtWZ8mE122yeygh6l1tVxa1dTO4M/W2JUB8G9frOxT63vaLiOquF1WrIQDZxQIfEmm6M9s
	U7dygBamcb/ylrf8DZI3zqLxNmXQzyjf7nImmMODOmi+tELcxHwaLLdJoLm/9dHsU3uIEg1IHnv
	M5luHKjYRe3FpUH8pIFSsULOrQdfTLWP/Xxw==
X-Received: by 2002:a05:6a00:1407:b0:837:eaa9:381f with SMTP id d2e1a72fcca58-83a57c7782dmr15579899b3a.0.1778311993011;
        Sat, 09 May 2026 00:33:13 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbf67fsm14681697b3a.47.2026.05.09.00.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 00:33:12 -0700 (PDT)
Date: Sat, 9 May 2026 15:32:52 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Alex Elder <elder@riscstar.com>, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 5/5] PCI: spacemit-k1: Add Spacemit K3 PCIe host
 controller support
Message-ID: <af7fu8xuv3faMhPe@inochi.infowork>
References: <20260502101319.2364052-6-inochiama@gmail.com>
 <20260507224217.GA48780@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507224217.GA48780@bhelgaas>

On Thu, May 07, 2026 at 05:42:17PM -0500, Bjorn Helgaas wrote:
> On Sat, May 02, 2026 at 06:13:18PM +0800, Inochi Amaoto wrote:
> > The PCIe controller on Spacemit K3 is almost a standard Synopsys
> > Designware PCIe IP with extra link and reset control. Unlike
> > the PCIe controller on K1, this controller supports external MSI
> > interrupt controller and can use multiple phy at the same time.
> > 
> > Add driver to support PCIe controller on Spacemit K3 PCIe.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> 
> Sashiko had some good questions:
> https://sashiko.dev/#/patchset/20260502101319.2364052-1-inochiama%40gmail.com
> 
> Looks like the CONFIG_PCIE_SPACEMIT_K1 menu item and help text
> drivers/pci/controller/dwc/Kconfig should be updated to include K3.
> 
> The "CONFIG_PCIE_SPACEMIT_K1" name itself should stay the same.
> 
> s/Designware/DesignWare/, also in 4/5 commit log
> s/phy/PHY/ here and other patches and subject lines
> s/msi/MSI/ in 3/5 subject and commit log when it's a stand-alone word
> s/pci:/PCI:/ in 4/5 subject to match history (and patch 3/5)
> 

See it, thanks, I will take care of that

> > +++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> 
> > +#define INTR_STATUS				0x0010
> > +
> >  #define INTR_ENABLE				0x0014
> >  #define MSI_CTRL_INT			BIT(11)
> > +#define RDLH_LINK_UP_INT		BIT(20)
> > +
> > +#define K3_PHY_AHB_IRQSTATUS_INTX		0x0008
> > +
> > +#define K3_PHY_AHB_IRQENABLE_SET_INTX		0x000c
> > +#define LEG_EP_INTERRUPTS		(BIT(6) | BIT(7) | BIT(8) | BIT(9))
> 
> Would be nicer to use "INTX" rather than "LEG" here since we use
> "INTX" in K3_PHY_AHB_IRQENABLE_SET_INTX, in the comments, etc.
> 
> > +#define K3_PHY_AHB_IRQENABLE_SET_MSI		0x0014
> > +/* MSI defined as BIT(11) in existing INTR_ENABLE, reusing */
> > +
> > +#define K3_ADDR_INTR_STATUS1			0x0018
> > +
> > +#define K3_ADDR_INTR_ENABLE1			0x001C
> 
> You're using a mix of upper- and lower-case hex here.  Be consistent
> and match the existing code.
> 
> Seems a little weird to have a mix of "IRQ" names (e.g.,
> K1_PHY_AHB_IRQ_EN, K3_PHY_AHB_IRQSTATUS_INTX,
> K3_PHY_AHB_IRQENABLE_SET_INTX) and "INTR" names (e.g., INTR_STATUS,
> INTR_ENABLE, K3_ADDR_INTR_STATUS1, K3_ADDR_INTR_ENABLE1) when I think
> they're really talking about the same concept.
> 
> And why do the new K3 names have "ADDR" in the middle when the
> existing "INTR_ENABLE" names don't?  It's obvious these are addresses
> (well, actually I think they're *offsets*, but no need to be that
> detailed).
> 

In fact I have no detailed document about these name, but reference
to their comments, I think it is a register for some link features.
So it could be more accurate to be named with "LINK"

> > +static int k3_pcie_init(struct dw_pcie_rp *pp)
> > +{
> > ...
> > +	val = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
> > +	val &= ~(0xffff << 8);
> > +	val |= ((0x1 << 4) << 8);
> 
> Can you use FIELD_MODIFY and some #defines here?

It is fine for me.

> 
> > +	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, val);
> > +
> > +	/* Set the PCI vendor and device ID */
> 
> Superfluous comment since the code is obvious.
> 

OK, I will remove it

> > +	dw_pcie_dbi_ro_wr_en(pci);
> > +	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, PCI_VENDOR_ID_SPACEMIT);
> > +	dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, PCI_DEVICE_ID_SPACEMIT_K3);
> > +	dw_pcie_dbi_ro_wr_dis(pci);
> > +
> > +	/* Finally, as a workaround, disable ASPM L1 */
> 
> I guess this means a device erratum?  It advertises L1 but it doesn't
> actually work?
> 
> > +	k1_pcie_disable_aspm_l1(k1);
> 
> > +static int k3_pcie_msi_host_init(struct dw_pcie_rp *pp)
> > +{
> > ...
> > +	val = dw_pcie_readl_dbi(pci, COHERENCY_CONTROL_3_OFF);
> > +	val |= (0xf << 11);
> 
> FIELD_MODIFY and some #defines here?
> 

OK.

> > +static int k3_pcie_start_link(struct dw_pcie *pci)
> > +{
> > +	struct k1_pcie *k1 = to_k1_pcie(pci);
> > +	u32 val;
> > +
> > +	k1_pcie_start_link(pci);
> > +
> > +	/* Enable INTx */
> > +	val = readl_relaxed(k1->link + K3_PHY_AHB_IRQENABLE_SET_INTX);
> > +	val |= LEG_EP_INTERRUPTS;
> > +	writel_relaxed(val, k1->link + K3_PHY_AHB_IRQENABLE_SET_INTX);
> > +
> > +	/* Enable MSI/MSIX specific to K3 */
> 
> s/MSIX/MSI-X/ to match spec usage.
> 
> > +	val = readl_relaxed(k1->link + K3_ADDR_INTR_ENABLE1);
> > +	val |= (MSI_INT | MSIX_INT);
> > +	writel_relaxed(val, k1->link + K3_ADDR_INTR_ENABLE1);
> 
> Generally speaking I think the interrupt setup belongs somewhere other
> than .start_link().  Usually .start_link() only enables LTSSM.
> 

Yes, this logic are not needed any more after I recheck the vendor
code. Only thing related to the link will be left.

With this, the macro like LEG_EP_INTERRUPTS can be removed.

> > +	return 0;
> > +}
> 
> > +static irqreturn_t k3_pcie_irq_thread(int irq, void *data)
> > +{
> > +	struct k1_pcie *k1 = data;
> > +	struct dw_pcie_rp *pp = &k1->pci.pp;
> > +	struct device *dev = k1->pci.dev;
> > +	u32 status0, status1, status2;
> > +
> > +	k3_pcie_clear_irq_status(k1, &status0, &status1, &status2);
> > +
> > +	writel_relaxed(status0, k1->link + K3_PHY_AHB_IRQSTATUS_INTX);
> > +	writel_relaxed(status1, k1->link + INTR_STATUS);
> > +	writel_relaxed(status2, k1->link + K3_ADDR_INTR_STATUS1);
> > +
> > +	if (FIELD_GET(RDLH_LINK_UP_INT, status1)) {
> > +		msleep(PCIE_RESET_CONFIG_WAIT_MS);
> > +		/* Rescan the bus to enumerate endpoint devices */
> > +		pci_lock_rescan_remove();
> > +		pci_rescan_bus(pp->bridge->bus);
> 
> This is the *only* driver that uses pci_rescan_bus() this way, which
> automatically makes it suspicous.  Maybe it's the first hardware that
> implements or is willing to use RDLH_LINK_UP_INT for this, but somehow
> I doubt it.
>

I am going to remove this. At least I do not think it is very proper
to add this in the first version. 
The vendor explained that they use this interrupt to speed up the
device link up check. This depends on a feature that make dwc skip
the link up delay. And this feature is removed in v7.0. In commit
142d5869f6ee ("Revert "PCI: dwc: Don't wait for link up if driver
can detect Link Up event"")

Regards,
Inochi
 
> > +		pci_unlock_rescan_remove();
> > +	} else if (!status0 && !status1 && !status2)
> > +		dev_WARN_ONCE(dev, true,
> > +			      "Received unknown event. status0=0x%08x status1=0x%08x status2=0x%08x\n",
> > +			      status0, status1, status2);
> > +
> > +	return IRQ_HANDLED;
> > +}
