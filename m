Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BD73DE427;
	Tue, 30 Jun 2026 20:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782849822; cv=none; b=jiTPlg3Q222Ba+I00wG5xlX2ZCOI29rj8wNIIKscEDrqH7kJ1da8c/xJzxIGArooJ7tpPET56bD6h0pZwv4sfm3HwdIcRS8FniG8DH647cbskNJfn9HlMuqulWpBbi6ac1Wh3CgGPmus4B2A5ly12/oxxM6BMtzvoOGCJfgz1rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782849822; c=relaxed/simple;
	bh=t/sbJdfHgxDxVNZICMbGcnWbfZQ6RtBOq3hTDIfkLoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzNoVB2kZdzRqHdXP0xUgsunxtt7z/xTdslz/EkUH7L59yV1iUzoKASrmURUFsPROIpp+buFKG8VUtzDZC8rO43qYPQzInvGahxGSOjG6FrA3+19O8X4Wwe2Kx1ejmjtFI43pg0bAgEd8ugGgEdTJRHCQW+J6BIlNTgE9Nv16vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnhOaCKx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnhOaCKx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401A71F00A3A;
	Tue, 30 Jun 2026 20:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782849821;
	bh=0uQcY6e62MD5cOtHsIbQ6XnRqLFz05BVjQkqp7aJJrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nnhOaCKx9sc26LwldUIE0xQDWju6bjE//OWIio2aNs1l3tskUetDOj8Z3SqG8Dusv
	 mu/iyS6+GtYz9ZLD8rxd8xFQ07dWE2y62TjZeHfSMunlQkdnXavqfOL2vJOn28WDGC
	 iYXvGIBwqkSSNvcrmNgjjSkcBuNvgyUeajuQTCRF32nxMLI53NALMaEbJoBnN7ikbO
	 qJWbA+6o8ANTTlCKjw5J0SFDkMBWAC/8Wc84xU+jddm7YmAJ5J3FukKxF45s+afjs4
	 TqRj1U4rpvDEas7KOPFYZAGZridgJYPObGuP7Gkx4np7cxHAxo+FdTpSmvpA98zgR5
	 ieKBGHioKNxpA==
Date: Tue, 30 Jun 2026 22:03:35 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Yicong Yang <yang.yicong@picoheart.com>
Cc: xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com, will@kernel.org,
	mark.rutland@arm.com, jic23@kernel.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	jingoohan1@gmail.com, mani@kernel.org, juwenlong@picoheart.com,
	geshijian@picoheart.com, douyufan@picoheart.com
Subject: Re: [PATCH v2 1/3] perf/dwc_pcie: Add support for Picoheart vendor
 devices
Message-ID: <akQhFxd-JT1ENxNW@ryzen>
References: <20260629092717.74946-1-yang.yicong@picoheart.com>
 <20260629092717.74946-2-yang.yicong@picoheart.com>
 <akOpEaCM0TiZB2zD@ryzen>
 <9d2e0676-0211-49a8-b63a-2a769211775e@picoheart.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d2e0676-0211-49a8-b63a-2a769211775e@picoheart.com>

On Wed, Jul 01, 2026 at 01:01:38AM +0800, Yicong Yang wrote:
> On 6/30/26 7:31 PM, Niklas Cassel wrote:
> > 
> > Could you please point to the in-tree device driver for this
> > DWC based "picoheart" PCIe controller?
> > 
> > $ git grep -i picoheart drivers/pci/controller/dwc/
> > <nothing>
> > 
> > It feels wrong to add PMU support for a PCIe controller,
> > if that PCIe controller does not have support in mainline.
> > 
> 
> we're using ACPI thus go through the common ACPI PCI code
> for PCIe controller itself. it's same to the already listed
> alibaba and ampere here (suppose they're also ACPI based system).

I see, thank you for the clarification.


Kind regards,
Niklas
