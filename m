Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:45437 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752157AbdCIIxu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2017 03:53:50 -0500
Subject: Re: Quick question on PCI EP framework
To: Primoz Fiser <primoz.fiser@norik.com>, <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <bc702b72-bf0f-d894-6408-40f4e721057e@norik.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <58C115ED.9040305@ti.com>
Date: Thu, 9 Mar 2017 14:14:29 +0530
MIME-Version: 1.0
In-Reply-To: <bc702b72-bf0f-d894-6408-40f4e721057e@norik.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

+Richard Zhu, Lucas Stach, linux-pci

Hi Primoz,

On Thursday 09 March 2017 01:48 PM, Primoz Fiser wrote:
> Hello Kishon,
> 
> I have a quick question on newly released PCI EP framework by you!
> 
> First of all, thank you for providing such a comprehensive framework.
> 
> And here is my question, is i.MX6Q with designware PCIe IP capable of providing
> EP functionality through your framework? Do we need specific IP core version?

I'm not sure of the exact version used in i.MX6Q. Richard Zhu or Lucas Stach
who maintain the PCI driver might have that information.
> 
> If yes, we probably need to port stuff from dra7xx right?

Yes, I think some porting will be required (designware core driver already
supports EP mode only the i.MXQ specific part have to be modified).

Thanks
Kishon
