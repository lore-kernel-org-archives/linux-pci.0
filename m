Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359513ADB99;
	Fri, 31 Jul 2026 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511474; cv=none; b=Yq7G2DFASrAEvGs/KVCzu9coIoGumZbPlAhyItBc8pmWYOvp7XAfWftUAv5Xr9XANJw0PMPhccDmTFDyF5F2viI7mGn3+cg1gSRqAogVlreQKzr/OadcpT0NBNHhm04s8clB/xERC+9gfzldA/aomkvzWKz1A6e5brfIxKaUqUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511474; c=relaxed/simple;
	bh=utTJUPyZTY2PS55lTm7qCjv93TKrWvCUoQ9pyTiB2js=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TRCYYbSTo76LJHo92+a+nwzV48WKDNVYy5+ygw5CCxyBjDo7JVxkC1vZpXQ3ruMbgII3qjizjJjvcjZBLMFRC1IUrMMWRaVlMZu/9ehZHl7bnmX292ZWHoF7QpbVTpWeLQfvetbmV4VrFn+IbKwiXaEjvNSKz0J95KJgIxf25Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDCAOEAr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDCAOEAr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A523A1F000E9;
	Fri, 31 Jul 2026 15:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785511472;
	bh=6xmfwfN/pP2GZ2+CDCsHLvPNKIXsVR24SrczdTwnBpk=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=QDCAOEAr7DlEDZ4K/Z61Y4yM9C4uIlmB2NiekJfRpZMzfUjdkV2xxymC0xzaK/M1n
	 5z1TQ2cOb2jWQWf/gCl9PESdWWxkAaseqs91aUwDs6pqiEP+kFFYxfj5GjqcrY4bYw
	 v+j4ih21F1AJ8xdr8/Paz7UZMpEydgVQh5lvhl+dTzBFVQsaGnaxvE9WNTwdIuUIyX
	 XLRxXgLfLjLB2r+ygAzYzeQwcKhkOhD1eEi/u+I2nr7JnZ+d45pCRHpOu+FBABsgWU
	 TNOCEa0HGfkPoOebdF+zCOURzheOp5ysRsjnOZCv6VnLnrtlPZ6zIrtj3kaWQdsEQI
	 2W9s+55S3WEKQ==
Date: Fri, 31 Jul 2026 10:24:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc: "thierry.reding@kernel.org" <thierry.reding@kernel.org>,
	"mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
	"lukas@wunner.de" <lukas@wunner.de>,
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
	"treding@nvidia.com" <treding@nvidia.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Disable NoSnoop and Relaxed ordering for Intel
 wireless BE200
Message-ID: <20260731152431.GA1566014@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b314134d7e39eb497a17283ce15467914aa054ae.camel@intel.com>

On Thu, Jul 30, 2026 at 08:16:33PM +0000, Grumbach, Emmanuel wrote:
> On Thu, 2026-07-30 at 15:08 -0500, Bjorn Helgaas wrote:
> ...

> > I wonder if the PCI core should disable RO and NoSnoop on Root
> > Ports across the board?
> > 
> > I think this would mainly affect MMIO accesses performed by
> > drivers, and I suspect drivers expect those writes to be performed
> > in order, e.g., if the driver writes DMA descriptors to the device
> > followed by a write to a doorbell, those should stay in order.  If
> > the RP has RO enabled, those writes may be reordered.
> 
> As a device writer I'd say we'd be required to add a memory barrier
> in that case, but we use writel usually.
> Does that include a write vs write ordering? Hm...

Not being an ordering expert, I'm not sure I can make a convincing
argument for whether RO should be enabled or disabled for Root Ports.

Maybe it's easier to argue that whatever the RO setting is, it should
be the same across all platforms because drivers shouldn't have to
adapt to platform differences.

Root Port settings potentially affect several endpoints, and I think it
would be impractical for drivers to request RO settings that might
conflict with each other.

Do you have any visibility into whether and how other OSes actively
configure Root Port RO and NoSnoop across the board, independent of
individual drivers?
