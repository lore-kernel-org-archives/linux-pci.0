Return-Path: <SRS0=SqGm=OQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8E2C07E85
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 04:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404972081C
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 04:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRMyYvXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404972081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbeLGEz1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 6 Dec 2018 23:55:27 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37059 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGEz1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Dec 2018 23:55:27 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so3173063wmd.2;
        Thu, 06 Dec 2018 20:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FI059+PUySrZpDCKnJZdfS9mUaz4H0QkSomxsjPgG5U=;
        b=jRMyYvXIn6Oo8/NyHT6lKnQ/fYpPc5iq1bfKOvGZ8J4AiFCsE0qM8W8JLnbkq9lr2v
         a+l6ViDkWrw5dSJ2lokitm2wpniqllwYVoPNDyJXCLFbbq+1LP7P6JsepqaulNisRBiR
         vD2cBHvNzC5ZCpuhzzfFpkD0/wFQ7H3tEHzObV+/wGOEuIiB7JLJdv1rk6oCl1BBfri4
         y9Gwl7aBAqiFeUA0/67Z53B/LP2AXgdJQkNVbm7izI7QYJB25AnIOM+EjnJ0g9UNEY5e
         ZQaANRRV+fp6e5S6HRMDkO77ZAzwpbfjIaLq5LlX6FAFsPEgvN29J5BE+/mxQRaNHaJa
         nLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FI059+PUySrZpDCKnJZdfS9mUaz4H0QkSomxsjPgG5U=;
        b=PYxUszvZjoU9UhEW16+PgvuUYnrdINsgyegDkEWFHeHUaKxxQS3wkk8EqiGwSA+hvV
         IpkvwhwCLDRhu7LEIFWq4+mq9UK/Y+kiJUO3h9OChB8Ys057ktw87YUyQ+IEppqogHf4
         6FkEVovGGnnIST1WksWBStepKLfS4V2SMFBTruId55481pawJEEm7Kh+BuKlffE84meC
         GX1xgy/ipEAfqCmjIHB5/dyLUogHts/rbI4AW9Qkrj2FrklJ42xjeICnIct5rNP8RDn0
         ROJlseyForx4Y4UrP+nmPx1dekcbo990k3e5xTIcSJzyczWbk/jwhYHrrgSkCFfBw+/D
         Qlew==
X-Gm-Message-State: AA+aEWaR7nzHSXl7U0pj9tKjy8Bjf9VzR/nbpg3YJGxE/AMjNN9YQlx3
        AJLWSltbwX9kd/1j9yMbw3QwP5L7d2PwVC4UeUc=
X-Google-Smtp-Source: AFSGD/X1UJ4ujP4WZtgCTKzMuE45UOnd6c+UV6ew0wwcdhBostzHDDOdXy27O5Pk6YDMNCbU2L9BohQk4HEt8AXhzls=
X-Received: by 2002:a1c:5585:: with SMTP id j127-v6mr769633wmb.127.1544158525164;
 Thu, 06 Dec 2018 20:55:25 -0800 (PST)
MIME-Version: 1.0
References: <20181206074555.19579-1-andrew.smirnov@gmail.com> <1544092136.3709.57.camel@pengutronix.de>
In-Reply-To: <1544092136.3709.57.camel@pengutronix.de>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 6 Dec 2018 20:55:13 -0800
Message-ID: <CAHQ1cqFeJtxnpfzqWVQ3T9Sv=gfw+cvZZw-uKnZV7pxJg_S+EA@mail.gmail.com>
Subject: Re: [PATCH] PCI: controller: dwc: Make PCI_IMX6 depend on PCIEPORTBUS
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 6, 2018 at 2:28 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Am Mittwoch, den 05.12.2018, 23:45 -0800 schrieb Andrey Smirnov:
> > Building a kernel with CONFIG_PCI_IMX6=y, but CONFIG_PCIEPORTBUS=n
> > produces a system where built-in PCIE bridge (16c3:abcd) isn't bound
> > to pcieport driver. This, in turn, results in a PCIE bus that is
> > capable of enumerating attached PCIE device, but lacks functional
> > interrupt support.
>
> This is odd. AFAIK PCI port services are a totally optional thing and
> them being absent should not lead to a non-functional PCI bus. So I
> would really like to see some deeper analysis what is going on here.
>

AFAICT, this is due to pcieport driver enabling MSI of the bridge
device (16c3:abcd) via pcie_port_device_register() ->
pcie_init_service_irqs() -> pcie_port_enable_irq_vec() -> etc.

I did an experiment on a i.MX8MQ/PCIE -> i210 setup I have: I disabled
CONFIG_PCIEPORTBUS and hacked igb_main.c enough to make the i210
driver believe it should fall back onto legacy interrupts. Even
without pcieport present in the system, i210 worked as expected via
legacy interrupts, which seems to collaborate my conjecture above.

Thanks,
Andrey Smirnov
