Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFDB339875;
	Mon, 22 Jun 2026 16:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782147390; cv=none; b=Pff14FGzete4YtreZul9KmO/QO/lsExOC+2x9GrIOzP8s+issMsDYlH1n07+5hvVXLZ6p3WHZNCsQBud2YsknX7MlO/BVyj1W7ExdOcdwUEswLHXjDwB0sdB3oo+rwvD4pTtujITDl4VLChgdyKYdFi4PdWg5EP6fnRi8Ig8yVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782147390; c=relaxed/simple;
	bh=kgzUdcsv1fUyU/UC/Cab0sLGQOE2ISzGgiWE8ABz9rw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cNhoa1PVPGgp0jo+rM2S4gUxWj3iTHq3Q6wjL8BrifIo3dMaseHKowRkcNitv8XWGJolKeLPiasGN609IM0VLl8h3Cj6sgO3dYzhg7hEv2UuHdMa9BOJJILotVY56FuJjtkPZf1+8GbOz2QIDT8IlCW6tlpKNxRVuqvmWPXJ0ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caqU7l76; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caqU7l76"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30DE1F000E9;
	Mon, 22 Jun 2026 16:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782147388;
	bh=DQbNJy77aiHlOEUx0BhEwnElSK5v5gnbGHzxyE7TxfI=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=caqU7l76HM7PHpCBqNI3xy0/3Hc1WnA1uqCGPHuPfx3oZp1u45KA48y2kOVfhoY0L
	 Ql/HFEHbJZpSbspcCyvjcwFPacHNDpK4IbG+3kyCLxs2XExlt6Xj550GAiz+Zc+U8l
	 9FUxzMzAqBk2yWkI/jScrNBar11vrAW1cdXiwm48ZDNcRSsiUmoXwguDW42I9Ifpjr
	 alzYIEa0TB7s2V8/2VnWfkxUgIfscYLR0q3BS+Ro88Viw70omC/KIUSprLIiOppBxU
	 bTeDIIGi1mOH22lPSAjOKno59iPEFiCvNvo3vu7Tn9ELbvejZtrz74apeXqjgeUIV/
	 MHA4K6+OhnBmA==
Date: Mon, 22 Jun 2026 11:56:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: "bjorn@helgaas.com" <bjorn@helgaas.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"will@kernel.org" <will@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"vidyas@nvidia.com" <vidyas@nvidia.com>
Subject: Re: Re: Re: [PATCH v2] PCI: host-common: Request bus reassignment
 when not probe-only
Message-ID: <20260622165627.GA668215@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR18MB584758C9286C78B6EE947FE7D3182@MN0PR18MB5847.namprd18.prod.outlook.com>

On Fri, Jun 12, 2026 at 04:03:25AM +0000, Ratheesh Kannoth wrote:
> ...

> Kindly advise if there are any outstanding action items required
> from my side. I see that the patch is not available in net-next yet
> or backported to stable versions. I want to ensure I haven't missed
> a step, so please excuse my impatience if it is simply a matter of
> the usual release cycle.

This is queued on pci/controller/host-common and is in pci/next for
v7.2.  I will ask Linus to pull that branch sometime this week.  This
is separate from net-next, so it won't appear there.  Backports to
stable will happen after Linus pulls the branch.

Bjorn
