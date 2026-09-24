Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A200175A97;
	Thu, 24 Sep 2026 02:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790218189; cv=none; b=fR7CGdQqqu4EMsKgk8SC+xD6tq+o/OLwMGUFhIW4BACua+j64GznK/72CZo9BkwMyHe4Y30AKzn2JAX5oAzzbm3a5p6pEPj7TGPbfk7mbO+rUxET1xrNB+LaiDWHVd0SvvtnvUFLQaXkk58Q/hGhqHGZB0mwgGwjmmB4bXr/UZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790218189; c=relaxed/simple;
	bh=BLQzwM9CA3pvKcX6gamTi/W9oZ+qPtKWcjCSvOYd8O8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LqzSNKmTBAcZn3oSGtgpDqqytbqNHqawEjKZ9dWRhLwTInQ3sAEjnmhvvavQRGRl+GVQfEMahYN1UkdTD12g3/sPz3x34qy5ENfCi7uWsKw8A0iAkJUVJDTalIBxT8x7jQH5JP6e87p5ip6QtAR53UOcMuN0rvCMex/YZGEPO+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnWvXjPz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnWvXjPz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6021F000FF;
	Thu, 24 Sep 2026 02:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790218187;
	bh=nqKrv9j7nwDwuCkYFcrrxbsaXIr+3HPgnP9RBtNkUtk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mnWvXjPzkgHH6kgadH3CpVG3/VA5eagnZtRckk8d0VkjGBBkB806jU1X6jt1mWPD5
	 tUpaWV31reVS3JiKeFz0ljtBOJdhtxllzI0RCx0gV2T8q3BsNyNHb5TGIEEGXdW96S
	 Va0SWGANeyCGUjewwLXMYdqtsutrwjKpPzdLt6cYbJOeGSLAObJG9gWtW6MMHKhhrM
	 jRijO53y+HzTilCwrRoUFvLAVgbqppYN3UgQD2sCicvKT+pIehNUwaXroy4uvjiQV7
	 eyDGkqadQd9tKMmOev8TNldNgsvgBK9HY9JocFG2ME9JOUSUQm8vmevck2gE5z7Fin
	 /Pa8jbHuFPZlQ==
Date: Thu, 24 Sep 2026 03:49:40 +0100
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
Subject: Re: [PATCH v13 06/15] cxl: Make HDM reset helpers available to
 built-in PCI code
Message-ID: <20260924034940.2e22b300@jic23-hlaptop>
In-Reply-To: <6dc03976-faa8-49cb-9b74-680e957f2f9e@amd.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
	<20260922083924.2451158-7-smadhavan@nvidia.com>
	<6dc03976-faa8-49cb-9b74-680e957f2f9e@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 16:40:05 -0500
"Cheatham, Benjamin" <benjamin.cheatham@amd.com> wrote:

> On 9/22/2026 3:39 AM, Srirangan Madhavan wrote:
> > PCI can be built in while CXL_BUS is modular, so PCI reset code cannot
> > depend on helpers provided by the cxl_core module.
> > 
> > Build the HDM resource helpers under CONFIG_CXL_RESET and restrict their
> > exports to cxl_core.
> >   
> 
> I think you should squash this patch into 3/15. Having this earlier does two things:
> 1) it makes it more clear why you're moving everything earlier in the set, and 2)
> bisects across the pass 3 patches will all result in the same configuration.
> 
> An alternative option would be to refactor the preceding 3 patches in-place and then
> move all of the helpers to this file in this patch, either would work.

There may indeed be some better orderings that make it easier to review
still - though this is already a great improvement on the earlier versions.

> 
> > Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> > ---

> > diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> > index 57995777af0d..30470799e059 100644
> > --- a/drivers/cxl/core/Makefile
> > +++ b/drivers/cxl/core/Makefile
> > @@ -1,12 +1,12 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_CXL_BUS) += cxl_core.o
> > +obj-$(CONFIG_CXL_RESET) += resource.o  
> 
> This file should probably be called reset.c instead of resource.c to match the
> Kconfig functionality.

I'm not keen on that change because the functions are core CXL stuff
that just happens to also be useful in reset.  You could change the object
name via some Kconfig magic so that matches, but the c file itself
wants to remain with some generic name.


> >  obj-$(CONFIG_CXL_SUSPEND) += suspend.o
> >  
> >  ccflags-y += -I$(srctree)/drivers/cxl
> >  CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
> >  
> >  cxl_core-y := port.o
> > -cxl_core-y += resource.o
> >  cxl_core-y += pmem.o
> >  cxl_core-y += regs.o
> >  cxl_core-y += memdev.o


