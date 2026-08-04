Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CDE43D501;
	Tue,  4 Aug 2026 17:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865169; cv=none; b=kZIzgFIZT6ivxgMRq98y+weT+E8bTRuMh4u4hNC/TdvWjclszGJ2+dokavQzn72Su8X9auvSKSoYdBpc82pdriqOnf9apnZIqSTQpim4AjCjMiXzHj55+pc0kJ/JuPpgTOv1z8+cMwubGPwsufNHJB69xFmHkRLgxDU11fjiMDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865169; c=relaxed/simple;
	bh=LCHud7JNG4VPCdrnSOvBaAFoKzZtridZPedd73F98Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kGMO8KFpK36bfBTkad7YWfPWPqZnhZ6W8GLkU/53a4ulVzpNgCRjgx+cmsRRRJp4uv1sjpErAjvDWNlN2tJ+2H1D8sH72lLcdnGEu5IvMhF6KCFKwE12/ioCMA6gyT3VWKl0+WW2ZOa5V8UuHhm6NX/17d9bW7q5OYIV+hCoj3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhqjZhjN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhqjZhjN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340DA1F000E9;
	Tue,  4 Aug 2026 17:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785865168;
	bh=R/y/OafoTcxCvkuztsvgH81hAaIwRNtfB6jAbUNw5Oc=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=hhqjZhjNLdckMofOvVWbcg7JgMlISSXeBjx0RZ9VTCSshWib07Zrp6EnCyNrN0BGy
	 3l7g7kfcCbBzgWsCUzMcWLKhD6Ko0Evl1Wani9/51muo96Xpc+dRR8Q4osAF5EoHsF
	 Pcjja11pa1pafLKMg0G5YSpMaiCXXrz+OXV2G0wInCGwRDmMzxz7KqipWkC2Fjo3qj
	 vqeo/dGSBlOKlHKb0Z8YfjBgwUDCThsAlVlyXokIrwMGigWt0P0pcZCBjMnD+P+Ksi
	 MeHOH8sxZafWNk8fTUXBaKJ2MfJqEj34j7FTSQAYy8lnVnXGhbNKKwm3YEhnwv3wez
	 RcsczRmk7UfmQ==
Date: Tue, 4 Aug 2026 12:39:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc: "thierry.reding@kernel.org" <thierry.reding@kernel.org>,
	"mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
	"lukas@wunner.de" <lukas@wunner.de>,
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
	"treding@nvidia.com" <treding@nvidia.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Disable NoSnoop and Relaxed ordering for Intel
 wireless BE200
Message-ID: <20260804173927.GA1845060@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c067883cd68a835a4ab5432e2b509b3686257b5.camel@intel.com>

On Tue, Aug 04, 2026 at 03:57:51PM +0000, Grumbach, Emmanuel wrote:
> On Fri, 2026-07-31 at 10:24 -0500, Bjorn Helgaas wrote:
> > On Thu, Jul 30, 2026 at 08:16:33PM +0000, Grumbach, Emmanuel wrote:
> > > On Thu, 2026-07-30 at 15:08 -0500, Bjorn Helgaas wrote:
> > > ...
> > 
> > > > I wonder if the PCI core should disable RO and NoSnoop on Root
> > > > Ports across the board?
> > > > 
> > > > I think this would mainly affect MMIO accesses performed by
> > > > drivers, and I suspect drivers expect those writes to be
> > > > performed in order, e.g., if the driver writes DMA descriptors
> > > > to the device followed by a write to a doorbell, those should
> > > > stay in order.  If the RP has RO enabled, those writes may be
> > > > reordered.
> > > 
> > > As a device writer I'd say we'd be required to add a memory
> > > barrier in that case, but we use writel usually.  Does that
> > > include a write vs write ordering? Hm...
> > 
> > Not being an ordering expert, I'm not sure I can make a convincing
> > argument for whether RO should be enabled or disabled for Root
> > Ports.
> > 
> > Maybe it's easier to argue that whatever the RO setting is, it
> > should be the same across all platforms because drivers shouldn't
> > have to adapt to platform differences.
> 
> That's playing safe, which is never a bad option if the performance
> hit is not significant, but I can't tell I can claim that have any
> expertise here.

I'm not a PCIe protocol expert, but it's hard for me to see how No
Snoop would be useful for outbound transactions initiated by the Root
Port.

For inbound DMA transactions without No Snoop, the RC can enforce
cache coherency by snooping CPU caches before accessing main memory.
If a driver knows that the main memory target is uncached or doesn't
need coherency, it can set No Snoop on its device to bypass the CPU
cache snoop.

But for outbound reads or writes from the RP, the completer is the
PCIe device that claims the transaction address, and I don't think any
other device or switch is able to snoop caches and affect the
response.

I suspect there *is* potential benefit for Relaxed Ordering on
outbound transactions, but I think drivers would need to be aware of
this.  Maybe the Linux driver model already comprehends this, and we
should enable RO on RPs.  Either way, I think we should configure RO
explicitly so drivers know what to expect and the behavior doesn't
depend on whatever firmware did.

> > Root Port settings potentially affect several endpoints, and I
> > think it would be impractical for drivers to request RO settings
> > that might conflict with each other.
> > 
> > Do you have any visibility into whether and how other OSes
> > actively configure Root Port RO and NoSnoop across the board,
> > independent of individual drivers?
> 
> I asked internally and we don't really know what Windows does when
> the PCI root port has those bits sets. We mostly test with Intel /
> AMD systems and those systems have those bits clear.
> 
> BTW - can you please point to the relevant paragraph in the PCI spec
> that states RelaxedOrder and NoSnoop should be set by default on the
> RP?

This is in PCIe r7.0, sec 7.5.3.4:

  Enable Relaxed Ordering - If this bit is Set, the Function is
  permitted to set the Relaxed Ordering bit in the Attributes field of
  transactions it initiates that do not require strong write ordering
  (see § Section 2.2.6.4 and § Section 2.4).

  A Function is permitted to hardwire this bit to 0b if it never sets
  the Relaxed Ordering attribute in transactions it initiates as a
  Requester.

  When not hardwired to 0b, the default value of this bit is 1b.


  Enable No Snoop - If this bit is Set, the Function is permitted to
  Set the No Snoop bit in the Requester Attributes of transactions it
  initiates that do not require hardware enforced cache coherency (see
  § Section 2.2.6.5). Note that setting this bit to 1b should not
  cause a Function to Set the No Snoop attribute on all transactions
  that it initiates. Even when this bit is Set, a Function is only
  permitted to Set the No Snoop attribute on a transaction when it can
  guarantee that the address of the transaction is not stored in any
  cache in the system.

  This bit is permitted to be hardwired to 0b if a Function would
  never Set the No Snoop attribute in transactions it initiates.

  Default value of this bit is 1b.
