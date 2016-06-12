Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:36376 "EHLO
	mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319AbcFLN5E (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 12 Jun 2016 09:57:04 -0400
Received: by mail-it0-f41.google.com with SMTP id a5so30218738ita.1
        for <linux-pci@vger.kernel.org>; Sun, 12 Jun 2016 06:57:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1465378523.1870.26.camel@googlemail.com>
References: <1465344472-15703-1-git-send-email-festevam@gmail.com> <1465378523.1870.26.camel@googlemail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 12 Jun 2016 10:51:04 -0300
Message-ID: <CAOMZO5Bix1Bgrsbn2K_1sh7ee=dxRccU1zk2fJei-WU4vvpCgg@mail.gmail.com>
Subject: Re: [PATCH] PCI: imx6: Add support for MX6SX LDO PCIE domain regulator
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Christoph,

On Wed, Jun 8, 2016 at 6:35 AM, Christoph Fritz
<chf.fritz@googlemail.com> wrote:

> There was a discussion doing the handling of the regulator inside the PM
> backend:

Thanks for pointing me to this discussion.

>
>> On Mon, 2016-02-15 at 07:24 +0000, Richard Zhu wrote:
>> > As Lucas discussed with me before,  the GPC regulator operations should[n't] be touched in
>> > Imx pcie driver at all.  These bits operations should be encapsulate into the PM system,
>> >  for example, the regulator driver.
>
> On Thu, 2016-02-18 at 12:59 +0100, Christoph Fritz wrote:
>> Ok, for an initial version, I'll just leave the regulator in my
>> devicetree enabled. For further enhancements I suppose
>> arch/arm/mach-imx/gpc.c needs to get touched?
>>
> @Richard and @Lucas: Any further hints on this?

Yes, would appreciate some hints or examples as to how to properly
handle the PCI LDO regulator on mx6sx.

Thanks
