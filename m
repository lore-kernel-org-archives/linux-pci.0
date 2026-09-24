Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C28D3264DD;
	Thu, 24 Sep 2026 01:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790212923; cv=none; b=nxb0cpfhyVEsfYHVn2rDc/yZ+IPxz0bzqI1JWgcsjS/CKnfxkWZ0QYjpneMgHQkbRIJ6H9e/FJfpmwRfOcE/76fBlK/5UtOTQkGQkGQcYutvE/6+Y3GDDYZLhi6qqWD2OzMlqE8EOYkGBGoUaCvkejnZfFXEBeJSr/EgAkSd3Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790212923; c=relaxed/simple;
	bh=3nCqoiU8F+veAvr0iNmxNPx0kO6p+NUFtLE74fRy1QI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+Y9hB7tCum/kb/96ZA76tE/4yy0M1saxcCMunIiuPU9IkVP5n6SDKXIqYPEpzai4x4mXwzoQo53bSVCILL1vL9ydGE45TBeNyZ63jAwYjElrzPYN+YBMEp6QwBaGfZmaOytC0Ltmi+kzlgSLSrLaCP/SKjttUF2/+1CojzJme0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdIrZ4ai; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdIrZ4ai"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5A51F00898;
	Thu, 24 Sep 2026 01:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790212921;
	bh=8WxBiMxYYnCFiA04JPPZ1ZA82DQzj+4DntEGVS2KTZA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RdIrZ4aivCZN4B2cC9Jjpp3xWuNaUOIEtAzPc4uunTiYcEnfk8fFBf33yvbQEZ64j
	 +vYjcu7uHgtlMQ4V7ATreejME7FGefUNLgiSjHoJCiJm7ivkSbiJbDZ512ClksVBnO
	 S09P/UiJ/3901ru+hkhvVG6Ioe9HgCRK+NqkHDOpynZh2KPoCMqzI2OluFNpxJMuaa
	 zLA8FaMe8Uw8ScKDc7vZljUYCmf6ddYwTNqhYTKuJ/HHbuhcv/pl5JG6IpYZ7MY1r5
	 bzrUUa/vd11imvh8X01Lacn8VO+jOgSRcCo9chzYw69HrDlWnofb2BACKT9Z4foK0c
	 MNrmrVgM9K4Sg==
Date: Thu, 24 Sep 2026 02:21:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: Srirangan Madhavan <smadhavan@nvidia.com>, Alison Schofield
 <alison.schofield@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Dave
 Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Ira
 Weiny <ira.weiny@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Alex Williamson
 <alex.williamson@redhat.com>, <vsethi@nvidia.com>,
 <alwilliamson@nvidia.com>, Sai Yashwanth Reddy Kancherla
 <skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Manish Honap
 <mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, Richard Cheng
 <icheng@nvidia.com>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v13 02/15] cxl: Share CXL port upstream PCI device
 lookup
Message-ID: <20260924022156.5d376e91@jic23-hlaptop>
In-Reply-To: <63e196f0-7175-4421-8677-5ae30cbfbacf@amd.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
	<20260922083924.2451158-3-smadhavan@nvidia.com>
	<63e196f0-7175-4421-8677-5ae30cbfbacf@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> >  
> >  	/*
> > @@ -625,11 +612,13 @@ void read_cdat_data(struct cxl_port *port)
> >  	port->cdat.table = buf->data;
> >  	port->cdat.length = length;
> >  
> > -	return;
> > +	goto out;

Confusing flow, just duplicate the pci_dev_put()

> >  err:
> >  	/* Don't leave table data allocated on error */
> >  	devm_kfree(dev, buf);
> >  	dev_err(dev, "Failed to read/validate CDAT.\n");
> > +out:
> > +	pci_dev_put(pdev);  
> 
> I'd use __free() instead of introducing another goto, especially since this is the ideal
> use case for it. There should be a free action defined for this, but I can't remember what
> it's called.

Don't do that.  See the guidance on where __free should be used in
cleanup.h.  There are places where it 'could' be used but we don't
because it adds fragility under potential code refactoring.

Jonathan





