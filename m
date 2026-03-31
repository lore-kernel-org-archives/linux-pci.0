Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D27432E143;
	Tue, 31 Mar 2026 17:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774978650; cv=none; b=l6kS9QWRAMhZU+cj4rSoa0UGifwJEc+ro243X4POOB72GgxE0vt6ba+pFUF1FpS4kBSPacGuE704B2b6nStV220fsNxegYWFSnFA3INfwUmHAm5ubNB6k7tGgCKB+IQczBFKCZTpnB3sdzp3UtPb2IAL7VlJrth9mi8nyU8J/Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774978650; c=relaxed/simple;
	bh=WpksPXyIw99SXHP6XfvYRIkFqPTyrE4cKVEoLSPOGjg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IBmSMptGbItx4o1xBAbQtOR91FXzLHeVhM3Ldj27Fk09BSLmZp3TpDeWeBzQARiuKHhFeB9INpb5cvHy9NyneMuDQZ7QZWqthaJGf9l0i+VsFdgNP5FGTawfVHuoQTU/QOmp2Skf8Wg9l9Zv70Ka5PgUxzv+oyKQ7jR5cD1Q7kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gG8740+2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gG8740+2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC550C19424;
	Tue, 31 Mar 2026 17:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774978649;
	bh=WpksPXyIw99SXHP6XfvYRIkFqPTyrE4cKVEoLSPOGjg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gG8740+2jWsBB00A/DGIMlZt4K6JOxU/WvIpb+wuD8JausTJEDb406FlA5+BejckJ
	 L1FgnjFO2WC9OvEWzMnTKEtsWanbjPH/VLFpePdQhsJsutw2Vr9tEFlAFQX/2wmNbL
	 x5jHIwDjqzf+oegOQptAITdZYTUXDLzKzqR/pM5skk9ss7t2sIBV2UaIY+SqhmgW4C
	 2QOm+qD3krGLt6g2p7/ZiaQVNhRyNYaWtU+/XuS/QUeaJTut6DGtygKO3DpoVxY/yk
	 TVzjAHFWTVooRrgLPvwNqNVhOgUQJ9CKM+Fg0QY26EOX51zaq8TsmsCse5XvJSAO/l
	 DF/LWj63WXKCw==
Date: Tue, 31 Mar 2026 12:37:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	andriy.shevchenko@intel.com, ilpo.jarvinen@linux.intel.com,
	dima.ruinskiy@intel.com, mbloch@nvidia.com, leon@kernel.org,
	linux-pci@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
	lukas@wunner.de, bhelgaas@google.com, richardcochran@gmail.com,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: Re: [PATCH net-next 01/15] igc: Call netif_queue_set_napi() with
 rtnl locked
Message-ID: <20260331173728.GA146742@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330230248.646900-2-anthony.l.nguyen@intel.com>

On Mon, Mar 30, 2026 at 04:02:30PM -0700, Tony Nguyen wrote:
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> When runtime resuming igc we get:
> 
>   [  516.161666] RTNL: assertion failed at ./include/net/netdev_lock.h (72)
> 
> Happens because commit 310ae9eb2617 ("net: designate queue -> napi
> linking as "ops protected"") added check for this. For this reason drop
> the special case for runtime PM from __igc_resume(). This makes it take
> rtnl lock unconditionally.

Taking the rtnl lock unconditionally certainly makes the code nicer,
but the commit log only mentions the "avoid the warning" benefit, not
the actual reason this is safe to do.

> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 72bc5128d8b8..98024b46789f 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -7536,7 +7536,7 @@ static void igc_deliver_wake_packet(struct net_device *netdev)
>  	netif_rx(skb);
>  }
>  
> -static int __igc_resume(struct device *dev, bool rpm)
> +static int __igc_resume(struct device *dev)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct net_device *netdev = pci_get_drvdata(pdev);
> @@ -7581,11 +7581,9 @@ static int __igc_resume(struct device *dev, bool rpm)
>  	wr32(IGC_WUS, ~0);
>  
>  	if (netif_running(netdev)) {
> -		if (!rpm)
> -			rtnl_lock();
> +		rtnl_lock();
>  		err = __igc_open(netdev, true);
> -		if (!rpm)
> -			rtnl_unlock();
> +		rtnl_unlock();
>  		if (!err)
>  			netif_device_attach(netdev);
>  	}
> @@ -7595,12 +7593,12 @@ static int __igc_resume(struct device *dev, bool rpm)
>  
>  static int igc_resume(struct device *dev)
>  {
> -	return __igc_resume(dev, false);
> +	return __igc_resume(dev);
>  }
>  
>  static int igc_runtime_resume(struct device *dev)
>  {
> -	return __igc_resume(dev, true);
> +	return __igc_resume(dev);
>  }
>  
>  static int igc_suspend(struct device *dev)
> -- 
> 2.47.1
> 
