Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C56303C83;
	Wed, 25 Mar 2026 23:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774480891; cv=none; b=g5MV1sZ7rJA9pNyUs+0fajFTnx5K/oftFRPG0EMOtF3u2Af1MRVtb3sEbXbhIH3ZXTIA3AbjtwqEWYdTKA1P+tDhcv8AVWmS0ST84Dk/aawWDq7kTAwMDpaSE0qTHTirb8ooHYyTCAcUKhNcQW6d6lPFPDrHWSaK8ZhaT5xpN4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774480891; c=relaxed/simple;
	bh=iUP5gfUnRDMujBtBr8pHc3/MmL7F3+O3/zSEc27NkOY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=plp9hh/FMWChb/kIm7jgM+AACnpLI1tNRBDMDDd+QwnECRypdLJzyZIWHZmXt+htyJHvil9BbBojJUSlXKD0iEhxw+9yrPkcdbwhdmh6eVnmtTyVC7/cGs3u3qOXFsC0r79VlpfHYw2jIQdjr1/PXyt2im+ihPiz7GuUO8gOsvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KObBzq2g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KObBzq2g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC74C4CEF7;
	Wed, 25 Mar 2026 23:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774480890;
	bh=iUP5gfUnRDMujBtBr8pHc3/MmL7F3+O3/zSEc27NkOY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KObBzq2glYXabxEyDVqEylZH2RV1OMluiJcNmRRRziOkSUYrjHaigHu20WxKdCAaL
	 4FW85bAl55za5YrdSZa5ELQ423PqZfTr6BrWXIGh261sbUMDDKSkZJBsSxDxONldhq
	 fcaOS3FQQ0mmxFqWlnGgVKmjR3ik7M6DdztvWRMcMkdSjNnAxQUHrbhz7FTvqhAAaS
	 o/7YrmmBruvq+Nbq3VcKlyUK2PEB0xhH7z8AyQHebsHw6NmXWbNKcNRTJmJE1K+bd3
	 Nr0Z4CnXJt687zYlbenumlwdat9PVoEcFlpKVZzbSfCrUclrihXqeY4M8wPbEL6GmJ
	 uQYkhg98/wuDw==
Date: Wed, 25 Mar 2026 18:21:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3] PCI: pciehp: Fix hotplug on Catlow Lake with
 unreliable PME status
Message-ID: <20260325232129.GA1300734@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acN5HorrB31LLjiJ@wunner.de>

On Wed, Mar 25, 2026 at 06:56:46AM +0100, Lukas Wunner wrote:
> On Tue, Mar 24, 2026 at 02:45:25PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > On 3/23/2026 4:24 PM, Bjorn Helgaas wrote:
> > > eb34da60edee ("PCI: pciehp: Disable hotplug interrupt during suspend")
> > > cleared PCI_EXP_SLTCTL_HPIE so that when the link goes down, we
> > > wouldn't get a PCI_EXP_SLTSTA_DLLSC interrupt and wake the system.
> > > 
> > > I don't know the details of why the PCI_EXP_SLTSTA_DLLSC would cause
> > > that wakeup.  I would think pciehp should field that, and it should be
> > > able to figure out whether to bring the port out of D3hot.
> ...

> The problem is, PME not only shares the interrupt with hotplug
> (PCIe r7.0 sec 6.7.3.4), but if INTx is used it also shares the
> interrupt with link bandwidth management, AER and DPC.  So there's
> lots of potential for spurious PME interrupts and I fear waking up
> the entire hierarchy below the Root Port on every interrupt may
> result in much worse power consumption.

This interrupt sharing bit is critical information for commit logs and
comments in the hotplug and PME paths that are especially sensitive to
it.  I'm embarrassed at how much time I wasted before remembering
that.

> At least Switch Upstream and Downstream Ports below the Root Port
> need to be woken to access config space of Endpoints.  With Thunderbolt,
> these may be in D3cold and waking them up consumes a non-trivial amount
> of time and energy.
> 
> As an aside, I note that the code in drivers/pci/pcie/pme.c doesn't
> take into account that there may be Switch Upstream and Downstream
> Ports between the Root Port and the wakeup-signaling device and
> those switch ports may be in D3hot or D3cold.  Which means config space
> of the wakeup-signaling device is inaccessible.  pci_check_pme_status()
> happens to be written in such a way that if it reads fabricated
> "all ones" responses from the device, it assumes that the device
> is signaling wakeup.  The final pci_write_config_word() in
> pci_check_pme_status() will be lost but there's a call to
> pci_enable_wake(pci_dev, PCI_D0, false) upon runtime resume
> which makes up for the lost write, so the code happens to work.
> Just be aware of pitfalls there...

Oh, my.  Sigh.
