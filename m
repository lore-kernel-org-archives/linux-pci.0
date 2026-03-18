Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448B82E1722;
	Wed, 18 Mar 2026 17:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773854525; cv=none; b=bvvF1HYmwgSay4AQzHzV9L5beWB3sxhHiYNHCnOWIeEZjbNhpkX5DJQSWBkw6Gt5mJF5gddaaVoaUv1hQha5o75hz2j5rHtdhK7i7XpLWUi+AL5bYa99j7gKXbnjjal1zXvExBAk5ATfGWyAnsPEHTjPyw0Dn2ifVmW+ocapbqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773854525; c=relaxed/simple;
	bh=1OgHpLEuNBi1/jSYIEf8g9ynIW7/JAsqHQFct/Wozi4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lx9eQssluKO+tE898dS8y4vhzwsWvIUWtF6kumOxVNaAjJxFiIUSKTXb89BLJtYh0//7E3ZQs2f4RhIagJF7sBOaZXwlzadLlmGfsHYM5s/4zVtKKLIg2U6L6NyPY1Bdy1++Kvs4tEhvLTP3Qegw+/nzZKMEECdCwX53bdyRaS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blvhD7Bq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blvhD7Bq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB944C19421;
	Wed, 18 Mar 2026 17:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773854524;
	bh=1OgHpLEuNBi1/jSYIEf8g9ynIW7/JAsqHQFct/Wozi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=blvhD7BqkUeHkikxU+oCyjYifKIxbD6EbW3EJmowgbboNYWrRUGNGeFQEIun+eJi3
	 lR2vhQUBEgPwOQbMBfK8dh9E8vxcTqJzN0oTVEjLwMQbXQhPhTj27jdGw4b/vljs5c
	 31mjjzTrUi8syI1ikynyLcmzFTthlx2c3PbIm/pr5vUHx6sanDRCk81qcetC0NMfYW
	 mBwW9AQ7mtlf30kT/zXLgN8NAce3/ya8aLBBQFmwAkOyz+BjPknC9efMDwk+J1Bt50
	 tr52pbfT2HZ2/M+exhel6tnbSLqlJztTgz1iFh1Lb5AsA8nh3E76MBycpvwY/YsAQO
	 RGYqF5YRbLzjA==
Date: Wed, 18 Mar 2026 12:22:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>,
	Jon Pan-Doh <pandoh@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Sizhe Liu <liusizhe5@huawei.com>
Subject: Re: [PATCH v1] PCI/DPC: Fix AER error logging for DPC/EDR triggered
 events
Message-ID: <20260318172203.GA51847@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318170449.2733581-1-sathyanarayanan.kuppuswamy@linux.intel.com>

[+cc Sizhe]

On Wed, Mar 18, 2026 at 10:04:49AM -0700, Kuppuswamy Sathyanarayanan wrote:
> aer_print_error() skips printing if ratelimit_print[i] is not set.
> In the native AER path, ratelimit_print is initialized by
> add_error_device() during source device discovery, and is set to 1
> for fatal errors to bypass rate limiting since fatal errors should
> always be logged.
> 
> The DPC/EDR path uses the DPC-capable port as the error source and
> reads its AER uncorrectable error status registers directly in
> dpc_get_aer_uncorrect_severity(). Since it does not go through
> add_error_device(), ratelimit_print[0] is left uninitialized and zero.
> As a result, aer_print_error() silently drops all AER error messages
> for DPC/EDR triggered events.
> 
> Set ratelimit_print[0] to 1 to bypass rate limiting and always print
> AER logs for fatal errors.
> 
> Fixes: a57f2bfb4a58 ("PCI/AER: Ratelimit correctable and non-fatal error logging")
> Co-developed-by: Goudar Manjunath Ramanagouda <manjunath.ramanagouda.goudar@intel.com>
> Signed-off-by: Goudar Manjunath Ramanagouda <manjunath.ramanagouda.goudar@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

I think this does the same as
https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=d4d1ecff2c2d
which is already queued for v7.1.

> ---
>  drivers/pci/pcie/dpc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index fc18349614d7..7605ddd9f0ba 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -256,6 +256,7 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
>  
>  	info->dev[0] = dev;
>  	info->error_dev_num = 1;
> +	info->ratelimit_print[0] = 1;
>  
>  	return 1;
>  }
> -- 
> 2.43.0
> 
