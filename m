Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4223D2DECDF;
	Tue, 17 Mar 2026 21:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773783228; cv=none; b=MiWrolA4w5P7kGNRGxsu0oLfmuJX1WfSnqi+Kav4InrHvtjRFWHLgVElsDmB6sRzuTMfb+Ndt2h6jTjMVaULeEIvbe05jL8ZVdBPvY+YOUNnPjX9QBmKML7u52ZvkpQNb66w+a4pa6ohw54z2AH4WATGSzmlMbrOPNWvQAB8jBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773783228; c=relaxed/simple;
	bh=LMSVczSYZkFdL97kbgl+5Fz+k3dRHlOCmZyPE0Lc4nI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cZmtmQR05xhLJTRLvFfVm7PftMgqLVVtnTMKArYeiuYg+qo8jvJttq14/zDK3f5ETDHV6HmuNklBGlEErAB7GsgCS+hE4SLIfs518yiujMhiT0Wsbr1u/8jVRhn20ut13oxKuSW4oX2CEw+I0DMvduZpYxm/I6+JzBl7Lj0iMjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNNV5UPf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNNV5UPf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0C0C4CEF7;
	Tue, 17 Mar 2026 21:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773783227;
	bh=LMSVczSYZkFdL97kbgl+5Fz+k3dRHlOCmZyPE0Lc4nI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BNNV5UPfEu+At/lYO8cjvKhnIpxh+QdcE40ouox1WCcHFgoH+t8H2z3Av1zGdk565
	 1maT4fRI00tyW1vNCSp9Y4/8hTFxT39ESF+3qNmlREcobc6nNsShKOV6uBoLLQqT58
	 ZOjbbWbWZU/DjWUgSiOEJ6/MhBHdjGVdTTafU7v7a66gsVA1iOxA9zB4jYvDmv53h/
	 y0CmuTWvyAt3vFh1Cx4d0P6VrJu8rm2VdVcUgdF9Mao1b3ft+/VRE4CqqzuftEQLOJ
	 T7wpm/xEq7azUwly1anFdtkiI1uHY+90oym1cRsOoh6HwIj9h8F16Qvyz3KJu4X9d1
	 bsktR+jQkUoYQ==
Date: Tue, 17 Mar 2026 16:33:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: lirongqing <lirongqing@baidu.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, kwilczynski@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][v2] PCI: sysfs: Suppress FW_BUG warning when NUMA node
 already matches
Message-ID: <20260317213346.GA110011@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317002803.2353-1-lirongqing@baidu.com>

On Mon, Mar 16, 2026 at 08:28:03PM -0400, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> The numa_node sysfs interface allows users to manually override a PCI
> device's NUMA node assignment. Currently, every write triggers a
> FW_BUG warning and taints the kernel, even when writing the same value
> that is already set.
> 
> Check if the requested node is already assigned to the device. If it
> matches, return success immediately without tainting the kernel or
> printing a warning.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Applied to pci/misc for v7.1, thanks!

> ---
> Diff with v1: invert the check and return if they are same 
> 
>  drivers/pci/pci-sysfs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 16eaaf7..dd7c9e5 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -378,6 +378,9 @@ static ssize_t numa_node_store(struct device *dev,
>  	if (node != NUMA_NO_NODE && !node_online(node))
>  		return -EINVAL;
>  
> +	if (node == dev->numa_node)
> +		return count;
> +
>  	add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
>  	pci_alert(pdev, FW_BUG "Overriding NUMA node to %d.  Contact your vendor for updates.",
>  		  node);
> -- 
> 2.9.4
> 
