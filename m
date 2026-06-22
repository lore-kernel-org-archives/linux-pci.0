Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5688D2E7F39;
	Mon, 22 Jun 2026 17:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782148609; cv=none; b=tra6kEPwJz0r+ptbCHg7OLTeMPL9MNf7dpX8DE+0B0MWkQKg/6eGgZRx6jcqT9jmJRcMC47+Vnvm55Rc9aVSmeyg9pNfNQ9LlFGMZfE7NV2VIdGTrKtCdxivu/ZeF6olimdegdhS/el64HPCiuJzi6gn/xgUP2hfYc+fTmronS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782148609; c=relaxed/simple;
	bh=RTxHbCWU9D+ZpCt15RzyakxYdwIyiv0JQgVK5qF5cJE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=km4ISwhI/c7qYsgUA3iO7ZcvzrkHZdrlW2WiVSpOiT6UbAG1sUUz2UlrFlSGZc5VlDprHtFi8xPzU9f/u+XM+E0cnKK5r9frQ2xTzd8RR0fgRFtZ9aLc1PIm3qGPIWhcXFtZQ0PH518JKx9gYd8q87/XZJsjzp4xY2qnR7dFnPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQtSWGhh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQtSWGhh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B081F00A3F;
	Mon, 22 Jun 2026 17:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782148607;
	bh=VcMnPJRoaga3xGcj22jm5ElwM8hLlIFDYrlbGA7u6P8=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=UQtSWGhhdGmzbx0q2JAIN0hFa6JKgNrdFf1Yf3+aXtgWRUOvc9XygH6fv0eHlfvdz
	 Z84iW5yZAna4vqDU8WBfVeyw9iZqqCpgCeAqXJeAMq7VYlPtOoE/TljEB8zAn3dDiz
	 sGlDn2WMV+d0TiKAbAuKQuzrQ8TK4eljahKc85rLFxGk8Myt9y987MfJQdrmKli6hO
	 BS9In/DIJCc8BTGX3LZRT4RqK0u7SXcOLHoEeWYAPfM+lS+PnEzc43k3MMlXe000Ie
	 bKoD43TMBBHeIU6+48qkcw0ghmXfVQnzkbnqbYAJHNem98Vjg/5rfcnKM1uyTNrJxH
	 igKqV8+OXNt2g==
Date: Mon, 22 Jun 2026 12:16:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: mani@kernel.org, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, kwilczynski@kernel.org, ilpo.jarvinen@linux.intel.com,
	jingoohan1@gmail.com, robh@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v7 1/3] PCI: Add public pcie_valid_speed() for shared
 validation
Message-ID: <20260622171646.GA681416@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03cb3d65-c3e5-4396-9612-4e3ca8bf02f5@163.com>

On Fri, Jun 19, 2026 at 11:33:11PM +0800, Hans Zhang wrote:
> On 6/15/26 23:17, Hans Zhang wrote:
> > On 6/12/26 01:23, Bjorn Helgaas wrote:
> > > On Tue, Apr 07, 2026 at 09:04:48PM +0800, Hans Zhang wrote:
> > > > Extract the PCIe speed validation logic from bwctrl.c's static
> > > > pcie_valid_speed() into a public static inline function in pci.h.
> > > > 
> > > > This allows consistent speed range checks (2.5GT/s to 64.0GT/s) across
> > > > multiple drivers and functions, avoiding duplicate code and ensuring
> > > > validation consistency as per PCIe specifications.
> > > > 
> > > > Signed-off-by: Hans Zhang <18255117159@163.com>
> > > > Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> > > 
> > > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > > 
> > > Any objection, Ilpo?
> > > 
> > > It looks like 1/3 and 2/3 are pure moves, and the interesting part is
> > > the use in dwc, which I'd like to be reviewed and applied by Mani.
> > 
> > Hi Mani,
> > 
> > Gentle ping on this series. Please apply it when you have time. Thank
> > you very much!
> 
> Hello Mani,
> 
> May I check if there is still window to merge it into v7.2-RC1?

There is not.  Unless there's some catastrophe the bits in pci/next
are what will be in v7.2-rc1 (I will update some merge commit logs,
but "git diff 40e92a5476e7 pci/next" should be empty).

> > > > ---
> > > >   drivers/pci/pci.h         | 5 +++++
> > > >   drivers/pci/pcie/bwctrl.c | 5 -----
> > > >   2 files changed, 5 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > > index 4a14f88e543a..f0a082bfd6f1 100644
> > > > --- a/drivers/pci/pci.h
> > > > +++ b/drivers/pci/pci.h
> > > > @@ -606,6 +606,11 @@ void pci_bus_put(struct pci_bus *bus);
> > > >        (speed) == PCIE_SPEED_2_5GT  ?  2500*8/10 : \
> > > >        0)
> > > > +static inline bool pcie_valid_speed(enum pci_bus_speed speed)
> > > > +{
> > > > +    return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_64_0GT);
> > > > +}
> > > > +
> > > >   static inline int pcie_dev_speed_mbps(enum pci_bus_speed speed)
> > > >   {
> > > >       switch (speed) {
> > > > diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> > > > index c4c8d260bf96..ea82e326f164 100644
> > > > --- a/drivers/pci/pcie/bwctrl.c
> > > > +++ b/drivers/pci/pcie/bwctrl.c
> > > > @@ -48,11 +48,6 @@ struct pcie_bwctrl_data {
> > > >   /* Prevent port removal during Link Speed changes. */
> > > >   static DECLARE_RWSEM(pcie_bwctrl_setspeed_rwsem);
> > > > -static bool pcie_valid_speed(enum pci_bus_speed speed)
> > > > -{
> > > > -    return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_64_0GT);
> > > > -}
> > > > -
> > > >   static u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
> > > >   {
> > > >       static const u8 speed_conv[] = {
> > > > -- 
> > > > 2.34.1
> > > > 
> > 
> 
