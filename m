Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E827B3C13FE
	for <linux-pci@vger.kernel.org>; Sun, 11 Oct 2026 05:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791697497; cv=none; b=mE8aqnt2KNTuCtug3IrxlUuR+5kva5n3tHabs+HoxTVDM2XI5UdmUUlWnOYwodRBM5FJLgvH191mxhwg1uWONAgE2ryst2wV3VPBXV9mUQNjuYeT+Q7FaCMuxkryjqcDpHNgzKitUV2X1fP+pROppiqu1qxhphen6d9kCWHass4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791697497; c=relaxed/simple;
	bh=dCUDHhz4dgapugA1Auq2FlHXDI5hd/sAmskaSQc9Qa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JnnfE1/A1Eeh52+GT6sl18NGEbbx0qVww3T29TCthiI/7f4fHu9g3Hi+syU4c9nq0beRvcLFQrpUMomiycwgvnTMBIAPc/oPdIrBB50Zu/yePTJQ5oI5a2IU8EhfY6c90efzNv1uiCDGSq9kBVKawCo+S/wrYSBl1S37HcPhUeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2aY7iBn; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2aY7iBn"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33e6279a1d7so1252502eec.1
        for <linux-pci@vger.kernel.org>; Sat, 10 Oct 2026 22:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791697495; x=1792302295; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T8diuNZ+zrgNOaX3UMVCcddQtmK2jbIBOVFz+8CGVq0=;
        b=Q2aY7iBnleak2MnUOPpERazeABiRxrc4dX22Uzqxqvv8Yxpc5pWO9kQwa1n/p5e25N
         dvRL6tn7Tu790AWjicHeA8yOU1yKb3YZPQzCifzMp91wRLndXmCag296fiFR53XZ+bLV
         Y9wTshu3Kw4qZzKJQTUDmCJncdqOjvjBvL/iFLTHkhUsik/IkFbsFbMNtn3oYLT/ECCP
         PNeoRu2e+ckktGlV49GLfEhr4Na6pOL9LwB3+zYzTlZmo4rI/r0r8kor9jQMy6Ir5ur3
         brqyFpad0ACTpk0mTDEX8RZWeFnye66FyHRBC0BLCCg7fdCN6HTIoKf/dD4UgY8tUuEQ
         dwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791697495; x=1792302295;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T8diuNZ+zrgNOaX3UMVCcddQtmK2jbIBOVFz+8CGVq0=;
        b=IGwiE8rAMYtDsRKS6iwzilwcxNRJwG/2jHHX9p2cuRMi79H1/1IycjlSZj2lIJsIh1
         jYI2bOE5AxeTTNiCDKtfRwwcbKoGgU18XiKo8M0jA8SKRWUP6xbsu03KP2JmS7zPzCt8
         +7lU8j9DxUhXQbBST71vuC7w+cL0v6MwN05L8IoOPnkBvMS+K+4LzOoWl1WuH3d3onUk
         sk8vPAQJs85H4O42+x6bpS62KL2cgWgVkoIkY5fBCw8zPHjuX1sZZ1hkJy2BzlKJYyt0
         /otLL76zj1d22KSET1I+ZpRRP/CMO9ZgjhL2cv1RmJOo8GnigeMEI14xlCoiAhSmfFZn
         84MQ==
X-Forwarded-Encrypted: i=1; AKwUvBwuNZ4fu3Tfcyqpv8Na4E1ZxQUnNoDfHE4G1JqxVS9SCBJiLQJxD8wgSJ+nes+/hmcwh2kGKHlNCvE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLRbnuU8aXHz95d+F57JoPif9zwOuHht9Aw5sUpBntHiz+ISolT
	3oP0nywtiP7KbE8YiXyzZXIXSrUXh4kQi34Z8Puy36aCXyOEyl/+k8zZ
X-Gm-Gg: AYBFou2ugS3LNoo6RQkn4qdk3KtYYj8QItDZk3IvKO8nzq5HlujZnvwFO0tkh+aoCLN
	nOVMg/e2jexouTSU2Gg04+Es3LBu5jyf5QnXT84ATRm3GlD4mqgl86GWrhpHMenrenWROAgzren
	JxuAn+ZS8JA7MTvBKYdIb4JX3H4vw/YxXlgJdPYVhrX5HrD6PwpXg+nT0pjU+sVjpx0kHo7r5ne
	cV5YpWAzp7MXqngl4gXovDGhl23gtTuJ4WwKCJCQQP+VWtnZTxyoYV9UArHJ0/LlRkZbRfMybJI
	ESn2GrT8wuArTjMepxQmLOPLE2IeBJAYBnRyO5lDMJ+M+bD5/X0Q+vnO/qEbWi6BkbzsDHtmJFv
	d4MFLd4TerobKcotKAhnBjy/1KewL2cBMVIljZXiQUR+nB68uiyJqC6myV/Mt6ThP1IRpAvaAwq
	0/cNO5I/1TW3j5FeH7esQWz5g/blj5KJ65l1gEAVn2kIxx6YYEoqnn4SMCjMot55mmLGOiPJlcq
	Abw2LphtEgl4pM22sQIkt/qkGtSOlGer+lcm9aqWI9miQ==
