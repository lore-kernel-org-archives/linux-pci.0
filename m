Return-Path: <SRS0=2mbU=OH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA56C43441
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 00:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BDF620645
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 00:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0nGH1Cv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BDF620645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbeK1L41 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Nov 2018 06:56:27 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44353 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeK1L40 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Nov 2018 06:56:26 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so20262678wrt.11;
        Tue, 27 Nov 2018 16:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UiJUATK56KU7YvCJTkJPNJNjxtAM8klz/1yQMp2SjLw=;
        b=A0nGH1Cv2GWH19BUDlZvf46hNNSCCWywT7uoDF3MJCDier6byJ4xw7XVmm5X4Zwt1R
         pYf0JO7FD1MYwxctGcZnYlfa1gpNnnZ3Pp13NjxI/Ccm8K2WApElGTXZhhDiNHlWKYgm
         VcSTiz2BC7yHkuYx3CxeHCtJWChVtdHn2wxxttH/bIJahc3Gi8OdBnZcIqhNQRRLsx8z
         UEDYBr5PAIp4SJ3xxZWZJJadG0B56JWeEII2Vo1Spc0vNHkSIH/GgvNpwm8eYt+yitCw
         jTZAkjUmy9pPKgMHCXnJRG8AUyRN3M1v4nGDtgNvcNXnqLsrFCnP+5QyD8zwxDIfFKId
         4zbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UiJUATK56KU7YvCJTkJPNJNjxtAM8klz/1yQMp2SjLw=;
        b=kyz3OPev5hfI7OwUN/AeW1SyhAqEBKBqKYVVA5zg4kNsAunUEe+ze+3feQcgKeIzcl
         9kxANoiKwmAG6mb7Gz9+YgL97hOt3XEiSzGWzCiUKP8BNCume+/skI+pJj3b7j7YtS28
         sjgokYdbayYksKUU5m0lpPwvQTpesJY9batuQNS+053yknYqmhMPj2pDjalo0eTjy4CZ
         xfdlrrcDc/QsAhphZz/4V/uOppmAH519Ee/7cizr7amqvgEdShz0htMBFtYLLjqfojy5
         Srw85BPkk8HJIiaU1Q0SBpMXJocJqMF6fwjnemvX4nvf6cmZ2pjyB6pUOJ+Q9/5d9p2H
         bkPQ==
X-Gm-Message-State: AA+aEWbEKZQBoAWnkyQbVpD+tOd6B2KDpkCogS76NBJn2LYQnV0ZI6v+
        9MMkrZs2JE84i1sjnxLrfmTBNO/SzEPSYvUrhIY=
X-Google-Smtp-Source: AFSGD/W3iktIVjLJsz7c8meC5cTEumhDqKbNL9T6rAYsEJ2uVwKwkWJInnxo3Pl32bnjGQX0GZjgkghVjX2gH+iepfE=
X-Received: by 2002:a5d:69c9:: with SMTP id s9mr22962135wrw.129.1543366601707;
 Tue, 27 Nov 2018 16:56:41 -0800 (PST)
MIME-Version: 1.0
References: <20181120132705.6917-1-stefan@agner.ch> <20181120132705.6917-3-stefan@agner.ch>
In-Reply-To: <20181120132705.6917-3-stefan@agner.ch>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Tue, 27 Nov 2018 16:56:30 -0800
Message-ID: <CAHQ1cqEfjqtJbb6qxTRa-rVvgy8+_Og4Eh21XMRETJHnRG9a6w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] PCI: imx6: limit DBI register length
To:     Stefan Agner <stefan@agner.ch>
Cc:     Jingoo Han <jingoohan1@gmail.com>, gustavo.pimentel@synopsys.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Trent Piepho <tpiepho@impinj.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 20, 2018 at 9:43 AM Stefan Agner <stefan@agner.ch> wrote:
>
> Define the length of the DBI registers. This makes sure that
> the kernel does not access registers beyond that point, avoiding
> the following abort on a i.MX 6Quad:
>   # cat /sys/devices/soc0/soc/1ffc000.pcie/pci0000\:00/0000\:00\:00.0/config
>   [  100.021433] Unhandled fault: imprecise external abort (0x1406) at 0xb6ea7000
>   ...
>   [  100.056423] PC is at dw_pcie_read+0x50/0x84
>   [  100.060790] LR is at dw_pcie_rd_own_conf+0x44/0x48
>   ...

