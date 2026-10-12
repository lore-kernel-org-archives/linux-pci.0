Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41DB1A9F96;
	Mon, 12 Oct 2026 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791836354; cv=none; b=qeCWk/ibC8M3CqL23povNc12CK31OY5HkntjbMfV+u7SSjneY1hSacBcNm187N7b2llVOqAMQA/l2quhNTih3ujGNmwya7U9TtdOhzk8t6PtrepQEVVTI9SgPVfx/q/ZE10DpO/4Cg3u0hIz+fqheriLYj08PLFqUZXl3Ath1lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791836354; c=relaxed/simple;
	bh=qU4s39QXYGF6y387WXktHtZDr51vM9T/ExPWCcqhXy0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dMOyfj9LYPgNbRiesyDTHM5f5vfYVWzuUM6WEP6ehoQwzLWI/O78VhmHmDoIrKThFfvSRMiRpoR58xo1s73HAXD6eNkj3f9MiBJE0GVcJuBIzXZFTZhir10u2gtv4hT9hbf+Ng31TTKkMOJBcoy+/OFwju4MRPXecv4ygDbpXQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdPnoYHq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdPnoYHq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4851F0089B;
	Mon, 12 Oct 2026 20:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791836352;
	bh=f9BkgVVYBdq6Ts9SUFvsw/7XFAECAP2nrcXtcKnMv2E=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=PdPnoYHqZnuCaHu+l29sLiHgVnChMLNTvXt+WIP/DYueKP+44Z6Jt5gCgou/RFFlY
	 YsQ6jAsyoB4TnXdybb9yeBkzRvGB77ZvX1n6N23a6bCMH9cO5Cp9LpWEjc3bp+OMsm
	 bmKJlz8PoR9bu1G5SvWzYuu1fHh+T03ZSGWUsK+BtNPHBaP7Wt7SOqkWd6veSacjAO
	 cDeKKJz8GQjvjICy3CLqU+SN7FNKVYW/pUXPIlyUZxZ5YzowzwGlKf2xWioWJAudVm
	 6P2xtamffQ+jhr+8ADNFkhTetins4X5SQLdi3bCCowwuYAP3rAjIm7VQf8E7ODqNfT
	 hmavqpwSVbcuA==
Date: Mon, 12 Oct 2026 15:19:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Varsh Satti <varsh@varram.me>
Cc: Rickey Bartlett <subtexel@gmail.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Keith Busch <kbusch@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: vmd: Flush initiator posted writes before demuxing
 interrupts on Meteor Lake
Message-ID: <20261012201910.GA1379657@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012194011.48215-1-varsh@varram.me>

On Mon, Oct 12, 2026 at 02:40:11PM -0500, Varsh Satti wrote:
> On Mon, Aug 24, 2026 at 09:32:20PM -0700, Rickey Bartlett wrote:
> > Meteor Lake VMD (8086:7d0b) is affected by erratum MTL016: the VMD can
> > signal its MSI before the posted writes carrying a child device's DMA
> > data have landed in memory.
> 
> Arrow Lake-H is affected too. It uses the same VMD device ID
> (8086:7d0b), so the existing match already covers it.
> 
> Hardware: ASUS ROG Zephyrus G16 GU605CP (BIOS GU605CP.307), Core Ultra 9
> 285H, with a WD PC SN5000S (firmware 34230100) as the only device behind
> the VMD.
> 
> Without the patch, on 7.2.9, I got 13 "timeout, completion polled"
> events in about an hour of desktop use. Each one froze the desktop for
> up to 30 seconds. Disabling APST and ASPM
> (nvme_core.default_ps_max_latency_us=0 pcie_aspm=off) did not help: I
> still got 7 in a 10 minute boot.
> 
> With the patch backported to 7.2.9, there were no timeouts in 13+ hours
> of normal use (~340k reads). Average read latency went from 77 ms to
> 0.49 ms. Apart from context, the only change the backport needed was
> adding struct vmd_dev::features, which 7.2 doesn't have.
> 
> Since this fixes 30 second stalls on laptops that are already shipping,
> would it be suitable for stable?

Yes, I think so.  I added stable tags to both:

  6fc5bcb43436 ("PCI: vmd: Flush DMA writes before handling MSI on Meteor Lake")
  78b25e75d082 ("PCI: vmd: Flush DMA writes before handling MSI on Arrow Lake")

The 8086:7d0b Arrow Lake-H ID is actually covered by the Meteor Lake
patch.

> Tested-by: Varsh Satti <varsh@varram.me>
