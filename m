Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A63A2FB997;
	Fri,  6 Feb 2026 22:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770416965; cv=none; b=kX6GSPNgLoFTtLmY8Hf61hrVRsIeu3mY+VPRVolK4ZEXR0384edUy5tmVVNsVijC1vt2v46hWRBLeaD2TaewI+8P8oUl+lw4mN1QHy5NA+MB4ujq6xZkc3WnkMSCJc8KZiDWhLyfqb6nms7ZqS+H8A0jB5uPsHQMcPYnDRiqoBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770416965; c=relaxed/simple;
	bh=/ZQzXvueEhb1Dzw5x/j36IsO3RIg2BwlBa5zM30ow5A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QZ4ZM4pocBXEIsenJGMqoJDhaZoNbuI2PuZimOm715afO1yPSxCJq/KH4/ETly+dZkrh+ygd7A8kQlrbPW7qd6NWtyHmnpz+jOrqLzfCKEpYrV1+SF/mMaEdb0H8uI0VGv8Tx1pkZTeYfrUt4Fk6SF76vbWERkTkJg0RmuzZ1D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+9VRAYZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+9VRAYZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDD5C116C6;
	Fri,  6 Feb 2026 22:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770416964;
	bh=/ZQzXvueEhb1Dzw5x/j36IsO3RIg2BwlBa5zM30ow5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=q+9VRAYZXZ6EIPF5h+E3PNNZJD20ouj/24JImWf8yg5+BU+69VNRRbcd+X31tedFH
	 SoOTNMHyHRHexMEphiM+TI3DEULjMEZWo96PpvXmw+H+KWtyHSLH9Q8sYyTxnV0LXD
	 Ep2xqHoN6dU9048HOzQIXf60iYK3la43BKeyMEKUzyxW7WjGUPjzpFn0domQG9SRbT
	 WGuOPM7HuRFnx1IBi9QFK2K38b06ig2+r5E8h7XNF9WCBGNU4weummBN0ebG4xioY1
	 iB0cuHC0TyXW22X74aDSDzgO4jy2nZSOnFo8oLq5dSigfJXw2MSuqb2At3Rhdt/nxx
	 x/QHd7d073w/Q==
Date: Fri, 6 Feb 2026 16:29:23 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: duziming <duziming2@huawei.com>
Cc: alex@shazbot.org, bhelgaas@google.com, chrisw@redhat.com,
	jbarnes@virtuousgeek.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, liuyongqiang13@huawei.com
Subject: Re: [PATCH v4 0/4] Miscellaneous fixes for pci subsystem
Message-ID: <20260206222923.GA98884@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <728a9d24-b2cc-43f3-a1c3-12695155bf2f@huawei.com>

On Fri, Jan 30, 2026 at 03:53:10PM +0800, duziming wrote:
> Hi all,
> 
> Gentle ping on this patchset. Any feedback would be greatly appreciated.

Sorry I didn't get to this.  Poke again after v6.20-rc1.

> On 2026/1/15 15:52, Ziming Du wrote:
> 
> > Miscellaneous fixes for pci subsystem
> > 
> > Changes in v4:
> > - Remove the architecture-specific #ifdef to apply the alignment
> >    check for all platforms (including x86), as device registers are
> >    naturally aligned anyway.
> > - Fix a potential issue in proc_bus_pci_read() to make it consistent
> >    with proc_bus_pci_write(), as suggested by Ilpo Järvinen.
> > - Link to v3:https://lore.kernel.org/linux-pci/20260108015944.3520719-1-duziming2@huawei.com/
> > 
> > Changes in v3:
> > - Check *ppos before assign it to pos.
> > - Link to v2:https://lore.kernel.org/linux-pci/20251224092721.2034529-1-duziming2@huawei.com/
> > 
> > Changes in v2:
> > - Correct grammer and indentation.
> > - Remove unrelated stack traces from the commit message.
> > - Modify the handling of pos by adding a non-negative check to ensure
> >    that the input value is valid.
> > - Use the existing IS_ALIGNED macro and ensure that after modification,
> >    other cases still retuen -EINVAL as before.
> > - Link to v1:https://lore.kernel.org/linux-pci/20251216083912.758219-1-duziming2@huawei.com/
> > 
> > Yongqiang Liu (2):
> >    PCI: Prevent overflow in proc_bus_pci_write()
> >    PCI/sysfs: Prohibit unaligned access to I/O port
> > Ziming Du (2):
> >    PCI/sysfs: Fix null pointer dereference during hotplug
> >    PCI: Prevent overflow in proc_bus_pci_read()
> > 
> >   drivers/pci/pci-sysfs.c |  7 +++++++
> >   drivers/pci/proc.c      | 11 +++++++++--
> >   2 files changed, 16 insertions(+), 2 deletions(-)
> 
> Thanx du!
> 
