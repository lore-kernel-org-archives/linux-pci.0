Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE954A49AC
	for <linux-pci@vger.kernel.org>; Mon,  5 Oct 2026 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215798; cv=none; b=Sfx+v4VzJaINZdjUSO2RJ7/a18aeQywx3WuScEVOZqbtPnxVbsJoljYpTKgWcDTyonEazGgtV8zALFHs1P/A0w/8zGuNxBZ3vLgFLYl0ucr+74T9ljxOjR/lpfpq6QTbsrlEqvQKLTZgr5oSnRzf3QbzOtW0Q28QG8eVE9Ow0UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215798; c=relaxed/simple;
	bh=x4Jnqs4dX/GifzA5HXhxL7NTTJwe/UklX0REgeDVdI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9FAZl6iGRIPraAn/DCaCvjA2CYyWpqwdBln/UhEpWBach85VrV1MCvknWUaM9f8+LENHqQezhqy9eQcBCxHIiRTllrYQ/+6X95N7GIDZXTwjxIFYi5+aHHqAnX7Ra1TvhGueso0oqIccgGlsD6neKAhiFtGdFBiDI/7s4qeo6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cj4VBovt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cj4VBovt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366F21F00893;
	Mon,  5 Oct 2026 15:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791215797;
	bh=LgPYNYfrn7ye985WUhZmZjMTjO1NjL5/D97itGyhqAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cj4VBovtnl76Di0FNaORQZqDfwdvc7zCoApzbtNjmPFX9T+uWd73bUMuh06UpnQ1+
	 ksSW1dEw2ub2TgAc9dPSUkjq9UsyIpuDX6Pv0bucOlI867eEbPfpGtLEsNSX7jrwRr
	 hO6Y8Q0Es7gBAN1iCW3ji5CF3mgjFCSkukc684bfHudd3KBwDlysCcz70C38EukJEy
	 7e3l+7ReX/I2JelXHCkZ1jLV7X3DZA6DEK1rlGvOC+NzJAOB8rgZ3+7zr5Gja+OICu
	 YKs18aFOTmpUEKcJbxSSZCe2vO8BGvgwIYw8chacuWO6WU1WI6CQ7l0xgyljXt4/kA
	 ACVa3CuIoU6ug==
Date: Mon, 5 Oct 2026 17:56:32 +0200
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Frank Li <Frank.Li@nxp.com>,
	Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: Update saved Max Payload Size in pcie_set_mps()
Message-ID: <asPIsBZYD51d7YsL@kbusch-mbp>
References: <20261005124154.2190628-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005124154.2190628-2-cassel@kernel.org>

On Mon, Oct 05, 2026 at 02:41:55PM +0200, Niklas Cassel wrote:
> pcie_set_mps() changes the Max Payload Size (MPS) in the Device Control
> register but leaves the copy saved by pci_save_state() alone, so the next
> pci_restore_state() puts back the old value.
> 
> The PCI core does change the MPS of devices whose state has already been
> saved: pci_configure_mps() reduces a Root Port's MPS when a device with a
> smaller MPS Supported is hot-added directly below it (commit 9f0e89359775
> ("PCI: Match Root Port's MPS to endpoint's MPSS as necessary")), and with
> "pci=pcie_bus_safe", pcie_bus_configure_settings() can do the same when
> pciehp calls it after a hot-add.  The Root Port's state was saved when it
> was added and again when portdrv probed it.
> 
> Since commit 3fc686d550f6 ("PCI/ERR: Add support for resetting the Root
> Ports in a platform-specific way"), pcibios_reset_secondary_bus() restores
> that saved state, without saving it first, after host->reset_root_port()
> has reset the Root Port, e.g. during AER recovery or on Link Down with the
> qcom and Rockchip DWC drivers.  The Root Port then goes back to the old,
> larger MPS while the device below it is restored to the smaller one, so
> the Root Port may send TLPs that the device treats as Malformed.
> 
> Update the saved copy of Device Control when pcie_set_mps() changes the
> MPS, like commit 909f7bf9b080 ("PCI: Update saved_config_space upon
> resource assignment") does for BARs.

Looks good to me:

Reviewed-by: Keith Busch <kbusch@kernel.org>
