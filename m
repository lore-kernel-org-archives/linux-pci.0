Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52326 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754426AbcCCRf0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 3 Mar 2016 12:35:26 -0500
Date: Thu, 3 Mar 2016 11:35:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] Fix NULL ptr dereference in pci_bus_assign_domain_nr()
 on ARM
Message-ID: <20160303173522.GA9189@localhost>
References: <m337sapw89.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <m337sapw89.fsf@t19.piap.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Krzysztof,

On Tue, Mar 01, 2016 at 07:07:18AM +0100, Krzysztof Hałasa wrote:
> Many ARM platforms use a wrapper:
> /*
>  * Compatibility wrapper for older platforms that do not care about
>  * passing the parent device.
>  */
> static inline void pci_common_init(struct hw_pci *hw)
> {
>         pci_common_init_dev(NULL, hw);
> }
> 
> which means that pci_bus_assign_domain_nr() can be called without
> a parent. This patch fixes the NULL pointer dereference.

What exactly is the impact of this?  Does this fix need to be in v4.5?
It sounds like it should be, but I need a little more detailed
justification, e.g., "platforms X, Y, Z don't boot at all without
this change."

> Signed-off-by: Krzysztof Hałasa <khalasa@piap.pl>
> Cc: stable@vger.kernel.org
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 602eb42..f89db3a 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4772,8 +4772,10 @@ int pci_get_new_domain_nr(void)
>  void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
>  {
>  	static int use_dt_domains = -1;
> -	int domain = of_get_pci_domain_nr(parent->of_node);
> +	int domain = -1;
>  
> +	if (parent)
> +		domain = of_get_pci_domain_nr(parent->of_node);
>  	/*
>  	 * Check DT domain and use_dt_domains values.
>  	 *
> 
> -- 
> Krzysztof Halasa
> 
> Industrial Research Institute for Automation and Measurements PIAP
> Al. Jerozolimskie 202, 02-486 Warsaw, Poland
