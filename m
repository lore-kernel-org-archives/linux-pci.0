Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF473D954E;
	Thu, 17 Sep 2026 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670166; cv=none; b=gXXd7BvEHvKyTJg+x7eJ7Nr8r79W1D2WgoRY4ALr1kAJcEoO7dd1gDMrDgy+uZr8CtiKb/VC3+mRjGxShvMaX+Bp8IO8o7jGNmfjngBWpru5pD8rzKvtIok45nOPNqdJdqDiRhqO0ZlOVMqXot+rfHG0hJRp6dh7ljLch5lB/gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670166; c=relaxed/simple;
	bh=likCwKHBXUnTeBGj77u0NOzDuA3om3Gs+1sLDOVPWuY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bK46i++VR5vr/vxzHAFmV5YgSoA1PD/HSFA6Se9tgRAphnShFHE6WQ/0NspB4IpWi3pi7GSW07n33uWXoAJqwYrW8D94EVm96iyOR1XWfVN2UZb7z8nJhH6NXrpujqIpSjc9jkGkUUdNRYLgLXE1Vte/K2Q79N6mjhd2RqN01Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNLdW7Sv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNLdW7Sv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358911F000FF;
	Thu, 17 Sep 2026 18:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789670164;
	bh=VMuIqdf58whRQjARyNRh45d2VJkJgHaiJ7/sfPxyN00=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=TNLdW7SvlO9XQo7SLg+Cjq1f6IPm2PtSLg5P/LY4YJbLKi/nqQO1HS0nA3Z/1szCf
	 DPkSrvyFZ21h3lgVp4iUqEO2zDGGDHmeFDPwQEqjdqdhVsDE9QUhQ0clrfPAh3Sph/
	 EV7DvBW4jiPSvI9DvRxx216mrV/YK+zIn2muToEr2+BPCpUyHE/+mvu7M2Vl9rwnpG
	 7HkGpPciP+pQlLeSShO1kBsCdI5/mVOGa1GMuvsRtQGU/P5IZxZblhLnBPNsfI4dio
	 luuu9jrVathR962wMg3H+Nb2+fEgp2FM9H1uvv/7dkYUiq6CH1tM6sqEUExqoI95zT
	 OyS+jIJ4L9eqQ==
Date: Thu, 17 Sep 2026 13:36:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Semih Baskan <strst.gs@gmail.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, rjui@broadcom.com,
	sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	rafal@milecki.pl, zajec5@gmail.com, florian.fainelli@broadcom.com,
	arnd@arndb.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	rosenp@gmail.com, rani.hod@gmail.com
Subject: Re: [PATCH] PCI: iproc: Use pci_alloc_host_bridge() on BCMA
Message-ID: <20260917183602.GA1036092@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAsRjRmmPanAjpquZ4VnDDw9jqRkxPkLsu+KjrpwsOMj8-TE-Q@mail.gmail.com>

On Thu, Sep 17, 2026 at 09:02:23PM +0300, Semih Baskan wrote:
> On Thu, Sep 17, 2026 at 10:59:29AM -0500, Bjorn Helgaas wrote:
> > And why do we need pcie-iproc-platform, since pcie-iproc-bcma.c will
> > claim them?
> 
> I do not see anything on Northstar that needs it. I think
> pcie-iproc-platform is the front end for the iProc SoCs that have no
> bcma bus.
> 
> > Is there a requirement that pcie-iproc-platform must be able to claim
> > the PCI host bridge if CONFIG_PCIE_IPROC_BCMA is not enabled?
> 
> None that I can find. Neither symbol depends on the other, no in-tree
> defconfig sets either one, and multi_v7_defconfig gets both from their
> defaults. OpenWrt builds only the BCMA one. The one use of the
> platform driver on Northstar I know of is Rafał's: 767012397976 says
> it was tested with it on BCM47094, and his test in the thread on the
> axi ranges ran both drivers on his board. The platform driver
> enumerated the two BCM4366 devices on its own:
> https://lore.kernel.org/all/93ee7456-4179-4d78-b980-1df0b7e0278a@gmail.com/
> I have not looked outside the tree.

Then it seems like we should remove the "brcm,iproc-pcie" compatible
from DTs for platforms where bcma can enumerate it via EROM.  Those
platforms can enable CONFIG_PCIE_IPROC_BCMA.  They still need the PCIe
controller node in DT so they can use the wifi nodes below it, but if
there's no "brcm,iproc-pcie" compatible, pcie-iproc-platform shouldn't
do anything.

Arnd, Rafał, jump in if I'm in the weeds here.
