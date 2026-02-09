Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB8E21257B;
	Mon,  9 Feb 2026 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770655820; cv=none; b=AGgquTEUqhtwFdVOcLHYtE0BFLlGb8UFEFFnpsHeS3quuq+OxCjox2CZ2yBQdcgLx9FwL2Ud71vAOA7j3ongx0bUuZn1QG2LWBeBs+AMjwS+JCx6fHxhWtK1LWWPSmNPiT1MGNCsiPmg+uLAHqexmfpR4IZIVXBYQorN6eDl114=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770655820; c=relaxed/simple;
	bh=QDfjBeYIw4ZLySX94O7vYq3ZOoqQRiuCsWPbNywmg58=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GXopZiD4ajlIB2WdVMZQL1teg4PQofylNJS0/esYkZmmyzd/rixbbqfHPbF1Za+FTn1XwRCLMVYQl1buNs2i1GdZHncuvf5x5Tie7ZhqcNLQSQyuQAySY16pTAPV/RVVfLe+Pd54nPxGs4b3hQs5FLv43G1s5QMLuVZapNopo9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f8rJH2XjxzJ468V;
	Tue, 10 Feb 2026 00:49:19 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id D45D440565;
	Tue, 10 Feb 2026 00:50:16 +0800 (CST)
Received: from localhost (10.48.156.2) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Feb
 2026 16:50:16 +0000
Date: Mon, 9 Feb 2026 16:50:14 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Wei Wang <wei.w.wang@hotmail.com>
CC: <bhelgaas@google.com>, <jgg@nvidia.com>, <akpm@linux-foundation.org>,
	<bp@alien8.de>, <rdunlap@infradead.org>, <alex@shazbot.org>,
	<kevin.tian@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] PCI: Add the enhanced ACS controls check to
 pci_acs_flags_enabled()
Message-ID: <20260209165014.000070da@huawei.com>
In-Reply-To: <SI2PR01MB43931402377765D5DEA04ED3DC65A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB43932C799AE9111C7D2C319FDC65A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
	<SI2PR01MB43931402377765D5DEA04ED3DC65A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Sat,  7 Feb 2026 19:30:59 +0800
Wei Wang <wei.w.wang@hotmail.com> wrote:

> The enhanced ACS controls introduced by PCIe Gen 5 ensures better device
> isolation. On devices that support the PCI_ACS_ECAP capability, the
> controls are required to be enabled properly:
> - ACS I/O Request Blocking needs to be enabled to avoid unintended
>   upstream I/O requests.
> - ACS DSP and USP Memory Target Access Control needs to be set with
>   Request Redirect or Request Blocking to ensure the Downstream and
>   Upstream Port memory resource ranges are not accessed by upstream
>   memory requests.
> - ACS Unclaimed Request Redirect needs to be enabled to ensure accesses to
>   areas that lies within a Switch's Upstream Port memory apertures but not
>   within any Downstream Port memory apertures get redirected.
> 
> To maintain compatibility with legacy devices that lack PCI_ACS_ECAP
> support, pci_acs_enabled() skips checking for the capability.
> 
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
Hi Wei Wang,

A few things inline.

Thanks,

Jonathan

> ---
>  drivers/pci/pci.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 1714e29ce099..53e79948b4ea 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c

> +static bool pci_acs_ecap_enabled(struct pci_dev *pdev, u16 ctrl)
> +{
> +	bool is_dsp = pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM;
> +	struct pci_dev *usp_pdev = pci_upstream_bridge(pdev);
> +	u16 mask = PCI_ACS_DMAC_RB | PCI_ACS_DMAC_RR;
> +
> +	/*
> +	 * For ACS DSP/USP Memory Target Access Control, either Request
> +	 * Redirect or Request Blocking must be enabled to enforce isolation.
> +	 * According to PCIe spec 7.0, the DSP Memory Target Access is
> +	 * applicable to both Root Ports and Switch Upstream Ports that have
> +	 * applicable Memory BAR space to protect. So if the device does not
> +	 * have a Memory BAR, it skips the check.
> +	 */
> +	if (pci_dev_has_memory_bars(pdev) &&
> +	    (ctrl & mask) != PCI_ACS_DMAC_RB &&
> +	    (ctrl & mask) != PCI_ACS_DMAC_RR)

As below. I'd use the mask define suggested in previous then FIELD_GET()
plus checking the value of that against defines for these two field
values.

> +		return false;
> +
> +	mask = PCI_ACS_UMAC_RB | PCI_ACS_UMAC_RR;
This is the mask for the field that should be in the header.
> +	/*
> +	 * The USP Memory Target Access is only applicable to downstream ports
> +	 * that have applicable Memory BAR space in the Switch Upstream Port to
> +	 * protect.
> +	 */
> +	if (is_dsp && pci_dev_has_memory_bars(usp_pdev) &&
> +	    (ctrl & mask) != PCI_ACS_UMAC_RB &&
> +	    (ctrl & mask) != PCI_ACS_UMAC_RR)
> +		return false;
> +
> +	/* PCI_ACS_URRC is applicable to Downstream Ports only.  */
> +	if (is_dsp && !(ctrl & PCI_ACS_URRC))
> +		return false;

I'd be tempted to group the DSP specific handling and drop the local variable.

	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM) {
		if (pci_dev_has_memory_bars(usp_pdev) &&
		    (ctrl & mask) != PCI_ACS_UMAC_RB &&
		    (ctrl & mask) != PCI_ACS_UMAC_RR)
// or use FIELD_GET() to get using the mask suggested in previous patch then
// match what was in the filed here.
			return false;
	
		if (!(ctrl & PCI_ACS_URRC))
			return false;
	}
> +
> +	/* PCI_ACS_IB is applicable to both Root and Downstream Ports. */
> +	return !!(ctrl & PCI_ACS_IB);
> +}
> +


