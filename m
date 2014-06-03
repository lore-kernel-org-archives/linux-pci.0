Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:46514 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932800AbaFCOu4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jun 2014 10:50:56 -0400
Received: by mail-ie0-f173.google.com with SMTP id lx4so6006914iec.4
        for <linux-pci@vger.kernel.org>; Tue, 03 Jun 2014 07:50:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1401801767.5422.4.camel@weser.hi.pengutronix.de>
References: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
 <20140424175844.GD29593@google.com> <1398421265.4657.25.camel@weser.hi.pengutronix.de>
 <CAErSpo7Boi8d+apAUC3TmmE33LuRMYJ6J+TEPLRbeyZyU3O8RQ@mail.gmail.com>
 <1398774686.4677.12.camel@weser.hi.pengutronix.de> <1399885183.5016.4.camel@weser.hi.pengutronix.de>
 <20140530173053.GF4607@google.com> <1401801767.5422.4.camel@weser.hi.pengutronix.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 3 Jun 2014 08:50:35 -0600
Message-ID: <CAErSpo5hP6UYbCVMu_43ezbrNvd0-BBW_KOVbcd_Uj4MHRao2Q@mail.gmail.com>
Subject: Re: [PATCH 0/8] i.MX6 PCIe binding change and MSI support
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Richard Zhu <r65037@freescale.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Marek Vasut <marex@denx.de>, Arnd Bergmann <arnd@arndb.de>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Tim Harvey <tharvey@gateworks.com>,
	Jingoo Han <jg1.han@samsung.com>,
	linux-samsung-soc@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
	Mark Rutland <mark.rutland@arm.com>,
	Shawn Guo <shawn.guo@linaro.org>, Sean Cross <xobs@kosagi.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 3, 2014 at 7:22 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Hello Bjorn,
>
> Am Freitag, den 30.05.2014, 11:30 -0600 schrieb Bjorn Helgaas:
>> On Mon, May 12, 2014 at 10:59:43AM +0200, Lucas Stach wrote:
>> > Hi Bjorn,
>> >
>> > just a friendly reminder. It would be nice if you could pull those in.
>> >
>> > Shawn already pulled the DT change and as it is a binding change this
>> > means PCIe on i.MX6 is broken in -next, as long as the remaining patches
>> > are missing.
>>
>> I applied these to pci/host-imx6 for v3.16.
>>
>> Sorry I didn't do this sooner; I get a lot of email and it's easy to
>> overlook things.  I mostly work from patchwork
>> (http://patchwork.ozlabs.org/project/linux-pci/list/?order=date), and I had
>> dropped this series from there because there was enough discussion that I
>> expected a re-post, so it wasn't on my radar screen anymore.
>>
>> Bjorn
>>
>> > Am Dienstag, den 29.04.2014, 14:31 +0200 schrieb Lucas Stach:
>> > > Hi Bjorn,
>> > >
>> > > Am Freitag, den 25.04.2014, 08:39 -0600 schrieb Bjorn Helgaas:
>> > > [...]
>> > > > >> >   PCI: designware: split Exynos and i.MX bindings
>
> It seems you missed this one patch. This isn't too urgent, as it is just
> the doc update, but it should still go into 3.16 along with the other
> changes. I would have expected that is ok for this to go through your
> tree.

Oops, sorry.  I had mentioned patches 4-8 earlier in the conversation,
so that's what I merged.

I added patch 2 to pci/host-imx6, and I'll ask Linus to pull it later
along with some other things I forgot.  Thanks for the reminder!

Bjorn
