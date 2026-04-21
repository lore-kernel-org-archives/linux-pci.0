Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3671C32E73E;
	Tue, 21 Apr 2026 18:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776794771; cv=none; b=fKW7nqRfN1vmf/+8psI16wiun2wsxR7mDpCYWZkt4vICWEtCCvyycLLuRwt6g+ymTp+5Jpqf08+ctZhkZcc/JHfGc+bSbrS3hGnhsguEtevJaNlQV+x4my+AEjb8TSp73RypiRjtp1I2/IuqJ4N+XEdBPilRjtMXJi49MqHLdik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776794771; c=relaxed/simple;
	bh=u2RU2iJp8nX9T6KmxrOd41O8bck9nLkdUdgISmWWn2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KolmOHBu9Tb/6S/R4XrruaFYw4Hp9W6sM28IGAiBcRwWcAJhYTT+bX8QnTah0BCyFdzggIt0LWMwQADPtCSKZDLRCia9XoV2Eii70cd9WkAnJQTx4Wz6NaF3DzCUY4UPcJiWKF3RQGuRgGZ4gbIEX5FVJ5DtCbOomM02ifxJgwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIkB/NLg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIkB/NLg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4409BC2BCB0;
	Tue, 21 Apr 2026 18:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776794770;
	bh=u2RU2iJp8nX9T6KmxrOd41O8bck9nLkdUdgISmWWn2Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VIkB/NLg2o4NBxFhjl0fZKqzN4Zn5OGedFrSN4DpdTdyY/Ah4xgtToDWkbkp6dSEr
	 VpLLrr97GVvfU+uxeLtpXPgNcHeQkDYWPdpiYMoRGMzyytG2/Rnrzjlr6sFYVC+x7C
	 7XQqPox+J+7FQZnH+WHWlCFCTvYxe2PBfIRqdEacS4L2+/f9pHt9JKnArTjJcX0N5p
	 cYJxud0bbd0DfbyFhZWyMY6h9tsXVMn8/JWW/1CfVYYcCA6ExwSMzLyBBVtquSe76x
	 O81sLhKvb1WdS+ER5gzKtVPT1afMLZ6/YflRxhjz0myWBXZ+lLo68P5QFggCkqF0Vr
	 j8iWNeA/Uq6rQ==
Date: Tue, 21 Apr 2026 13:06:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Jim Quinlan <james.quinlan@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Hans Zhang <18255117159@163.com>, Niklas Cassel <cassel@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1] PCI: Remove MPS/MRRS Kconfig settings
Message-ID: <20260421180609.GA313824@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403221144.GA429611@bhelgaas>

