Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B602E9729;
	Mon,  8 Jun 2026 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933473; cv=none; b=MHi6BVZOLwrr8Rmq16o7T4WK1rkuYvFVqEnEFBLqVPj0bB1iShYRsRN0p/o4EreF3gAGy7tD7I7+ID4xRS4n9rm0Jlv+R7wdEGRIiYWNalDK8VD8NYjfh4OnS0biMp3Z2iOnDc9zJzyMenoLx0uHMgNiJCtS/nHaSyocJCxmsAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933473; c=relaxed/simple;
	bh=9H1+IAr+cX7/YPZowzjYlyASpJNhEZTYrSMu5XRIfeE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=reyvxc1h8LWvwgy8hI5YOESaA09B+w1Ym85nGs+fF2GVgvRNbOOLZ1dlDSejKcp4qyp2y5bDZ3xB+64Vf1/+SzVJqRctoQTudky3kWEMRgdPvgQM1gdEeHeJmvzF9HR0lMVbkbAYdHz0VLRrsuCai4L3MzqWoM2SowRFD4KLTK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFquHVI6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFquHVI6"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1A65E1F00893;
	Mon,  8 Jun 2026 15:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780933472;
	bh=Lw/Xcp0P7CyMiPt/7LQ9xmZdvftr7VlOQ72Z6l9jLMw=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=VFquHVI6BdJzhXA8gbjd+I06+m8yUP/owdM1OSopjnDKRofXc/J8hNQRjhOgQCLb9
	 MGnGdFRzxcpIqtXZBWSOkXEu2lviBI4gm0ER8D6e2/YZn3tKxc/ZQttfq/Disp18tR
	 N09slHqrqmEmQkpD4qAMoONWK9hkqpzMG08OdACQg6oZdU7/lS+xFKsY7xG6GYqP0Z
	 1kR5MiVtt7xK0iVIKUIb4/2zjHqV9iGruPesI2Y6T62G9mWbEznjwo7+dA+TL+kdNO
	 OAUn8LAQM8x9uIuENOHExk3r1oV1xoL6fGbLXWPKMYCClePfOYF8ItwBAD2BysA1i3
	 OfQRxeEGARqWg==
Date: Mon, 8 Jun 2026 10:44:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI/CXL: Allow PM Init to complete on cxl_bus reset
 if ACS SV enabled
Message-ID: <20260608154431.GA36788@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428182454.464655-2-fabio.m.de.francesco@linux.intel.com>

On Tue, Apr 28, 2026 at 08:24:34PM +0200, Fabio M. De Francesco wrote:
> CXL r4.0 sec 8.1.5.1 Implementation Note describes a scenario in which
> issuing a Secondary Bus Reset on a CXL Downstream Port leaves the
> Port Power Management Initialization Complete bit unset when the PCIe
> Access Control Service (ACS) Source Validation bit (SV) is enabled on
> the Downstream Port. The spec states that another SBR alone will not
> facilitate recovery and shows a software recovery sequence.
> 
> Implement the sequence by extending cxl_reset_bus_function() to save,
> clear, and restore ACS SV and Bus Master Enable (BME) on the Downstream
> Port around the SBR with the use of helpers.
> 
> The wait inside pci_bridge_secondary_bus_reset() covers the 100 ms
> referenced by the spec. The helpers return when ACS SV is not enabled on
> the Downstream Port.

When reposting, fix subject line of cover letter.

> + * cxl_reset_bus_function - SBR for a child of a CXL downstream port
> + * @dev: child device whose upstream bridge is a CXL downstream port
> + * @probe: if true, only check whether the reset is supported
> + *
> + * Issues an SBR on @dev's parent bus. Temporarily sets the CXL Port
> + * DVSEC Unmask SBR bit across the reset. When ACS Source Validation
> + * is enabled on the bridge, also temporarily clears Bus Master Enable
> + * and ACS Source Validation, per CXL r4.0 sec 8.1.5.1.

Use imperative mood consistently.  ("Issue ...", "Temporarily set
...").

> + * Return: 0 on success, -ENOTTY if the reset cannot be issued, or an
> + * errno from the reset path.
> + */
>  static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  {
>  	struct pci_dev *bridge;
>  	u16 dvsec, reg, val;
> +	u16 saved_cmd = 0, saved_acs_ctrl = 0;
>  	int rc;
>  
>  	bridge = pci_upstream_bridge(dev);
> @@ -4957,6 +5002,8 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  		return rc;
>  	}
>  
> +	cxl_disable_acs_sv_bme(bridge, &saved_cmd, &saved_acs_ctrl);
> +
>  	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR) {
>  		val = reg;
>  	} else {
> @@ -4971,6 +5018,8 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
>  				      reg);
>  
> +	cxl_restore_acs_sv_bme(bridge, saved_cmd, saved_acs_ctrl);
> +
>  	pci_dev_reset_iommu_done(dev);
>  	return rc;
>  }
> -- 
> 2.53.0
> 
