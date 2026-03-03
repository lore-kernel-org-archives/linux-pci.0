Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116B22AE8D;
	Tue,  3 Mar 2026 00:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772496219; cv=none; b=rShoki2sZUO4y4pO8GcU1hzuAY4uyvbkdORPmHsnKMSFDc0ndZjZG48fscjkRyRa8+Go6OBSrWDZvEALz4WmVN5ZPBE2521swXorb7GhyIroQL90rbisO0tMOmxDnKgVrJewxNLxPeMd2tBmIX2b6a+KeCVxlHDjLDvQtC2H270=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772496219; c=relaxed/simple;
	bh=4emZIzE+o1mlLRHR+GatVLXIOOg5njXFyaCJc8pf0XE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jNz7t8c1SbGtxuW69OYaAop/xgexrtKSGMWIqyY3PzpN2Ybvpjcl+Cgq1rfACOPcri0kPcWqw3yPlolx18vlTh+wR8Z+DndHvao1Z2oqynzg7onjlkAJ3QtxskA9LG2WD3LhK+FfyXKQ8n5zd6FBp4ICzpEro0ULC/4jVMpmuAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rT7R3VyZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rT7R3VyZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52271C19423;
	Tue,  3 Mar 2026 00:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772496218;
	bh=4emZIzE+o1mlLRHR+GatVLXIOOg5njXFyaCJc8pf0XE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rT7R3VyZBPsn1Tn+AKkUHaZkbdt3ESIvze8qu4nTPOUkCpqcFH7Rwn2lYTWZ2RRot
	 lyh1kFyd/nk6onbJJ3pe/rOqrQxHTUj6e9VxyT6yKcy8Pe2tyaYg3X0TpyNqIVxWkP
	 mDQfzDU0OB+QHWACtijiH4cB9YyTeZHJ/BLXC/odqSH/Mq1+ZPvrEZpCOX9KMa62F/
	 0n/d2y2UfLGJWfTDmGWR4jINaFdTybaHJ0jXraGt1jyTHgSxJsjeZU3efGUJaPldSc
	 tl4744T6gntm4YbGw7c5iMM/OxYH15RlQ8uCA9wQWp7k9O6KUPNueO78zFdBitj6NF
	 APJtEyQw3eNnQ==
Date: Mon, 2 Mar 2026 18:03:37 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	Hans Zhang <18255117159@163.com>, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v2 RESEND 1/1] PCI: pcie_bus_config can be set at build
 time
Message-ID: <20260303000337.GA4038046@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNzJM=C+Byb+wnmPYdJcYoTT7N-XwE3o2OpJzmcJrtOc8A@mail.gmail.com>

On Tue, Feb 24, 2026 at 04:10:17PM -0500, Jim Quinlan wrote:
> On Fri, Feb 20, 2026 at 5:11 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Sep 28, 2020 at 03:46:51PM -0400, Jim Quinlan wrote:
> > > The Kconfig is modified so that the pcie_bus_config setting can be done at
> > > build time in the same manner as the CONFIG_PCIEASPM_XXXX choice.  The
> > > pci_bus_config setting may still be overridden by the bootline param.
> > >
> > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> >
> > We merged this as b0e85c3c8554 ("PCI: Add Kconfig options for MPS/MRRS
> > strategy"), which appeared in v5.10.
> >
> > In retrospect, I think this might have been a mistake because it
> > forces a build-time configuration for something that may not be known
> > at build time and can be set via command-line parameter.
> ...

> > But I can't find any discussion about it.  Did you have a use case
> > where command line parameters weren't usable?
> 
> Yes.  We have a Cable Modem (CM) customer who can update their Linux
> version but cannot update their boot loader or its default bootline.
> FWIW, they only want the option to set pcie_bus_config to
> PCIE_BUS_SAFE via the .config.
> ... 

> It's a CM product which uses a particular Wifi chip.  Recognizing this
> scenario would have the RC trying to grab the EP's vendor-id (and
> possibly more info), and that seems awkward at best.

This is actually kind of weird.  I don't know why a particular device
would have any special MPS or MRRS requirements.

Do you have any more details about this?  Does the WiFi chip actually
not *work* with other MPS settings?  Or is this a performance thing
where other settings don't give acceptable performance?

I assume there's no hotplug in this setup, so we don't't have to worry
about adding new devices at runtime.  Do you know if there's any
P2PDMA usage?
