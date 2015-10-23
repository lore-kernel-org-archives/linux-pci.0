Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:35424 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbbJWGxH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 23 Oct 2015 02:53:07 -0400
Received: by vkex70 with SMTP id x70so5101818vke.2
        for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2015 23:53:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20151022153455.GA16360@localhost>
References: <20151021183741.28724.71281.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<1445504666.3173.20.camel@pengutronix.de>
	<20151022153455.GA16360@localhost>
Date: Fri, 23 Oct 2015 12:23:03 +0530
Message-ID: <CAHM4w1=uMoHs11_ow=o62sp2iHcxjJMusQy9361nxquwM+Su5A@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] PCI: designware: LTSSM #define cleanup
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Murali Karicheri <m-karicheri2@ti.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 22, 2015 at 9:04 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Thu, Oct 22, 2015 at 11:04:26AM +0200, Lucas Stach wrote:
>> I'm not sure if I like the removal of all the LTSSM state defines, as
>> not all reference manuals include them and so I liked to have the header
>> as a reference. But if you prefer to not carry unused defines in the
>> kernel I won't object strongly to the removal.
>>
>> Otherwise the series looks fine, which you may take as a Reviewed-by.
>
> Thanks, Lucas.
>
> OK, I put the rest of the LTSSM #defines back in
> drivers/pci/host/pcie-designware.h as a separate patch (below):
>

Thanks for putting it back. Its useful to debug issues related to link
training, which one finds many a time with new silicon. And as Lucas
pointed, its not mentioned in most of the user manual. I remember, I
had to grep it into RTL code :(.

For the series
Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
