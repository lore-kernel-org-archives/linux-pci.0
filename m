Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C73344D91;
	Mon, 23 Feb 2026 12:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848354; cv=none; b=f4aT01W1wLeyMslo1NCQIHw40pzJEoOefV+rpKYpBK6Clab5K7HyWQ2J4jon0rFve3P9b8rIzBGQAXy51cB8WVORzUPX8XzQ37pTWfg2YiH9tBplTI4VayO9qIN7XvqrLbYtBMbxvT09ODtwnBmCnZ8VYyPQYtyu7X6abtqMNW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848354; c=relaxed/simple;
	bh=IcsBeFejWl737Lp+xHttyvoIw+wb/+wVPzqZmwhVK70=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bfipcZmCHWCQiU1TGpKwdPNvEjQvdqwKXeyozsVkHNdoIWkDp62fwCaILtgtoDydf1FEyT6/Wemx5YwQX7QFKwGn4Ws+mlBS7kDfX4il2ApAJarjqh2b41p6ivRhmG2zlI/SMsUDofx7ubs+AhqmytoG5Lt4RU4vwlMR7tZB484=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gKIivX6X; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gKIivX6X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771848353; x=1803384353;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=IcsBeFejWl737Lp+xHttyvoIw+wb/+wVPzqZmwhVK70=;
  b=gKIivX6XABq8s9TXj6nImkrIAwnGX4ipXsBotJgI/EkuuOgVEDT9CU6A
   2pZBEhVDLbEH4bPtoLHxsEqd1te+09gzPCAeP/mJsu0VKDpTUEZsSHMhY
   ZEzVnN6Kpbx28cjhbAQRxs+eXqkGGHizxo4KB6PPmSzDUvVDhLt2WxD7q
   rQ1qQmnJc8lPcidGC7ag3mhriO/wUW52UuV1YjkJLA2cYnRhDzKcnJ96U
   nSsy0SvyaDSvpu6Lwla4EJMrkvrZTzdkYDQUWbWxVMmbh2yVVAqCYcI5e
   R+ugohsKGiGgZ319vGH3xmDcGMEzy9ac6CpNbd0QMW9ZATuT4UmIbMyu0
   Q==;
X-CSE-ConnectionGUID: WQxQT3g6SAKLlcRAiFprEg==
X-CSE-MsgGUID: sF3KYj3UQRO65OiMzVLjMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="75449473"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="75449473"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 04:05:52 -0800
X-CSE-ConnectionGUID: p0W11Ej2RM2qiYBas2upMg==
X-CSE-MsgGUID: GFbZMzcWSQa1GxjPupHBCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="214774767"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.30])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 04:05:50 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 23 Feb 2026 14:05:47 +0200 (EET)
To: Hongyu Xie <xiehongyu1@kylinos.cn>
cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v1] PCI: replace msleep to save waiting time
In-Reply-To: <20260223061919.1408000-1-xiehongyu1@kylinos.cn>
Message-ID: <71825caa-5399-3676-4678-49d282e0a923@linux.intel.com>
References: <20260223061919.1408000-1-xiehongyu1@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 23 Feb 2026, Hongyu Xie wrote:

> In pcie_wait_for_link_status, using msleep(1) to wait for link status

Add () after any function name in the commit message.

> change.
> But msleep(1) can sleep for nearly 5ms.

Why does the extra delay matter/is a problem? It would be good to include 
such a justification into this change description.

> ftrace shows:
>  0)               |                pcie_wait_for_link_status() {
>  0)   0.500 us    |                  pcie_capability_read_word();
>  0)   0.580 us    |                  pcie_capability_read_word();
>  0) * 10292.26 us |                }
> 
>  after changing to usleep_range.

+ ()

>  ftrace shows:
> 
>  0)               |                pcie_wait_for_link_status() {
>  0)   0.320 us    |                  pcie_capability_read_word();
>  0)   0.480 us    |                  pcie_capability_read_word();
>  0) # 2483.980 us |                }
> 
>  So fix this by using usleep_range.

Ditto.

> Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index f3244630bfd0..68532e248e51 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4519,7 +4519,7 @@ static int pcie_wait_for_link_status(struct pci_dev *pdev,
>  		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
>  		if ((lnksta & lnksta_mask) == lnksta_match)
>  			return 0;
> -		msleep(1);
> +		usleep_range(1000, 1100);
>  	} while (time_before(jiffies, end_jiffies));
>  
>  	return -ETIMEDOUT;
> 

-- 
 i.

