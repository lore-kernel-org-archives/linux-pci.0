Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463EA379988;
	Fri, 12 Jun 2026 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781273567; cv=none; b=VfUJu5bz3SF95ndaSzflWGm5DJrp1nBvnqifFWXjmt7q9/T4Tl6n/NKBKR7HOhlZmPKHuI+ujYxpsvBJlZNVMG9/Rx8D8oOM4FbnUh1G6zX8mxBlptmnjsshs52yGhZp+mInxZY3gfBP04JqeMjOpgDdMaUqKkfDUJuzYqkeCCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781273567; c=relaxed/simple;
	bh=nDce2hOE1x0f7fv3crzzrikracErWax9PlL83Z00jgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Qg9O9wCptgN3WLdMDxMbjd7khe98kzY+oz62XPg9funA4uXPRFk3tLlT9Jxbs+oAabFVLJ4hnqboGvlbAa9+pA6P9C4eLB5STdEFhIExRujGBF5JEBiPQ996K3mkXIH81CC58CENh8mn3ML7h3ky0NoyjmdSZj5tTro/K/xmA2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnVXc1H/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnVXc1H/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815BA1F000E9;
	Fri, 12 Jun 2026 14:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781273564;
	bh=gkRlOqWLDOL9V+xajZiBlg7nENjsjV7EqIVO2RaSGlw=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=QnVXc1H/a8sNOm8x1VwpAxSFKDIfDkRD5dUSM49LtKBcWLfxkmHekfPrhUyNNTf8L
	 5ezf0IHHCUrGBfbuV9tUuDwmblmbqRve/V9MZisaCk8PZuWjaVo6RGNPM8W0xWVO3u
	 9tTKsI1lrCVlMmJPBYwFP4w2LEffEFx6+phQ+4HGZp0JuutB/h3Q6gh1FtfRGJrEBb
	 r7BqkkcPquea/RjbpysjQYMzWT6yPECsQY7LzvMTpq0jMmJjZGQvYxrKW9X9KdtyN6
	 Kn9YCW9Y+aU9n6hAXD8v5+Kb+I4q+kY9Ab+8BXDE8rd/OaD2/5O1GaF+JKNf6h0LFd
	 qZuUBhHAj7eTQ==
Date: Fri, 12 Jun 2026 09:12:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Shawn Jin <shawn.jin@asteralabs.com>, linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/11] PCI: Lower bound bridge window alignment
Message-ID: <20260612141243.GA596363@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a35f669-b13b-c07a-fbd6-a8ea1ce9a38b@linux.intel.com>

On Fri, Jun 12, 2026 at 02:50:17PM +0300, Ilpo Järvinen wrote:
> On Wed, 29 Apr 2026, Ilpo Järvinen wrote:
> 
> > pci_resource_alignment() does not consider bridge windows special,
> > yet their alignment is subject to different requirements from BAR
> > alignment.
> > 
> > Add lower bound to bridge window alignment to help callers out to
> > always have large enough alignment.
> > 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> Hi Bjorn,
> 
> Could you please pull this change and the subsequent one, the commits in 
> pci/resource:
> 
> ae09d28ecbbc ("PCI: Lower bound bridge window alignment")
> cf996b886675 ("PCI: Return valid alignment for assigned resources")

Sure, I dropped these two patches from pci/resource.  The rest are
still heading to v7.2.  Thanks!

> The rest of the changes in this series seem okay and can proceed if you're 
> okay with keeping a partial series.
> 
> The reason for this request is the dev->bus vs dev->subordinate issue 
> sashiko mentioned in its review.
> 
> I've tried to come up with a solution to that but it has become so ugly
> I have not been very happy with it. Maybe there's no other way but the 
> problem boils down with pci_min_window_alignment() having to be capable of 
> dealing two cases, each lacking one of the key pointers (bus or bridge 
> dev):
> 
> 1) root bus without bus->self
> 2) bridge without a subordinate bus struct (if subordinate bus' alloc 
>    failed)
> 
> Only way to solve that I could think of is passing both the bus and the 
> bridge device to pci_min_window_alignment() and the related arch side 
> function pcibios_window_alignment(). The ugliest parts then involve 
> getting a bus pointer compatible with both of those cases, like this:
> 
> 	struct pci_controller *phb = pci_bus_to_host(bus ? bus : bridge->bus);
> 
> But it's too late in the cycle now to try even that, IMO, so better to 
> wait to the next cycle.
> 
> -- 
>  i.

