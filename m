Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAC93A1E8C
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771953190; cv=none; b=KMpJsdqQeU43UEFUAYAOtWcTdrGRkqywgmJFDNfWGi49BGOft5O/d2E/0uAUSP9EOKGo+lTjgOWt1kKwJrZUGSyB48KHIyQNuDLkKyV7kgf9xzr/vgAiuP3FZ2vU572a/CQ/p6D7ikdhKjZDHIr8ALTybygimtqCabiKtysLP8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771953190; c=relaxed/simple;
	bh=NulEL6fqLs0czE4T5z48TsWluNiFQuZ3KFDTeVj9E5M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IBFEDZ2r2EwYGkOQZ7MLzlEW+lcAOUZ+EPolOHZikE+3kn+koSRlRCcE7SndQ5b7sqtssJYGMFjSSwnzSoXZp1hhPw+Z5ng/GdTCb0JdLBGpBEgq25IfutZDnRF9J61HzXqfeyd1ITOzx08DpKmCCABLeBislnEPIaPqIY65o9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCTNLL77; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCTNLL77"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D1FC116D0;
	Tue, 24 Feb 2026 17:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771953189;
	bh=NulEL6fqLs0czE4T5z48TsWluNiFQuZ3KFDTeVj9E5M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DCTNLL770X8FvQXcamjZnxBqUTQ2CgMojtGXy8g3eVWwMWxhX3P/EsK9vjcXgD0+K
	 s6yFtX+c0GRBW/HxZ5RT9uuQzg9kmS2MdSYUOiqMULwBLscaI7RjzRxsZnSVt7G08c
	 2T4KsgoB9f5RmMUMf3eCcMs3GKzMflLAEZpCCMztlXClKHu3aEEVGW0ggvg7OzUYtG
	 kud+6vVxeR8FMigP7AWYN2aG5hFxnfDJgDAJ7Ui+GIlmChOyUdNsTqWCKsfbT7frFn
	 Px5Snu8wU+mMju5n1nHOpOFV5j0LZ5TDa/UyxqVrKjIKdAZIdzDSVa8zdxEDFtkY9M
	 6l0ndDg9qmong==
Date: Tue, 24 Feb 2026 11:13:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dima Ruinskiy <dima.ruinskiy@intel.com>
Subject: Re: [PATCH 0/5] PCI / igc: Improvements related to PTM enabling
Message-ID: <20260224171308.GA3737399@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224111044.3487873-1-mika.westerberg@linux.intel.com>

On Tue, Feb 24, 2026 at 12:10:39PM +0100, Mika Westerberg wrote:
> Hi all,
> 
> There is (still) an issue with Linux PCIe PTM enabling that happens because
> Linux automatically enables PTM if certain capabilities are set. However,
> turns out this is not enough because once we enumerate PCIe Switch Upstream
> port we also enable PTM but the Downstream Ports are not yet enumerated.
> This triggers floods of AER errors like this:
> 
>       pcieport 0000:00:07.1: AER: Multiple Uncorrectable (Non-Fatal) error message received from 0000:00:07.1
>       pcieport 0000:00:07.1: PCIe Bus Error: severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Receiver ID)
>       pcieport 0000:00:07.1:   device [8086:d44f] error status/mask=00200000/00000000
>       pcieport 0000:00:07.1:    [21] ACSViol                (First)
>       pcieport 0000:00:07.1: AER:   TLP Header: 0x34000000 0x00000052 0x00000000 0x00000000
>       pcieport 0000:00:07.1: AER: device recovery successful
>       pcieport 0000:00:07.1: AER: Uncorrectable (Non-Fatal) error message received from 0000:00:07.1
> 
> We have ACS Source Validation enabled so Requester ID 0 which is sent by
> the not-enumerated Downstream Port triggers the ACS violation AER.
> 
> This can be prevented by enabling PTM when the whole topology has been
> enumerated and doing it like that seems to be reasonable anyway because we
> only have a couple of drivers enabling it now so it does not make sense to
> enable otherwise as it consumes bandwidth.
> 
> I did that fix and the problem went away but wanted to test with a device
> and driver that actually enables PTM. I have a couple of igc NICs here that
> has this support. However, when testing I noticed that during power state
> transitions we still get errors like this from igc:
> 
>   igc 0000:03:00.0 enp3s0: Timeout reading IGC_PTM_STAT register
> 
> and after this PTM for the device stays disabled.
> 
> This series includes fixes for igc that deal with the issues I found and
> now PTM gets succesfully enabled and works accross suspend and runtime
> suspend of igc, and there are no flood of AER errors as above. While there
> there is one cleanup patch in the middle that drops unused parameter.
> 
> Mika Westerberg (5):
>   igc: Call netif_queue_set_napi() with rntl locked
>   igc: Let the PCI core deal with the PM resume flow
>   igc: Don't reset the hardware on suspend path
>   PCI/PTM: Drop granularity parameter from pci_enable_ptm()
>   PCI/PTM: Do not enable PTM automatically for Root and Switch Upstream Ports

These last two don't look dependent on the igc patches, so I applied
them to pci/ptm for v7.1, thanks!

Let me know if there is some dependency and I can ack them and drop
them from the PCI tree.

>  drivers/net/ethernet/intel/ice/ice_main.c     |  2 +-
>  drivers/net/ethernet/intel/idpf/idpf_main.c   |  2 +-
>  drivers/net/ethernet/intel/igc/igc.h          |  2 +-
>  drivers/net/ethernet/intel/igc/igc_ethtool.c  |  6 +-
>  drivers/net/ethernet/intel/igc/igc_main.c     | 33 ++++----
>  .../net/ethernet/mellanox/mlx5/core/main.c    |  2 +-
>  drivers/pci/pcie/ptm.c                        | 77 ++++++++++---------
>  include/linux/pci.h                           |  6 +-
>  8 files changed, 64 insertions(+), 66 deletions(-)
> 
> -- 
> 2.50.1
> 
