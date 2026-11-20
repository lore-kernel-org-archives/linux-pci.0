Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198723;
	b=TtI8wZP9vIfjfnr4Dw4ZL4KISvIbeFX/sdgJf95tKt45tXO749cvka389HLCzghWnKjY
	 ui7hw50nyPEh3Ah7BcjGqUaSf8TI19gcBIVP8RMmCDSMe/rql5zZkpI7r6cuFTdZA2G6q
	 /k8z6cv654Um7rYn1HLpdi+tpoc6WxKx1cDox2bNTN7zLotR/OnMNOr8W+8LUZRsSSyk/
	 aprH04uXjnCe7swbVywQVfmWj8T/yhGc7UU/5tWukDEM3FFhXaFrQ7UqMObXXZo6sjLWb
	 QhhBo55RbGPq7KQvWYGeYaWoT3ncwY96UX28+QJarzomKScRjO4xxMCBvp54/NvjYKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198723;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rgXKnSUZElXu6HNU7bpeg5zewNDR9H2FgK8k6uu7Vng=;
	b=IDT8Ses6I3U5+dJQ5PxJTIjnWRDu36o8H/BKFu7FUdmxD1+Wahaw2MAzmm2qWe19HfVl
	 +sZ9fRtunf+BZLrf6EmVGPs9diy4yQwZtrE4S/kBlpqqmWcLi7PQ84mo1jBsnORoJ5UO9
	 MFVx83wwhgHgvpOc/MqbdKJdS/q3aFeX5IgT0+d9k3mAVf3CHskMuuLLCBHjV7lZpz0yb
	 VJVwiOF4+nrhshYVM8+zsefYF6mufj0Y2g9gbwfcHzLnJkk//8iPUuB9zC4ICicfmdw9H
	 mkRStJq/pwX9uDYCtf7s6H9HdkzdD8uZdItPxwoR+zHorzdVAZ4xUqCZu6BYtMb33eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DH9ujpUw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244E9606C6DA;
	Fri, 20 Nov 2026 18:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DH9ujpUw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EB91F000C6;
	Fri, 20 Nov 2026 18:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198722;
	bh=rgXKnSUZElXu6HNU7bpeg5zewNDR9H2FgK8k6uu7Vng=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=DH9ujpUwgfcyQywCk4NCBT0vob6ZhvET1c2bea0v313EKzWXrCd5a/bZzfy7apxgq
	 aGGlKtKK6GfA/sJmrsJrq5LNhefjB57Rq8hMzDUKlsLjMzsQ0HNWuZIwWK9YfrhjCB
	 2b31KbTzvPjk8kHarH3nanKfRz0q4cN9+98jfEfBkoE4tyMAy4Z6tLT3vObATGw1kb
	 CVZZ3jhO56qLvw1DhN7dMdm1hSHwWCRQhL33PETuxcnS3FnFcEltycN00U0gmgvPs5
	 PQGZoU9tc5O4O28vpbRDtcbsYaCZ4DA4sUj4fkDVGlKF+1ydgMP3qp4sAcsaJWq30i
	 jAI4olcKIcpZw==
Date: Fri, 20 Nov 2026 12:18:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] PCI/DPC: Decide DPC ownership with
 host_bridge->native_dpc
Message-ID: <20261120181841.GA893187@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <av7BRHcVkXOGT6yp@wunner.de>

On Thu, Nov 19, 2026 at 10:28:36AM +0100, Lukas Wunner wrote:
> On Wed, Nov 18, 2026 at 06:10:42PM -0600, Bjorn Helgaas wrote:
> > On Wed, Nov 18, 2026 at 10:17:12AM -0800, Kuppuswamy Sathyanarayanan wrote:
> > > This series makes host_bridge->native_dpc the single decider for whether
> > > Linux uses DPC, as Bjorn asked during the review of "Simplify PCIe native
> > > ownership".
> [...]
> > > Patches 1-2 are the two DPC patches from v2 of Lukas's "Error reporting
> > > for AER-incapable devices", which are included here directly.
> > > 
> > >   https://lore.kernel.org/r/34c9ee153876bac953135b4518035194b7c07c6c.1794997749.git.lukas@wunner.de
> > >   https://lore.kernel.org/r/58d8a99cc6c2ecba6dadc450ecb4501d47816732.1794997749.git.lukas@wunner.de
> > 
> > Applied to pci/aer for v7.5, thank you!
> 
> Hm, it looks like you applied to pci/portdrv instead of pci/aer.
> 
> Note that the first two patches in Sathya's series are identical to
> the first two patches of this other pending series...
> 
> https://lore.kernel.org/r/cover.1794997749.git.lukas@wunner.de
> 
> ...and so if/when that other series gets applied to pci/aer,
> the two patches will have to be applied once more as otherwise
> the last (7th) patch in that series doesn't apply cleanly.
> 
> If on the other hand you move the patches from pci/portdrv to pci/aer,
> the first two patches in my series need not (and should not) be applied.

Thanks, I did move all these to pci/aer to avoid this complication.

There were minor conflicts with Yazen's patches in
sysfs-bus-pci-devices-aer but nothing serious, and if we rework the
negative value handling in the ratelimiting parameters they would
mostly disappear.
