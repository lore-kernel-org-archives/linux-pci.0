Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5A63DB64D;
	Mon, 31 Aug 2026 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788171906; cv=none; b=NMOAbeP0OztqoEwoy9eVaSurq1hfRgCr4uEG5fuqJWhqwOdK7c2mFdl41HfmbP9HYgeAsolpJqq0HtgYbxwCliornGtr9j+yG4zHLMqhpE6QPmGoaAM2BNruWlMRi8JtNy1vf7oQgq4ufzlQagqa4ZdaJYcvfcxFVfU7Yc6CsVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788171906; c=relaxed/simple;
	bh=+e/t8V5CHYveliNBxUuHao6IVDZv7eObUKDHnlxpyRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufgsR5/4g+ks5UWF35KPw1wqj1mKDDrx2/C/7ace/crdqAKqdxRmzfnO6sfLRKZG8sPd/ATFUjMmHWeXoNr5LVyAosZJCWEYwEo5q871/09mFOrVbBvvznbMTdYB17WHOWxizc5C4WhV2+/U10FJuF+UjH/Q3n8BTDjIz1NRAH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwlEeD1A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwlEeD1A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F52C1F000E9;
	Mon, 31 Aug 2026 10:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788171903;
	bh=zaseKfBKearPYw7Wuabe86eyjpL9spqzKr085aFFM3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JwlEeD1AYQjwcUAv68IL1iO2pIcPdLTkGHHVGdpXZpuMdmTjBJhc2u8Z6i04N/LDX
	 qmDHN67KZvrQqQUz0P1hN3v4pm0coO4+caT2+mPVHnrZWokDN/aLxDlHEKYfyuvhtH
	 3dWCDefqAMUIGIWySelqyQiMhaTIzzJIhuVcuZJXFsC8cpmQXJjhA4bFf0O5PhJKWF
	 DILbrSEIX0djfXkoeAUuW/dNd8iiRunMYv08yFvK0Gb5byNnHmwBknZLT9a8W6h62S
	 QpQ75f/dgPQ6ImlDr7kl6PJB9gFi2m5n5HAgq2qgMwteKBqDZdbmIp+yj8ydPULnNt
	 6/amISV3gHSCw==
Date: Mon, 31 Aug 2026 12:24:55 +0200
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
Message-ID: <apVWd1u9JjTKQczu@ryzen>
References: <20260830151948.3547577-1-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830151948.3547577-1-den@valinux.co.jp>

Hello Koichiro,

On Mon, Aug 31, 2026 at 12:19:45AM +0900, Koichiro Den wrote:
> Hi,
> 
> Some DWC endpoint controllers keep the MSI-X Table and PBA at fixed
> locations in a reserved BAR. On RK3588, the MSI-X doorbell uses this
> hardware-owned layout, as discussed in e.g. [1].
> 
> The reserved-region types for the Table and PBA were added with the
> Tegra194 description. The MSI-X setup API, however, still takes only the
> Table BAR and offset and assumes that the PBA immediately follows it in
> the same BAR.
> 
> This series passes the complete layout to pci_epc_set_msix() and adds
> pci_epc_get_hw_msix_layout() to expose a hardware-owned layout. The core
> does not select it automatically. The choice stays with the EPF.
> 
> A hardware-owned layout is not a direct replacement for every caller.
> pci-epf-ntb, for example, reads host-programmed Table entries from its
> own BAR to set up peer outbound mappings.
> 
> The series also fixes an interrupt-type mismatch in vNTB. ntb_hw_epf can
> select MSI-X, while pci-epf-vntb currently configures and raises only
> MSI. On RK3588, selecting the fixed BAR4 layout also selects the DWC
> MSI-X doorbell. EPF-owned layouts continue to use the regular path.
> 
> In short:
> 
> - pci-epf-vntb gains MSI-X support and uses the hardware-owned layout
>   when available.
> - pci-epf-test, pci-epf-ntb, and the NVMe PCI EPF keep their EPF-owned
>   layouts. This avoids unnecessary changes and reduces regression risk.
>   They can use a hardware-owned layout later if/when needed.
> 
> [1] https://lore.kernel.org/r/aY2q80zeRKSRO21H@fedora


Perhaps you could improve the cover letter to more clearly state why you
are doing this change.

Some guesses:
- Better performance. We avoid the need to map + unmap the MSI target
  address using an iATU each time we raise an MSI-X. We also avoid the
  need to flush posted write before unmap.
  Is there any performance difference? If so, it would be nice with some
  numbers.
- Allows more concurrent I/Os. By not using an iATU when raising an MSI-X,
  we have one more iATU available, so we can have one more outstanding I/O.
- Less waste of BAR space. (Since the MSI-X table and PBA already
  always takes up space in one of the BARs, it is wasteful to have
  the EPF drive duplicate it in another BAR.)



Personally, I don't see why we should only change pci-epf-vntb to use
the hardware-owned layout when available. I don't see why we would not
want to change pci-epf-test, pci-epf-ntb, and nvmet-pci-epf as well.
(If the EPC defines a HW defined MSI-X table + PBA, why not always
use that? If there is no HW defined MSI-X table + PBA, let the EPF
put the MSI-X table in any BAR it likes.)


I understand that you introduce dw_pcie_ep_msix_layout_is_hw_owned()
because you want an EPF driver optionally use the HW defined table.
But if all EPF drivers always use the HW defined table if available, I think
you can avoid introducing this helper, and let rockchip_pcie_raise_irq()
unconditionally call dw_pcie_ep_raise_msix_irq_doorbell() for case PCI_IRQ_MSIX.

See e.g. drivers/pci/controller/dwc/pci-layerscape-ep.c which already calls
dw_pcie_ep_raise_msix_irq_doorbell() unconditionally for case PCI_IRQ_MSIX.


Kind regards,
Niklas
