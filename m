Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:41330 "EHLO
        nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755569AbcL0A0J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Dec 2016 19:26:09 -0500
Date: Tue, 27 Dec 2016 01:19:47 +0100
From: Martin Mares <mj@ucw.cz>
To: Satanand Burla <satananda.burla@caviumnetworks.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] pciutils: Add decode for Atomic Ops in lspci
Message-ID: <mj+md-20161227.001441.74860.nikam@ucw.cz>
References: <1482797232-13210-1-git-send-email-satananda.burla@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1482797232-13210-1-git-send-email-satananda.burla@caviumnetworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi!

> This adds support for decoding Atomic Ops added in the following ECN
> https://pcisig.com/sites/default/files/specification_documents/ECN_Atomic_Ops_080417.pdf

In general, I would like to have Atomic Ops support in lspci,
but your patch has a couple of issues.

First of all, its coding style is inconsistent with the rest of the
code (and also with itself).

>  #define  PCI_EXP_DEV2_TIMEOUT_DIS	0x0010	/* Completion Timeout Disable Supported */
> +#define  PCI_EXP_DEV2_ATOMICOP_REQUESTER_EN	0x0040	/*AtomicOp RequesterEnable */
> +#define  PCI_EXP_DEV2_ATOMICOP_EGRESS_BLOCK	0x0080	/*AtomicOp Egress Blocking */

Coding style: comments.

> +static int
> +device_has_memory_space_bar(struct device *d)
> +{
> +  struct pci_dev *p = d->dev;
> +  int i,cnt = 0, found = 0;

Coding style: spaces.

> +  byte htype = get_conf_byte(d, PCI_HEADER_TYPE) & 0x7f;
> +
> +  switch (htype)
> +    {
> +    case PCI_HEADER_TYPE_NORMAL:
> +      cnt=6;
> +      break;
> +    case PCI_HEADER_TYPE_BRIDGE:
> +      cnt=2;
> +      break;
> +    case PCI_HEADER_TYPE_CARDBUS:
> +      cnt = 1;
> +      break;
> +    default:
> +      return 0;
> +    }
> +
> +  for (i=0; i<cnt; i++)
> +    {
> +      pciaddr_t pos = p->base_addr[i];
> +      pciaddr_t len = (p->known_fields & PCI_FILL_SIZES) ? p->size[i] : 0;
> +      u32 flg = get_conf_long(d, PCI_BASE_ADDRESS_0 + 4*i);
> +      if (flg == 0xffffffff)
> +        flg = 0;
> +      if (!pos && !flg && !len)
> +        continue;
> +      if ((flg & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_MEMORY)
> +        {
> +          found = 1;
> +          break;
> +	 }
> +    }
> +  return found;
> +}

I do not understand why this is so complicated. Just ask pci_fill_info()
for PCI_FILL_BASES and use p->base_addr[]. No need to touch the config
registers, no need to switch on header type.

>  static void cap_express_dev2(struct device *d, int where, int type)
>  {
>    u32 l;
> @@ -973,9 +1013,18 @@ static void cap_express_dev2(struct device *d, int where, int type)
>  	FLAG(l, PCI_EXP_DEVCAP2_LTR),
>  	cap_express_devcap2_obff(PCI_EXP_DEVCAP2_OBFF(l)));
>    if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_DOWNSTREAM)
> -    printf(" ARIFwd%c\n", FLAG(l, PCI_EXP_DEV2_ARI));
> -  else
> -    printf("\n");
> +    printf(" ARIFwd%c", FLAG(l, PCI_EXP_DEV2_ARI));
> +  printf("\n\t\t\t");
> +  if ((type == PCI_EXP_TYPE_ROOT_PORT) || (type == PCI_EXP_TYPE_UPSTREAM) ||
> +      (type == PCI_EXP_TYPE_DOWNSTREAM))

Coding style: superfluous parentheses.

> +    printf(" AtomicOP Routing%c", FLAG(l, PCI_EXP_DEVCAP2_ATOMICOP_ROUTING));
> +  if (type == PCI_EXP_TYPE_ROOT_PORT || device_has_memory_space_bar(d))
> +    {
> +      printf(" 32bit AtomicOP Completer%c", FLAG(l, PCI_EXP_DEVCAP2_32BIT_ATOMICOP_COMP));
> +      printf(" 64bit AtomicOP Completer%c", FLAG(l, PCI_EXP_DEVCAP2_64BIT_ATOMICOP_COMP));
> +      printf(" 128bit CAS Completer%c", FLAG(l, PCI_EXP_DEVCAP2_128BIT_CAS_COMP));
> +    }
> +  printf("\n");

This does not look good. It might write an empty line (if no condition
matches), it will write a space after a tab, and the output will be
hard to comprehend.

What about output like this?

	AtomicOPs: Routing+ 32bit+ 64bit- 128bitCAS-

>    if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_DOWNSTREAM)
> -    printf(" ARIFwd%c\n", FLAG(w, PCI_EXP_DEV2_ARI));
> -  else
> -    printf("\n");
> +    printf(" ARIFwd%c", FLAG(w, PCI_EXP_DEV2_ARI));
> +  printf("\n\t\t\t");
> +  if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_ENDPOINT)
> +    printf(" AtomicOp Requester En%c", FLAG(w, PCI_EXP_DEV2_ATOMICOP_REQUESTER_EN));
> +  if ((type == PCI_EXP_TYPE_ROOT_PORT) || (type == PCI_EXP_TYPE_UPSTREAM) ||
> +      (type == PCI_EXP_TYPE_DOWNSTREAM))
> +    printf(" AtomicOP Egress Blocking%c", FLAG(l, PCI_EXP_DEV2_ATOMICOP_EGRESS_BLOCK));
> +  printf("\n");

Same here.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"C++: an octopus made by nailing extra legs onto a dog." -- Steve Taylor
