Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7303B1EC7;
	Tue, 28 Jul 2026 18:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785261798; cv=none; b=pMu5Yscwli4jCnGRP5E6Z152dffiwS1z68kqxTcmocnC3eJ+UV6yZ+iRXCO31Vfc/V5W2zoHgwUKQiwupXzWSLNfwLGkCm/U5+e4Wog96ABo9j+OGG3s1x7+y7l4M2MXKCq7rcnaMIQO2fJxHC2x1IkoMWG6lysA45ytrjHYBpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785261798; c=relaxed/simple;
	bh=xb+Tg3MmX3+MWd+WMgo87IVlFWc+pgdiosaPwYzBdHw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bxldCIbI4swLCG0DecG+wDoUtYBoqIJatiuEToIJ7lS5TX4+wKRiCV0nfx11S8jrsmzdimmPKhYWyKIMTHB14OeQfeoq59pNeaKgOrDdOdpPeX92G2ciZw/VZX5/L9k8Zagzn0pbOrrWNHb8L7cF9j1fxYqnYx6XSiKXAuJ1Xsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRUxQDpC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRUxQDpC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C03D1F000E9;
	Tue, 28 Jul 2026 18:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785261797;
	bh=koKIBERje7VOI/wRscqhkRYHC41pZNMUtF38onhCcAU=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=SRUxQDpCG8tvtsk+Xnkx7OGwWxvYz4mrQVcF36s93QCt+saFxp8aQUI/MyeGCnvWg
	 TFq0KpXjNY0q0ZpwtGQTTk0N2CfbKVXESfI4kBa1JXbMMdWuPxEcY/HJU1UrsI+p/n
	 edSmYC9y62KuID5uR4b4aAlIMp8SL3LykrGmbN+tLLTpR+4E9iFOc6fa9yX4FUS3RO
	 78Dn7kOLhse/hRORtFhz9AAKasUkg7kcIMNX/jNMGgackA8TemqMOo6onFZDY3uvlS
	 F++TZBBmAemzKDefAuNiy30+UyKYOQ9d+G9u5V1LGwBWVPIcxjpj4XT2VsSo8w3cCu
	 yf9fcHdGxvTjA==
Date: Tue, 28 Jul 2026 13:03:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc: "lukas@wunner.de" <lukas@wunner.de>,
	"thierry.reding@kernel.org" <thierry.reding@kernel.org>,
	"mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
	"treding@nvidia.com" <treding@nvidia.com>,
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Disable NoSnoop and Relaxed ordering for Intel
 wireless BE200
Message-ID: <20260728180315.GA1380884@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <534363f87b37ba6f1449d0524400bcfd7fdf5b3e.camel@intel.com>

