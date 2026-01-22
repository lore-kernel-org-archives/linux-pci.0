Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322D822F388;
	Thu, 22 Jan 2026 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077379; cv=none; b=DaGnONje+ecBPeoTxw+MqkpedjnDxZm46cspfHKQz1WM0Cf+nsSlBZwXQic3gDGjExIcKdR71p4LYnmvX3E8LOn8Qkg/o4RP8r0N9U3b7RqO3LT4FCErH+GgGXCQfvQqBwIl17jneYwjp7IJjACzc2H2iUQZxP4KvXszjHBtCbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077379; c=relaxed/simple;
	bh=kT4mlWylBTehL4zttxMz1bZDT7RsJT3UKca38Q2+FGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rP3mmO0F7Jo/yIWjmKqexvpeIt/r2safBwsfe7C00pt62Q+v2pXr2sgs7uKwfSgCiOfHJHKpATX86qa4zlheDzMX7I2Vl7OqR8mSXbB/rv5uFQVfCkumpip+NWqbc+f1gGU8sv9QSRxUvOhqpewxA2JO4e1fqaPa52rCf2XH0a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4+YbGt0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4+YbGt0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1ED8C116C6;
	Thu, 22 Jan 2026 10:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769077379;
	bh=kT4mlWylBTehL4zttxMz1bZDT7RsJT3UKca38Q2+FGQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Z4+YbGt0EmMwS3RGo8HvrjHlLUTH1r1IGaR7g3wmuvJw47MW8qV3hLYZxAfsWxb6J
	 N2WCyOZpXhjYxB8NIBBb2By6KYm6gIMdlGNGjbvDV5wzK5RANt1nN9Oq5Q/KjC+LI9
	 9FbcviqlQSA9xxhI+pa4V4HlydvJf+A3uQ1URBf9TdH0VVGOU0NdML1R+aqu/k8enV
	 o54UUy8Z7dQubUMWqAwNypLN3UOMDyNZnAMtreVL6EOQ/Exw3x6hDbI8HIW++lrQlf
	 3kcGwT0VQmP/B/tfh0vRgWMU/jldIqLyUSgFkvVMH95IiTSA+hXq8b02qDmAadmj2L
	 HGnELr2WMLXkQ==
Date: Thu, 22 Jan 2026 04:22:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Haakon Bugge <haakon.bugge@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Johannes Thumshirn <morbidrsa@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] PCI: Initialize RCB from pci_configure_device
Message-ID: <20260122102257.GA1239174@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2C6ECE99-B9CD-4325-87D2-A2E212BDBDA3@oracle.com>

On Thu, Jan 22, 2026 at 09:42:46AM +0000, Haakon Bugge wrote:
> > On Wed, Jan 21, 2026 at 12:35:40PM +0100, Håkon Bugge wrote:
> > [snip]
> 
> > RCB isn't meaningful for switches, so we'll read their LNKCTL
> > unnecessarily.  I propose something like this, which also clears RCB
> > if it's set when it shouldn't be (I think this would indicate a
> > firmware defect):
> > 
> >        /*
> >         * Per PCIe r7.0, sec 7.5.3.7, RCB is only meaningful in Root Ports
> >         * (where it is read-only), Endpoints, and Bridges.  It may only be
> >         * set for Endpoints and Bridges if it is set in the Root Port.
> >         */
> >        if (!pci_is_pcie(dev) ||
> >            pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> >            pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM ||
> >            pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
> >            dev->is_virtfn)
> 
> I see that sec 1.3.2 defines "Endpoints are classified as either
> legacy, PCI Express, or Root Complex Integrated Endpoints (RCiEPs)."
> But, shouldn't we also exclude Root Complex Event Collectors
> (PCI_EXP_TYPE_RC_EC)?

Yes, probably so.