On Fri, Apr 03, 2026 at 05:11:44PM -0500, Bjorn Helgaas wrote:
> On Thu, Mar 26, 2026 at 05:13:11PM -0500, Bjorn Helgaas wrote:
> > This reverts b0e85c3c8554 ("PCI: Add Kconfig options for MPS/MRRS
> > strategy"), which allowed build-time selection of the "off", "default",
> > "safe", "performance", or "peer2peer" strategies for MPS and MRRS
> > configuration.  These strategies can be selected at boot-time using the
> > "pci=pcie_bus_tune_*" kernel parameters.
> > 
> > Per the discussion mentioned below, these Kconfig options were added to
> > work around a hardware defect in a WiFi device used in a cable modem.  The
> > defect occurred only when the device was configured with MPS=128, and
> > Kconfig was a way to avoid that setting.  It was easier for the modem
> > vendor to use Kconfig and update the kernel image than to change the kernel
> > parameters.
> > 
> > Neither Kconfig nor kernel parameters are a complete solution because the
> > WiFi device may be used in other systems where it may be configured with
> > MPS=128 and be susceptible to the defect.
> > 
> > Remove the Kconfig settings to simplify the MPS code.  If we can identify
> > the WiFi device in question, we may be able to make a generic quirk to
> > avoid the problem on all system.
> > 
> > This is not a fix and should not be backported to previous kernels.
> > 
> > Link: https://lore.kernel.org/all/CA+-6iNzd0RJO0L021qz8CKrSviSst6QehY-QtJxz_-EVY0Hj0Q@mail.gmail.com
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> I applied this on pci/misc for v7.1.

I decided not to apply this for v7.1 because there wasn't much time
left in the cycle, but I applied it again on pci/enumeration for v7.2.

> > ---
> >  drivers/pci/Kconfig | 62 ---------------------------------------------
> >  drivers/pci/pci.c   | 10 --------
> >  2 files changed, 72 deletions(-)
> > 
> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > index e3f848ffb52a..f1330d219763 100644
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -252,68 +252,6 @@ config PCI_DYNAMIC_OF_NODES
> >  	  Once this option is selected, the device tree nodes will be generated
> >  	  for all PCI bridges.
> >  
> > -choice
> > -	prompt "PCI Express hierarchy optimization setting"
> > -	default PCIE_BUS_DEFAULT
> > -	depends on PCI && EXPERT
> > -	help
> > -	  MPS (Max Payload Size) and MRRS (Max Read Request Size) are PCIe
> > -	  device parameters that affect performance and the ability to
> > -	  support hotplug and peer-to-peer DMA.
> > -
> > -	  The following choices set the MPS and MRRS optimization strategy
> > -	  at compile-time.  The choices are the same as those offered for
> > -	  the kernel command-line parameter 'pci', i.e.,
> > -	  'pci=pcie_bus_tune_off', 'pci=pcie_bus_safe',
> > -	  'pci=pcie_bus_perf', and 'pci=pcie_bus_peer2peer'.
> > -
> > -	  This is a compile-time setting and can be overridden by the above
> > -	  command-line parameters.  If unsure, choose PCIE_BUS_DEFAULT.
> > -
> > -config PCIE_BUS_TUNE_OFF
> > -	bool "Tune Off"
> > -	depends on PCI
> > -	help
> > -	  Use the BIOS defaults; don't touch MPS at all.  This is the same
> > -	  as booting with 'pci=pcie_bus_tune_off'.
> > -
> > -config PCIE_BUS_DEFAULT
> > -	bool "Default"
> > -	depends on PCI
> > -	help
> > -	  Default choice; ensure that the MPS matches upstream bridge.
> > -
> > -config PCIE_BUS_SAFE
> > -	bool "Safe"
> > -	depends on PCI
> > -	help
> > -	  Use largest MPS that boot-time devices support.  If you have a
> > -	  closed system with no possibility of adding new devices, this
> > -	  will use the largest MPS that's supported by all devices.  This
> > -	  is the same as booting with 'pci=pcie_bus_safe'.
> > -
> > -config PCIE_BUS_PERFORMANCE
> > -	bool "Performance"
> > -	depends on PCI
> > -	help
> > -	  Use MPS and MRRS for best performance.  Ensure that a given
> > -	  device's MPS is no larger than its parent MPS, which allows us to
> > -	  keep all switches/bridges to the max MPS supported by their
> > -	  parent.  This is the same as booting with 'pci=pcie_bus_perf'.
> > -
> > -config PCIE_BUS_PEER2PEER
> > -	bool "Peer2peer"
> > -	depends on PCI
> > -	help
> > -	  Set MPS = 128 for all devices.  MPS configuration effected by the
> > -	  other options could cause the MPS on one root port to be
> > -	  different than that of the MPS on another, which may cause
> > -	  hot-added devices or peer-to-peer DMA to fail.  Set MPS to the
> > -	  smallest possible value (128B) system-wide to avoid these issues.
> > -	  This is the same as booting with 'pci=pcie_bus_peer2peer'.
> > -
> > -endchoice
> > -
> >  config VGA_ARB
> >  	bool "VGA Arbitration" if EXPERT
> >  	default y
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 8479c2e1f74f..274c6685344e 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -120,17 +120,7 @@ unsigned long pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
> >  
> >  
> >  /* PCIe MPS/MRRS strategy; can be overridden by kernel command-line param */
> > -#ifdef CONFIG_PCIE_BUS_TUNE_OFF
> > -enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_TUNE_OFF;
> > -#elif defined CONFIG_PCIE_BUS_SAFE
> > -enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_SAFE;
> > -#elif defined CONFIG_PCIE_BUS_PERFORMANCE
> > -enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_PERFORMANCE;
> > -#elif defined CONFIG_PCIE_BUS_PEER2PEER
> > -enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_PEER2PEER;
> > -#else
> >  enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_DEFAULT;
> > -#endif
> >  
> >  /*
> >   * The default CLS is used if arch didn't set CLS explicitly and not
> > -- 
> > 2.51.0
> > 
