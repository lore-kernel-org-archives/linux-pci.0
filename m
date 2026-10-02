Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8064D357CE0
	for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2026 23:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790984388; cv=none; b=mHuQYJqJGxOObymSZfsOMYKNREdPhPXNeEZz0X4qUYE9K4v1g6bhmjz8r6kUU+p06dQlmlGLGl484xa3KJEnNkCXZY66TiX/wDJW93Y77w3ngv0bl7HQiHFbXteS58ZxoFR0jUTLXTmcG5ToKI77IS6z+1hVFc8JIqTUADeUkWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790984388; c=relaxed/simple;
	bh=NAFk/xfQo2MgkGAPIKUO30ii93hV4/iqSpYcf0X2Zts=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DBMKJO7rSDg82nBr0TrFobfRdt+UZJIq+DGKuGnMHgCIcqXY7YYIHtjJTh0+KDoUahXcMpoQNXD/fyINIWvIiSha4AIVPUTW0rlDUlqBpcmbBMCEYuh/tqhU9ygwQX51phNePYq15m+m2vtoUbawWk2Dlvm0l8aNivNzZffhOpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEOYXd9y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEOYXd9y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58841F00893;
	Fri,  2 Oct 2026 23:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790984387;
	bh=2F9PM14gbO/JmqJbFmB0qxBlVb6KOCBrfWS4oqVBhpU=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=CEOYXd9ydMm151azfENtOP96RpUuf/G8x/7YY7LRbScsOU9/xEXGFx8ltpG8F/3fY
	 wQ3wUC6WnkD9XutfhcG31IEBYM7FCUf3kfUErfW+rKSYkWTnkpFpVO+JSu1iDTKMVe
	 6E2likWy2SrsgPjYVFOSBOhbOzz2RPK4ecoY71G+HhzERWlHcOWavefP+B0bpy1xkT
	 WD2WguvFougIbwkoPTU6/vGip5qDJhnspOF/LO5b5xjIkXed9lP/SvvShx571aOu/K
	 8XdQ5e+agFkD7dBYU81dkjiPaKLt8l0OUAuKlhIFF1mhcT4WbXQG5KDtxkJduOVFLp
	 qipXMH6MDi60g==
Date: Fri, 2 Oct 2026 18:39:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: mediatek: fix W=1 snpringf warnings
Message-ID: <20261002233945.GA406594@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b835e360b42c5e0994f9301a34dbdf140a8d3ef5.1772493898.git.ryder.lee@mediatek.com>

On Mon, Mar 02, 2026 at 05:46:48PM -0800, Ryder Lee wrote:
> Fix the following errors in W=1 builds.
> 
>   $ make W=1 drivers/pci/controller/pcie-mediatek.o
>     CALL    scripts/checksyscalls.sh
>     DESCEND objtool
>     INSTALL libsubcmd_headers
>     CC      drivers/pci/controller/pcie-mediatek.o
>   drivers/pci/controller/pcie-mediatek.c: In function ‘mtk_pcie_parse_port’:
>   drivers/pci/controller/pcie-mediatek.c:963:43: error: ‘%d’ directive output may be truncated writing between 1 and 10 bytes into a region of size 6 [-Werror=format-truncation=]
>     963 |         snprintf(name, sizeof(name), "port%d", slot);
> 	|                                           ^~
>   drivers/pci/controller/pcie-mediatek.c:963:38: note: directive argument in the range [0, 2147483647]
>     963 |         snprintf(name, sizeof(name), "port%d", slot);
> 	|                                      ^~~~~~~~
>   drivers/pci/controller/pcie-mediatek.c:963:9: note: ‘snprintf’ output between 6 and 15 bytes into a destination of size 10
>     963 |         snprintf(name, sizeof(name), "port%d", slot);
> 	|         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ...

> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -953,7 +953,7 @@ static int mtk_pcie_parse_port(struct mtk_pcie *pcie,
>  	struct mtk_pcie_port *port;
>  	struct device *dev = pcie->dev;
>  	struct platform_device *pdev = to_platform_device(dev);
> -	char name[10];
> +	char name[20];
>  	int err;

FYI, from internal Sashiko review while backporting this:

[Severity: High]
This is a pre-existing issue, but looking at the error paths around port
parsing, is there a missing IRQ teardown that could lead to a use-after-free
or resource leak?

When mtk_pcie_parse_port() successfully parses a port, mtk_pcie_setup_irq()
allocates an IRQ domain and registers a chained IRQ handler that keeps a
pointer to the port struct.

If a subsequent initialization step fails, such as parsing another port in
mtk_pcie_setup() or pci_host_probe() failing in mtk_pcie_probe(), the probe
function aborts and returns an error:

mtk_pcie_setup() {
    ...
    err = mtk_pcie_parse_port(pcie, child, slot);
    if (err)
        return err;
    ...
}

The error paths, such as the put_resources label in mtk_pcie_probe() which
calls mtk_pcie_put_resources(), will free the memory of the port struct but
fail to unregister the chained IRQ handler or remove the IRQ domain.

Because of this, a freed port pointer remains registered as the handler data.
If the shared interrupt fires, could mtk_pcie_intr_handler() dereference this
freed pointer and crash?

Additionally, if platform_get_irq() fails in mtk_pcie_setup_irq(), it looks
like the function returns an error without destroying the just-created
port->irq_domain:

mtk_pcie_setup_irq() {
    ...
    if (port->irq < 0)
        return port->irq;
    ...
}

Would it be appropriate to add proper teardown functions to these error paths
to unregister the handlers and clean up the domains?
