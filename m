Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9288B3DCDA1
	for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2026 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777047098; cv=none; b=cohNiHm3P6dv8oI73i7tlrRe3vW6d3IqPkIYUysrVv/EZZNQrLuwIlhnpfcKI7rvVB5T6j4KzwwVxczsNLFbs8ZT2nY510tTZQzj4RywUg9chzl9rO762/PrTeTMq5DBihyU2hp+74GKIU5WsVwY37UA30vQoGiyyOoTxh+ghTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777047098; c=relaxed/simple;
	bh=+FIUDUlqHR9RYUAWvzBpyf5cv0SvCBZygezZMdueHIM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dQ6DPIjLf9Ecz6tdqCCaX8F3HC1Q1sIaIMVNl8aB5ixyIXGK87kVNIVfAOoalOSKdsIaF1Lxr2aYOczifFmrXZZS9NuIw0bp4hdDk0x06MYO6Hf4LVb3WisnUUhjdFeGt9qC5RMxPOYOuYLaIXYzf+lD9fSYt++3W32jdrc+4WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsWD8Xk5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsWD8Xk5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132C7C19425;
	Fri, 24 Apr 2026 16:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777047098;
	bh=+FIUDUlqHR9RYUAWvzBpyf5cv0SvCBZygezZMdueHIM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PsWD8Xk5SX8BpiukhO5L/T/5GrkpgMTCyaMyM3RhFNtcNvUJbgJ5i6L4cr66EcuGD
	 9ChL29jmRLIT7R+GFXB1yhUNIL/VJKsu9PmVL70YJOttBo/HfPyhyblslUITGPEWzH
	 UDYIISAJFRVSdSSnuGr0Gt/GCY/fG8OvbSFCabpQ8lW/zbDZ6c9Vts73kElG5zWns1
	 0fLD0FrjYfCE54Gv01TnqK0CLY29wEBeTfOlGfSA18K7C2vb1rtJ9JAXhZKvmposuI
	 N1GidA+FzzKMyd1TrqinfjZiN9xnyEEy5rn13sHWaq94x+Cwy6arow+lSE+089IPOt
	 o298yhFUC22wQ==
Date: Fri, 24 Apr 2026 11:11:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] pci: don't fallback to bus reset after failed slot reset
Message-ID: <20260424161136.GA11831@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421150644.3543733-1-kbusch@meta.com>

On Tue, Apr 21, 2026 at 08:06:44AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> If a bus has hotplug slots that implement the slot's reset_slot
> callback, it is not safe to do the non-slot specific bus reset, so don't
> fallback to it. If a slot reset does fail, the subsequent bus reset will
> attempt a 2nd link reset on top of previous and fail to handle the
> hotplug events.
> 
> Fixes: 8238cb69c01fe ("PCI: Make reset_subordinate hotplug safe")
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Applied to pci/reset for v7.2, thanks!  Will be rebased after
v7.1-rc1.

> ---
>  drivers/pci/pci.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8f7cfcc000901..d34266651ad09 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5607,13 +5607,14 @@ static int pci_try_reset_bus(struct pci_bus *bus)
>   *           reset for affected devices
>   *
>   * This function will first try to reset the slots on this bus if the method is
> - * available. If slot reset fails or is not available, this will fall back to a
> + * available. If slot reset is not available, this will fall back to a
>   * secondary bus reset.
>   */
>  static int pci_reset_bridge(struct pci_dev *bridge, bool restore)
>  {
>  	struct pci_bus *bus = bridge->subordinate;
>  	struct pci_slot *slot;
> +	int ret = 0;
>  
>  	if (!bus)
>  		return -ENOTTY;
> @@ -5627,19 +5628,17 @@ static int pci_reset_bridge(struct pci_dev *bridge, bool restore)
>  			goto bus_reset;
>  
>  	list_for_each_entry(slot, &bus->slots, list) {
> -		int ret;
> -
>  		if (restore)
>  			ret = pci_try_reset_slot(slot);
>  		else
>  			ret = pci_slot_reset(slot, PCI_RESET_DO_RESET);
>  
>  		if (ret)
> -			goto bus_reset;
> +			break;
>  	}
>  
>  	mutex_unlock(&pci_slot_mutex);
> -	return 0;
> +	return ret;
>  bus_reset:
>  	mutex_unlock(&pci_slot_mutex);
>  
> -- 
> 2.52.0
> 
