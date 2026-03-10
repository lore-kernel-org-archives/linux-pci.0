Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0B62C11FE;
	Tue, 10 Mar 2026 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773156657; cv=none; b=NOF4QPZgt5kfcq/cV/eS2s3S/2jpQS/TOnJwJc4G8SzoIwP+qazbmezVS7KlrzRaa7nrwEh+R5hSiMuj5j3sp4dgIEx0jARd+WTSbaEJ7VefqJ4mlQS8LeWzY+YN7jsldb8QEqfwQgZ5I8qhTik8nXeokUe+flzXQlGHiAhSROs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773156657; c=relaxed/simple;
	bh=b4O0EM+uxFd+g9UdQ2la/JIfIpf7FntL6wm/5Ex5rSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBn1Qwam01amy3heu+Gz8o9r9t4nJbnqRjldG3E+pCF/xYGDpBXkcZ3JYwtrFqu+Fb8VJbGv4Ky8iB/DV9F6ME+V9NlHPMHCum3nPukoqsj4BVlBP9Fv5fgU11MPIoLFdXWbdcqATK9SDlNU0KkV5r6IXtzCsTJPJzhUaaq3rEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cldBNYhX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cldBNYhX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC00C19423;
	Tue, 10 Mar 2026 15:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773156656;
	bh=b4O0EM+uxFd+g9UdQ2la/JIfIpf7FntL6wm/5Ex5rSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cldBNYhXxNqSMKyUEjACEnnIiGpiLgfRumrIzYfQu904sAMT25Sn5aadisyNtr0+O
	 ddl7aaWmR2LeoRQXQQb3oCv0AYAJDP+u+zCCIHfoQPU8pzhv1/phPWZsUEavMYswRH
	 sOUkeKhxkRbbE4/sutIzwyQ8yHQMPLsX+t9fS5yCHbu8g2hJW/hpYmiEcA9ynM06bo
	 CgZE5JIDswJwFsH05YrGcB8DcxLw97a6lkGosu/SNwXcT+j42JinGzdFREh6VOEIkv
	 Kfw9y82F637atCLv03Up3A2Of+tr91yiWjAl9XIU4te9q2EW1kZKr3YHb3xKYwZ1Ni
	 MzlmkhLOCk8IA==
Date: Tue, 10 Mar 2026 21:00:42 +0530
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
	Grimmauld <grimmauld@grimmauld.de>
Subject: Re: [PATCH v3] PCI: dw-rockchip: Enable async probe by default
Message-ID: <f7tfshf7riljjibuqge4ubfjmludubpyh3ppdf6lasurzdzbtj@sw4xxagfhnn3>
References: <20260226101032.1042-1-linux.amoon@gmail.com>
 <177260693908.10259.13055467642416391434.b4-ty@kernel.org>
 <87bc37ee-234c-4568-b72e-955c130a6838@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bc37ee-234c-4568-b72e-955c130a6838@arm.com>

Hi Robin,

On Tue, Mar 10, 2026 at 01:41:56PM +0000, Robin Murphy wrote:
> Hi Mani,
> 
> On 2026-03-04 6:48 am, Manivannan Sadhasivam wrote:
> > 
> > On Thu, 26 Feb 2026 15:40:23 +0530, Anand Moon wrote:
> > > Rockchip DWC PCIe driver currently performs synchronous link training for
> > > combo PHYs (PCIe 3.0/2.0 and SATA 3.0) during boot. This process waits for
> > > the link to be fully established, adding several milliseconds to the boot
> > > sequence. To optimize boot time, this change enables asynchronous probing,
> > > allowing link establishment to proceed in the background while the kernel
> > > continues probing other devices.
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [1/1] PCI: dw-rockchip: Enable async probe by default
> >        commit: ec392abc95932838bf7e3d659d358f4df9ff5a0a
> 
> This appears to have the side-effect that calling pci_host_probe() from
> async context can effectively force async probe for the endpoint drivers
> as well, but some drivers are not OK with that, as our CI has just
> flagged up.
> 

Thanks for reporting!

> (And as for that particular warning, ISTR last time I looked into it
> another context, the opinion of the MDIO/phy maintainers seemed to be
> "don't force async probe".)
> 

This was discussed during v2 [1] and concluded that the async probe benefits
outweigh the unharmful splat from phylib. I also agree with the above conclusion
that this splat should not prevent us from enabling async probe for PCI
controller drivers. It can easily save a few 100ms during boot.

- Mani

[1] https://lore.kernel.org/linux-pci/aYHVlS1nbCMMyF04@ryzen

-- 
மணிவண்ணன் சதாசிவம்
