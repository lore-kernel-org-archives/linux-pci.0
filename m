Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E604317D;
	Fri, 10 Apr 2026 22:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775861256; cv=none; b=GlkeDm7ZxgDITOUQNd8+XSY3Rfv4i1jgsCLPF+o/O1e8hKDwC0Hs7aPhfr8AWoBKCHTdRCQDyPxa0hotcJW0g9h9mrZ0pUeCC8ZK4n/PpLaBORhB1oFEiTQRENUjo5Q40xuE+iotQHByrGqCDTcdzSb3ycKRHdrTo9dQThK6S5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775861256; c=relaxed/simple;
	bh=5bIn+L9X/6JU6pyEGWF/SLljsCQU5z13cMI6A3ovRvc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tvwJc6b6UouP9r4AQNAcI5LyQKs7vV38RDDiPo2Z8uXxAsSYvCvGGxOo8tBDgFjGKkOEfNyEH7JR2u6u3tJM+imsmCZa/XzT3RMpvymWF+kaDUQM2fGz8uC9vltNYd+OBtKoG8XlVqjxzTwXwndVUm3BMq+0/DaeHSz1OAfc82E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZKKJtEH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZKKJtEH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488ADC19421;
	Fri, 10 Apr 2026 22:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775861256;
	bh=5bIn+L9X/6JU6pyEGWF/SLljsCQU5z13cMI6A3ovRvc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YZKKJtEHAZ8zUY54ceDO700FtqIZ46s8+eSQtFSYWXEknseDL813I8Blc1h0SGPuK
	 UH29RY0TIGju2VPwfonTMGo3p6iwVYMSe72vZTFg/phciwfEEAbG4IR/Oh9TxEoIjo
	 MVWKeZ6LRSCcpUBUmUitQfsyTOfNm/AMa4q9AfqcbWp9wRbdnOYywHr8lHdvtzQEDu
	 wN3iPljd/BPmHlnr7MAzgjd7tqOp3/f8y4UsaAfWGaWxXN1/+j93E6wlJI1mN7ZpH5
	 ER5B5UMbirhLL6IX+LRh9Htt+CSUnr9zoAxlUXZgGOEUHfhPohCfIQRV0RDdaGa1hh
	 UQ/YSW4VCq67g==
Date: Fri, 10 Apr 2026 17:47:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Fu Hao <fuhao@open-hieco.net>
Cc: bhelgaas@google.com, perex@perex.cz, tiwai@suse.com,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 6/8] ALSA: hda: Add support for Hygon family 18h model
 5h HD-Audio
Message-ID: <20260410224735.GA598593@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d68343d2e840bc2b0d466eb175ec2bc2f952771e.1775548724.git.fuhao@open-hieco.net>

On Tue, Apr 07, 2026 at 04:24:56PM +0800, Fu Hao wrote:
> Add the new PCI ID 0x1d94 0x14a9 for Hygon family 18h model 5h
> HDA controller.
> 
> Signed-off-by: Fu Hao <fuhao@open-hieco.net>
> ---
>  include/linux/pci_ids.h       | 1 +
>  sound/hda/controllers/intel.c | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 406abf629..19d968017 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2613,6 +2613,7 @@
>  #define PCI_VENDOR_ID_ROCKCHIP		0x1d87
>  
>  #define PCI_VENDOR_ID_HYGON		0x1d94
> +#define PCI_DEVICE_ID_HYGON_18H_M05H_HDA	0x14a9

It looks like PCI_DEVICE_ID_HYGON_18H_M05H_HDA is only used in
sound/hda/controllers/intel.c, so it should probably be defined there
so you don't need to modify include/linux/pci_ids.h:

 *      Do not add new entries to this file unless the definitions
 *      are shared between multiple drivers.