X-Received: by 2002:a05:693c:8811:20b0:356:7ddb:2e54 with SMTP id 5a478bee46e88-3567ddb2f02mr6808511eec.29.1791697494583;
        Sat, 10 Oct 2026 22:44:54 -0700 (PDT)
Received: from [192.168.21.192] ([24.18.106.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841648sm23485573eec.3.2026.10.10.22.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Oct 2026 22:44:54 -0700 (PDT)
Message-ID: <17a20959-44ed-43e5-8414-201120468f2f@gmail.com>
Date: Sat, 10 Oct 2026 22:44:52 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] PCI: Set supported_speeds in set_pcie_port_type()
To: Stian Halseth <stian@itx.no>, Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andreas Larsson <andreas@gaisler.com>, linux-pci@vger.kernel.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20261007131304.309511-1-stian@itx.no>
Content-Language: en-US
From: Tony Rodriguez <unixpro1970@gmail.com>
In-Reply-To: <20261007131304.309511-1-stian@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

This patch also works on the Sparc S7-2, the correct x8 link is shown 
instead of unknown.

# dmesg | grep -iE x8 | grep -iE link
[    8.421411] mlx5_core 0001:03:00.0: 63.008 Gb/s available PCIe 
bandwidth (8.0 GT/s PCIe x8 link)
[    9.472465] mlx5_core 0001:03:00.1: 63.008 Gb/s available PCIe 
bandwidth (8.0 GT/s PCIe x8 link)
[   14.734746] mlx4_core 0001:04:00.0: 63.008 Gb/s available PCIe 
bandwidth (8.0 GT/s PCIe x8 link)

Tested-by: Tony Rodriguez <unixpro1970@gmail.com>

On 10/7/26 6:13 AM, Stian Halseth wrote:
> sparc64 and powerpc create PCI devices from the device tree in
> of_create_pci_dev(), which calls set_pcie_port_type() but not
> pci_setup_device(). Since d2bd39c0456b, supported_speeds is only set in
> pci_setup_device(), so it stays 0 for these devices.
> pcie_get_speed_cap() then returns PCI_SPEED_UNKNOWN, max_link_speed
> reads "Unknown", and the failed link retraining quirk passes
> PCI_SPEED_UNKNOWN to pcie_set_target_speed(), which warns on a SPARC
> T7-1:
>
>    WARNING: drivers/pci/pcie/bwctrl.c:125 at pcie_set_target_speed+0x284/0x2e0
>
> Set supported_speeds in set_pcie_port_type(), which all three paths
> call.
>
> Fixes: d2bd39c0456b ("PCI: Store all PCIe Supported Link Speeds")
> Closes: https://github.com/sparclinux/issues/issues/109
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
> Tested on a SPARC T7-1: before, max_link_speed reads "Unknown" and the
> warning above appears with CONFIG_PCIEPORTBUS; after, all 23 PCIe
> devices report their real speed and the quirk lifts the 2.5GT/s
> restriction without a warning. Not tested on powerpc.
>
>   drivers/pci/probe.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5afc..52a79b033b069 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1651,6 +1651,8 @@ void set_pcie_port_type(struct pci_dev *pdev)
>   		pdev->aspm_l1_support = 1;
>   #endif
>   
> +	pdev->supported_speeds = pcie_get_supported_speeds(pdev);
> +
>   	parent = pci_upstream_bridge(pdev);
>   	if (!parent)
>   		return;
> @@ -2074,9 +2076,6 @@ int pci_setup_device(struct pci_dev *dev)
>   
>   	set_pcie_untrusted(dev);
>   
> -	if (pci_is_pcie(dev))
> -		dev->supported_speeds = pcie_get_supported_speeds(dev);
> -
>   	/* "Unknown power state" */
>   	dev->current_state = PCI_UNKNOWN;
>   
