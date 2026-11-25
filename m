Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795565430;
	b=W98iXKXwsuM9ZdI8gOarScWeMEQpCfycufPQqoZrdE/JzA8ifwHd97kVYeVPPOhob6Ta
	 T3YrMYMtoaw1jCo9YtWKPT9UcQlCi+y4qnHXRKp/2oJ8pKM8Tcgxe4HaiNZZxWVbW/b3Y
	 xEMaZcp55PpPRTvGU+yEuOPV+MtqrQh9oiI6iiA5K4smGsOuf98ueAm247JOhrCiqcPic
	 hM2coFkMwKGKotLBr0vGhXC7vr50cYFdrGmUJVBf2wekkkAn/RMxMBO+Xvc2+xzuba0Gg
	 Ez0KP2l4hfUiqEZVSdHRD9hSY8Kn7Di+r2LiqLvHt9xGbwUn1YUg225tme7gjEj7Nug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795565430;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=UXIld9QrTe+UE0l/81XlCBtJ2t8TTqOmbpSiK2nPqBM=;
	b=v7nOtYU42ZGxQmECrch5Gl8NOtbplJ3IfIjKDQbTjXK+hG4dSBEbPW+aGi1alkSpiWDB
	 aZoPjsphCLFmFm7c0cct7HBMfiou+l0ce+YkEXX9aim1RXcSrYdZBXIeJR4AqeO6i8Q6g
	 UXTWKFONomNp9h3r654MqElZ841+kzW3Lis3P6BRkpyRYwYON9Ar/rsiMPGgLRhsiS1nQ
	 rDYQalG6Z1aIx4LviDrOCQPa7nvWa+LG5z+Nze0P1TAPVEjUUT3G9GQXZlabN2/ld70F7
	 zkyN2yVVu1JhkKkH8aJxOZMhzSkJw8BXYnt4awvImjOoL/jfArDDZOvFewWkW3Iz2aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gyHLuBJt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7255C606A31E;
	Wed, 25 Nov 2026 00:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gyHLuBJt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1281F000C0;
	Wed, 25 Nov 2026 00:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795565429;
	bh=UXIld9QrTe+UE0l/81XlCBtJ2t8TTqOmbpSiK2nPqBM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=gyHLuBJt3fYGXFD2OttwhMGc+aj+vkZjnBE+33di7izJVDOoiXGvVgBi4XyXFV8ER
	 UxfFXEtmtIN7a5Sz9nUNgS8Jf/v9VOAsm9pWjG+VNeE0Jnbzw6ApZnjYjoITt7T0jO
	 FtMPYzJznhDhrYpigZI0eDuzEbWfIgxm5TEj4Ixfiyn2tzey28WZi0fR9VDKkgppZQ
	 9iA7usey5lc/xHxF6aWDP1jwUa25nDaOrSKKbg/bSkJnNsbrYES8BVjaJ6ImIRT7Qd
	 StisrFZkSJQH5xf3MEC39fXTgCGlzHwaayQUguLfB0eBypXYAWvtWDBB3xX0kTYykW
	 AL1aQC1FUaUAw==
Date: Tue, 24 Nov 2026 18:10:28 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joshua Machauer <machaujo@amazon.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
	Richard Cheng <icheng@nvidia.com>, linux-pci@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	nh-open-source@amazon.com
Subject: Re: [PATCH v2] PCI: Skip the CXL state update for a VF
Message-ID: <20261125001028.GA1195082@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123162035.79133-1-machaujo@amazon.de>

On Mon, Nov 23, 2026 at 04:20:35PM +0000, Joshua Machauer wrote:
> set_pcie_cxl() runs for every added device. It first refreshes the CXL
> state of the upstream bridge, which walks that bridge's extended
> capabilities and recurses up to the Root Port, and then searches the
> device's own extended capabilities for the Flex Bus Port DVSEC.
> 
> For a VF neither step changes anything. A CXL device exposes its Flex
> Bus Port DVSEC through Function 0 (CXL r4.0, sec 8.1.8), so the search
> in a VF finds nothing and the VF's is_cxl stays false. The bridges
> above a VF are the ones above its PF, which were already refreshed when
> the PF was added. Because enabling SR-IOV adds the VFs one after
> another, each add repeats both walks without effect.
> 
> Return early for a VF. Every device keeps the is_cxl value it has
> today, and the bridges above the PF are no longer refreshed during a
> VF add.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Joshua Machauer <machaujo@amazon.de>

Applied to pci/enumeration for v7.5, thank you!

> ---
> v2:
> - Shorten the commit log (Dave)
> - State that VF adds no longer refresh the bridges above the PF, and
>   cite the spec section in the comment (Richard)
> 
> v1: https://lore.kernel.org/all/20261119164219.51540-1-machaujo@amazon.de/
> 
>  drivers/pci/probe.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 9a178e0e5f7f..e302f9dabddd 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1717,6 +1717,15 @@ static void set_pcie_cxl(struct pci_dev *dev)
>  	if (!pci_is_pcie(dev))
>  		return;
>  
> +	/*
> +	 * A CXL device exposes its Flex Bus Port DVSEC through Function 0
> +	 * (CXL r4.0, sec 8.1.8 "PCIe DVSEC for Flex Bus Port"), so a VF has
> +	 * none. Its upstream bridges are the PF's, which were updated when
> +	 * the PF was added.
> +	 */
> +	if (dev->is_virtfn)
> +		return;
> +
>  	/*
>  	 * Update parent's CXL state because alternate protocol training
>  	 * may have changed
> -- 
> 2.47.3
> 
