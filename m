Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6FC446853;
	Mon, 21 Sep 2026 20:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023661; cv=none; b=K+wlMx9/GYb/rCzKQuyna67prjYBMBplAOCLlWzwv9iARGUrEJAnPQBLMHz6uamj08U/AADkCa5YN1Ui/uMU/r0vbDBUeCFpoy2Vm01SvjLWKIwfJ4aJSD7RbpIBEvRQjvS6XnBVb8kaZdBeheB2kxRWCv2Jhs86VviNAUrwjcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023661; c=relaxed/simple;
	bh=mlc5wSH/imewlxINdd/LQID8CnVMUZAkDjDLG4u+LEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2vSxw9jV/URoh7rFr7jA0vsqw2wTw8LRbLrrUJXS5XEsnfdX3wUGSWpPdT2995yaJfGKDumC1eUXROpAfMkMuuSTyj3Tzan3Z3UCjmtk7l0TgXagTBpuAnuRrqe67hhKsMTJ86fcp/stcRM/h0Hsu1qk65/nyOSiD+3UDJednY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=A0rg89kI; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="A0rg89kI"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hpZzq4kg5zKmg4;
	Mon, 21 Sep 2026 22:47:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790023655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f2rabTClWV5kxaYEDs2ubJgcu6AzV7reEk3bkAfZHCk=;
	b=A0rg89kIDpgVtfuh8XX6OXO5j73hbSYP+1MzhZnfYBnct073RbJCQW+idRnhNUxxnLSja+
	SY5GSe0ZOFZE+mv+6Zm5UalOEGGqxaEFtBu9LwFVJAZQ1NWxcmYGkXeqXUkmv2N2k+dUVg
	tbzfF1qyyaKZEdqDWdVspQgEddUhaYpdOsMsP94cxnItRj+zKMOvfRibRsDgonnPPnoKgW
	GfbNjnRaQGIyoMUTHvmVOH6rK0Gts9e1TuLnNHgHAexCqSo9cVYHLRB7NCZ7x1cZQ5a+xr
	cYCm15c0gOygEGOcs359dQTExjDkYYHcha23Qu0botF8urvOaVM8jM6jP5AZHw==
Message-ID: <95685b0e-21dd-4446-8fef-c5664cea4057@mailbox.org>
Date: Mon, 21 Sep 2026 22:47:30 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: rcar-gen4: Fix device_node leak in
 rcar_gen4_pcie_host_msi_addr()
To: Fuad Tabba <fuad.tabba@linux.dev>, Manivannan Sadhasivam
 <mani@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>
References: <20260918091052.2825315-1-fuad.tabba@linux.dev>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260918091052.2825315-1-fuad.tabba@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 4685aef00d3d3a8873d
X-MBO-RS-META: 686nfa6ji5unow17db6y6fcbyiqg4a67

On 9/18/26 11:10 AM, Fuad Tabba wrote:
> rcar_gen4_pcie_host_msi_addr() calls of_msi_xlate() with *msi_np NULL,
> so it receives the MSI controller node with a reference held, and every
> return past the NULL check leaks that reference, the success path
> included. Declare msi_node with __free(device_node) so it's put on
> every return.
> 
> Fixes: 8d6af27c0a73 ("PCI: rcar-gen4: Configure AXIINTC if iMSI-RX is not used")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/linux-pci/20260905213855.8D6671F00A3D@smtp.kernel.org/
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
> ---
>   drivers/pci/controller/dwc/pcie-rcar-gen4.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index fbe465a29068f..d61ce802b4614 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -323,7 +323,7 @@ static struct rcar_gen4_pcie *rcar_gen4_pcie_alloc(struct platform_device *pdev)
>   static int rcar_gen4_pcie_host_msi_addr(struct dw_pcie_rp *pp, u32 *msi_addr)
>   {
>   	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
> -	struct device_node *msi_node = NULL;
> +	struct device_node *msi_node __free(device_node) = NULL;
I think you have to call of_node_put() on msi_node(), so what about this 
instead ?

"
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c 
b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 8057c31c0123a..2eb20cff2fcad 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -382,20 +382,29 @@ static int rcar_gen4_pcie_host_msi_addr(struct 
dw_pcie_rp *pp, u32 *msi_addr)
  		return -ENODEV;

  	/* Check if "msi-parent" or the "msi-map" points to ARM GICv3 ITS. */
-	if (!of_device_is_compatible(msi_node, "arm,gic-v3-its"))
-		return dev_err_probe(dev, -ENODEV, "Compatible MSI controller not 
found\n");
+	if (!of_device_is_compatible(msi_node, "arm,gic-v3-its")) {
+		ret = dev_err_probe(dev, -ENODEV, "Compatible MSI controller not 
found\n");
+		goto exit;
+	}

  	/* Derive GITS_TRANSLATER address from GICv3 */
  	ret = of_address_to_resource(msi_node, 0, &res);
-	if (ret < 0)
-		return dev_err_probe(dev, ret, "MSI controller resources not 
obtained\n");
+	if (ret < 0) {
+		ret = dev_err_probe(dev, ret, "MSI controller resources not obtained\n");
+		goto exit;
+	}

  	addr = res.start + GITS_TRANSLATER;
-	if (addr >= SZ_4G)
-		return dev_err_probe(dev, -EINVAL, "MSI controller address above 
32bit range\n");
+	if (addr >= SZ_4G) {
+		ret = dev_err_probe(dev, -EINVAL, "MSI controller address above 32bit 
range\n");
+		goto exit;
+	}

  	*msi_addr = addr;
-	return 0;
+
+exit:
+	of_node_put(msi_node);
+	return ret;
  }

  static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
"

Also, I think drivers/pci/controller/pcie-iproc.c 
iproc_pcie_msi_enable() needs similar fix ?
