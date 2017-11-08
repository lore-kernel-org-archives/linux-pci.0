Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:53506 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751910AbdKHLA3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Nov 2017 06:00:29 -0500
Received: by mail-lf0-f66.google.com with SMTP id l23so2608019lfk.10
        for <linux-pci@vger.kernel.org>; Wed, 08 Nov 2017 03:00:29 -0800 (PST)
Subject: Re: [PATCH 1/3] PCI: rcar: Add the initialization of PCIe link in
 resume_noirq
To: Marek Vasut <marek.vasut@gmail.com>, linux-pci@vger.kernel.org
Cc: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20171108092806.10335-1-marek.vasut+renesas@gmail.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <677fb0a8-de66-46d3-cdf6-512ca2a9d27e@cogentembedded.com>
Date: Wed, 8 Nov 2017 14:00:27 +0300
MIME-Version: 1.0
In-Reply-To: <20171108092806.10335-1-marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/8/2017 12:28 PM, Marek Vasut wrote:

> From: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
> 
> Reestablish the PCIe link very early in the resume process in case it
> went down to prevent PCI accesses from hanging the bus. Such accesses
> can happen early in the PCI resume process, in the resume_noirq, thus
> the link must be reestablished in the resume_noirq callback of the
> driver.
> 
> Signed-off-by: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
>   drivers/pci/host/pcie-rcar.c | 31 ++++++++++++++++++++++++++++---
>   1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index 889603783f01..aa588a7d4811 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
[...]
> @@ -529,7 +530,7 @@ static void phy_write_reg(struct rcar_pcie *pcie,
>   	phy_wait_for_ack(pcie);
>   }
>   
> -static int rcar_pcie_wait_for_dl(struct rcar_pcie *pcie)
> +static int rcar_pcie_wait_for_dl(struct rcar_pcie *pcie, int atomic)

    How about *bool* atomic?

[...]

MBR, Sergei
