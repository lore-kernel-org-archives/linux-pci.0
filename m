Return-Path: <SRS0=e3W/=SH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496F1C282DC
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 21:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE1721855
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 21:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554499124;
	bh=EmDuMgKZldKwvdgYSsupdRNOccOPaaVD19Lj9XObv/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ucMa7teQyKMWy+kQg8LWDH0NMyYKTGfvb2s0+2dwhYktmjtqTz6xONJ2vfhFRDB7p
	 FWeoB1K4mM4S7lxsL3E/M/WLZ/ZKKXOWgGgIwFbb94gZGUCdHlsWSN9x2FvRXrvisV
	 dhDWIag0o426PElU/As3bPUS80XS5ta7guVsJ9gQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfDEVSn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Apr 2019 17:18:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbfDEVSn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Apr 2019 17:18:43 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4BD02173C;
        Fri,  5 Apr 2019 21:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554499122;
        bh=EmDuMgKZldKwvdgYSsupdRNOccOPaaVD19Lj9XObv/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iA6CV9M6+GWWeAVe1x3iG2yq2cTxpzWgwV09R12dMm4SF4CtJJgM236fGjODQ68Cb
         9c0bbxLJMUEkhHnT1uakGLJSloCqngamKgfxN5BstCHfSU3mGQEOuJVmDisRy+zjQ5
         EhVDd03tFhOFxutOM3JjIvljF/9F2M1puxSs5U4A=
Date:   Fri, 5 Apr 2019 16:18:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Jeremy.Linton@arm.com, Grant.Likely@arm.com, Robin.Murphy@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] PCI: OF: Support external-facing property
Message-ID: <20190405211840.GB159318@google.com>
References: <20190402131548.41949-1-jean-philippe.brucker@arm.com>
 <20190402131548.41949-3-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402131548.41949-3-jean-philippe.brucker@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 02, 2019 at 02:15:48PM +0100, Jean-Philippe Brucker wrote:
> Set the "untrusted" attribute to any PCIe port that has an
> "external-facing" device tree property. Any device downstream of this
> port will inherit the attribute and have only the strictest IOMMU
> protection.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Rob, you can take both of these, or ack the first and I'll take them.

> ---
>  drivers/pci/of.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 3d32da15c215..3e7ac7748d90 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -35,6 +35,9 @@ void pci_set_bus_of_node(struct pci_bus *bus)
>  		bus->dev.of_node = pcibios_get_phb_of_node(bus);
>  	else
>  		bus->dev.of_node = of_node_get(bus->self->dev.of_node);
> +
> +	if (of_get_property(bus->dev.of_node, "external-facing", NULL))
> +		bus->self->untrusted = true;
>  }
>  
>  void pci_release_bus_of_node(struct pci_bus *bus)
> -- 
> 2.21.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
