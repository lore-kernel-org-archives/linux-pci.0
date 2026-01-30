Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E701624D5;
	Fri, 30 Jan 2026 03:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769743818; cv=none; b=Vl1JSdinrpu4AkFluUoBEtNPSwr951x14Rr2DujYuJdAtRr1HkKYPNCK9WdTn+PqoatOAF6XksEenopzgflsjYdYA0pyG47A/FXCpAHBfj3w3yOkwNSCZvkT1yZ2MZ0JFIlSCcYpR/F5nAKpeZK6VdTwYzx+AumaneZeTDP7PJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769743818; c=relaxed/simple;
	bh=okHqWEPNmTmLXzWUsl1Zg7XjbwpS3tu5EZ2NM0mJEeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFtW0aLh3vFd/AvrTr9AtIp65kBGxY0oKsPlNMWqe9XFgbk5SftEZw0bHDcZQFjwRYwZE9AvLrxVyZ8+sZ4R9F1Nzub0fibjpkY/Ivg+PyAAzHN9NtNunWjBZd085YfTv3Dm+71Y+HAPghC7Aa07F9bQd0px1/6Q/5pLtAj/6UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JoAb7VsD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoAb7VsD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF35C4CEF7;
	Fri, 30 Jan 2026 03:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769743817;
	bh=okHqWEPNmTmLXzWUsl1Zg7XjbwpS3tu5EZ2NM0mJEeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JoAb7VsD45CW+h+5tdwec67bELx1JS4HsmrJJC7JbW+UGBeyMUK6X2rOsAMOiinwk
	 qB/YWDu5Gf0o0dzFLIO58/FztoKUf2ce20dK+Oj+B4ibsic1UlNDgaqfxT4+lDZLan
	 OHZsevrBE5eTEE1haTCoT3+kx7KxEQ1eXw0r5uR6R6wR/Z2RmikIXYqAYyfKMEGIbY
	 u8XLFTJTonRPL7k2Sm5v0KuhnSUn0ub9XzS1eOAv0aK/5aCdo4wlFAGxTr1agZvrYO
	 X3PvLjv90CcRu2dorgVj9ZRHTi0WhxFCVPbmPWAHcyxeogETjiTqYdBqXyXUgfEd+f
	 Ni70RVyA7BoZA==
Date: Thu, 29 Jan 2026 21:30:14 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, jonathanh@nvidia.com
Subject: Re: [PATCH 1/3] PCI: host-common: Add shared D3cold eligibility
 helper for host bridges
Message-ID: <bz2dnldnx2z6o3jtm7hdy4f3azmd4ug2sq2pi7anuar7s7xssq@b7cqfkr7pd36>
References: <20260128-d3cold-v1-0-dd8f3f0ce824@oss.qualcomm.com>
 <20260128-d3cold-v1-1-dd8f3f0ce824@oss.qualcomm.com>
 <kztudduots342zz7gnx3twtlvjm5pd7sde627zxcsbe6c2imqk@7mmp7vjght5j>
 <832e8ea4-2b85-4513-a285-9d4ab1dd66b0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <832e8ea4-2b85-4513-a285-9d4ab1dd66b0@oss.qualcomm.com>

