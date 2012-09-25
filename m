Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hapkido.dreamhost.com ([66.33.216.122]:55987 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753743Ab2IYIlK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2012 04:41:10 -0400
Received: from homiemail-a88.g.dreamhost.com (caiajhbdcbef.dreamhost.com [208.97.132.145])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 0BAACDC147
	for <linux-pci@vger.kernel.org>; Tue, 25 Sep 2012 01:41:10 -0700 (PDT)
Date: Tue, 25 Sep 2012 09:40:04 +0100
From: Jurij Smakov <jurij@wooyd.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org
Subject: Re: [PATCH 20/29] PCI, sparc: kill pci_find_next_bus
Message-ID: <20120925084004.GA6652@wooyd.org>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
 <1348561590-28067-21-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348561590-28067-21-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 25, 2012 at 01:26:21AM -0700, Yinghai Lu wrote:
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> ---
>  arch/sparc/kernel/pci.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
> index acc8c83..70d8c16 100644
> --- a/arch/sparc/kernel/pci.c
> +++ b/arch/sparc/kernel/pci.c
> @@ -997,11 +997,13 @@ static void __devinit pci_bus_slot_names(struct device_node *node,
>  
>  static int __init of_pci_slot_init(void)
>  {
> -	struct pci_bus *pbus = NULL;
> +	struct pci_host_bridge *host_bridge = NULL;
> +	struct pci_bus *pbus;
>  
> -	while ((pbus = pci_find_next_bus(pbus)) != NULL) {
> +	for_each_pci_host_bridge(host_bridge) {
>  		struct device_node *node;
>  
> +		pbus = hot_bridge->bus;

Should this be 'host_bridge' and not 'hot_bridge'?

>  		if (pbus->self) {
>  			/* PCI->PCI bridge */
>  			node = pbus->self->dev.of_node;
> -- 
> 1.7.7
> 
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
