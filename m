Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E165E4E141D;
	Fri,  9 Oct 2026 15:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791559789; cv=none; b=AoD5m0+/rkjObkrm8/yGjRQ+0cTkF7gLVRUYtWzBDtaFYQdCRldqj89ZAdJ92yEF0qNixEPghnamfEHrEXSNF3CAcaYaLt0fvHbrds8UjLkTKeUEV9KkEAg41gLCatAge7LNYL0qf4DBt2i7as2yx4jAZwY1ibrGfRq5iw+v4uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791559789; c=relaxed/simple;
	bh=m5Oxfi8s5vZu+bzQS+WRYvMM6s6DS+tla1qoaKR9uBU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Qko3Z3RoXhnagll7ONK3pJHa9pOfL9QYwLxtUGbLZNqpqcuJpTy3/4bjrWe8sTdYQTJdBoh6Yr+sMUW1xTCKFhktQZ0Ibr2uVvsXy/3jgkm7VwrEKqbu70uJfo19Cz8ZfWVK7vKR60UiHzTrMa4GFXXZHzgRufUSlz2sCZehzOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcsICqKP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcsICqKP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961691F000FF;
	Fri,  9 Oct 2026 15:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791559788;
	bh=rtlq/9YcmXw8NmebrTfGcIs8U33OKDOfAPBwtnMEh1E=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=XcsICqKPqnQSdKfgvRh3AoIIbXjevADj+oCFJqtTe+2F3ekENxE1hgxJPf/KkZvNP
	 LyVTI6pOBs1gTKjV5J+qjTKGE3teS8TpsQVl5y5qjsq/DjPEzuGXRrJEJ0hBqknYGG
	 0JBOe1inPsSaXG9nJR8gkNA/0oKvx2L09YDFZdUYQxIkhL81SUiAWOXwbet8BU8XXP
	 B95JzLmcu+kH8KG8ycdTVv6aE7zCDLNoPaa04sd+QmnIHPkfLmjoC4EcpdqRn1z14M
	 ZfOtMEom4O440aMhI4UWv826HFjfD7j9IqnUgAZZmtGjnvOoU4OGjjnH3LfMb6FpzO
	 Qe3tQOwFA0NWQ==
Date: Fri, 9 Oct 2026 10:29:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Claudiu Manoil <claudiu.manoil@nxp.com>
Cc: netdev@vger.kernel.org, s32@nxp.com,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1 5/5] PCI: Create OF node for NXP ENETC
 pseudo-MAC functions
Message-ID: <20261009152947.GA976116@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2706e800774bb7e72992a8cc9d17ce7be039f046.1791548316.git.claudiu.manoil@nxp.com>

On Fri, Oct 09, 2026 at 03:40:34PM +0300, Claudiu Manoil wrote:
> NXP ENETCv4 pseudo-MAC (PPM) ports can be probed as pure PCI endpoints,
> without any "ethernet" node in the static device tree. The ENETC4 driver
> describes their fixed link by applying a device-tree overlay onto the PCI
> function's own OF node, which requires that node to exist.
> 
> Request the PCI core to synthesize a per-function OF node for these
> devices by registering of_pci_make_dev_node() as a final fixup, following
> the existing precedent for the Xilinx, Red Hat and EFAR devices. The
> helper is a no-op when the function already has a static OF node, so this
> has no effect on platforms that describe ENETC via static DT. It only
> takes effect when CONFIG_PCI_DYNAMIC_OF_NODES is enabled.
> 
> Both ENETC4 PCI device IDs are covered (0xe101 and 0xe110), since either
> can be instantiated as a pseudo-MAC port on S32N79.
> 
> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/quirks.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index de9bbccda21f..86f0a182224b 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6391,6 +6391,8 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EFAR, 0x9660, of_pci_make_dev_node);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PHILIPS, 0xe101, of_pci_make_dev_node);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PHILIPS, 0xe110, of_pci_make_dev_node);
>  
>  /*
>   * Devices known to require a longer delay before first config space access
> -- 
> 2.34.1
> 
