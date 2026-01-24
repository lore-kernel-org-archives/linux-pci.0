Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F332B9B9
	for <linux-pci@vger.kernel.org>; Sat, 24 Jan 2026 18:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769280504; cv=none; b=n6C3AIye8N7/7PaKgqSDXosecyEHyHKnA1xP5Hi1TFjtnLhrzVxa4fvPUvLrwKY1ivMbmON+DoWziLn88mgWaYsCGkV0lj0m93jS77wK3U8H0ml3cbURIPPgeCQKdMF65zvBH9N3KS6uy4Nccky3R91sY+C7V6hDajiJdPbRb4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769280504; c=relaxed/simple;
	bh=t9eLKQMXXlPtwh7rPdUTk1HqMqvuuD16R0QPNjRDbT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xwus9AEyewsLrxCr20NjFP82m4xheh3cK0UyP7234bYneWcUPu8XNEYWlTq9QkCxeY+HK3FwiASXPLESpXQmZhl4mNRkn9MhuOPgeFwfUT2Oy8K8axPWKzyHqOceSUIWxYplxW1lOk+VYCZluNdRCSl0iNvQg8a9TJL48BwM5mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 657BD2C06A83;
	Sat, 24 Jan 2026 19:48:13 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 56CCB2D95D; Sat, 24 Jan 2026 19:48:13 +0100 (CET)
Date: Sat, 24 Jan 2026 19:48:13 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Dongdong Liu <liudongdong3@huawei.com>,
	"hch@infradead.org" <hch@infradead.org>,
	"logang@deltatee.com" <logang@deltatee.com>,
	"leon@kernel.org" <leon@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"rajur@chelsio.com" <rajur@chelsio.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH V11 7/8] PCI: Enable 10-Bit Tag support for PCIe Endpoint
 device
Message-ID: <aXUT7Xg7V6Dusek8@wunner.de>
References: <20211105173949.GA932723@bhelgaas>
 <53978a8a-18b6-419d-8a54-b7c16f98253d@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53978a8a-18b6-419d-8a54-b7c16f98253d@nvidia.com>

On Sat, Jan 24, 2026 at 02:35:12PM +0000, Vidya Sagar wrote:
> On 05/11/21 23:09, Bjorn Helgaas wrote:
> > On Fri, Nov 05, 2021 at 04:24:24PM +0800, Dongdong Liu wrote:
> > > Current we use sysfs to enable/disable 10-bit tags for a requester also
> > > depend on the RP support 10-bit tag completer, so it will be ok.
> > 
> > Ah, OK.  So we can never *enable* 10-bit tags unless the Root Port
> > supports them.
> >
> > I misunderstood the purpose of this file.  When the Root Port doesn't
> > support 10-bit tags, we won't enable them during enumeration.  I
> > though the point was that if we want to do P2PDMA to a peer that
> > *does* support them, we could use this file to enable them.
> >
> > But my understanding was wrong -- the real purpose of the file is to
> > *disable* 10-bit tags for the case when a P2PDMA peer doesn't support
> > them.
[...]
> Hi Dongdong Liu,
> Thanks for pushing this patch series.
> I would like to know your plan to pursue this series in getting them merged.
> Given that there is no action on this series since 2021, I would like to
> take it up if you don't have an imminent plan.

Smita (+cc) took another stab at 10-bit tag support in 2023:

https://lore.kernel.org/all/20230828095429.GA17864@wunner.de/

The approach proposed by Dongdong Liu -- to disable 10-bit tag support
via sysfs -- doesn't seem right.  The kernel has all the information
it needs to automatically determine when to enable or disable 10-bit tags.
User space has no business overriding that.  There is an in-kernel API
to set up P2PDMA and it can automatically disable or re-enable 10-bit tags
when it is appropriate.  I think the only reason why a sysfs interface
would be needed is to support setting up P2PDMA behind the kernel's back
for proprietary technologies such as Nvidia GPU Direct.  I hereby
preemptively NAK patches that add a sysfs interface for this purpose.
Please help improve the existing in-kernel P2PDMA support instead
by plumbing 10-bit tag awareness into it.

Thanks,

Lukas
