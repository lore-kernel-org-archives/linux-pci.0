Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794225793;
	b=UBnsCubhIEF5/sqN1Na4K7+csSL6uu7VwkHVFB0n4beaz0sa0jHyghnKPkeiIGg6P86o
	 xsYpBR69Ovrbu+5ejOY67L98WX8g8/ZgKwyySuvlHI4Lfa8q1JJK0m2May0+turtywDhA
	 DZ2nMQxk47FpsPproDfUdhLlc8mxBmyzxBe2Kl4B8G74bkaKoa897ZhXgcnXnRoQiPzAg
	 OaRcMv14Axq5fkD4mS06owr1fE7JYAZEtyPKDJQtGN22VxVtii7d0fvF4vbcGQFIAoom4
	 lijAx33CvX0jg8Wf7kZ923HyHp3I5dc9+tix7JeD8i/t/PUlGwrwcYAfE91ttwkbn6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794225793;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=Pz9Hpm8j1u82FYaXh8nr33sjNtVErXhzD75hDRVTwoY=;
	b=JDnV7Fn+8VFT5sbRPZhwKbmGNc1lIvIcT1qKT6NtDRelVC6U7iScPFuVWQ0zxtGJYxvf
	 ymUPMWbfGaW/vbY6V4TjiWNZTqsSa7hNcCuZh1DgB6irHbPjR0W1BzQ7JVHdjo2M4mA6A
	 XNZVaEuLU+CQTXZvzqKOEPEnGR73VYhK701ocPKzwzxvB83ETzpyNhCbdATINi8I02zwU
	 uoP0AtjQsqrutZpQXQ7E4bVFfG9KFv3jhsp9GcBVuyLfqJnM7alpHdoLjYQRFQUv9b2JB
	 5bZ9RgYz/zlX5pZZluTZpmHRsXPgsaLGuKJnDL4K7L+hacW069TP8ZH6dI5ijS+Iewg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="nlX/lCT3";
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AE2606A31C;
	Mon,  9 Nov 2026 12:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60AE2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nlX/lCT3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794225793; x=1825761793;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=sYbfKgh8lkl7yxvDpMidYJPRN6EgAMxRg2ax/bIvwq8=;
  b=nlX/lCT3G8XZnDZJKH91ZuhOjs3A9z7MXyzw/0vuVOePY2EOVUlupE8y
   wKel9erEWxsaT+86jU5hUnE+/xdZemp1h6YDuWFvzyadWpQVv78E4Mida
   HLEcLFM6hfD09Ph8LnZyEUk/zxpU8hzhq8+3H6r8hszwox+uZzwx655dv
   wsT8CbEdjh3ZMoSzh36rzh0vgQKBYfR6pwJcmJ75SuKtlEbv/Z9Yfrk2f
   wt2W99TqoMvydk1v303pNAuw1GkrbaDhweGsGxLcSlaWYOGVH25sJPznA
   NerK4ufY9c3sIo+E7uB/ntizd+NVh/cPHRCh89SNkbaO2LBc1cBn1TIg4
   A==;
X-CSE-ConnectionGUID: 69RhCk68QZ2c7qLXtW8Nmg==
X-CSE-MsgGUID: T9rd8x2sTdmQVPp/rgGuig==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="3047382"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="3047382"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 04:03:12 -0800
X-CSE-ConnectionGUID: xYJiNJYtRwe4WKF5bJna/Q==
X-CSE-MsgGUID: pa3sT1BRSxiuFmlUIbzTqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="9707620"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 04:03:06 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 9 Nov 2026 14:03:02 +0200 (EET)
To: Hans Zhang <18255117159@163.com>
cc: bhelgaas@google.com, mani@kernel.org, lpieralisi@kernel.org, 
    kwilczynski@kernel.org, thierry.reding@kernel.org, ryder.lee@mediatek.com, 
    jonathanh@nvidia.com, robh@kernel.org, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-mediatek@lists.infradead.org, 
    linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 1/5] PCI: Use pcie_get_link_speed() in pci.c
In-Reply-To: <20261108094034.679945-2-18255117159@163.com>
Message-ID: <43198b7a-b0f7-49e4-731a-807e7d9e5959@linux.intel.com>
References: <20261108094034.679945-1-18255117159@163.com> <20261108094034.679945-2-18255117159@163.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 8 Nov 2026, Hans Zhang wrote:

> Replace the to_pcie_link_speed() wrapper with pcie_get_link_speed() in
> pcie_link_bandwidth_mbps() and pcie_bandwidth_available(), and remove
> the now-unused wrapper.  pcie_get_link_speed() performs the same lookup
> with bounds checking and is already exported.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/pci/pci.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7c6f2aba8144..92ede1768caf 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6025,11 +6025,6 @@ int pcie_set_mps(struct pci_dev *dev, int mps)
>  }
>  EXPORT_SYMBOL(pcie_set_mps);
>  
> -static enum pci_bus_speed to_pcie_link_speed(u16 lnksta)
> -{
> -	return pcie_link_speed[FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta)];
> -}
> -
>  /**
>   * pcie_link_bandwidth_mbps - get the current bandwidth of a single PCIe link
>   * @pdev: PCI device to query
> @@ -6048,7 +6043,7 @@ int pcie_link_bandwidth_mbps(struct pci_dev *pdev)
>  	if (err)
>  		return pcibios_err_to_errno(err);
>  
> -	speed = pcie_dev_speed_mbps(to_pcie_link_speed(lnksta));
> +	speed = pcie_dev_speed_mbps(pcie_get_link_speed(FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta)));

Readability seems worse due to cramming everything into a single 
statement.

>  	if (speed < 0)
>  		return speed;
>  
> @@ -6089,7 +6084,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
>  	while (dev) {
>  		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
>  
> -		next_speed = to_pcie_link_speed(lnksta);
> +		next_speed = pcie_get_link_speed(FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta));
>  		next_width = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
>  
>  		next_bw = next_width * PCIE_SPEED2MBS_ENC(next_speed);
> 

-- 
 i.

