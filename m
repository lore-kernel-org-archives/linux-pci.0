Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCA536B90A;
	Tue,  1 Sep 2026 06:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245159; cv=none; b=YI2MizmFlKP/ltCAqvG0zwSybdWnfpZbZhJjZbjlKhHcKKeR14SIKNtuNhKitEq0mtWTlug2EMysje3K9lb9t1VwH/1ygE0uhYEkm/7pXhQT0SblwoVYa6CwXLPcXCAXMOAKig6lMwb9y9UZ0hnOknOBdyQ0qvZKDvSODoGjtHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245159; c=relaxed/simple;
	bh=W/nwyhnsYv/268Axgt633KDCI9dPa5FEesZko/5uCDE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ciOqigfRWXGLv5sO0q/FWhx4HIETNF8HYNicKyKKUWt5dfqrDrzfigu1nflYSxX3QAB9WE2VXNsrJWxmkpMOusiMGJXxTzvsFzdZdob9VoWIG0775AEoBrOhNNIfByBe8aGXnaIvZwY+j4gBu+cwwd62qvJX6z/ovNAcqOqi9II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=g39Qc0Hh; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="g39Qc0Hh"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8F3891A192B;
	Tue,  1 Sep 2026 06:45:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5D5E66053C;
	Tue,  1 Sep 2026 06:45:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CFBE211C7923C;
	Tue,  1 Sep 2026 08:45:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788245149; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UaE3AUwBFLv/HV5738IQzS7QClGRaDYytvnf8R7BOZw=;
	b=g39Qc0Hh8RF/fXRwcqE57liEKzLtqtjL9mQ0IQxupxbRily1EN5mYlOIr9v4ScgYnDyWBf
	WsmZezMEUj9L+Fu7+Cd2H0khiRlgy0ntlkonsYLomh9d908+TTOa7iAlAEJ8aSlkCAisCn
	3eA9d3VR/W/9Q+KNtXZM2vdEa/69hx7TC955v16LlyzOc2qIqOd1ougSXCf5o0PmI/neWv
	dWU+SKWrbL+ga4LlC+gfe/jbm5g8nr9l2O46sPWbGXwQOp+AAYJJX3CKc1tOVSOQxMByOn
	6iEm+OruRJeJTqAFf4hiR4R45n5+zHc2QMVrVC4HiBXtc5WlmZ7aucsgoaw2Sg==
Date: Tue, 1 Sep 2026 08:45:46 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Alex Elder <elder@riscstar.com>
Cc: bhelgaas@google.com, robh@kernel.org, saravanak@kernel.org,
 daniel@riscstar.com, mohd.anwar@oss.qualcomm.com,
 lorenzo.bianconi@oss.qualcomm.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] of: address: kill of_node_is_pcie()
Message-ID: <20260901084546.424c6ef2@bootlin.com>
In-Reply-To: <20260901011338.1323243-5-elder@riscstar.com>
References: <20260901011338.1323243-1-elder@riscstar.com>
	<20260901011338.1323243-5-elder@riscstar.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Alex,

On Mon, 31 Aug 2026 20:13:37 -0500
Alex Elder <elder@riscstar.com> wrote:

> The of_bus->match function for the "PCI" bus type is fairly liberal
> in what it accepts as a PCI bus devicetree node.  If a node has no
> device_type property, it even allows a node named "pcie@" to be
> accepted as represnting a devicetree bus, though it issues a warning
> in that case.
> 
> A recent PCI commit introduced of_pci_verify_node().  When a PCI
> device is added, if it has a devicetree node, that function checks
> its device_type property.  For PCI bridge devices, if there is no
> device_type property (value "pci"), a warning is issued.
> 
> That warning duplicates the warning made by of_node_is_pcie(), and
> there's no point in that.  Avoid the second (OF) warning by just
> checking the node name directly in of_bus_pci_match().
> 
> That leaves of_node_is_pcie() unused, so get rid of it.
> 
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
> v3: - Added (new) in this version of the series
> 
>  drivers/of/address.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 499d37ceae210..ee2eb44884d85 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -134,16 +134,6 @@ static unsigned int of_bus_pci_get_flags(const __be32 *addr)
>   * PCI bus specific translator
>   */
>  
> -static bool of_node_is_pcie(const struct device_node *np)
> -{
> -	bool is_pcie = of_node_name_eq(np, "pcie");
> -
> -	if (is_pcie)
> -		pr_warn_once("%pOF: Missing device_type\n", np);
> -
> -	return is_pcie;
> -}
> -
>  static int of_bus_pci_match(struct device_node *np)
>  {
>  	/*
> @@ -156,7 +146,7 @@ static int of_bus_pci_match(struct device_node *np)
>  	 */
>  	return of_node_is_type(np, "pci") || of_node_is_type(np, "pciex") ||
>  		of_node_is_type(np, "vci") || of_node_is_type(np, "ht") ||
> -		of_node_is_pcie(np);
> +		of_node_name_eq(np, "pcie");
>  }
>  
>  static void of_bus_pci_count_cells(struct device_node *np,

The warning here was printed based on the node name whereas of_node_is_pcie()
prints the message based on the 'device_type' property of a pci_dev node.

For PCI to PCI bridges, no problem the warning is indeed duplicated but what
happens for the PCI host controller?

PCI host controller drivers calls pci_host_probe() and are seen by the PCI core
as a struct pci_host_bridge.

of_node_is_pcie() is called for children of the PCI host controller (i.e. PCI
devices scanned on the PCI bus handled by the host controller) but not for the
PCI host controller itself.

The OF node of the host controller must have the 'device_type' property set
to "pci".

I am not so sure that this warning was duplicated when we consider the PCI
host controller node.

Can you double check on your side?

Best regards,
Hervé
