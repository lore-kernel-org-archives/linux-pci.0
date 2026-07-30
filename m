Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D40404BD5;
	Thu, 30 Jul 2026 23:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785452810; cv=none; b=H1UOMCygMAngshoIhaoyKP7FCTV0AKpP3Ignu8v/mY2x9SMZUjadXc7D/7TFYx7A9RirxjJjtEdw1TAsU/rmS3cqAt5f9N0N6bYQ5miF/tUb1/p7NbEa7uz+WeE8ar1YDOBJBU1gN/r3SHfKmLp9hvL5g6CjOMIDHfkaXaw/80A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785452810; c=relaxed/simple;
	bh=zizLoJiGNGbsJiokhXVXEUwLZEI1sjEkp78ppupM1U8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gyk/3POdQG0ReRnc6Naa18jqJKX57GsJfc4mC4Mr/I7W34eJeAv3XrE9t/fK5W4++Goe+m2NMwdCWnzj261dDwjHwCqG5WPfcP83Ja3hA76KA+SkEOYtEEIxT2QGbizt7U2l5o83ijbUueLYAmgjWpK4aVUsKFW+1Ri/EN38oYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H2fmBqZW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H2fmBqZW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=zQVM6Rn482J/KebetyMlWZ3jkJiw9Xm5MkoT7XS91QM=; b=H2fmBqZWKt0UF1q2ctgqa8WZqX
	74nUS//qOLPtY2tK6A9KQZz1Su2MQgfpD7MxXzqLFyWzQBf0+1PJZnjzMd3Y/ZlpNn5ksQLUB7FO/
	6FheqJmwCAtaRVeK9jHG7z3b2hDzOx5fhoshpcN2B9yGxMNL3ODuVPb1b1+DYQji1NAUc1RoATeP4
	jabfnD8TY/+MIUH3R6G2KjAkUOZ0LByfhJJJEaK0Vq+zNMkggcvF5FtFB5UsCgBsSIrKYqkn7bjcr
	4WZx+VOzUi0ZhiazFpfZZykmEnRpTqBnSmeKUWif6sYJdWCeI6PovaNOh28aOe7pODlwLhBOzjOAn
	bmRxza8w==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpZps-0000000BSyq-3KRd;
	Thu, 30 Jul 2026 23:06:44 +0000
Message-ID: <589ea512-93c6-4e1c-83d7-ba45a0b35843@infradead.org>
Date: Thu, 30 Jul 2026 16:06:44 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Jul 30 (pci/controller/cadence/)
To: Mark Brown <broonie@kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-pci@vger.kernel.org
References: <amtnlbQl2KLongvo@sirena.org.uk>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <amtnlbQl2KLongvo@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/30/26 8:02 AM, Mark Brown wrote:
> Hi all,
> 
> Changes since 20260729:
> 

(1) /usr/bin/ld.bfd: drivers/pci/controller/cadence/pcie-cadence-plat.o: in function `cdns_plat_pcie_probe':
pcie-cadence-plat.c:(.text+0x2f8): undefined reference to `cdns_pcie_ep_setup'

In this case, a builtin driver attempts to call into a loadable module:

#
# Cadence-based PCIe controllers
#
CONFIG_PCIE_CADENCE=y
# CONFIG_PCIE_CADENCE_DEBUGFS is not set
CONFIG_PCIE_CADENCE_HOST=y
CONFIG_PCIE_CADENCE_EP=m
CONFIG_PCIE_CADENCE_PLAT=y
CONFIG_PCIE_CADENCE_PLAT_HOST=y
CONFIG_PCIE_CADENCE_PLAT_EP=m
# end of Cadence-based PCIe controllers

(2) /usr/bin/ld.bfd: drivers/pci/controller/cadence/pcie-cadence-plat.o: in function `cdns_plat_pcie_probe':
pcie-cadence-plat.c:(.text+0x11f): undefined reference to `cdns_pcie_host_setup'


This is similar, just a different driver is =m in the failure case.

#
# Cadence-based PCIe controllers
#
CONFIG_PCIE_CADENCE=y
CONFIG_PCIE_CADENCE_DEBUGFS=y
CONFIG_PCIE_CADENCE_HOST=m
CONFIG_PCIE_CADENCE_EP=y
CONFIG_PCIE_CADENCE_PLAT=y
CONFIG_PCIE_CADENCE_PLAT_HOST=m
CONFIG_PCIE_CADENCE_PLAT_EP=y


-- 
~Randy

