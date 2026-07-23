Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B385B3C1097;
	Thu, 23 Jul 2026 21:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784840569; cv=none; b=tiFOQdwXJ0EGykBaGWEgV6uqDrdMtLHc/l5cXCFJ7P5sxoAJB2j+RQNKHk1znTyYbDfkiTktZQ1Q4/Z32LEMcO0KbSlrkugyfQvpGCUWiaXD+XEgFb4zN+ZS9SM2EP/TLGRByWQnDGbCdEiQePI1gEt6u8fdmi1Q77ApSORl4Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784840569; c=relaxed/simple;
	bh=YjNRzJD2CRV1QZk0fZHE8UwrrZonxcGYW8gLmOB6pnA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GKgpw1cbYVCafAPMxLAv9A5ZVC9ap1SpkBjQEzligN8sltBdI6Nu4aLNEUJbeYLSvw1ryp668bSKqmidjxUXDVlySIiruYggPHNRWmcWkHj2mlDJQdEWoJcPXMR6IfibBASOqpB1AQqPf6ZcleWCp1LlPBOrfD/jDVRvQSck9tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+GNuK1J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+GNuK1J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2966C1F000E9;
	Thu, 23 Jul 2026 21:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784840568;
	bh=8Aq0VIIJ8LKClnnjnBMW8rUxAJy/+/z70CBPVRyzrLw=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=O+GNuK1JbjE16BdqOXqI8IKCVj+MdNkhqVyqEb4qzBB4AH09EWLP83uZieUjayUPr
	 rGMnTc3nG2DuHMEFQWs5jTM4Hne7LNYtnPmpeO0E3oJ1SSPvGYITVWwLL12zs4HJ59
	 m5VE//wKqmA7hw/MzeBVd2YuUAFb6aKv2dJAQqGzoL4eXVGhA9NHgEeQ1N2KCP7I75
	 0xHu5KtZoambog7Ju7R8yKcayHleu8WLHurc/ijKaStanCfIl8tMs70rP6SOwxCJUF
	 9qthbt0O3H3JUglxSJuVDrt0bFfTZRDvsYoMrhrVAw7UnJyIrLIHTBl8jJHuKl3qYQ
	 XkK04+eusd1kg==
Date: Thu, 23 Jul 2026 16:02:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	joro@8bytes.org, linux-pci@vger.kernel.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	bhelgaas@google.com, alexander.deucher@amd.com, jgg@ziepe.ca,
	Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
Message-ID: <20260723210246.GA856455@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70e6d40b-3e13-4efd-b1e7-62195ff66e91@amd.com>

[+cc Gerd, Alex]

On Thu, Jul 23, 2026 at 02:58:14PM -0500, Mario Limonciello wrote:
> On 7/23/26 14:53, Bjorn Helgaas wrote:
> > On Thu, Jul 23, 2026 at 11:32:49AM -0500, Mario Limonciello wrote:
> > > On 7/23/26 11:23, Vasant Hegde wrote:
> > > > On 7/23/2026 9:41 PM, Mario Limonciello wrote:
> > > > > On 7/23/26 10:59, Bjorn Helgaas wrote:
> > > > > > On Thu, Jul 23, 2026 at 06:15:48AM +0000, Vasant Hegde wrote:
> > > > > > > Certain AMD GPU's must always be in identity mode. Currently its enforced
> > > > > > > using PASID check. It worked fine as most GPU's has PASID feature. But
> > > > > > > this means, identity mode enforcement is done for all PASID capable devices.
> > > ...
> > 
> > > > +static bool quirks_force_identity_mapping(struct pci_dev *pdev)
> > > > +{
> > > > +       struct pci_dev *root_port;
> > > > +       int class = pdev->class >> 8;
> > > > +
> > > > +       /* AMD GPU vendor ID */
> > > > +       if (pdev->vendor != PCI_VENDOR_ID_ATI)
> > > > +               return false;
> > > > +
> > > > +       /* GPU class */
> > > > +       if (class != PCI_CLASS_DISPLAY_VGA &&
> > > > +           class != PCI_CLASS_DISPLAY_OTHER)
> > > > +               return false;
> > > > +
> > > > +       if (pci_upstream_bridge(pdev) &&
> > > 
> > > I don't think you need to check for pci_upstream_bridge() to be
> > > non-NULL.  You already checked that it's an endpoint by looking at
> > > the class.  So an endpoint will be connected to a bridge of some
> > > sort (either a switch internal to the dGPU or to a root port).
> > 
> > I think devices can be passed through to virtualized guests with
> > no upstream bridge visible to the guest, can't they?
> 
> None of the GPUs in APUs support SRIOV, so there isn't a VF to be
> passed in to a guest.  But I guess you could pass the whole endpoint
> in.
> 
> When passed into a guest doesn't it end up associated behind a root
> port in the guest though?

I don't think the Root Port is always passed into the guest.  From
1ae8c4ce1570 ("PCI: Enable AtomicOps only if Root Port supports
them"):

  On s390 and many virtualized guests, the Endpoint is visible but the
  Root Port is not.  In this case, pci_enable_atomic_ops_to_root()
  previously enabled AtomicOps in the Endpoint even though it can't
  tell whether the Root Port supports them as a completer.

Maybe Alex will chime in and tell us more about non-s390 guests.
