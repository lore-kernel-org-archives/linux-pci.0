Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailsec119.isp.belgacom.be ([195.238.20.115]:19748 "EHLO
	mailsec119.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933155AbbCPUag convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 16 Mar 2015 16:30:36 -0400
Date: Mon, 16 Mar 2015 21:30:32 +0100 (CET)
From: Fabian Frederick <fabf@skynet.be>
Reply-To: Fabian Frederick <fabf@skynet.be>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Michal Simek <michal.simek@xilinx.com>,
	linux-sh@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Simon Horman <horms@verge.net.au>, linux-gpio@vger.kernel.org,
	linux-pci@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	=?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>
Message-ID: <195534809.1144303.1426537832550.open-xchange@webmail.nmp.proximus.be>
In-Reply-To: <55073BC0.3020009@cogentembedded.com>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be> <1426535685-25996-1-git-send-email-fabf@skynet.be> <1426535685-25996-4-git-send-email-fabf@skynet.be> <55073BC0.3020009@cogentembedded.com>
Subject: Re: [PATCH 25/35 linux-next] PCI: constify of_device_id array
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> On 16 March 2015 at 21:23 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> wrote:
>
>
> Hello.
>
> On 03/16/2015 10:54 PM, Fabian Frederick wrote:
>
> > of_device_id is always used as const.
> > (See driver.of_match_table and open firmware functions)
>
> > Signed-off-by: Fabian Frederick <fabf@skynet.be>
> > ---
> >   drivers/gpio/gpio-mpc8xxx.c      | 2 +-
> >   drivers/gpio/gpio-octeon.c       | 2 +-
> >   drivers/gpio/gpio-tz1090-pdc.c   | 2 +-
> >   drivers/gpio/gpio-tz1090.c       | 2 +-
> >   drivers/gpio/gpio-zynq.c         | 2 +-
>
>     What the GPIO driver changes are doing here, in the PCI patch?
Nice catch :) I'll split that patch and only send those to avoid too much noise.

Thanks,
Fabian

>
> >   drivers/pci/host/pci-rcar-gen2.c | 2 +-
> >   drivers/pci/host/pcie-xilinx.c   | 2 +-
> >   7 files changed, 7 insertions(+), 7 deletions(-)
>
> [...]
>
> WBR, Sergei
>
