Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3C4331235;
	Mon, 23 Feb 2026 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867602; cv=none; b=Xc8XOE2o1iRXxGoZF7M7+90VJFFdTeGlxxFjFBwAglJdf9Ooh9yAOK0CHsLSidSNPCwD86prMfYsqNPf5nGeZpLHvjE3xIFYc7TiYOUKwqFEqYWOAom8Qk4c8xRHRTBp/jXyf+cDkWnHqAg9djJ7hseKwyyLE1nyE/a35PLlMPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867602; c=relaxed/simple;
	bh=Uvz67bHig6UnP5k/OJHaj1rc/mxmm8La2NYZIr2bPfs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=s/2rJw+Xq2G+h02ALeMQW6U7eIvcFkzunxByRuen/w/ltv+fUtkkHCe6GTkTM67RZYvVczh0CoXXJ4Kr0miLeD/g3UugtK3Jw/SfigGujI28YrTQPFQEVFqkLskUleL5YpYrahIFfLCvDCdjuM8Dz9LoAldVWNj/fvES1spy+w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbCoF66A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbCoF66A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05643C116C6;
	Mon, 23 Feb 2026 17:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771867602;
	bh=Uvz67bHig6UnP5k/OJHaj1rc/mxmm8La2NYZIr2bPfs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=AbCoF66AzKxSBrVHsNJK9wNWGoOf+brMtC34hE6Ot1wMdn2UhUt3wPIJRMA0DMapC
	 ipVazdR0iswNuKYAw+HVcN8gEFgxqxRqc91xN7IimzWUdYzvdVNg0CN5Tj6+gCwGTd
	 s1BsdTl38p67woi/eSQ9ujo0+v6XBfhh1ki9XrUIkO5VY+s7U0dGy2t6lDShsE/pho
	 T1HYX6G9IHDrmSQfb4uux+bTVI/yuhet62EG81VnOhqZasSLlBkUDBineRj2Xm5oX3
	 4hQ2EJGmS/XrQiLYY3pYjA4giT+g3DxVwpVSyWgRPusI79qJRzQTJytkpfqq4Vuc/P
	 /iiz4ebq9eGpg==
Date: Mon, 23 Feb 2026 11:26:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Majed Alkhaleefah <majedalkhaleefah@gmail.com>
Cc: Scott Murray <scott@spiteful.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: cpcihp: Check pci_hp_add_bridge() return value
Message-ID: <20260223172640.GA3697753@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223023645.344137-2-majedalkhaleefah@gmail.com>

On Mon, Feb 23, 2026 at 02:36:46AM +0000, Majed Alkhaleefah wrote:
> Check the return value of pci_hp_add_bridge() in cpci_configure_slot(). If
> bridge initialization fails, log an error message using err().
> 
> Current functionality doesn't consider uninitialized bridges a failure.
> Changing this may introduce regressions. As such, intentionally avoid
> propagating the failure (e.g., returning -ENODEV).
> 
> This patch addresses an item in the cpcihp TODO list.

This sentence could just be dropped and the item removed from the list
in the same patch.

> Compile-tested only.
> 
> Signed-off-by: Majed Alkhaleefah <majedalkhaleefah@gmail.com>
> ---
>  drivers/pci/hotplug/cpci_hotplug_pci.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/cpci_hotplug_pci.c b/drivers/pci/hotplug/cpci_hotplug_pci.c
> index 6c48066acb44..331c21833c44 100644
> --- a/drivers/pci/hotplug/cpci_hotplug_pci.c
> +++ b/drivers/pci/hotplug/cpci_hotplug_pci.c
> @@ -269,8 +269,12 @@ int cpci_configure_slot(struct slot *slot)
>  	parent = slot->dev->bus;
>  
>  	for_each_pci_bridge(dev, parent) {
> -		if (PCI_SLOT(dev->devfn) == PCI_SLOT(slot->devfn))
> -			pci_hp_add_bridge(dev);
> +		if (PCI_SLOT(dev->devfn) == PCI_SLOT(slot->devfn)) {
> +			if (pci_hp_add_bridge(dev) != 0) {
> +				err("Failed to initialize bridge %s at slot %02x",
> +				    pci_name(dev), slot->number);

There are five callers of pci_hp_add_bridge(), and none of them checks
the return value, so I'm not sure it's worth just changing this one.

I suspect something in the pci_hp_add_bridge() path would already log
a message in the event of a failure.  If that's the case, I doubt it's
worth adding another message here (and maybe pci_hp_add_bridge()
should just be made a void function).  If we *do* need a message here,
I would want to update all the callers similarly.

> +			}
> +		}
>  	}
>  
>  	pci_assign_unassigned_bridge_resources(parent->self);
> -- 
> 2.43.0
> 
