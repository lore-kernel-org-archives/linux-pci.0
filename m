Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6F827472
	for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772209880; cv=none; b=oXwo13LxFtPnH2SrXQv5Ii1jSSeBTMeeU/mjQ17NekuIeLiG3AGvVLeLEY/iStkyOSapZXDJKBuyyUo9AC/rMsXE06tq0Z/r7phD0eru8oiTG/aTuKgTUOzDn5x9Nq/93Wf92E2hs8vSqS45K34ANdt4pEKP40sWI1Elioc1pI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772209880; c=relaxed/simple;
	bh=cEH+NcykM6ePQ7LalrjV/TpxF4Jj7yL58QjZ07YznB8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CHqWgIdGCo499bvXe1OgGW4n9EVLKMU+qig2OSnRqayqGioanUn4uLjPjh2Uu4+c+9om739I3cVnSCNQ2sk1rxS+n06RhMat/PurPTQbAB2IKgl3XY4n76KfdsWW+78YNS+zGOj0rSWGQZ8P2zSwW9L8nlwBxB14HjT1fdYz0LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drYUGh3j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drYUGh3j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBECBC19422;
	Fri, 27 Feb 2026 16:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772209879;
	bh=cEH+NcykM6ePQ7LalrjV/TpxF4Jj7yL58QjZ07YznB8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=drYUGh3jR39WSnfOjL0243FgE8lque774yrHw7hB2ODlSv9tzUrsAz5X2bdo1jWOO
	 Fjxg2tSVDvb3xc0dVsczf/f0NmjtALjXrKFfu9yd6v/r1mLSX2TS3mjsCtN4r39m9M
	 I6+beC+pWKFlPQOq2P9KujxPkpsSnwgm/twfkcp99NChbFQNfGYQ5LJsYKVty3jd3f
	 DyVzZI0tPdQWYaVo52w+aEdWW7hKomgiyxuQbuaDncvz353sCYjhl8mPlYgOYRjUm2
	 j5zelxdCeSHpDQGPSj7Nr0RO6wH5DDrKGtEU/OxhCMn/DkCRrdjctXKk/i2/t4J6kf
	 1v0QofFm94qDg==
Date: Fri, 27 Feb 2026 10:31:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sizhe Liu <liusizhe5@huawei.com>
Cc: bhelgaas@google.com, jonathan.cameron@huawei.com, shiju.jose@huawei.com,
	keith.busch@intel.com, linux-pci@vger.kernel.org,
	linuxarm@huawei.com, prime.zeng@hisilicon.com, fanghao11@huawei.com,
	shenyang39@huawei.com, Shuai Xue <xueshuai@linux.alibaba.com>,
	Lukas Wunner <lukas@wunner.de>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH] PCI/ERR: Clear fatal status of the reporting device
Message-ID: <20260227163118.GA3897131@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227102505.3966864-1-liusizhe5@huawei.com>

[+cc others interested in error handling]

On Fri, Feb 27, 2026 at 06:25:05PM +0800, Sizhe Liu wrote:
> During PCIe native AER error recovery, ERR_FATAL status bits are not cleared
> after fatal error handling. This causes stale ERR_FATAL bits to be reported
> in subsequent AER events, even after reporting "device recovery successful".
> 
> Prior to commit bdb5ac85777d ("PCI/ERR: Handle fatal error recovery"), native
> AER handled non-fatal and fatal errors separately, clearing the corresponding
> status bits for both types after processing. That commit unified the error
> paths through pcie_do_recovery(), which began invoking
> pci_cleanup_aer_uncorrect_error_status() after commit bfcb79fca19d
> ("PCI/ERR: Run error recovery callbacks for all affected devices").
> 
> This function only clears non-fatal error (NFE) bits and leaves ERR_FATAL
> bits uncleared, resulting in stale error status.
> 
> Fix this by explicitly clearing the ERR_FATAL status bits for the reporting
> device during recovery, restoring the original fatal error handling behavior.
> 
> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>
> ---
>  drivers/pci/pcie/err.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index bebe4bc111d7..f51225f2592d 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -281,6 +281,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	if (host->native_aer || pcie_ports_native) {
>  		pcie_clear_device_status(dev);
>  		pci_aer_clear_nonfatal_status(dev);
> +		pci_aer_clear_fatal_status(dev);
>  	}
>  
>  	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
> -- 
> 2.33.0
> 
