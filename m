Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E31D2F39CF;
	Wed, 28 Jan 2026 17:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769620855; cv=none; b=nw7xF4b4XcAFTMOnmo/92MdGbAF9Kl4b19XMp0Oz7jLxxxRm9u3Wy6BmkosXNlQKcnzPTMI89xP3Z4tHRBsFSQ0tXAUe/vPGpc8WMq7VvbU7pcJWE6rGp84wgAkPldGzTJ1CbyvEbhspJZC2S2QsVLPMdbPJIE+j/vhVGEyncW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769620855; c=relaxed/simple;
	bh=aF+sEaIDM8apYXm//ht7oW6qKJ52vVW5aASWwS/WZxY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YHb9nomeI111dot8tsNV/HBODvvMtcimc4idM6c6CqgCvcBbk95wCsUoN6QEu08uNX00BGEyPfD8Gb+/K0wmdiayn4u1hlnHadadyvPgIyCKKgGMgfHTc5/GhSnYutzwsrY/DFp24PPo7+0eeF4xMiCAGrmIoZAzHoVqOXfKWOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYuPDcWM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYuPDcWM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0488C4CEF1;
	Wed, 28 Jan 2026 17:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769620855;
	bh=aF+sEaIDM8apYXm//ht7oW6qKJ52vVW5aASWwS/WZxY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jYuPDcWM8V8fT2TEcJm2xLLqK73UlUD3w7+NgOKSouE8BB2FBf9gp722YO2IFtGR+
	 RB3eUieiVh+3TsRQVjgj8mVzC5a34KYxCfgfNBvTejtX3s4MCUQWhRYl23t2PMtLT6
	 ySjTypxQOT6BG5zH9gavNEgHXV7cREo8PKaIV3RdhWXbV1EaZYyfCg1XPdGojDiC6i
	 /He8uKPj5hdvoXws/Rx1JTf0G5XE7dqXjHTEiobKWPiQoetPhv0X1ISLBNFnrr24Ph
	 K/MADiEZUXoVlZ6hz4+68onyMedVr2iGLdKBOXtgNp86M+S1OSxfnfSRjWPMiR5jqm
	 ODamprbKvz5JQ==
Date: Wed, 28 Jan 2026 11:20:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Haakon Bugge <haakon.bugge@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Johannes Thumshirn <morbidrsa@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] PCI: Initialize RCB from pci_configure_device
Message-ID: <20260128172053.GA422887@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B6127BDA-03D1-4BFB-BA69-A91DC452BE9D@oracle.com>

On Wed, Jan 28, 2026 at 05:08:23PM +0000, Haakon Bugge wrote:
> > On Thu, Jan 22, 2026 at 02:09:53PM +0100, Håkon Bugge wrote:
> >> Commit e42010d8207f ("PCI: Set Read Completion Boundary to 128 iff
> >> Root Port supports it (_HPX)") fixed a bogus _HPX type 2 record, which
> >> instructed program_hpx_type2() to set the RCB in an endpoint,
> >> although it's RC did not have the RCB bit set.
> >> ...

> For this and the other commit, is it OK that I add
> you as a co-developer? Aka:
> 
> Co-developed-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

No need for co-developed-by, IMO this is just part of normal patch
iteration. And I'll add my Signed-off-by when merging the patches.

> > +	pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
> > +					   PCI_EXP_LNKCTL_RCB,
> > +					   (rp_lnkctl & PCI_EXP_LNKCTL_RCB) ?
> > +					   PCI_EXP_LNKCTL_RCB : 0);
> 
> Looks good to me! This will enforce the locked flavour of
> pcie_capability_clear_and_set_word(). Is that an overkill?

Probably no need for locking in this instance, but it's a per-device
lock so there won't be any contention anyway.

Bjorn