On Thu, Jan 29, 2026 at 11:08:57AM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 1/28/2026 7:56 PM, Bjorn Andersson wrote:
> > On Wed, Jan 28, 2026 at 05:10:41PM +0530, Krishna Chaitanya Chundru wrote:
> > > Add a common helper, pci_host_common_can_enter_d3cold(), to determine
> > > whether a PCI host bridge can safely transition to D3cold.
> > Please read https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
> > 
> > It clearly says that you're supposed to start your commit message with a
> > description of the problem you're solving. In fact, even after reading
> > the entire commit message a few times I only know what the patch does,
> > but it's not clear to me why this patch exists.
> > 
> > > The helper walks all devices on the bridge's bus and only allows the
> > > host bridge to enter D3cold if all PCIe endpoints are already in
> > > PCI_D3hot.
> > The code below does walk the bus, but it doesn't allow/disallow anything
> > as far as I can tell, it queries their type, state, and if they are wake
> > capable?
> > 
> > > For devices that may wake the system, it additionally
> > > requires that the device supports PME wakeup from D3cold(with WAKE#).
> > > Devices without wakeup enabled are not restricted by this check and can
> > > be allowed to keep device in D3cold.
> > > 
> > Again, this code doesn't perform any action, it doesn't
> > allow/disallow/restrict the devices from doing anything, it merely
> > queries a bunch of things across all devices, and the commit message
> > fails to capture why this is useful.
> This is a helper function used by controller drivers, to know if the
> controller
> driver can keep in D3cold state or not. we use endpoint states and their
> wakeup
> capability support to determine d3cold can be supported or not. The return
> value
> of this function will tell controller drivers to know if we can allow D3cold
> or not.

Please make sure that the commit message captures this.

Regards,
Bjorn

> > > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > > ---
> > >   drivers/pci/controller/pci-host-common.c | 29 +++++++++++++++++++++++++++++
> > >   drivers/pci/controller/pci-host-common.h |  2 ++
> > >   2 files changed, 31 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> > > index c473e7c03bacad2de07c798768f99652443431e0..225472c5ac82c6c5b44257d68a0fc503ec046ff1 100644
> > > --- a/drivers/pci/controller/pci-host-common.c
> > > +++ b/drivers/pci/controller/pci-host-common.c
> > > @@ -106,5 +106,34 @@ void pci_host_common_remove(struct platform_device *pdev)
> > >   }
> > >   EXPORT_SYMBOL_GPL(pci_host_common_remove);
> > > +static int pci_host_common_check_d3cold(struct pci_dev *pdev, void *userdata)
> > > +{
> > > +	bool *d3cold_allow = userdata;
> > > +
> > > +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
> > > +		return 0;
> > > +
> > > +	if (pdev->current_state != PCI_D3hot)
> > > +		goto exit;
> > > +
> > > +	if (device_may_wakeup(&pdev->dev) && !pci_pme_capable(pdev, PCI_D3cold))
> > > +		goto exit;
> > > +
> > > +	return 0;
> > > +exit:
> > > +	*d3cold_allow = false;
> > > +	return -EBUSY;
> > > +}
> > > +
> > > +bool pci_host_common_can_enter_d3cold(struct pci_host_bridge *bridge)
> > Please add kernel-doc for any EXPORT_SYMBOL() functions, so that it's
> > clear to the next guy what the API does.
> Initially, I had a change in my workspace which has kernel-doc, but after
> seeing this
> file I see none of the exported API's had a kernel-doc. Following it I
> dropped the kernel
> -doc at last minute. I will add this in v2.
> 
> - Krishna Chaitanya.
> > 
> > Regards,
> > Bjorn
> > 
> > > +{
> > > +	bool d3cold_allow = true;
> > > +
> > > +	pci_walk_bus(bridge->bus, pci_host_common_check_d3cold, &d3cold_allow);
> > > +
> > > +	return d3cold_allow;
> > > +}
> > > +EXPORT_SYMBOL_GPL(pci_host_common_can_enter_d3cold);
> > > +
> > >   MODULE_DESCRIPTION("Common library for PCI host controller drivers");
> > >   MODULE_LICENSE("GPL v2");
> > > diff --git a/drivers/pci/controller/pci-host-common.h b/drivers/pci/controller/pci-host-common.h
> > > index b5075d4bd7eb31fbf1dc946ef1a6afd5afb5b3c6..18a731bca058828340bca84776d0e91da1edbbf7 100644
> > > --- a/drivers/pci/controller/pci-host-common.h
> > > +++ b/drivers/pci/controller/pci-host-common.h
> > > @@ -20,4 +20,6 @@ void pci_host_common_remove(struct platform_device *pdev);
> > >   struct pci_config_window *pci_host_common_ecam_create(struct device *dev,
> > >   	struct pci_host_bridge *bridge, const struct pci_ecam_ops *ops);
> > > +
> > > +bool pci_host_common_can_enter_d3cold(struct pci_host_bridge *bridge);
> > >   #endif
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > > 
> 
