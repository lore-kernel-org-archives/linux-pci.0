Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:48459 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933193AbeBVQVb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Feb 2018 11:21:31 -0500
Date: Thu, 22 Feb 2018 17:21:13 +0100 (CET)
From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
cc: Rolf Evers-Fischer <embedded24@evers-fischer.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
Subject: Re: [PATCH 1/2] pci: endpoint: Free func_name after last usage
In-Reply-To: <CAHp75VfgqqkLq0PbC0SBMCyCLqqoNZcUW0xngjacEL0VtAskmg@mail.gmail.com>
Message-ID: <alpine.LNX.2.20.1802221710110.1801@5HSWXM1.fritz.box>
References: <20180221124707.26308-1-embedded24@evers-fischer.de> <20180221124707.26308-2-embedded24@evers-fischer.de> <CAHp75VfgqqkLq0PbC0SBMCyCLqqoNZcUW0xngjacEL0VtAskmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Wed, 21 Feb 2018, Andy Shevchenko wrote:

> > Change-Id: I0d1b6fd652395b85f82b11c43bf9b7db512854d1
> 
> First of all, this shouldn't be here.
>
Please excuse me. I know that I have to remove this, but
unfortunately I forgot to do so (here and also in the other patch).
 
> > Signed-off-by: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
> > Signed-off-by: Rolf Evers-Fischer <embedded24@evers-fischer.de>
> 
> Looks like bipolar disorder?
>
You are right: One "Signed-off" should be enough.
 
> To the topic.
> This is a slow path and your change makes code slightly less readable
> b/c of patterns used in the kernel.
> 
I see. It is probably not a good idea to free the
memory in the middle of the function.
If you don't mind, I will remove this patch and change the other
one accordingly.

With best regards,
Rolf Evers-Fischer
