Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C99217659;
	Mon,  9 Mar 2026 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773096620; cv=none; b=YW0UczzjvXrLvW5IDDe7uS4ep/MwAFfvPCTwnwmFni+aqjFMsb7LQgCrxdv0u7f4+l+Ql/qIfb3E+TYEemYe8BtvRjYbXGe35ouNi2LJsX7t2S85OobY0LnlYSB+PmzMsoEfof1rVak8Cub2GQsv+2UPq3N3NS2IeIn6o4sP0BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773096620; c=relaxed/simple;
	bh=KVdfSo8Fym+8HhHhMkfp7kvgXY9fCLwo+EIudl1KX28=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=C3OlycbsLNtOCANLHea/mWB+jJ+ydDOa5gDPfj3uvlom6CyT8ZeXeHbb17S5NkbF0Fw5mhJOSW37pn6jKRTSe/sPOnaqJozslIFq4M4h4DlRkwn+mzXjzDQ3qF9+iG2PA8rq12oB7UNRjxc9EOx1Iifh4yYg+GdxpfcATeqe9WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhMylrw6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhMylrw6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0B2C4CEF7;
	Mon,  9 Mar 2026 22:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773096620;
	bh=KVdfSo8Fym+8HhHhMkfp7kvgXY9fCLwo+EIudl1KX28=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QhMylrw6YnLkmh/z7MjhCN4+z921M/ewULuQlfOCArlyc/hJxLWKD7h5MPXCZ1J9T
	 aJL7gu1UulTyZ5ceDjW8/nnfBBRiHuGRuiGx/UDpEb9N2AvwJWxaaKYeqa0Gjd2ypy
	 wurnQawtQ/ZCfwTh4IKUJKaaEbf8/bv9hllAcYjQFCFWXbV2NLz4axQBh9ioythbHe
	 0d1RlJQkfFIGd+3ssiHhJiYgyiPGV3XwRd0Z6e6DMhhJfzvXKz3kq91V1EQB4UolSb
	 /t+9+rkv5k5ZsrA6oiTAcCbhg4BYgiilxhKOwilz0Q2bBU1lK07ufYjFIeq3Aa4WyI
	 QJlt3njVsl7tQ==
Date: Mon, 9 Mar 2026 17:50:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, lukas@wunner.de,
	kwilczynski@kernel.org, mani@kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Shuan He <heshuan@bytedance.com>
Subject: Re: [PATCH v2] PCI: Remove redudant call to pci_proc_attach_device()
Message-ID: <20260309225018.GA636900@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228072129.10445-1-manivannan.sadhasivam@oss.qualcomm.com>

On Sat, Feb 28, 2026 at 12:51:29PM +0530, Manivannan Sadhasivam wrote:
> pci_proc_init() should just initialize the top level procfs directory for
> PCI devices and let pci_bus_add_device() add the device specific procfs
> attributes later.
> 
> But it is also calling pci_proc_attach_device() for each PCI device. This
> causes a race condition with pci_bus_add_device(), which may run in
> parallel, calling the same API, leading to the below warning spat:
> 
>  proc_dir_entry '000c:00/00.0' already registered
>  WARNING: CPU: 2 PID: 179 at fs/proc/generic.c:375 proc_register+0xf6/0x180
>   proc_register+0xf6/0x180
>   proc_create_data+0x3e/0x60
>   pci_proc_attach_device+0x74/0x130
>   pci_bus_add_device+0x42/0x100
>   pci_bus_add_devices+0xc6/0x110
> 
> Hence, remove the call to pci_proc_attach_device() from pci_proc_init().

Seems plausible, but given that this code has been this way basically
forever, I'd sure like to figure out what's different about Shuan and
Lorenzo's system that makes this issue show up now.

> Reported-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Reported-by: Shuan He <heshuan@bytedance.com>
> Closes: https://lore.kernel.org/linux-pci/20250702155112.40124-1-heshuan@bytedance.com
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
> 
> Changes in v2:
> 
> * Dropped the sysfs change as it is supposed to be replaced by static resources
>   change.

v1: https://lore.kernel.org/linux-pci/20250723111124.13694-1-manivannan.sadhasivam@oss.qualcomm.com/

> NOTE: I don't know if there is any reason to call pci_proc_attach_device()
> before pci_bus_add_device(), but it definitely causes a race.
> 
>  drivers/pci/proc.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
> index ce36e35681e8..de894ae70e9a 100644
> --- a/drivers/pci/proc.c
> +++ b/drivers/pci/proc.c
> @@ -463,13 +463,10 @@ int pci_proc_detach_bus(struct pci_bus *bus)
>  
>  static int __init pci_proc_init(void)
>  {
> -	struct pci_dev *dev = NULL;
>  	proc_bus_pci_dir = proc_mkdir("bus/pci", NULL);
>  	proc_create_seq("devices", 0, proc_bus_pci_dir,
>  		    &proc_bus_pci_devices_op);
>  	proc_initialized = 1;
> -	for_each_pci_dev(dev)
> -		pci_proc_attach_device(dev);
>  
>  	return 0;
>  }
> -- 
> 2.51.0
> 
