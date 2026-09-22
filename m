Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5703437130
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071085; cv=none; b=TGpvZMXs61HdqmV4kKUU2slibJ75Gsj9Ya5dhj7zumOTuJ8fIDaw4C5S3e/zMpGyJmFjTa11NriPGzZgmGOtyj55WGuoEDHPiNQ+lZlOj66K/blEr6svvbwiWfkGjzkknYJwWiVgejSXlUoi4jow2QNdgW4MAggIQQkSHFzQxFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071085; c=relaxed/simple;
	bh=C4LLXvtQMDw662WCzSNHdeIs2oqs1V4Z6R4c9+OP03M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOaUXTRqS7ZQX787XngfyvFTg2CqoNsJ3G3jO4M22dmVWzg7THxLWXwNj+8JWjNIqsAZuTtQZf3UajbFsdQh2C+n+GucUxydz79dcRkmXIYDroxUAMlV5bgJ1iWigLVNU3/EGoSEwAzHp3uvcuwXZ81cEFGiVNkov9lD2k+9ILg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6uGvOZ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6uGvOZ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655821F000FF;
	Tue, 22 Sep 2026 09:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790071084;
	bh=WQBS5R0whaJkYzuhh7NQd3CDih82U3WKGo1Y562Jqzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y6uGvOZ4yCZl/PLPOeanDDDwQBxVLj4TMH71KosAc5aUyPycFwXEfPHyJxBva2VIr
	 RV4GX2zpNvJezL2iA5hlLC+BpB2g8ZmRCbtQ6+N9z1GZu8LcMaAITH7IQLnEx9VgZW
	 KNqbtbf2k1mmkw8rssaFV+XiFsmnGZa0viWhbte0iJuhWBNYaWWjv7CYCboUGLfXaN
	 BRLYhrjRut02OeGfJQUP1gEHdPT/anEwfnaTKjsSEEXicaBJjMzx8vR9Z+VeX85aZr
	 064DoJAEDK8e0X5MXifNjY4nCiTcRCb/aDJfFcTUmDjbidbJm+CjegB+4lNRP6D3ZD
	 m6Anbey3No0LQ==
Date: Tue, 22 Sep 2026 11:58:00 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 2/3] PCI: dw-rockchip: Make the INTx irq setup
 devm-managed
Message-ID: <arJRKDwpZl_Cb1zP@ryzen>
References: <1790044622-164744-1-git-send-email-shawn.lin@rock-chips.com>
 <1790044622-164744-3-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1790044622-164744-3-git-send-email-shawn.lin@rock-chips.com>

On Tue, Sep 22, 2026 at 10:37:01AM +0800, Shawn Lin wrote:
> The irq domain and the chained handler set up by the previous commit
> are resources owned by the device, but nothing releases them if probing
> ever fails after they are set up, and they are not tied to the device
> lifetime in any other way either.
> 
> Tie their lifetime to the device with devres: create the irq domain
> with devm_irq_domain_instantiate() and uninstall the chained handler
> through the rockchip_pcie_intx_chained_release() devres action. The
> driver is builtin and cannot be unbound (suppress_bind_attrs), so probe
> failure is the only path that ever needs this cleanup, and devres takes
> care of it without sprinkling it over every error path.
> 
> Since the irq setup is the last step of rockchip_pcie_configure_rc(),
> the only failure point left after the chained handler is installed is
> devm_add_action_or_reset() itself, whose failure mode runs the action,
> so the handler can never run against the devm-freed rockchip structure.
> devres also unwinds in reverse registration order, so the handler is
> always uninstalled before the domain is removed. There is no devm API
> for chained handlers, hence the small devres action wrapper.
> 
> While at it, drop the now unused rockchip variable from
> rockchip_pcie_host_init().
> 
> Suggested-by: Niklas Cassel <cassel@kernel.org>

Thank you for giving me credit :)

Unfortunately, I don't think that I was the one who suggested this change.
I think you came up with the idea :)


Kind regards,
Niklas
