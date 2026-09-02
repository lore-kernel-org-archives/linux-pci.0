Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB9C377EC2;
	Wed,  2 Sep 2026 07:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788333923; cv=none; b=Eiwngob+C0gVtr2ZUTbbpTsgGZl22Yn2VF2Zr/fOnk4qqUfNuj0TjklTNTKylGC/+ESBUHWxTkFWAL9J9jM1qgbxJ0Dl8p1Pnwkr1YFg83O6TwaFSCdmMMDQ9YitfIupfDDyaK2787dqKspcdbqvwQxcJyxZFmaSxjEl0ytflc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788333923; c=relaxed/simple;
	bh=xVefhCfWOs315KhgltJ/xQPwfNGo9Mqizsdsfu2cXzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+Ro269800Uee8XrmofKrWXxwblCyPCu1TPVkrY/4ChOtEKa/XwKjuAp6US4h+tb41yXvImd0DPsHD6k5x4H33dX6cKv8vWnJ9U89eaGXlenpFAeH5RfonU2ZaW0qrOm7x5eB5thLPLYadHVpZla71aVnvdPlZyjvgHS/TAhVxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDj0pHfA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDj0pHfA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCB81F000E9;
	Wed,  2 Sep 2026 07:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788333922;
	bh=DlTJOIsThjiSM/dkMSfWXp9ZPGqirIyhJ6Grt5P8AUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XDj0pHfAS59/KUdvAlCj+JVDqbtR0LF4LH36ZomND++PC0c/U3kb0O2eaVcXYGYZF
	 FMoEsSlT8I2yP9jm7xm5/5lbxp8/vK2siRw3ZoX28miej3Bp8Hzv2rIlMNOBl3yUo8
	 fiQ2iYcVEep0worPDZpDACJuVKRHrZtJMgi+VEl2xAvoCLB39rc70tZiYwgnkX1fRE
	 pdGPdEwKvxCyc/o/yzzaA9U/uETV1LQ+tiXjeZrugtoGjYRGqII3GHYRwdloxcCcZN
	 0HlQyAJ/AxdnGgmRbrjsClUesLhRna4dWFJSJpuEMI31aSSVi44BBjGjV+fVrRRiOF
	 JDetf+6cvik6g==
Date: Wed, 2 Sep 2026 09:25:13 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Aksh Garg <a-garg7@ti.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	ntb@lists.linux.dev, linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] PCI: endpoint: Support hardware-owned MSI-X table
 and PBA
Message-ID: <apfPWc09CY2o-P5s@ryzen>
References: <20260830151948.3547577-1-den@valinux.co.jp>
 <apVWd1u9JjTKQczu@ryzen>
 <pj5vpwwd5tr5tuvhdq3bcpefnq27r6ljvwoysguz2o4tglcqx5@l7zmb6wjnhla>
 <apXdm2I33edo8kpZ@ryzen>
 <sor2mm4jzgeprhn3fjw4jmcaowwkhhuus6exi4k5kum6frqvug@gatkk7r4qyxd>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sor2mm4jzgeprhn3fjw4jmcaowwkhhuus6exi4k5kum6frqvug@gatkk7r4qyxd>

On Wed, Sep 02, 2026 at 11:14:00AM +0900, Koichiro Den wrote:
> 
> This still sounds really odd, and it does not obviously explain why both DWORDs
> at 0x4000 and 0x4004 are affected. I may be missing something important. If
> anything similar involving iMSIX-TX Table RAM entry #0 has been discussed
> before, please point me to the relevant thread.
> 
> (Also, I can share my current WIP v3 series, which makes pci-epf-test and
> nvmet-pci-epf use the hardware-owned layout when available, while leaving
> pci-epf-ntb with its EPF-owned layout. If you have any setup where you could
> test it, please let me know.)

Some time ago, I did verify that I could raise an IRQ using
dw_pcie_ep_raise_msix_irq_doorbell(). If I remember correctly, I did so using
pci-epf-test and not nvmet-pci-epf.

Did pci-epf-test work? (From what you explain, it seems to be related to if
MSI-X Table entry #0 is used or not.)

Please share your branch. I should have time to do a quick test.


> 
> > 
> > 
> > What I suggest that you instead do something like:
> > Patch 1/7: pci-epf-vntb: Fix to actually use MSI-X when requested.
> >            This probably includes adding the code that is inside the
> > 	   if (ret == -ENOENT) { }.
> > Patch 2/7: PCI: endpoint: Support hardware-owned MSI-X table and PBA
> > Patch 3/7: PCI: dw-rockchip: Support fixed MSI-X table and PBA on RK3588
> > Patch 4/7: pci-epf-vntb: Add code that calls pci_epc_get_hw_msix_layout()
> >            and uses that layout, if the function returned success.
> > Patch 5/7: pci-epf-test: Add code that calls pci_epc_get_hw_msix_layout()
> >            and uses that layout, if the function returned success.
> > Patch 6/7: nvmet-pci-epf: Add code that calls pci_epc_get_hw_msix_layout()
> >            and uses that layout, if the function returned success.
> > Patch 7/7: pci-epf-ntb: Add comment that explains why it cannot call
> >            pci_epc_get_hw_msix_layout() like all other EPF drivers that
> > 	   support MSI-X.
> > 
> > 
> > This way, patch 1/7 can be backported, and will help all users vNTB users,
> > even the users that do not use RK3588 as an EPC.
> 
> That split makes sense. However, given the issue I described above, perhaps I
> should send patch 1/7 as a standalone fix and hold off on the rest until the
> issue is understood and resolved.

Agreed, a standalone 1/7 patch could be picked up without the need to wait for
any other changes.


> 
> Testing vNTB alone (ie. this v2 way) did not expose it because its first data
> doorbell uses MSI-X Table entry #2. I only found the issue because your
> suggestion led me to convert and test nvmet-pci-epf, thank you!

I'm sorry that we have a problem.
At least it is better to discover it now, rather than discovering it after
the patches had been merged.


Kind regards,
Niklas
