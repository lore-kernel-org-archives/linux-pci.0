Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4DD48C403
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 16:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772553841; cv=none; b=BYTReuQ4hto27lH6+3bkKUOLUah1+L26KjoI4e0gw1Uy+JjtGKGX27oY6m8GjM8hnIf3Z7g5q4gidmTQSpdG89m/YQSxTMg5ofYfrl79xQSLSrUliD3LgS+dkS0p+E4oa7qHfd/On/B+TqT+NmvovV4lLZDiE/XDgDI4NIQRcZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772553841; c=relaxed/simple;
	bh=K1I4YDSH6fsnqiudQ9QfYkr6IqYMz8DX3KDgzD3hyUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yx7NJT+JJEgEhsAFs6rxrTNvi05TVqSiT+xiQAAdcH/DuJl8CxG6pa65bkdj3S98G5peUtHRWzk1SOaTXhnetO3mikYsxO80FEkKjGbVTsT5TaO05H/wvRkiBzHn+fKKM39uLTYLy4BqF1BwoR+QK3L0wySUUUBewJrTgIhd+Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMaepPpL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMaepPpL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F451C116C6;
	Tue,  3 Mar 2026 16:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772553841;
	bh=K1I4YDSH6fsnqiudQ9QfYkr6IqYMz8DX3KDgzD3hyUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LMaepPpLi3YDi13ce8LeSGsJDrr+cULiO4jcIvOedUaTClCRp/SsWr4pkBqmuGVcp
	 oBFE6X7Uyy483X3H34Zsy/85ElrixdOZvCMN8Jz1Ksn8QH9Fs0tv4zkIcslG0zVXfR
	 0cqMipo7TVIiutKpEX6JDGeYO6U9/mujfKSPVcTBhC0pWg7njXyBUMQ+DdKmPisM3u
	 3woBQoWMuX37xmpaDVlfYLk7nH7mxZXspUIEe5rgwUOsjsn3la1JJ0WFEg7nD56XVA
	 mJRhUdmBvkg7XcbIv/+Nf5O6u3ZIJufNWqzPxbnWZYZEmxSFLAgV9942BC95OdAEwd
	 +XtfhKWkkStgQ==
Date: Tue, 3 Mar 2026 21:33:50 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sune Brian <briansune@gmail.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, mathias.nyman@intel.com
Subject: Re: [BUG] PCIe Stall on USB_PCI=y with SoCFPGA Root Port
Message-ID: <ltyufyd2mwqvduccjijrtpudbv7enh3shtyzbvjuz2ctypqy2p@j35crt53ylkk>
References: <CAN7C2SC_2k6+dvBTRoV1_trpPEF5h+k9KDOapTwcb90+=BUatw@mail.gmail.com>
 <20260302235100.GA4037767@bhelgaas>
 <CAN7C2SAcJp8nAhbRT9OyLeT2YsvmX=+Y4qhBZR_WQ3aDqNHywA@mail.gmail.com>
 <8d5cdf11-b5ba-2b10-c2ba-76d4aedb5197@linux.intel.com>
 <CAN7C2SAzfTTiViekA7kkYo2At+qYVSv-y22DyJC5RtdrfLYWjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN7C2SAzfTTiViekA7kkYo2At+qYVSv-y22DyJC5RtdrfLYWjw@mail.gmail.com>

On Tue, Mar 03, 2026 at 09:34:59PM +0800, Sune Brian wrote:
> On Tue, Mar 3, 2026 at 9:06 PM Ilpo Järvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Tue, 3 Mar 2026, Sune Brian wrote:
> >
> > > On Tue, Mar 3, 2026 at 7:51 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > >
> > > > [+to Joyce, pcie-altera.c maintainer]
> > > >
> > > > On Sat, Feb 28, 2026 at 11:05:17PM +0800, Sune Brian wrote:
> > > > > Dear PCI maintainers,
> > > > >
> > > > > Root Port: Cyclone V HPS Root Port PCIe
> > > > > Endpoint: uPD720202 Card
> > > > > Kernel version: 6.12.33-g3234b1ed8956-dirty
> > > >
> > > > v6.12 is fairly old; can you reproduce a problem with v6.19 or
> > > > v7.0-rc1?
> > >
> > > Had tried 6.19 same situation USB_PCI=y simply repeatable hang.
> > > No message shown or tells what happened.
> >
> > Hi,
> >
> 
> Hi all,
> 
> After a hard working day to repeatedly check and check.
> I finally got it to work.
> 
> The reason why it is not working in the first place is caused by
> INTEL-Altera PCIe driver having some registers shadowing bugs.
> Neither NVMe nor WIFI card had unraveled the inherent issue.
> While the USB slot card successfully triggered the inherent bug.
> 
> So the hang and stall is triggered by wrong register mapping under
> the PCIe driver not USB_PCI flag.
> 

Could you please post the fix so that others can also benefit?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