Could this be a regression? Prior to 415b6185c541 ("PCI: imx6: Fix
config read timeout handling") all of the imprecise aborts were caught
and handled via no-op handler. I did an experiment on i.MX6Q board
that I have (ZII RDU2) and adding a simple no-op for imprecise aborts
via

hook_fault_code(16 + 6, imx6q_pcie_no_op_handler, SIGBUS, 0,
                       "imprecise external abort");

seems to "resolve" this problem:

hexdump /sys/devices/soc0/soc/1ffc000.pcie/pci0000\:00/0000\:00\:00.0/config
0000000 16c3 abcd 0547 0010 0001 0604 0010 0001
0000010 0000 01c0 0000 0000 0100 00ff 1010 0000
0000020 0100 01b0 fff0 0000 0000 0000 0000 0000
0000030 0000 0000 0040 0000 0000 0000 012a 0001
0000040 5001 dbc3 0000 0000 0000 0000 0000 0000
0000050 7005 0181 c000 7e27 0000 0000 0000 0000
0000060 0000 0000 0000 0000 0000 0000 0000 0000
0000070 0010 0042 8000 0000 201f 0010 cc11 0013
0000080 0040 3011 0000 0000 03c0 0040 0008 0000
0000090 0000 0000 001f 0000 0000 0000 0002 0000
00000a0 0002 0001 0000 0000 0000 0000 0000 0000
00000b0 0000 0000 0000 0000 0000 0000 0000 0000
*
0000100 0001 1401 0000 0000 0000 0000 2030 0006
0000110 0000 0000 2000 0000 00a0 0000 0000 0000
0000120 0000 0000 0000 0000 0000 0000 0007 0000
0000130 0000 0000 0000 0000 0000 0000 0000 0000
0000140 0002 0001 0000 0000 0000 0000 0000 0000
0000150 0000 0000 00ff 8000 0000 0000 0000 0000
0000160 0000 0000 0000 0000 0000 0000 0000 0000
*
0000700 0076 0163 ffff ffff 0004 0700 2c00 1b2c
0000710 0120 0001 0000 0000 8000 0000 0280 0000
0000720 0000 0000 0001 0000 b611 03d5 0410 0800
0000730 4020 0000 4004 0000 ffff 000f 0000 0000
0000740 000f 0000 0000 0000 c019 0020 c003 0020
0000750 0000 0080 0000 0000 0000 0000 0000 0000
0000760 0000 0000 0000 0000 0000 0000 0000 0000
*
0000800 0000 0000 0000 0000 0000 0000 012c 0000
0000810 0000 0000 0000 0000 0302 0000 0000 0000
0000820 c000 7e27 0000 0000 0001 0000 0000 0000
0000830 0000 0000 0000 0000 0000 0000 0000 0000
*
0000900 0001 0000 0002 0000 0000 8000 0000 01f8
0000910 0000 0000 ffff 01f8 0000 0000 0000 0000
0000920 0000 0000 0000 0000 0000 0000 0000 0000
*
0001000

Maybe a simple fix would be to install such a handler when running on i.MX6Q?

Thanks,
Andrey Smirnov

>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 7ac1a639fe91..41d6127b40ad 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -41,6 +41,7 @@ enum imx6_pcie_variants {
>
>  struct imx6_pcie_drvdata {
>         enum imx6_pcie_variants variant;
> +       int                     dbi_length;
>  };
>
>  struct imx6_pcie {
> @@ -779,6 +780,8 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>                 break;
>         }
>
> +       pci->dbi_length = imx6_pcie->drvdata->dbi_length;
> +
>         /* Grab GPR config register range */
>         imx6_pcie->iomuxc_gpr =
>                  syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
> @@ -839,7 +842,7 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
>  }
>
>  static const struct imx6_pcie_drvdata drvdata[] = {
> -       [IMX6Q] = { .variant = IMX6Q },
> +       [IMX6Q] = { .variant = IMX6Q, .dbi_length = 0x15c },
>         [IMX6SX] = { .variant = IMX6SX },
>         [IMX6QP] = { .variant = IMX6QP },
>         [IMX7D] = { .variant = IMX7D },
> --
> 2.19.1
>
