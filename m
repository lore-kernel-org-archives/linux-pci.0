Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CF036C9EE;
	Wed, 20 May 2026 20:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779308878; cv=none; b=J6MMDtCq0EV8c/Bgp9Cac6tOjLXEZX30joXDzC5v0iRmaS4tLBXXMQ3hkZ+4w6fsyqf1XHFEOWSL0dRtXcqub01a993CYqu7Iz+GEChq0QXmouFQKIUHrwunXr15mH3fGSG8vlA7cXp1GpF+MiT1tD+7C7y7hFpNOwo7xPXwEvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779308878; c=relaxed/simple;
	bh=O4mp0TCZLIIQoOZJrrRwFBYSguOzPbONHyPBbBQMzOc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hqyY/OTfmzuPctfxZgOqUsAfydzMRX+TVsxPMdzteHSeSLjTfhqT70vGjlkrSLvNpxa6gPXvTqg/C3Pn/vU5a09MvPijiVURq+DuTSlZQRsWK7XKBlVrXSQeRwRVXdNof8iEPO80zPShI66mZtPD4nqTIax6zd7BcJ9kF1Y4V08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tzb1Ret7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tzb1Ret7"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9C32C1F000E9;
	Wed, 20 May 2026 20:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779308876;
	bh=Sf1SMQC28bDRL9mfOLMubwubEk1ClyBVQ/X/6xOLHzc=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Tzb1Ret77ExKLvkEHhl993AAxmn1PQZDUTwx1VawQJyrOOaiXEOcOhOUXf4DIQxVg
	 xBtX0U8pNf9//BzKJH6MzU6mvOMjZiqc6gcibTTnVMyFFttt/mGxPG23JhfredhdtC
	 gHofPsuO6hd3CxCZE+fqiEawS+IeZgoZ5XyhksIeYLSi17kBZmGYcR9c/k0ThnMxef
	 hA/in1OvY9BzhpP3Tf8n4DHdPKNnG+OF1WCv0K3JBl91IrM53Ojf81RZ298bR6C4eR
	 bHD9eFR/fXqfcBw2VYfh/e6mMt/pS8p1NKwgTopsZyOMq/04ZW2BgRVHwv2ru2o26W
	 4LS/8EHAyDBNg==
Date: Wed, 20 May 2026 15:27:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, jonathanh@nvidia.com,
	bjorn.andersson@oss.qualcomm.com
Subject: Re: [PATCH v5 1/5] PCI: host-common: Add helper to determine host
 bridge D3cold eligibility
Message-ID: <20260520202755.GA120626@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519223901.GA20376@bhelgaas>

On Tue, May 19, 2026 at 05:39:01PM -0500, Bjorn Helgaas wrote:
> On Wed, Apr 29, 2026 at 12:12:23PM +0530, Krishna Chaitanya Chundru wrote:
> > Add a common helper, pci_host_common_d3cold_possible(), to determine
> > whether PCIe devices under host bridge can safely transition to D3cold.
> ...

> > +static int __pci_host_common_d3cold_possible(struct pci_dev *pdev, void *userdata)
> > +{
> > +	u32 *flags = userdata;
> > +	int type;
> > +
> > +	/* Ignore conventional PCI devices */
> > +	if (!pci_is_pcie(pdev))
> > +		return 0;
> > +
> > +	type = pci_pcie_type(pdev);
> > +	if (type != PCI_EXP_TYPE_ENDPOINT &&
> > +	    type != PCI_EXP_TYPE_LEG_END &&
> > +	    type != PCI_EXP_TYPE_RC_END)
> > +		return 0;
> 
> From https://sashiko.dev/#/patchset/20260429-d3cold-v5-0-89e9735b9df6%40oss.qualcomm.com:
> 
>   If the topology contains an active conventional PCI device or an
>   intermediate PCIe switch in PCI_D0, returning 0 here allows
>   pci_walk_bus() to continue without clearing the
>   PCI_HOST_D3COLD_ALLOWED flag.
> 
>   Does this create a situation where the host bridge might
>   aggressively power off the link, dropping power to these active
>   components?
> 
> I guess this is intentional, since you have comment about ignoring
> conventional PCI devices.  But this does seem like a potential
> problem.  Why should we ignore switches here?  And I think it's still
> fairly common to have a PCIe-to-PCI bridge leading to a conventional
> PCI device, and I don't know why we should ignore them.
> 
> The commit log consistently refers to "PCIe" devices and endpoints, so
> maybe there's some reason that I'm missing.
> 
> There are other sashiko comments on this series that I think should
> also be looked at.

This series is all in pci/next, so you and Mani can decide on whether
any sashiko comments need to be addressed.

Even if there's no code change, I think it'd be nice to have a brief
comment here about why conventional PCI and switches are ignored.
