Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABFD4317D;
	Sat, 21 Mar 2026 03:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774063992; cv=none; b=pX0AxLExKcKgHoFmcxbZYwSR6oOgfUJ3sXGZuGcFoPrqpwvZ6gf4aftH64KIFNf0y8Cu99J0x6uEeNWY4CaI/y7kO7senSkKda81PcwMbT1yVnUhnb4gbGb31caTNQrHk5gpzTv9eqCBSrmqSN8r/lFbeRVYuxj6wOEXZEvwcHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774063992; c=relaxed/simple;
	bh=x5/ukawUb4SdSwAy3c7T4WDy8fcHnnYYIyEyaNocxS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iQrrIE6Qj3vaTjY0G95Fzt2o5HumZDIA0EhuBUGbciN/yggLmE2xTpGISrUgbpPU3HyZLcqck8rYCm3Qvtb/INWYxa6csv/z+/0ZJ0GCNKVbkJtzt6Lyvq9uGrwxrJgKjVwFw09Iv9ZXzzHCsNz1uIRHG1YE9wQJsywbPkCCHpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=g9Qs16iV; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="g9Qs16iV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=qtUIqwRmMTJIrcGkJNjzGiQxaV7o+b3FjaZpmH3sWZY=;
	b=g9Qs16iVnSVGuQmeNS0XZQ7aih8YSZXk+txZrOQe1yMmFCbe988PJVrx6KFzP+
	p+mkxraW9l05L00JSFsnTIT//tHCjHI9In5vZxdb4YExAL90P/81ZRAdMFwnVYvP
	tdFKT9mh6ZmxXaZRcwjRteZXRt4HdHm59qErPjFYZD36g=
Received: from [192.168.50.71] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgAHJMVXEb5pF8irWg--.11673S2;
	Sat, 21 Mar 2026 11:32:40 +0800 (CST)
Message-ID: <e0a55d52-1f16-45d7-b569-a8fcd0308bfe@163.com>
Date: Sat, 21 Mar 2026 11:32:39 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] PCI: cadence: Add LTSSM debugfs
To: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, hans.zhang@cixtech.com
Cc: robh@kernel.org, mpillai@cadence.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260321032852.3007448-1-18255117159@163.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260321032852.3007448-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PSgvCgAHJMVXEb5pF8irWg--.11673S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw4DXr47KrWkCw4DJFyfXrb_yoW8tFWrpa
	yDGFWfAa1xArW3u3Zav3WUXryftF97Ja97XwsF9347u3W3CryDJF1xtFWFqr9rGrsIqr17
	JF15tas7KF1SyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR89N-UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBhkCGm+EVgVwwAA34

Hi,

Sorry for the noise. The patch was sent in error. Re-sent.

Best regards,
Hans


On 3/21/26 11:28, Hans Zhang wrote:
> Hi,
> 
> This series adds debugfs support to the Cadence PCIe controller driver,
> allowing users to read the current LTSSM state of the link for debugging
> purposes.
> 
> Patch 1 introduces a new flag 'is_hpa' in the cdns_pcie structure to
> distinguish HPA (High Performance Architecture IP) platforms, which
> have a different register layout for LTSSM status.
> 
> Patch 2 implements the debugfs file "ltssm_status" under a per-device
> directory. It reads the LTSSM state from the appropriate hardware register
> based on the 'is_hpa' flag and displays both a descriptive string and the
> raw value.
> 
> ---
> Changes for v2:
> - s/DW_PCIE_LTSSM_NAME/CDNS_PCIE_LTSSM_NAME/
> - S/January 2026/March 2026/
> - EXPORT_SYMBOL_GPL(cdns_pcie_debugfs_init); // Resolve the following error issues.
>    >> ERROR: modpost: "cdns_pcie_debugfs_init" [drivers/pci/controller/cadence/pcie-cadence-host-mod.ko] undefined!
>    >> ERROR: modpost: "cdns_pcie_debugfs_init" [drivers/pci/controller/cadence/pcie-cadence-ep-mod.ko] undefined!
> 
> v1:
> https://patchwork.kernel.org/project/linux-pci/cover/20260315155514.127255-1-18255117159@163.com/
> ---
> 
> Hans Zhang (2):
>    PCI: cadence: Add HPA architecture flag
>    PCI: cadence: Add debugfs property to provide LTSSM status of the PCIe
>      link
> 
>   Documentation/ABI/testing/debugfs-cdns-pcie   |   5 +
>   drivers/pci/controller/cadence/Kconfig        |   9 +
>   drivers/pci/controller/cadence/Makefile       |   1 +
>   drivers/pci/controller/cadence/pci-sky1.c     |   1 +
>   .../controller/cadence/pcie-cadence-debugfs.c | 214 ++++++++++++++++++
>   .../pci/controller/cadence/pcie-cadence-ep.c  |   2 +
>   .../cadence/pcie-cadence-host-hpa.c           |   8 +-
>   .../controller/cadence/pcie-cadence-host.c    |   8 +-
>   drivers/pci/controller/cadence/pcie-cadence.h | 147 ++++++++++++
>   9 files changed, 393 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/ABI/testing/debugfs-cdns-pcie
>   create mode 100644 drivers/pci/controller/cadence/pcie-cadence-debugfs.c
> 
> 
> base-commit: 1c9982b4961334c1edb0745a04cabd34bc2de675

