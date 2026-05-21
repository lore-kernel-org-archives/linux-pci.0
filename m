Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770CE3806A3;
	Thu, 21 May 2026 10:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358954; cv=none; b=Xa1ibnM+2IqalpCggDT74DZ9I7JHU1pJQMeiA1HQRlw9CBR0JVZOlLqc38AWbyQdKLUZDDLyzaMSFaveqir0UPcxjmD0mrMIz5SPzdwAxDR946A/1W1H7lacGwCg8qaHYrcdJkPp2B4aJxrrm04teDKEpn1mecmscbWyY3ehzSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358954; c=relaxed/simple;
	bh=+HW0dOk5wH9pqNi3mzEx4jIB8et3CH9L54AR6abHdV0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=l+dLB0TwskwOFV2YzJPBWeFfyK77xq3hAiLedENNk6rl+NgFhQGNbGFfRppvWUnp0LcpkzyGiGFUDygYkG+FFWDlEGT4OoaDYSwuhQ39D4mFgolYCn7SWvjlFrqIkWuuCE2tfYri+k/c8CwerAgnbhOJjP1aHo3ahsQC9bwtcWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bsKcNw5i; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bsKcNw5i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779358952; x=1810894952;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+HW0dOk5wH9pqNi3mzEx4jIB8et3CH9L54AR6abHdV0=;
  b=bsKcNw5ik0zSYeU8vKlnQQ1/V9mjF93WTYugGXc415/hkP1Sd/rGuXAI
   a5uJfROl7ljZsbhdJr6EtpgKu6ZiuJX8hYW+v0ja8gOHE3l/RHF+5GDKW
   b395Tz/aa0/4GCSfHwpSd8+vuNnS+HV6Y+MncQp0Y1lVe0aBd2Gd6dem5
   7EWFauw8ZirswRToivO+QD2CB1t71TjMAFE4XBzRPxQrsg3pBja+u99NZ
   1ebVizCqzdQU6KrCNltStJmlDhL23ws00uBnYCiJa9iPwaSdsZppo/FdJ
   arKF3HS4UQvgjGJfpoCUD9yu5K8uWVvWFHtba+FfPYMLgzvMtmTE8ieVl
   w==;
X-CSE-ConnectionGUID: aJ0xSPkjSRCBoWKl40qy2Q==
X-CSE-MsgGUID: caVzMgQ2QFG+TmpY1w0Cmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80329234"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="80329234"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 03:22:32 -0700
X-CSE-ConnectionGUID: 5bRRu3c6SxmrfLy2tNIOTg==
X-CSE-MsgGUID: 3CFzgJUxQ6CUSyitSYc8bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="236070105"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.98])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 03:22:29 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 21 May 2026 13:22:27 +0300 (EEST)
To: Gianfranco Dutka <gianfranco.dutka@arista.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI/sysfs: NULL res_attr slot after kfree as defence
 against double-remove
In-Reply-To: <20260520211306.3301893-1-gianfranco.dutka@arista.com>
Message-ID: <376c679c-8637-d19a-48d1-165d8f2fc2f0@linux.intel.com>
References: <20260520211306.3301893-1-gianfranco.dutka@arista.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 20 May 2026, Gianfranco Dutka wrote:

> pci_remove_resource_files() frees the bin_attribute pointed at by
> pdev->res_attr[i] / pdev->res_attr_wc[i] but does not clear the slot
> after kfree().  If pci_remove_sysfs_dev_files() is ever invoked twice
> against the same pdev, the second pass dereferences a freed
> bin_attribute and faults inside strlen() called from
> kernfs_remove_by_name_ns().
> 
> To the best of my knowledge no in-tree caller hits this today -- the
> primary path (pci_stop_dev() -> pci_remove_sysfs_dev_files()) is
> expected to fire once per device -- so this is being submitted as
> defence-in-depth rather than as a fix for a reproducer in the upstream
> tree.  The motivation is that a freed-but-not-cleared pointer in a
> device-lifetime table is a sharp edge: any future caller (in-tree or
> out-of-tree) that re-enters the teardown path turns it into a UAF
> with no warning.  Other allocator-managed pointer tables in the
> kernel NULL the slot after kfree() for exactly this reason, and the
> two-line change makes pci_remove_resource_files() idempotent at
> essentially zero cost.
> 
> For full disclosure: the way I encountered this was via an
> out-of-tree PCIe hotplug driver on an AMD Ryzen Embedded V3000
> platform.  The driver re-enters pci_stop_and_remove_bus_device()
> against a pdev that the standard pci_destroy_dev() path has already
> torn down, and with slub_debug=FZPU the second entry faults with the
> classic POISON_FREE signature:
> 
>   BUG: unable to handle page fault for address: 6b6b6b6b6b6b6b6b
>   RIP: strlen+0x4
>   Call Trace:
>     kernfs_find_ns
>     kernfs_remove_by_name_ns
>     sysfs_remove_bin_file
>     pci_remove_resource_files
>     pci_remove_sysfs_dev_files
>     pci_stop_bus_device
>     pci_stop_and_remove_bus_device
>     <out-of-tree hotplug driver remove path>
> 
> I am aware that "out-of-tree driver re-enters teardown" is not by
> itself a reason to take a change upstream, and I would understand a
> NACK on that basis.  The reason I am still sending it is that the
> fix is local, mechanical, matches an idiom already used elsewhere in
> the kernel, and removes a class of bug rather than papering over the
> specific caller that surfaced it.

Hi,

To me it looks more like pci_remove_resource_files() is expected to be 
entered only once.

If this change is accepted, the 2nd entry is "silently" allowed whereas 
better course of action would feel to catch that in 
pci_remove_resource_files() with:

	if (WARN_ON_ONCE(something))
		return;

That way, developers may become aware the code has some lifetime issue.

(I'm not strictly against your change but I think it would be much better 
to have sane lifetimes and catch offenders.)

> Signed-off-by: Gianfranco Dutka <gianfranco.dutka@arista.com>
> ---
>  drivers/pci/pci-sysfs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1228,11 +1228,13 @@ static void pci_remove_resource_files(struct pci_dev *pdev)
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

-- 
 i.

