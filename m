Return-Path: <SRS0=GqAx=SG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E7CC4360F
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 17:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0582171F
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 17:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2uo5L+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfDDRcv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:32:51 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33794 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfDDRcu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2019 13:32:50 -0400
Received: by mail-lj1-f193.google.com with SMTP id j89so2857965ljb.1
        for <linux-pci@vger.kernel.org>; Thu, 04 Apr 2019 10:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ttXfDlhzKFT3/WQXNSMy0/EwMiU4EkpxXdjFqXysLPE=;
        b=L2uo5L+Z8RXjm3l1v4GGcGXNVObRUs1+8zUephbZHSiwiFxvio3z+W7WFdea5mAo26
         xewkCsz+AXHXi7k4u8nEj/1lLB05I6nequTLRBp8TpwtKvNN8xeHYD7raQqRyRG4i4j4
         UZN8mOltMDjQ+5iXN7qaH7eo/KVfWU85j6yNHTXoGLBbCalR/KmKn09WvACQ/5qDD+J6
         zAlppaKyoiDyaEBOE1IKuukvs4mDJSFBtRDxSIAyfdUTV7DqsTKvz/q1+PCU46oFaSDx
         v7Q0KXm7vL3Dy8sAfVgGpmjtbfbjv0/foiQU2MFWrv7t9GMattaF0h+bx2TF1XOXM2a1
         Jd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ttXfDlhzKFT3/WQXNSMy0/EwMiU4EkpxXdjFqXysLPE=;
        b=W7d2j1ry0tOmplZ2J912YMwU+zNaBFs5FIo30sREQZZs03YHkkQEB4wDWq7P+2DFAG
         CFDJA0ascBfCICftW7+5fBRPyFpW3WlWQFU8s+MRi69gP1Ao+3QV49fS3LRQum86+txK
         QqKk8d9IcNoEvqY7ZOJtJDpB0PuyAfzo1G6xex3+5kwlyE5hJ62uwYJQy1akRqW5gJ0F
         rN1yXRVQk6l8AlVXraSLtJPuyYUUOqbTgo78r7FCxn1FQ/24Tnml9eN8AczHiZvdLbGM
         f1KmjN+H9u2702+0pLHdI4dUehGJYYeuOxWoQMxd5NpSXjclLrWBiFzzqIEqfRY+B/Pj
         4VpQ==
X-Gm-Message-State: APjAAAWxX+btNEE639otjhQD/KiINrGSrC4yv9QRA/DCmlsjMVDfLlK+
        5aeHNR7hv01R3o6yF66bYXMWKIBircsu9CoDZD0=
X-Google-Smtp-Source: APXvYqwBxwtRV3GlMuzoWc29WqND19hwdLLhbdWcfXceYBbC5dn1tHwlRvgH7+Sy72VbCunuW4PS4Y/adn1tvkElzoM=
X-Received: by 2002:a2e:5d94:: with SMTP id v20mr4146947lje.138.1554399168654;
 Thu, 04 Apr 2019 10:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190404164517.17735-1-l.stach@pengutronix.de>
In-Reply-To: <20190404164517.17735-1-l.stach@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 4 Apr 2019 14:32:39 -0300
Message-ID: <CAOMZO5Cycm23RFM=GBME_gGXT=F_oaT-XB2P1eCz8M9T+-DEjA@mail.gmail.com>
Subject: Re: [PATCH] PCI: imx6: Allow async probe
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        patchwork-lst@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lucas,

On Thu, Apr 4, 2019 at 1:46 PM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Establishing a PCIe link can take a while. Allow async probing so all
> this happens in the background while other devices are being probed.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 3d627f94a166..2eb39d5de4f6 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1279,6 +1279,7 @@ static struct platform_driver imx6_pcie_driver = {
>                 .of_match_table = imx6_pcie_of_match,
>                 .suppress_bind_attrs = true,
>                 .pm = &imx6_pcie_pm_ops,
> +               .probe_type = PROBE_PREFER_ASYNCHRONOUS,

This does not seem to be imx6 specific.

Should this be moved to
drivers/pci/controller/dwc/pcie-designware-plat.c instead?

Thanks
