Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5170385D79
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 08:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424683; cv=none; b=gIn8GWlJ5hTOIgdfjukpnmVbHwaoVKgK+aHJrT+UuTK9DDv5Oajd3VAn1qKEsY5jnS4H1OJddPDbfkmY2W5bcOO6BmaO5/WxJZp+CCeORCnAXVw4h4uOjaLNz1VqQFhSXedTtSwqnhdzu+zPAUVwsx5XnL+TUJyXSGRHn109wKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424683; c=relaxed/simple;
	bh=ZSMJZCybAIoh3uCB5nhV7lnLgX1ZO7/IAAyYuSYBydo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khabzQJ9BJtHi/i/rLpvacd4i1jJggor/MBg8FETVAaRy4P4jGyD1zQqo7tj3SbN5zdIKGunubhc7UQ8kGq3tb+vRSyCp8wHhPsrK5W94Sf4AObjRDla10TMCbp9u/3WcydFu2ZnbkOEXtz/JYqyhpDIYvTzG/8Um8wVt92uuqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kU4/dqMk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kU4/dqMk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6741F000E9;
	Thu,  3 Sep 2026 08:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788424681;
	bh=SEdKLGY8Dx0KycnlUSJA/O5HwJ6iu4wVyfrZkU/ciM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kU4/dqMkg7o/QwADyTl7D0EuG3Ijp9hna0lRJouj950+zmLnYfoj+3v8bFmD4b98d
	 +SoQaNCKhGaPuri126PjM/3o/PTe8gxFC1BBJa1H57WmVYxsq6jJDQ4r643V/XdY5b
	 579kNA0O1S7TURCMiA1a1hiqdnzzr/lQgQr0QsQV2d5/ySXkY4lVYunQBaKd/uydP9
	 t8VQ6T6tmCwzEmeonT3H6ljrgFp+JPMPD5WU7pigFqe9fMHIcFH5qlMAUNO3vtQDyg
	 fnWeDUC7JI96HVYqE3JpNpySeOeDyzFZ/oAvDNNmsDFrafqJegtk2FpZDYUUUiBUel
	 kBB9gFDrBQURQ==
Date: Thu, 3 Sep 2026 10:37:57 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
	Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH 2/2] PCI: dw-rockchip: Do not recreate the INTx irq
 domain on root port reset
Message-ID: <apkx5X83hrHIPOZN@ryzen>
References: <1788403477-71491-1-git-send-email-shawn.lin@rock-chips.com>
 <1788403477-71491-3-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1788403477-71491-3-git-send-email-shawn.lin@rock-chips.com>

On Thu, Sep 03, 2026 at 10:44:37AM +0800, Shawn Lin wrote:
> .reset_root_port() re-runs the host ops .init() callback to reprogram
> the Root Complex after the controller reset. However, .init() also
> creates a new INTx irq domain on every root port reset, so that:
> 
>   - the previous irq domain is leaked, as it is never removed, and two
>     irq domains end up registered for the same fwnode;
> 
>   - the INTx virqs of the downstream PCI devices were allocated in the
>     previous irq domain and are never re-mapped, while the chained
>     handler now looks up virqs in the new, empty domain. Hence, after a
>     link down recovery, INTx interrupts are silently lost.
> 
> Split the (re)programming of the Root Complex registers out of .init()
> into rockchip_pcie_host_hw_init() and call that from .reset_root_port()
> instead. The INTx irq domain and the chained handler are now only set up
> once, at probe time, which keeps the already mapped virqs valid across
> root port resets.
> 
> Fixes: b376b3ff9cb0 ("PCI: dw-rockchip: Implement .reset_root_port() and use for link down")
> Cc: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---

If I compare to pcie-qcom.c, the difference is that they do
e.g.:
irq = platform_get_irq_byname_optional(pdev, "global");

after calling dw_pcie_host_init() in qcom_pcie_probe().


I guess pcie-dw-rockchip.c could do the same:
Call of_irq_get_byname() and rockchip_pcie_init_irq_domain() in
rockchip_pcie_configure_rc(), after calling dw_pcie_host_init().

That way, you don't need to introduce another rockchip_pcie_host_hw_init().

pci->pp.ops->init() is called by both dw_pcie_host_init() and
dw_pcie_resume_noirq(). So calling of_irq_get_byname() in .init()
does seem slightly wrong, as we would get the irq on each resume.

Perhaps pcie-dw-rockchip.c does not have support for resume, so it
does not matter right now, but still seems a bit weird to call
of_irq_get_byname() in init().

I did not look if rockchip_pcie_init_irq_domain() should be called
on each resume, but I since we don't tear down the irq_domain in
pci->pp.ops->deinit(), in fact we don't even have a ->deinit(),
so calling rockchip_pcie_init_irq_domain() in ->init() does seem
wrong as well.

So my vote is to move both to rockchip_pcie_configure_rc(), after
calling dw_pcie_host_init().


Kind regards,
Niklas
