Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4752826E165;
	Thu, 23 Jul 2026 19:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836411; cv=none; b=qMFrqQZEr18Dn2ecnPu1C67kLb+PTNvjwqv7DNIC+mm6dYnHxeJnl5jgB0UNDeUq2sILkk/gM7lzewfDR5x47/Yh8F0+iUpAOuY+5sxp3snR688bnpNeyDwBm5t3dyikAQ35G8ebOlzAwxTZqX8yJrWBLJ8pdggjZxOC5Qy8PZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836411; c=relaxed/simple;
	bh=1aqx14EmUh0W3tdcGF4ZH3JxsIol+e0TAT402wCG36s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hjkoGItU1+QQjOYCXSZNptuj2tKScgQs4yaTOf6yjW/GNx8Ql5uEGJJFD0rKC8zTNHvMwZ6EpZBdqrqiAVQ8fiHkas7ZPopiGsaMcvirW1EgV7IKJsU7xkuPDgvt9VV8x1aVFv0aPTdxkLBM70DB9udbuYrpwKexgB90Tf+xBmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/Cp1BKb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/Cp1BKb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977701F000E9;
	Thu, 23 Jul 2026 19:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784836409;
	bh=klDxcqGjO/Iq9TQ3WkwCJV4JMMG+1hTjxKQ1RcKaCjs=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=e/Cp1BKb47OSvdHCRMnDfqjOLvjOVNRJKqtrmI0Uc94B/UOfjzui6BbdFPid5kQw8
	 EaOztuLlColW7JifXN6ibOlH4kza6azSZEbIvRsHab9EqVd0ihe39QIyLOMWj93kkT
	 ayF8zcQ+BouPzuoEtqCJ8wrdHkGc+i3MqGkzZSjIuXnXIkNkgkNA0W2mQ1Dqc5FrIm
	 FVTEac0ghAX2qUIfMTyK2W3pxA43dzRpNG0rbAoeo41ETOkdQvsNuS2qbsP9qQRaoq
	 zAfp/AZAgY0dZQDOaLyiE5SdG96tlrTBE+CkKL2r2kHkvf8yyN5fFCiCfJo716TTpf
	 PYaErpc80oV8g==
Date: Thu, 23 Jul 2026 14:53:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	joro@8bytes.org, linux-pci@vger.kernel.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	bhelgaas@google.com, alexander.deucher@amd.com, jgg@ziepe.ca,
	Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
Message-ID: <20260723195328.GA852751@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9595d4f-419f-4d42-bd22-c3a8964c370b@amd.com>

On Thu, Jul 23, 2026 at 11:32:49AM -0500, Mario Limonciello wrote:
> On 7/23/26 11:23, Vasant Hegde wrote:
> > On 7/23/2026 9:41 PM, Mario Limonciello wrote:
> > > On 7/23/26 10:59, Bjorn Helgaas wrote:
> > > > On Thu, Jul 23, 2026 at 06:15:48AM +0000, Vasant Hegde wrote:
> > > > > Certain AMD GPU's must always be in identity mode. Currently its enforced
> > > > > using PASID check. It worked fine as most GPU's has PASID feature. But
> > > > > this means, identity mode enforcement is done for all PASID capable devices.
> ...

> > +static bool quirks_force_identity_mapping(struct pci_dev *pdev)
> > +{
> > +       struct pci_dev *root_port;
> > +       int class = pdev->class >> 8;
> > +
> > +       /* AMD GPU vendor ID */
> > +       if (pdev->vendor != PCI_VENDOR_ID_ATI)
> > +               return false;
> > +
> > +       /* GPU class */
> > +       if (class != PCI_CLASS_DISPLAY_VGA &&
> > +           class != PCI_CLASS_DISPLAY_OTHER)
> > +               return false;
> > +
> > +       if (pci_upstream_bridge(pdev) &&
> 
> I don't think you need to check for pci_upstream_bridge() to be
> non-NULL.  You already checked that it's an endpoint by looking at
> the class.  So an endpoint will be connected to a bridge of some
> sort (either a switch internal to the dGPU or to a root port).

I think devices can be passed through to virtualized guests with no
upstream bridge visible to the guest, can't they?
