Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:51493 "EHLO nbd.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754926Ab2EDK4p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 4 May 2012 06:56:45 -0400
Message-ID: <4FA3B596.3050106@openwrt.org>
Date: Fri, 04 May 2012 12:55:18 +0200
From: John Crispin <blogic@openwrt.org>
MIME-Version: 1.0
To: David Daney <ddaney.cavm@gmail.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] OF: PCI: const usage needed by MIPS
References: <1335808019-24502-1-git-send-email-blogic@openwrt.org> <4F9ED1DC.3050007@gmail.com> <4F9FE4F6.5070909@openwrt.org> <CAErSpo4bZ=0=DtbDots_GOGeLNhX6Q4eJrdetaFQMv4iiv5+XA@mail.gmail.com> <4FA32E47.7020406@gmail.com>
In-Reply-To: <4FA32E47.7020406@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi David,

> The problem is when you start declaring function pointers in various
> ops vectors.
>
> Consider:
>
> void (*foo)(const struct pci_dev *)
> void (*bar)(struct pci_dev *)
>
> foo and bar are not type compatible, and you will get compiler
> warnings if you use one where the other is expected.
>
> So the question is:  Are we ever going to the address of any of the
> functions that are being modified?  If so, we have created a problem.
>



i could not find any place in the code where this happens, which does
not mean that there are none.


>> Similar reasoning applies to of_irq_map_pci().
>>
>> So I'm fine with this.  You sent it to Grant, so I'll assume he'll
>> merge it unless I hear otherwise.
>>
>> Acked-by: Bjorn Helgaas<bhelgaas@google.com>
>>
>

Thanks for the Ack, i hope this patch gets accepted as is. I am simply
missing the overview of the pci subsystem to evaluate if this can cause
regressions.


John