On Thu, Jul 23, 2026 at 11:35:41AM +0000, Grumbach, Emmanuel wrote:
> On Thu, 2026-07-23 at 15:19 +0530, Manikanta Maddireddy wrote:
> > On 22/07/26 10:34 pm, Bjorn Helgaas wrote:
> > > > The problem was that we didn't show up at all in the enumeration.
> > > > We
> > > > send a malformed TLP. I'm not quite an expert at this, but our
> > > > PCIe
> > > > experts run a PCI analyzer on the enumeration on that specific
> > > > platform and they saw that platform's PCI controller sets the
> > > > NoSnoop and Relaxed ordering bit in the TLP. According to the
> > > > spec
> > > > (which I ignore), the BE200 is supposed to return the TLP as
> > > > received, but we reply with 0 Attributes and the enumeration
> > > > doesn't
> > > > complete successfully.
> > > I'm curious about the details of this enumeration failure.  Do you
> > > know which TLPs had No Snoop and Relaxed Ordering set?  Per the
> > > PCIe
> > > spec, they shouldn't be set for the config requests used for PCI
> > > core
> > > enumeration.
> > > 
> > > At least*some* config reads to the BE200 must work; otherwise, we
> > > wouldn't know the Vendor or Device ID, which we need to apply the
> > > quirk.  So I think you should see something like this in dmesg, and
> > > BE200 would probably appear in lspci output:
> > > 
> > >    pci 0000:04:00.0: [8086:272b] type 00 class ...
> > > 
> > > Is the failure that iwl_pci_probe() itself fails somehow?
> > > 
> > > You mentioned that this happens on Jetson Thor, but I'm not sure
> > > what PCIe controller that is.  My guess is it might be Tegra264
> > > [1], which doesn't look like it's merged yet.
> > > 
> > > Thierry, Manikanta, do you have any insight into this?  Does
> > > this PCIe controller set No Snoop and Relaxed Ordering for some
> > > reason?  I don't think endpoint drivers are expecting that.
> > > 
> > > [1]https://lore.kernel.org/linux-pci/20260716-tegra264-pcie- 
> > > v8-0-23e51589229b@nvidia.com/
> > 
> > Hi,
> > 
> > Jetson Thor(Tegra264) is not setting NoSnoop and RlxdOrd bits in
> > config 
> > read TLP.
> > 
> > I made sure that both these bits are set in RP's DevCtl
> > 
> >                  DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
> >                          RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
> > 
> > and dumped TLP header for a config read towards BDF 0x100 with offset
> > 0x24.
> >     0x04000001      0x0000000f      0x01000024      0x00000000
> > 
> > I think dmesg and AER log with header information might help with
> > this 
> > particular issue.
> 
> Ok, so I checked again the logs and I was wrong.
> We do see the device in the enumeration, it does show up in lspci.
> Problems start when we want to access our registers.
> I attached the full dmesg output. In that log we try to load iwlwifi
> twice.
> 
> I'm adding here the snippet of the first load:
> 
> [   15.275887] iwlwifi 0001:01:00.0: Adding to iommu group 53
> [   15.279737] iwlwifi 0001:01:00.0: enabling device (0100 -> 0102)
> [   15.280047] iwlwifi 0001:01:00.0: HW_REV=0xFFFFFFFF, PCI issues?  \\ **

The "enabling device" message is from pci_enable_resources(), called
in the pci_enable_device() path.  The 0100 is from a config read of
PCI_COMMAND, and the 0102 is from adding PCI_COMMAND_MEMORY to enable
memory BARs.

The "HW_REV=" is from iwl_pci_probe(), which looks like the very first
MMIO read to a BE200 BAR.

So I guess the theory is that Tegra264 set NoSnoop and/or RlxdOrd in
the MMIO read, BE200 didn't copy the attributes from the Request to
the Completion as required by PCIe r7.0, sec 2.2.9.1, and Tegra264
logged a Malformed TLP?

AFAICS we still don't know why Tegra264 would set NoSnoop and/or
RlxdOrd in the MMIO read.

Unless iwlwifi asked for NoSnoop and/or RlxdOrd to be set, I think
it's a potential problem for drivers if Tegra264 sets them.

> [   15.280070] iwlwifi: probe of 0001:01:00.0 failed with error -5  \\ **
> [   15.280087] pcieport 0001:00:00.0: AER: Correctable error message received from 0001:00:00.0
> [   15.280104] pcieport 0001:00:00.0: DPC: containment event, status:0x3f01 source:0x0000
> [   15.280110] pcieport 0001:00:00.0: DPC: unmasked uncorrectable error detected
> [   15.280127] pcieport 0001:00:00.0: AER: found no error details for 0001:00:00.0
> [   15.280154] pcieport 0001:00:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
> [   15.280157] pcieport 0001:00:00.0:   device [10de:22d8] error status/mask=00040000/04400000
> [   15.280160] pcieport 0001:00:00.0:    [18] MalfTLP                (First)
> [   15.280163] pcieport 0001:00:00.0: AER:   TLP Header: 4a008001 01000004 00000028 72040000
> [   15.280274] pci 0001:01:00.0: AER: can't recover (no error_detected callback)
> 
> Does that help?
> 
> > 
> > Thanks,
> > Manikanta


