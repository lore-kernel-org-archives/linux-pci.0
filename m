Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8371F3D7D75;
	Tue, 16 Jun 2026 06:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781590985; cv=none; b=qoceAbOsRbyTa+mqYbJvQew9BhHAH7XLc2jm7BwDRNgfIzMbTu2l0P6aMIJ05WvvSRu447EdcpaSc2aZNWA9x50v2E1hyDDFpG8Dp9mPVjsrozZ6tfrnWNHFAdr8e+zgnHkDqn+dLUMFBCGL/VBjxV/J570wFjZIZSX0vwwI2Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781590985; c=relaxed/simple;
	bh=2hZD5P6iv4LV6rM2c31XzUClq7PpjRi0KqyOvpDKgLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcmZr0f8KBdg58su1GhjIeC3oBh6HnF80jlYj+1ec9gwFcYYUCUw0BZ7fSXH8B/h9+lZP1A0qRn4xKMPa2ceiC8sELtBgC6R4pS9ZaCfajGI627PaQBw+pwjC7f5x9b4Pe02gckDNFC0v/PYa3Uyg8FegtBZadLOgSRIXalm4+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6GSroaw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6GSroaw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF171F000E9;
	Tue, 16 Jun 2026 06:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781590984;
	bh=JgENt1aUql5leWB11YhE4AQhVjtbVDS4QwxhrhSyIHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K6GSroawCwbP0PxVEQc17I3NazJ7RtNnYjSWzZ6hX8BidX+413z4mve6p06B6m9mB
	 rjLO9xYk4L11ZlS58wskr7I3MmKAHk9oyEmVlNDpEuO1gvh25fmpDuDrRnFDKhkwGl
	 DM6UEXr6vP23ROYX/Bhz1jUgZDponk+coNBaagfsqGnRXRRalAW79bIq1FFyA/ghGQ
	 wWMuGcAn/SgRZmPD5/pITbQoucTk3Ju5OUrn/WTLX4P3Fi6/sBMvSq7HyZeHRkmFW1
	 cpAdgXkypm7w2V1XKvTExM+7xheraW5WRnldrwcrJhyUh7hmUpVrw+pBppo7+z6Eqg
	 U/kvYrg5/KCZw==
Date: Tue, 16 Jun 2026 08:22:53 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, kwilczynski@kernel.org, bhelgaas@google.com, corbet@lwn.net, 
	kishon@kernel.org, skhan@linuxfoundation.org, lukas@wunner.de, cassel@kernel.org, 
	alistair@alistair23.me, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, s-vadapalli@ti.com, danishanwar@ti.com, srk@ti.com
Subject: Re: [PATCH v5 3/4] PCI: endpoint: Add support for DOE initialization
 and setup in EPC core
Message-ID: <grfjlghqd3k3i3uxll2jksrh7pgi2mtxifbq2vymsdgbzijsnq@dvgu2qp2hza3>
References: <20260611191252.GA499821@bhelgaas>
 <0216a528-3737-4714-b9d1-5d28008e0ec8@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0216a528-3737-4714-b9d1-5d28008e0ec8@ti.com>

On Fri, Jun 12, 2026 at 01:54:13PM +0530, Aksh Garg wrote:
> 
> 
> On 12/06/26 00:42, Bjorn Helgaas wrote:
> > On Wed, Jun 10, 2026 at 03:32:55PM +0530, Aksh Garg wrote:
> > > Add pci_epc_init_capabilities() in EPC core driver to initialize and
> > > setup the capabilities supported by the EPC driver. This calls
> > > pci_epc_doe_setup() to setup the DOE framework for an endpoint controller,
> > > which discovers the DOE capabilities (extended capability ID 0x2E), and
> > > registers each discovered DOE mailbox for all the functions in the
> > > endpoint controller.
> > > 
> > > Add pci_epc_deinit_capabilities() in EPC core driver for cleanup of the
> > > resources used by the capabilities of the EPC driver. This calls
> > > pci_ep_doe_destroy() to destroy all DOE mailboxes and free associated
> > > resources.
> > > 
> > > Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > Signed-off-by: Aksh Garg <a-garg7@ti.com>
> > > ---
> > > +/**
> > > + * pci_epc_doe_setup() - Discover and setup DOE mailboxes for all functions
> > > + * @epc: the EPC device on which DOE mailboxes has to be setup
> > > + *
> > > + * Discover DOE (Data Object Exchange) capabilities for all physical functions
> > > + * in the endpoint controller and register DOE mailboxes.
> > > + *
> > > + * Returns: 0 on success, -errno on failure
> > > + */
> > > +static int pci_epc_doe_setup(struct pci_epc *epc)
> > > +{
> > > +	u8 func_no, vfunc_no = 0;
> > > +	u16 cap_offset;
> > > +	int ret;
> > > +
> > > +	if (!epc->ops || !epc->ops->find_ext_capability)
> > > +		return -EINVAL;
> > 
> 
> Hi Bjorn,
> 
> Thank you for your feedback comments. I will work on them and post v6
> series incorporating the changes.
> 
> > I don't see anything that sets pci_epc_ops.find_ext_capability in this
> > series, so this looks currently unused and untestable, so likely not
> > mergeable as-is.  What's the plan for users of this?
> > 
> 
> Currently there is no EPC driver upstream which supports DOE yet. However, I
> am working on a platform which supports DOE (support for
> which would be added soon). Mani pointed out that if EPC driver support
> for the same is guaranteed to be added soon, the APIs can be merged
> first.
> 
> For the demonstration purpose, he asked to show how an EPC driver is
> expected to use the API as a snippet in the cover letter itself.
> 

I retract my previous comment here. Let's not introduce dead code in the kernel.
We can review the series now, but cannot merge it until the EPC driver gets
submitted.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
