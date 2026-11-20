Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795194525;
	b=n1gdpY4A6dGZRiasfqoAZLRf9REj6IDSPhDaSP2pCGq2SuPhm+XO7mesAfSbWO3Zl00g
	 nL4IlyoZDSBOGOyX+x/40FqrwDrtM9TOlVUkUFABJOK7/o6TseI4IzG1vWrtFkKNZx1od
	 /1Yv/qfbhaNKflkZHonquPMJQrO+q8KkHBgpp49jUOE4B4tHHtsPxuByakJS600D7S4LL
	 CWkGGiA/H2ZOa7ranHTgAYFgRJTcjaAGYPJ4OWNEMGRdZyH1rvwJ0yrfod3E3AX6HFAzM
	 Yk2quiqXfQt/BZTzKqbTEyNXGf4ACAQ6THRLIvzYAI/pGU42GaPjkoNe6Zv6jQts4sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795194525;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=M/TnF/JPDUYBbnDVZz77UYEHinNWNgD8WyG0zugAQds=;
	b=hFWwO6qTeQz4tpvRc4RzU8eSi75vVPMD85z/DmN6/52Aa80YPtZSf+c1VHK3TYcXITAl
	 uIs3O9nuf8Bq7xB+dAGAhDhJ4RcjuNQMh3YDyXvOocpZ3eGyKcoQtaPXdux2lLgaTTyZy
	 1SZYkGMygQ0w01urQhBN22alC0VE8ycnwJ+TlPnu1TYK1xKHCCv3T3TjVPIbzFikZsDWn
	 RSSoESd/hLdjUAcTOa6kGbhSoEz1Ygolf1+2RE2HD+1mkgM/uN4hAK8rrK2EqVtvC7qsQ
	 F+vqj2BZyKKlX342NFghDzFzyaKlAwaBmG0siOTZJ1mu9IT/5v2gb0ThhzFljElziOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T53bGmNz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0080A606A330;
	Fri, 20 Nov 2026 17:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T53bGmNz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE67C1F000C4;
	Fri, 20 Nov 2026 17:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795194524;
	bh=M/TnF/JPDUYBbnDVZz77UYEHinNWNgD8WyG0zugAQds=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=T53bGmNzn2por7HmMxXHcZFShi32TTJ7cWoglynDcHJyRL/EONqCWGUiEn5CX95uV
	 jyWOpzl5EFHFFTY6B/o4wCCm8awlzXOw3NWgL24INTGKneZeXhIfPcKEyCAjY9OrNv
	 j6YK93AaV3lWiN4IOaXpk+5JRoouYQ+zxyseJJPjK//2d3C3W4fAIV4sawJNh2xQt/
	 7tzeV+CX3qHjYlyTjRNKLr+cS5ek/VNbHEMDTtJJmWv2Hf1QDhtKo3Frwy+bPIWUPx
	 Y3TcYuk3t5ff102OVZVRz9H1igtl4oK7K/f5EBTATPAy+ZlnEoaPNdxo+wn5Frsw5S
	 h4Um7Siweo5Xw==
Date: Fri, 20 Nov 2026 11:08:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	qiang.yu@oss.qualcomm.com,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH v6 2/7] PCI: Export pci_set_target_speed()
Message-ID: <20261120170842.GA890036@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261119-bwscale-v6-2-9a9a715fcb46@oss.qualcomm.com>

On Thu, Nov 19, 2026 at 06:26:34PM +0530, Krishna Chaitanya Chundru wrote:
> Export pci_set_target_speed() so that other kernel drivers can use it
> to change the PCIe data rate.
> 
> Acked-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

The bulk of this is in MHI, so I assume this series will be routed
that way; let me know if otherwise.

> ---
>  drivers/pci/pcie/bwctrl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> index c1e749df5bbe..0512ec62dd5b 100644
> --- a/drivers/pci/pcie/bwctrl.c
> +++ b/drivers/pci/pcie/bwctrl.c
> @@ -219,6 +219,7 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(pcie_set_target_speed);
>  
>  static void pcie_bwnotif_enable(struct pcie_device *srv)
>  {
> 
> -- 
> 2.34.1
> 
