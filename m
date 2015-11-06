Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:35196 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032020AbbKFT7I (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Nov 2015 14:59:08 -0500
Received: by obctp1 with SMTP id tp1so100791238obc.2
        for <linux-pci@vger.kernel.org>; Fri, 06 Nov 2015 11:59:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1446802576.3126.5.camel@pengutronix.de>
References: <1446735481-27326-1-git-send-email-tharvey@gateworks.com>
	<1446802576.3126.5.camel@pengutronix.de>
Date: Fri, 6 Nov 2015 11:59:08 -0800
Message-ID: <CAJ+vNU1ME+LgHohZv1oy9MbZ-Y+U44ihVasjEnvw2AAcr40RHg@mail.gmail.com>
Subject: Re: [PATCH RFC] PCI: imx6: add dt prop for link gen, default to gen1
From: Tim Harvey <tharvey@gateworks.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 6, 2015 at 1:36 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Am Donnerstag, den 05.11.2015, 06:58 -0800 schrieb Tim Harvey:
>> Freescale has stated [1] that the LVDS clock source of the IMX6 does not pass
>> the PCI Gen2 clock jitter test, therefore unless an external Gen2 compliant
>> external clock source is present and supplied back to the IMX6 PCIe core
>> via LVDS CLK1/CLK2 you can not claim Gen2 compliance.
>>
>> Add a dt property to specify gen1 vs gen2 and check this before allowing
>> a Gen2 link.
>>
> I think I already said this in the last round: there is nothing vendor
> specific in a max-link-speed property. I would really like to have this
> as a common DW PCIe property right from the beginning, so that we don't
> burden us with keeping backward compatibility with vendor specific
> properties when this moves to common code eventually.

Hi Lucas,

I did discuss this patch with you off-list but I think I misunderstood
your meaning then.

So you are asking me to simply rename the properly
'fsl,max-link-speed' to 'max-link-speed' and the rest of the patch is
good with you?

Regards,

Tim
