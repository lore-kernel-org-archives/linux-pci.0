Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692C0303A1E;
	Mon, 16 Feb 2026 11:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771242689; cv=none; b=cGLqtITIu34P9Tc3cix+f2RruYAuTnqhKGI5NSWpn30eC27H2QMPSp8cGgxlAtRi5/mv/I3foWrNVreZuXjTgfCrHhnZ2/9+VzD8G4Zb5qy7Mv2eAc5kmWZBO7YUmANPINLAGqAHaALS0yeZX80iCcDjFJRsPfuuffsgSgpG0WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771242689; c=relaxed/simple;
	bh=MdbbGVpQAUObn7H7K1OtaPcnYX3wikRn1Fg3HiZ0fCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eov6gc/j3dD+ekiRPV4Kstzp1zmrKm94JRkqJoqeXht24HNICDOTulBc61kySEJuW3Tzckl3GoleU7snPnkK2zwQwnjMuX9HGLm0olGgZswWfWno4VJQXwVjnfPoPDSDNvjfgYPKVT9FbnpilRrjya8KBDjBiyI2NIASTRNgv8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZSYvrwA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZSYvrwA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C9AC19423;
	Mon, 16 Feb 2026 11:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771242689;
	bh=MdbbGVpQAUObn7H7K1OtaPcnYX3wikRn1Fg3HiZ0fCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NZSYvrwAzugjAEnQK9F3slU+7b2cBtyHdDIXoX+BZ1/tDYldXhRPN/ns0YMNrFw5l
	 xCtl4PivgJfb0xGSmx3e8csv2gcRuwl2afZ8jGV6s7z0wBY11A1s5eqQdNq+Gpo+OC
	 q9MgWsoa7GtQMfJODncVMDjIcEYS7yBdHKsD2V0DfCyart/Zs+AM4au2UytsgoveQp
	 osGQ7LPDGNE7ptKa+xkaR3otxLJR9mPk0duh4rv4y0HaUeEDsYp8On1aw0WaND+BNB
	 CfeNwhtkfbOWga3RHBknDL7PnRpPVAuuLm1wWz3ex5B9Re+u3d/1xUzg8v2YCcD/Ik
	 GfEprVdMC23rA==
Date: Mon, 16 Feb 2026 12:51:23 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com,
	allenbh@gmail.com, Frank.Li@nxp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH 0/4] PCI: endpoint: Doorbell-related fixes
Message-ID: <aZMEu0_kAsRKOncz@ryzen>
References: <20260215150914.3392479-1-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215150914.3392479-1-den@valinux.co.jp>

On Mon, Feb 16, 2026 at 12:09:10AM +0900, Koichiro Den wrote:
> Hi,
> 
> This is a small fix-only series related to the previous (v6)
> doorbell-related series:
> https://lore.kernel.org/linux-pci/20260209125316.2132589-1-den@valinux.co.jp/
> 
> These patches address a few independent fixes in pci-epf-vntb,
> pci-epf-test and pci-ep-msi:
> 
>   1/4 fixes IRQ unwind in MSI doorbell setup (pci-epf-vntb)
>   2/4 adds a bounds check for doorbell BAR offset (pci-epf-test)
>   3/4 avoids free_irq() if doorbell IRQ was not successfully requested
>       (pci-epf-test)
>   4/4 fixes error unwind and prevent double allocation in
>       pci_epf_alloc_doorbell() (pci-ep-msi)
> 
> These fixes were originally intended to be included in the next revision
> of the main series. However, doing so would have grown the v7 series to
> around 15 patches, so I am posting them separately to keep the feature
> series manageable.

I think it is a good idea to split out the doorbell fixes to its own series.

However, when splitting things out, it is getting a bit hard to track the
most "up to date" thing to look at.

At least for me, it would be nice if you could create a patchwork account
and then go in to:
https://patchwork.kernel.org/project/linux-pci/list/?submitter=216987

And mark your older series (that now has a newer version) as "Superseded".

You've been doing a lot of nice work lately, but it seems like the PCI
maintainers patchwork queue/backlog is quite large right now (7 long pages
in patchwork).


I think the chances are higher that your work will get picked up if you mark
your old series as "Superseeded", because it keeps the PCI maintainers queue/
backlog smaller. (So less chance that something will be overlooked/missed.)

(I do this myself too, because it seems to make things more likely to get
picked up.)


Kind regards,
Niklas
