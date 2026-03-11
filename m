Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008C3299A94;
	Wed, 11 Mar 2026 05:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773206716; cv=none; b=GwZtYXYjtI4uK3QywJS+zLa4X+e+FLYn5Bg7Q7HkjEU5HltxgLRRzv3ygi44Wygi7Po+Gyk9CeM4Mp6CAlGhXwo7Nq4OikLX5fvrAMcPZX3ojcf/rhV224+4dFLTtzEWA0aNgRtTJwyXprfOdrc110pZ+ehWjvXi9h25dpJOun4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773206716; c=relaxed/simple;
	bh=Lz9CL6rzdbiGSs2MlZc2h5jp54acjzYn9zhxUZhjCSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoSpxFMql30dgpGSlNaJhGBMsYMm7gQA5B9wv/NSTS3CiezuwQWYOdJq0ik0854yslLOiPfaWqvW45TjkFQ3/2FzaunS8LrlKfd4uJ14UzJstILEcB7AVBuJU+gJ89wuQDkYlkcUpAALsXz2osq4UxKh1kuuEYHlfQVuXhsuy0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdjU4UpZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdjU4UpZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A392C4CEF7;
	Wed, 11 Mar 2026 05:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773206715;
	bh=Lz9CL6rzdbiGSs2MlZc2h5jp54acjzYn9zhxUZhjCSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EdjU4UpZvCZbIz4IVjbWg8bEigB3Il9TDaxRPMNRYXAG6xI2m5oVM27GWJq9zR/hH
	 8Ty+XAHDBc4IUpQM8TdwFjmSF4DaxoA0q72QiB0raWNfuMJ4QZoYnb1hcXum40d/Sz
	 0czfouRTFALAxFnaQi0PvKTVzE2B1cAP/3MX5rWbrFPZZZ9rPBzE+9Hirvq5N2ItzK
	 UTE/x50P9uX3bI8lKJEFcYCb4wRUjI3INck/AuD0xtc05ojvJAqYALfkhZDrk+q0xK
	 fJH78WljXcK36ZUbkStnvdCkZOBhl9NtbnuzcSAWrIB8kJvVdk3UTbP58N16nx/tdr
	 mhCw5KctX23kw==
Date: Wed, 11 Mar 2026 10:54:59 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Niklas Cassel <cassel@kernel.org>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Hans Zhang <18255117159@163.com>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>, 
	Grimmauld <grimmauld@grimmauld.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3] PCI: dw-rockchip: Enable async probe by default
Message-ID: <qwanhqrpztzkudik5fmberhabnzaly7v53677dohqzj5nq4wi2@6ndpiubyxcbi>
References: <20260226101032.1042-1-linux.amoon@gmail.com>
 <177260693908.10259.13055467642416391434.b4-ty@kernel.org>
 <87bc37ee-234c-4568-b72e-955c130a6838@arm.com>
 <f7tfshf7riljjibuqge4ubfjmludubpyh3ppdf6lasurzdzbtj@sw4xxagfhnn3>
 <5d88fb5b-e771-4ea6-8d2c-c5cfd21e5860@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d88fb5b-e771-4ea6-8d2c-c5cfd21e5860@arm.com>

On Tue, Mar 10, 2026 at 09:03:32PM +0000, Robin Murphy wrote:
> [ +driver-core maintainers - async probe question below ]
> 
> On 2026-03-10 3:30 pm, Manivannan Sadhasivam wrote:
> > Hi Robin,
> > 
> > On Tue, Mar 10, 2026 at 01:41:56PM +0000, Robin Murphy wrote:
> > > Hi Mani,
> > > 
> > > On 2026-03-04 6:48 am, Manivannan Sadhasivam wrote:
> > > > 
> > > > On Thu, 26 Feb 2026 15:40:23 +0530, Anand Moon wrote:
> > > > > Rockchip DWC PCIe driver currently performs synchronous link training for
> > > > > combo PHYs (PCIe 3.0/2.0 and SATA 3.0) during boot. This process waits for
> > > > > the link to be fully established, adding several milliseconds to the boot
> > > > > sequence. To optimize boot time, this change enables asynchronous probing,
> > > > > allowing link establishment to proceed in the background while the kernel
> > > > > continues probing other devices.
> > > > > 
> > > > > [...]
> > > > 
> > > > Applied, thanks!
> > > > 
> > > > [1/1] PCI: dw-rockchip: Enable async probe by default
> > > >         commit: ec392abc95932838bf7e3d659d358f4df9ff5a0a
> > > 
> > > This appears to have the side-effect that calling pci_host_probe() from
> > > async context can effectively force async probe for the endpoint drivers
> > > as well, but some drivers are not OK with that, as our CI has just
> > > flagged up.
> > > 
> > 
> > Thanks for reporting!
> > 
> > > (And as for that particular warning, ISTR last time I looked into it
> > > another context, the opinion of the MDIO/phy maintainers seemed to be
> > > "don't force async probe".)
> > > 
> > 
> > This was discussed during v2 [1] and concluded that the async probe benefits
> > outweigh the unharmful splat from phylib. I also agree with the above conclusion
> > that this splat should not prevent us from enabling async probe for PCI
> > controller drivers. It can easily save a few 100ms during boot.
> 
> The problem is not an "unharmful splat" from one driver on one board -
> that's *a* symptom, and the fact that it happens to be a relatively benign
> one does not dismiss the problem that forcing async probe upon drivers that
> are not designed to support async probe cannot in general be assumed to be
> safe, so is not OK. It's one thing if a user brings it upon themselves by
> explicitly using the "driver_async_probe=" option, but it's very different
> if some other driver starts doing it for them.
> 

I have a contrary view here. If just a single driver or lib doesn't handle async
probe, it cannot just force other drivers to not take the advantage of async
probe. As I said above, enabling async probe easily saves a few hunderd ms or
even more if there are more than one Root Port or Root Complex in an SoC.

Moreover, there are multiple ways this splat could be triggered as reported in:
https://lore.kernel.org/netdev/7103704.9J7NaK4W3v@fedora.fritz.box

> Looking closer, it seems like the fundamental issue might be when we've got
> this far (simplified for clarity):
> 
> - async_run_entry_fn
>   - rockchip_pcie_probe
>     - pci_host_probe
>      - pci_bus_add_device
>        - device_initial_probe
>          - __device_attach_driver
> 
> wherein we then reach the "if (data->check_async && async_allowed !=
> data->want_async)" condition, at which point check_async is true (from
> device_initial_probe()), while async_allowed and want_async are *both*
> false, but that leads us to actually go ahead and call driver_probe_device()
> for the child device despite being in async context. That doesn't seem right
> to me - I'm guessing it maybe wasn't anticipated to have bus drivers calling
> device_initial_probe() from within async in the first place?
> 

But isn't the underlying issue is with phylib calling request_module() while the
driver core performs async probing?

> It may not strictly be the fault of this patch - clearly 91703041697c ("PCI:
> Allow built-in drivers to use async initial probing") is implicated in this
> too - but the fact is that it *has* exposed a bug that needs fixing one way
> or another, it can't just be left hanging and impacting end users.
> 

I strongly agree with you here that the underlying issue should be fixed. But
the real impact to end users is not this splat, but not having the boot time
optimization that this patch brings in. As an end user, one would want their
systems to boot quickly and they wouldn't bother much about a harmless warning
splat appearing in the dmesg log.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
