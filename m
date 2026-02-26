Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8326B36896E;
	Thu, 26 Feb 2026 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772126045; cv=none; b=YRP3Su2Fnk1GLkzbnAGa+fnJt3o1GWujRHy66cHt5JnLpzPj+8sp+dLRq/ar1PyeErquuFQ2W6WKJlBKwIAGlvadDQz4AxhQWmOlByy936hF8eDzmSXWV+fdxV9S/ZDrbma5UU4Hh7LzoGwdlsqqQ6FY43L4xbIrcH35rVEQ8yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772126045; c=relaxed/simple;
	bh=X6A6fowkZ6aMRZIizNYBTrL8TqiDPcG1Re2wby4Fwmk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hIXpolEsEWRAbobQdGMMwnJFvwM8W/uw5kunKVis/ZNn+JhfpDZN8ehsChg1fR7Ognh9rYbnH30/aFJQW4XwyAjxCRBS28aDNNh8LYp8Fftn6gIAzH6oiGXjEbzF4wuBaDg15G+fP2/JqueJ8Ntprpsd9JBRz3t94Pd57e5tnDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pM+CplqC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pM+CplqC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A913C116C6;
	Thu, 26 Feb 2026 17:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772126045;
	bh=X6A6fowkZ6aMRZIizNYBTrL8TqiDPcG1Re2wby4Fwmk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pM+CplqCQUwdcubr2VbwkskrbIxgGL/zqagGZ4QWlVOKjrRx7riK3fx6NBN4/e+/p
	 t+6MjadWoj5O9u5VkWiezCzb4y9Gtp0Oib3oUqRjKDK8EQMbmvsqQDs/a7OpvdRtXx
	 Sd8m1v979Wt8/gJhsSAteLFBSkGCHpQmxipjf+22v7LmkSX4EqvK5zMYFAIPxfTuvm
	 pEl7TGr088dCGvvG7gElhPQZlzmDgwfsuSgv6kVSpqG04DM8pMhWGcgpVyJ0qmeJDC
	 yld26L4LM81pwUYL9M6f8WJoh5B18fBK2Y69DNUMdRti0IQ91r0wppCwxNVIQbNwZt
	 LFGudnJxEp6Rw==
Date: Thu, 26 Feb 2026 11:14:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ziming Du <duziming2@huawei.com>
Cc: bhelgaas@google.com, alex@shazbot.org, chrisw@redhat.com,
	jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, liuyongqiang13@huawei.com
Subject: Re: [PATCH v4 2/4] PCI/sysfs: Fix null pointer dereference during
 hotplug
Message-ID: <20260226171403.GA3813150@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116081723.1603603-3-duziming2@huawei.com>

On Fri, Jan 16, 2026 at 04:17:19PM +0800, Ziming Du wrote:
> During the concurrent process of creating and rescanning in VF, the
> resource files for the same pci_dev may be created twice.

Where are the two resource file creations?  This will help review the
patch.

> The second
> creation attempt fails, resulting the res_attr in pci_dev to kfree(),
> but the pointer is not set to NULL. This will subsequently lead to
> dereferencing a null pointer when removing the device.
> 
> When we perform the following operation:
>   echo $sriov_totalvfs > /sys/class/net/"$pfname"/device/sriov_numvfs &

I think it would be more informative to include an actual sample here.
We can easily substitute the device names and numbers, given a
concrete example.  It's a little bit harder to intuit what $pfname and
$sriov_totalvfs should be.  E.g.,

  $ cat /sys/bus/pci/devices/0000:02:00.0/sriov_totalvfs
  128
  $ echo 128 > /sys/bus/pci/devices/0000:02:00.0/sriov_numvfs &

Unless it's important to use /sys/class/net/..., use
/sys/bus/pci/devices/... both places to make it simpler.

>   sleep 0.5
>   echo 1 > /sys/bus/pci/rescan

These look like shell commands ...

>   pci_remove "$pfname"

but what is "pci_remove"?  I guess it must be an echo into
/sys/bus/pci/devices/.../remove; expanding it here would be better.

> system will crash as follows:
> 
>   Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>   Call trace:
>    __pi_strlen+0x14/0x150
>    kernfs_find_ns+0x54/0x120
>    kernfs_remove_by_name_ns+0x58/0xf0
>    sysfs_remove_bin_file+0x24/0x38
>    pci_remove_resource_files+0x44/0x90
>    pci_remove_sysfs_dev_files+0x28/0x40
>    pci_stop_bus_device+0xb8/0x118
>    pci_stop_and_remove_bus_device+0x20/0x40
>    pci_iov_remove_virtfn+0xb8/0x138
>    sriov_disable+0xbc/0x190
>    pci_disable_sriov+0x30/0x48
>    hinic_pci_sriov_disable+0x54/0x138 [hinic]
>    hinic_remove+0x140/0x290 [hinic]
>    pci_device_remove+0x4c/0xf8
>    device_remove+0x54/0x90
>    device_release_driver_internal+0x1d4/0x238
>    device_release_driver+0x20/0x38
>    pci_stop_bus_device+0xa8/0x118
>    pci_stop_and_remove_bus_device_locked+0x28/0x50
>    remove_store+0x128/0x208
> 
> Fix this by set the pointer to NULL after releasing 'res_attr' immediately.

This *sounds* like it would still be racy unless there's a lock around
this.  If there is a lock, please mention what it is and where it's
held.

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Ziming Du <duziming2@huawei.com>
> ---
>  drivers/pci/pci-sysfs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 18e5d4603b472..fbcbf39232732 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1227,12 +1227,14 @@ static void pci_remove_resource_files(struct pci_dev *pdev)
>  		if (res_attr) {
>  			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
>  			kfree(res_attr);
> +			pdev->res_attr[i] = NULL;
>  		}
>  
>  		res_attr = pdev->res_attr_wc[i];
>  		if (res_attr) {
>  			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
>  			kfree(res_attr);
> +			pdev->res_attr_wc[i] = NULL;
>  		}
>  	}
>  }
> -- 
> 2.43.0
> 
