Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45677 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933139AbeBVRMY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Feb 2018 12:12:24 -0500
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.20.1802221710110.1801@5HSWXM1.fritz.box>
References: <20180221124707.26308-1-embedded24@evers-fischer.de>
 <20180221124707.26308-2-embedded24@evers-fischer.de> <CAHp75VfgqqkLq0PbC0SBMCyCLqqoNZcUW0xngjacEL0VtAskmg@mail.gmail.com>
 <alpine.LNX.2.20.1802221710110.1801@5HSWXM1.fritz.box>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 22 Feb 2018 19:12:23 +0200
Message-ID: <CAHp75Vcp=OkkTcM+jey_YqCDo52BOFP0XH4cd8HWmReej=-5dQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] pci: endpoint: Free func_name after last usage
To: Rolf Evers-Fischer <embedded24@evers-fischer.de>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 22, 2018 at 6:21 PM, Rolf Evers-Fischer
<embedded24@evers-fischer.de> wrote:
> On Wed, 21 Feb 2018, Andy Shevchenko wrote:

>> This is a slow path and your change makes code slightly less readable
>> b/c of patterns used in the kernel.
>>
> I see. It is probably not a good idea to free the
> memory in the middle of the function.
> If you don't mind, I will remove this patch and change the other
> one accordingly.

Sounds good to me!

-- 
With Best Regards,
Andy Shevchenko
