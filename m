Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0202471D0B
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 22:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784932748; cv=none; b=Z32aXcKmQonXB+W5SAQ/y/HVqEbalBHsiwXkq1J33uCyQBUBztNNCPjIrwPdgN4n5rH5A2j2Ljoj3jjtbNV6RC7ttgO38Yw8YxtGEFzrThsrFmgYjbsSJl1bDpTg7D7vrSutHmg0mCVVHDK9+B2sk3nNWK83MbeRmxpXvbqxpdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784932748; c=relaxed/simple;
	bh=HVVLVDxA9qhoraaObo7lcYvWkf47Tf3wbghp9UR7Yu8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GnxeYg13WFb3lEVTw+fRaYWnEygg4rvYfGuzrUiRuvo5K32BS4UCPuF4mU0f+hls+UxwPku2GaUA6G3eZ2v7B0HiVy84O6B4BFOSwO7mPh19gQod6YSyCb8n66geSESwJdX0uehqSACmiXrYOSl3RDKyEn6npwZKnvJy2kvvSKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTVJW/rh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTVJW/rh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBF21F000E9;
	Fri, 24 Jul 2026 22:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784932744;
	bh=vd175WF07d9T5qMoFKENrd0CE8q6aweRvb1UJK8MvvE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=cTVJW/rhxjCJVFPOgownsdU+uecYUKAX5qv8pljZp+HZ4HIVB8X6jEvh8zABoecm+
	 muk68Y9x4gmEHynyHn3qyyNqqGM7d6Ii+PAJbGp+YwzWCpFu7DBMf5PPJyL8vvpLbz
	 P36SOMqcTeYrlvVGWwMoNzqwuc+PC2NUZ2TM3AwHC9gh8T+/mVmTQU+uPTzUoW+l2p
	 ej0qht04ZUknI9H2I+ghIdEvnQ761iKHqNktxGN5H690gpEaX7UdeTmzL0BIHN9svB
	 BIUJ1L1d2AXXegYicjKGH/hButgZTVM2MSCdRqO/DhhjLyioXA36rw8hfw5TwnbH8Z
	 OOHbGsIWkgdPQ==
Date: Fri, 24 Jul 2026 17:39:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Yury Murashka <yurypm@arista.com>,
	Matthew W Carlis <mattc@purestorage.com>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	Qingshun Wang <qingshun.wang@linux.intel.com>,
	Yicong Yang <yang.yicong@picoheart.com>, dio.sun@enflame-tech.com,
	linux-pci@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Terry Bowman <terry.bowman@amd.com>,
	". Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Arjun Govindjee <agovindjee@purestorage.com>,
	Ashish Karkare <ashishk@purestorage.com>,
	Jasjeet Rangi <jrangi@purestorage.com>,
	Meeta Saggi <msaggi@purestorage.com>, rhan@purestorage.com,
	sconnor@purestorage.com, an.luo@enflame-tech.com,
	fernando.hu@enflame-tech.com, bill.wu@enflame-tech.com,
	xin.wang@enflame-tech.com
Subject: Re: [PATCH 0/6] PCI/AER: Support Advisory Non-Fatal Errors
Message-ID: <20260724223903.GA1073029@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1784905909.git.lukas@wunner.de>

On Fri, Jul 24, 2026 at 05:24:00PM +0200, Lukas Wunner wrote:
> PCIe r7.0 sec 6.2.4.3 specifies that certain Non-Fatal Errors may be
> signaled with ERR_COR instead of ERR_NONFATAL.  These so-called Advisory
> Non-Fatal Errors are masked by default and hence not reported by Linux.
> 
> This series seeks to change that.  The meat of it is in patch [6/6].
> There have been several previous attempts to support Advisory Non-Fatal
> Errors which are all linked in the patch.
> 
> The preceding patches contain prep work.  In particular, they ensure that
> the detecting agent and layer is reported correctly for each error (patch
> [1/6] and [2/6]), simplify logging of the error source (patch [3/6]),
> fix reporting of the TLP Prefix/Header Log (patch [4/6]) and move code
> around (patch [5/6]).
> 
> The patches have been tested internally, but further testing would be
> appreciated to raise the confidence.  Thanks!
> 
> Lukas Wunner (6):
>   PCI/AER: Fix mapping of errors to agent & layer
>   PCI/AER: Log agent & layer for each individual error
>   PCI/AER: Deduplicate logging of Error Source Identification
>   PCI/AER: Emit TLP Log only for unmasked errors
>   PCI/AER: Move retrieval of FEP and TLP Log into helper
>   PCI/AER: Support Advisory Non-Fatal Errors
> 
>  drivers/pci/pci.h      |   4 +
>  drivers/pci/pcie/aer.c | 250 ++++++++++++++++++++++++++++++++---------
>  2 files changed, 200 insertions(+), 54 deletions(-)

Applied to pci/aer with the intention of v7.3, thank you!

I noticed a sashiko comment on 6/6 but haven't had time to look at it
yet.  I left the series on pci/aer for build testing in the meantime.
