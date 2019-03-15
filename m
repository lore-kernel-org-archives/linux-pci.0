Return-Path: <SRS0=ivaI=RS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFACC43381
	for <linux-pci@archiver.kernel.org>; Fri, 15 Mar 2019 02:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB00B218A1
	for <linux-pci@archiver.kernel.org>; Fri, 15 Mar 2019 02:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbHXOP3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfCOC0c (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 14 Mar 2019 22:26:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39614 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727284AbfCOC0b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Mar 2019 22:26:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id p8so7947282wrq.6;
        Thu, 14 Mar 2019 19:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ptlz0Z5uqx11HivWwUhAT0xhoM6MDZEYWnSilM25v3w=;
        b=SbHXOP3RuBdBxbxYE9V97n3nJlWr2WCF18PHip1j/CFpCNrxcEnAuYOLXpS7YO8IZA
         UrA0rBNlR1MGwLsyMneTV71f4n59rEDuPzvoPeUWBpYnqwHXBGBc79hTj16kGHzm/WaO
         NkovufVewmDHjH+plTlO8hK2hhbap08ACH5shErJ6kMyOHA2ICVPurr4MIwtTzNB16QC
         oUlSuL4XefustMzuH1ZyseUWMFs9k2gcaFHdipKbU9UhGogAbS5rBvyGtUQJWopV+ZoT
         CpKxx0FPzXi77waUxw7yr2vdR+lQNK8pblTSlE2WE9SdtyXTt5pkkrqDy62F5ScIkCRX
         0Sdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ptlz0Z5uqx11HivWwUhAT0xhoM6MDZEYWnSilM25v3w=;
        b=n/Vki1RCUpmbC2LG3ei1vNMric1BLFL67hUNOUpG3652z8gdimNHq5RynKiopsjvI0
         EluWT7HqcslXWZxiHBRWuTnWFGu2eV2JquGIDHBk8CbqAdRn5ONdjPjKq87D4KtG2AL3
         xVJkj9LrAW3IT8A2b33pJ26/5AoR+eFEp+ONmWGHnqOUjEWETPuhjSHrwIsK8w2jnXGX
         7Ze021xc34c/Iwt+5GzgzwVq0kMwpQxw994dcrn04EGJGnWJHyjlCvUcqBUMV9mSfEcW
         khUs1ohLpUKUkI5wcoWb4cH4u0NihOqmbE0iNaHQzUdrMk4wMO7ta1IdhYnz1NAIKRb2
         uupQ==
X-Gm-Message-State: APjAAAVFbDhiWEoBiRS49uuv2e46utQCMHEF3uQuMSp5UjG5yZ+A/EqD
        zWcF8c6ercykoktanw8Pq2hZJZtg3Wc62aCCjE8=
X-Google-Smtp-Source: APXvYqz40YxIMCaN+vTpwftFbBPztiZBKEwBt+VEEFQFpPNjT0wNr3EO0wCSWUmuBTseHWrD7dZpWq38QdHRK0tydpY=
X-Received: by 2002:adf:a147:: with SMTP id r7mr571038wrr.5.1552616789596;
 Thu, 14 Mar 2019 19:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <1552467452-538-1-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1552467452-538-1-git-send-email-hongxing.zhu@nxp.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 14 Mar 2019 19:26:18 -0700
Message-ID: <CAHQ1cqFK36Qh8BW-0Nd+rZra2m1=et7aAWBwD-GkLU4VwvOAWg@mail.gmail.com>
Subject: Re: [RFC 1/2] dt-bindings: imx6q-pcie: Add support for i.MX8QM/QXP PCIe
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 13, 2019 at 2:15 AM Richard Zhu <hongxing.zhu@nxp.com> wrote:
>
> Add codes needed to support i.MX8QM/QXP PCIe.
> - HSIO(High Speed IO) subsystem is new defined on i.MX8QM/QXP.
>   The PCIe and SATA modules are contained in the HSIO subsystem. There
>   are two PCIe, one SATA controllers and three mixed lane PHYs on
>   i.MX8QM. There are three use cases of the HSIO subsystem on i.MX8QM.
>   1. PCIea 2 lanes and one SATA AHCI port.
>   2. PCIea 1 lane, PCIeb 1 lane and one SATA AHCI port.
>   3. PCIea 2 lanes, PCIeb 1 lane.
>   i.MX8QXP only has PCIeb controller and one lane PHY.
>   Use the hsio-cfg property to specify the different modes.
> - The HSIO address map as viewed from system level is as shown below.
>   address [31:24]    Local address    Target    Address Size
>   5F                 0                HSIO      16MB
>   60-6F              40-4F            HSIO      256MB
>   70-7F              80-8F            HSIO      256MB
>   The property local-addr is required to specify it.
> - Both external OSC and internal PLL can be used as PCIe reference
>   clock, use the ext_osc property to distinguish them.
> - clock request GPIO for controlling the PCI reference clock request
>   signal. And should be configure OD when L1SS maybe enabled later.
> - One more power domain HSIO_GPIO and clock PCIE_PER are required by
>   i.MX8QM/QXP PCIe.
>   Add these specific properties to enable i.MX8QM/QXP PCIe.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt      | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> index a7f5f5a..f7586c9 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> @@ -10,6 +10,8 @@ Required properties:
>         - "fsl,imx6qp-pcie"
>         - "fsl,imx7d-pcie"
>         - "fsl,imx8mq-pcie"
> +       - "fsl,imx8qm-pcie"
> +       - "fsl,imx8qxp-pcie"
>  - reg: base address and length of the PCIe controller
>  - interrupts: A list of interrupt outputs of the controller. Must contain an
>    entry for each entry in the interrupt-names property.
> @@ -38,6 +40,10 @@ Optional properties:
>    The regulator will be enabled when initializing the PCIe host and
>    disabled either as part of the init process or when shutting down the
>    host.
> +- clkreq-gpio: Should specify the GPIO for controlling the PCI reference clock
> +  request signal.
> +- ext_osc: External OSC is used as PCIe reference clock or not. 0: Internal
> +  PLL. 1: External OSC.

Forgot to mention one thing in my very first reply, so I'll mention it
here. I think figuring out the way to add support for external vs
internal reference bus clock (that "ext_osc" binding above) is going
to be a whole other discussion. It might be easier/more expedient to
focus on just one particular use-case first (say external oscillator
only), get it all done and accepted and then return to this particular
feature in a separate series/discussion. However, that's just how I'd
approach this, so, please don't feel compelled to do it that way just
because I suggested it.

Thanks,
Andrey Smirnov
