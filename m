Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795029314;
	b=Lr1LmiMHkodza8FFKKKJvb1WaBbBDguS6c6131ZylKMc5KpE+v/Rq0N58/+9LieM8diY
	 yiGa8u+BY65dRvaP0dusPkFD4aHi3oHO8GS4gPeFfnGr+0esb3qOve1UmPsPxEjmMeTEh
	 k4FOXXZop9I8otBVOZsHJFZVpr8n2N36wHUJEAUFgkhyIGV2xTt+iC23YiFPYAhNhwWor
	 GOpZFA3dhGa8wodpZrV0xmjc2J44kZHPA7Z8rjC985pY4I96YY0BQXi4qfYRiIMo9WweZ
	 uf/H7FiQv1lRBR1EiwvZokxLdaHynmJSndH2XtFKbNSlL+Vded4VEpguX1L74Z9iFhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029314;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SoI3j8AewBJ4L4zGAQ6PYgF1rVxCwZAZzep5HCgSdwk=;
	b=3pYe7JsdGRDI7Rd/CsSLq04XZKOsz4LU9kbigZ92j3mzcPzNdkmbKdSOsHXQ5W9lEeMe
	 /sOo7SRqehztvDRcb0MIxVZgYN2QVpmR3wOIrXjvL8nTjouXQ4XqMlGTEepfQsXShCkDl
	 euRNDHYjBFsCCzljRf9UEtcTamvEFQ8ATRsaf4jEJ/HVBJCPGnlzupvC+wVQs6g+BlYLn
	 3/73asnalII1jUD7Aq4b+Rc6mSWSDUNmAuhV4u6A5dCRhQNYuIgQ2kaGu/fsiZoNS/BsL
	 shX2f5SXpDKctZXdXkR2RV4MBRaPnE7lcbyfAyq8On3JpW9JpYe4Jf/t0oyy1lPhnhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GTL7TzVI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5070A606A32A;
	Wed, 18 Nov 2026 19:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GTL7TzVI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C571F000C7;
	Wed, 18 Nov 2026 19:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795029314;
	bh=SoI3j8AewBJ4L4zGAQ6PYgF1rVxCwZAZzep5HCgSdwk=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=GTL7TzVIoKMr/Lt6EC3nrm4mPvWAxgE2fVuldl2xZue15xiqTrZXNYFgWppViW830
	 N3FXEJpcEc6IzM9Xime3AQwvg+hzU+uGE2jA9XsK703yJktima5cPV2leFCOscqgis
	 4VC6aVkunDUXvJV1SZ+7WTz8ogR+lC20hR49Z1/uSWEdCnKeosQ7/xqPQ0cMISsVxp
	 7zvcnnB7p8YmI52xlwtNQifu/ECGfM7cw7iwsGPiuYUFjKfuErXqHqco3jW43FDWzS
	 v8i1IxR2pq/ZCOsRHMC79J+grGd17n1cCl+riY/zU8Fl+f7JROwbq7biuJIVqdtPi9
	 aPBG45SrsTm0g==
Date: Wed, 18 Nov 2026 13:15:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gokulkrishna Sekar <gokulkrishnasr@gmail.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	mika.westerberg@linux.intel.com, linux-kernel@vger.kernel.org,
	Gokulkrishna Sekar <Gokulkrishna.Sekar@harman.com>
Subject: Re: [PATCH] PCI: Encode corrected PCIe port type with FIELD_PREP()
Message-ID: <20261118191512.GA707364@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118162547.GA597321@bhelgaas>

On Wed, Nov 18, 2026 at 10:25:47AM -0600, Bjorn Helgaas wrote:
> On Wed, Nov 18, 2026 at 03:35:05PM +0000, Gokulkrishna Sekar wrote:
> > set_pcie_port_type() validates PCIe port topology and corrects
> > invalid upstream/downstream port type information in the cached
> > pcie_flags_reg value.
> > 
> > When performing these corrections, the code clears the
> > PCI_EXP_FLAGS_TYPE field but writes PCI_EXP_TYPE_UPSTREAM or
> > PCI_EXP_TYPE_DOWNSTREAM directly into pcie_flags_reg. The
> > PCI_EXP_TYPE_* values are decoded port type numbers, not values
> > encoded for the PCI_EXP_FLAGS_TYPE bitfield, so the corrected type
> > is stored in the wrong bit position.
> > 
> > As a result, the cached port type may not match the corrected
> > topology and subsequent users of pcie_flags_reg can observe an
> > incorrect PCIe device type.
> 
> Looks like subsequent users would think the device was a PCIe Endpoint
> (PCI_EXP_TYPE_ENDPOINT==0x0) instead of an Upstream or Downstream
> Port, but only for devices that claim to be the wrong type in the
> first place, so it probably doesn't actually affect many systems.
> 
> But it seems like a candidate for stable anyway.
> 
> > Use FIELD_PREP(PCI_EXP_FLAGS_TYPE, ...) when updating the cached
> > field so the corrected port type is encoded consistently with the
> > format used in the PCI Express Capabilities Register.
> > 
> > Fixes: ca78410403dd ("PCI: Get rid of dev->has_secondary_link flag")
> > Signed-off-by: Gokulkrishna Sekar <Gokulkrishna.Sekar@harman.com>
> > ---
> >  drivers/pci/probe.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 9a178e0e5f7f..7b09a4463097 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -1674,7 +1674,8 @@ void set_pcie_port_type(struct pci_dev *pdev)
> >  		if (pcie_downstream_port(parent)) {
> >  			pci_info(pdev, "claims to be downstream port but is acting as upstream port, correcting type\n");
> >  			pdev->pcie_flags_reg &= ~PCI_EXP_FLAGS_TYPE;
> > -			pdev->pcie_flags_reg |= PCI_EXP_TYPE_UPSTREAM;
> > +			pdev->pcie_flags_reg |= FIELD_PREP(PCI_EXP_FLAGS_TYPE,
> > +							   PCI_EXP_TYPE_UPSTREAM);

Oh, I forgot: I think this is a candidate for FIELD_MODIFY() instead
of the "&= ~PCI_EXP_FLAGS_TYPE, FIELD_PREP(PCI_EXP_FLAGS_TYPE)"
sequence so we don't have to repeat PCI_EXP_FLAGS_TYPE.

> >  		}
> >  	} else if (type == PCI_EXP_TYPE_UPSTREAM) {
> >  		/*
> > @@ -1685,7 +1686,8 @@ void set_pcie_port_type(struct pci_dev *pdev)
> >  		if (pci_pcie_type(parent) == PCI_EXP_TYPE_UPSTREAM) {
> >  			pci_info(pdev, "claims to be upstream port but is acting as downstream port, correcting type\n");
> >  			pdev->pcie_flags_reg &= ~PCI_EXP_FLAGS_TYPE;
> > -			pdev->pcie_flags_reg |= PCI_EXP_TYPE_DOWNSTREAM;
> > +			pdev->pcie_flags_reg |= FIELD_PREP(PCI_EXP_FLAGS_TYPE,
> > +							   PCI_EXP_TYPE_DOWNSTREAM);
> >  		}
> >  	}
> >  }
> > -- 
> > 2.56.1
> > 
