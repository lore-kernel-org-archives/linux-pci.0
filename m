Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:33934 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932735AbbCPUXd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Mar 2015 16:23:33 -0400
Received: by lagg8 with SMTP id g8so50214732lag.1
        for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2015 13:23:31 -0700 (PDT)
Message-ID: <55073BC0.3020009@cogentembedded.com>
Date: Mon, 16 Mar 2015 23:23:28 +0300
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
To: Fabian Frederick <fabf@skynet.be>, linux-kernel@vger.kernel.org
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Michal Simek <michal.simek@xilinx.com>,
	=?windows-1252?Q?S=F6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
	Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org
Subject: Re: [PATCH 25/35 linux-next] PCI: constify of_device_id array
References: <1426533469-25458-1-git-send-email-fabf@skynet.be> <1426535685-25996-1-git-send-email-fabf@skynet.be> <1426535685-25996-4-git-send-email-fabf@skynet.be>
In-Reply-To: <1426535685-25996-4-git-send-email-fabf@skynet.be>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello.

On 03/16/2015 10:54 PM, Fabian Frederick wrote:

> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)

> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
>   drivers/gpio/gpio-mpc8xxx.c      | 2 +-
>   drivers/gpio/gpio-octeon.c       | 2 +-
>   drivers/gpio/gpio-tz1090-pdc.c   | 2 +-
>   drivers/gpio/gpio-tz1090.c       | 2 +-
>   drivers/gpio/gpio-zynq.c         | 2 +-

    What the GPIO driver changes are doing here, in the PCI patch?

>   drivers/pci/host/pci-rcar-gen2.c | 2 +-
>   drivers/pci/host/pcie-xilinx.c   | 2 +-
>   7 files changed, 7 insertions(+), 7 deletions(-)

[...]

WBR, Sergei

