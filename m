Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9D733987F;
	Thu, 21 May 2026 21:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779399086; cv=none; b=SaFHzkmT8CezgVRUzsjt2TMCX+SKovlgiJVT3PLCY2HD8BYIc2TIJtwO3fB4rRk/HsuQTOZ6Glqw/kXeBZVvlbkE9J6LdNUJh74kSMbfmqpacy1HJX+COp5wD58G0tQut26ill8zsYVJ6XFxuqWVDtaxraIeoqaScUegI/ruNAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779399086; c=relaxed/simple;
	bh=h8ikakxvqpw5WyOUVceHpvM64IyokaOStkttaCVRUFg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=f1Mcd0JyXuEjlIZgJUtZRst8OUIakyxZyJ+cjOReNACaolnr5PWgl41rNPeNa2K32DHEMM7DT/1xOS9clSMOeVG6RLEqV3wWpksm9ak4Ir+Sdcf0kiYbjDoDf/U7/VFoQ5gv+ENijlbrXnfIF0DQRnLvFdBn6QoFTqucaubWcdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tv8O9OLX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tv8O9OLX"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id F39AD1F000E9;
	Thu, 21 May 2026 21:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779399085;
	bh=tq+kuMc+QiIEzKRijb2ZvXgAy//G+v1mhZJfU/LS4n0=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Tv8O9OLXEPBkfCCuuxsSqZS+6Bsb+7fPrUiD2mA4bm6j9P1ujSYv9AU93zw5qh9Yv
	 1T3V+gyCtSG/9uFWAY5zyg1bUu7FsDjM3owiTX5V3qoE9jPHrUIHCb0ZImi6hTBjwt
	 nviCpsUO40DOCMDmk+GREpA2xkVp71W+3ghkN4g2hTJBPH53VBjqsrxuAlB2BcC/ys
	 wS6hZFXvXeQN4W5CAzz+r6AqBAKCVdDRbarASPAJIzrAFJ5b6BNHjpfkUW4hZRDGf9
	 Oaov6wCYIhtV+2Z/Ek/gmOiB/Bw+pm7clsGqUhwILoOKHSUtj9nZv90dG5qeUHXVHL
	 trRrOwr0MSfhw==
Date: Thu, 21 May 2026 16:31:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	bhelgaas@google.com, praan@google.com, baolu.lu@linux.intel.com,
	kevin.tian@intel.com, miko.lenczewski@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	dan.j.williams@intel.com, jonathan.cameron@huawei.com,
	vsethi@nvidia.com, linux-cxl@vger.kernel.org, nirmoyd@nvidia.com
Subject: Re: [PATCH v6 1/3] PCI: Add pci_ats_required() for CXL.cache capable
 devices
Message-ID: <20260521213123.GA186424@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag90FlOaljwa0qqU@Asurada-Nvidia>

On Thu, May 21, 2026 at 02:07:34PM -0700, Nicolin Chen wrote:
> On Thu, May 21, 2026 at 03:57:23PM -0500, Bjorn Helgaas wrote:
> > On Thu, May 21, 2026 at 01:34:20PM -0700, Nicolin Chen wrote:
> > > +bool pci_ats_required(struct pci_dev *pdev)
> > > +{
> > > +	if (!pci_ats_supported(pdev))
> > > +		return false;
> > > +
> > > +	/* A VF inherits its PF's requirement for ATS function */
> > > +	if (pdev->is_virtfn)
> > > +		pdev = pci_physfn(pdev);
> > > +
> > > +	return pci_cxl_ats_required(pdev);
> > 
> > I acked this before I saw this sashiko feedback, which looks like a
> > legit issue to me:
> > 
> >   Will this VF inheritance logic ever be reached?
> > 
> >   According to the PCIe SR-IOV specification (section 9.3.3.1), VFs do
> >   not implement the ATS Extended Capability, which means pdev->ats_cap
> >   is always 0 for VFs.

Huh.  I wish sashiko would include the spec revision because that sure
looks wrong.  In PCIe r7.0, there is no sec 9.3.3.1.  In PCIe r6.0,
sec 9.3.3.1 is the SR-IOV Extended Capability, which doesn't mention
ATS.  In both, sec 10.5.1 is the ATS Extended Capability and says both
PFs and VFs can implement it.

So I think this is OK as-is:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
