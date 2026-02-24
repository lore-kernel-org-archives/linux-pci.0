Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FDD39E6F6
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771952319; cv=none; b=Nk1+6x/WcjYvX/1u93Yyy3PmWdWU3caulK8APk9aa7jsTJtlCLtR+6fNpZpqqiDNKPYGim1B0Qj1NGM/oV5GDoT3qBXMKaSuLBqRYIEjV5SuEzKJO1ntloXktlzqNtpN/wKpAviMML41K19nQncveitVk1Q6h8m0az4LmCB7/4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771952319; c=relaxed/simple;
	bh=siQjsKnJuhuW3XUqku5HX25GJOs/BK8nuegDHFGMHIc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XPL1iwCQUchVAarV53CAWPAQcKgLQdgH/r/UBQKfWvzyooCZsqJNJBe1IFpLKLE4oIHK2NbvSdw9JIDQ48PAGF8x2Shttp8hx35h+0yRzN4hQOr4EtxMfFmhwioa5vy0xEztUhZ/puMJLyfiemryMEVfNGVjmBWzyKW5NtDJXTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYMc6Wsk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYMc6Wsk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BD2C116D0;
	Tue, 24 Feb 2026 16:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771952319;
	bh=siQjsKnJuhuW3XUqku5HX25GJOs/BK8nuegDHFGMHIc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DYMc6Wskj4xkhmLQdMdsuiEdJWI66KqbasbEvT1KFsX6E1TzKu52L6jtI10bVP97u
	 n6YC1U3/juI+0meYG5LC2+/64CG23usJvSmZ3mlrd1S7179/rIsdhGHWwABwbdalk6
	 tKYHjcpL+kdnnZcOkr+4UvWs/fnYyv3Fh6+7Y3X4jaPlJEmJ5MRTGoZZyFv7zH0hK0
	 1Remt4YfQvRY1kuCWWzeeJJtjg6qaVxHUYjsF6ePqRzVzCCyDf8/iR8S1B94WiEq79
	 6PNUwZxVN0/D3BXOfLHS4tB7ih+DUMs0OwRAy5HtXvNBtJd5gw0Gl9pTVnfAqu2RAx
	 eqEEYdXDnvyHQ==
Date: Tue, 24 Feb 2026 10:58:37 -0600
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
Subject: Re: [PATCH 2/5] igc: Let the PCI core deal with the PM resume flow
Message-ID: <20260224165837.GA3736201@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224111044.3487873-3-mika.westerberg@linux.intel.com>

On Tue, Feb 24, 2026 at 12:10:41PM +0100, Mika Westerberg wrote:
> Currently igc driver calls pci_set_power_state() and pci_restore_state()
> and the like to bring the device back from low power states. However,
> PCI core handles all this on behalf of the driver. Furthermore with PTM
> enabled the PCI core re-enables it on resume but the driver calls
> pci_restore_state() which ends up disabling it again.
> 
> For this reason let the PCI core handle the common PM resume flow.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

I love it, thanks a lot for doing this!

Do we still need the pci_enable_device_mem() and pci_set_master()
in __igc_resume()?

I suppose some of that is related to the pci_disable_device() in the
suspend path (__igc_shutdown()), but there are only a few dozen
drivers that do this, so I'm not sure it's essential.

> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 7ffd34bfa14e..99a4c99ddd57 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -7526,9 +7526,6 @@ static int __igc_resume(struct device *dev)
>  	struct igc_hw *hw = &adapter->hw;
>  	u32 err, val;
>  
> -	pci_set_power_state(pdev, PCI_D0);
> -	pci_restore_state(pdev);
> -
>  	if (!pci_device_is_present(pdev))
>  		return -ENODEV;
>  	err = pci_enable_device_mem(pdev);
> @@ -7538,9 +7535,6 @@ static int __igc_resume(struct device *dev)
>  	}
>  	pci_set_master(pdev);
>  
> -	pci_enable_wake(pdev, PCI_D3hot, 0);
> -	pci_enable_wake(pdev, PCI_D3cold, 0);
> -
>  	if (igc_is_device_id_i226(hw))
>  		pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
>  
> -- 
> 2.50.1
> 
