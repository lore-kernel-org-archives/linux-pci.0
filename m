Return-Path: <SRS0=Cddw=OF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40131C43441
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 18:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086DE20865
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 18:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCfWeVoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086DE20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbeK0F1X (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:27:23 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38237 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeK0F1X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Nov 2018 00:27:23 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so16569795wrw.5;
        Mon, 26 Nov 2018 10:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oHET04vnt76Of1oTZas6DTUZqoIYIdK/9T5S9aS3Oik=;
        b=dCfWeVoh4Xsa0+9+7Pv1Gt2Uwz96F8mXKHrHW9Kqc8oJocvSX3kyTebkZQ05cZ6DZ2
         OogRFOCVXPR7sqVjKCAWor8h8kgaArukUJAX3RmyBqHngOGhbL+CZJJxm2HBTpwYmM6k
         l2qaweEL5+kN+3IhldytvPefbKlsFsVTr30nqFTgK/oZlusRdCI+34S4Ydgh5VMQyiW0
         TKCBKfdQoLjWJQLSX3A0dmAWdbMoKyWpztJc8S6jECCQZ1pCdqdfUwuXygyPphPLmm62
         GpVwubYXZSSA+4DEXFtT5bN2bpw1hKIvBOZHLKxOs7Xj0hqNxY4WuMDaT7Thxkp8CjWl
         wG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oHET04vnt76Of1oTZas6DTUZqoIYIdK/9T5S9aS3Oik=;
        b=FJs392nxNWQmDvN6eQsSdvRim0iDbtxy2L63ijsXW1vC4av5dDCRqlivHvSXYQiMYr
         qQ4PSUN1bHkbWwfnQrUrPYzc6an9As1nzwcpCobVWcKWE9jfq5GMPyLB3PfAVLl/NZwz
         74WsfcyA3+RhYBkTFkyj56rdXHdXUwSjW0rZBFiLVUqgmLDDlqIQ7arva8XF4l0dmXMx
         uRMg80UjmNCvPbMRYZrLLY4OpXLqRweuqlH1t8AYaLuUuM2F5aY5XSyoH9M4+uvXsNF3
         Nu91QvKYashB9095PdAlaCtr2e7cCLmhddgCszK05yb6J+Lso5IHx9r3PiWDl63l5eUt
         1ESA==
X-Gm-Message-State: AA+aEWYNvUj2Jv0kJjIxdGl1oP9eh4+zjiyOSGEknUKVKSOW5sy+D1BW
        3k6LXrccYbgbQ48j92yBJjmmj3nqXH1unhhHxU0=
X-Google-Smtp-Source: AFSGD/W5eAap531+pG9BSnQz1tAsf+04UlqX18+9IcVXJ54Nz7Lt5hnd4BRIhx2/Rqavgl/q3IrrZ7aMjCYa/3D7aRE=
X-Received: by 2002:a05:6000:51:: with SMTP id k17mr23447619wrx.259.1543257143836;
 Mon, 26 Nov 2018 10:32:23 -0800 (PST)
MIME-Version: 1.0
References: <20181117181225.10737-1-andrew.smirnov@gmail.com>
 <20181117181225.10737-3-andrew.smirnov@gmail.com> <1542676938.30311.581.camel@impinj.com>
In-Reply-To: <1542676938.30311.581.camel@impinj.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 26 Nov 2018 10:32:12 -0800
Message-ID: <CAHQ1cqG0oVWQw9NC_22f7bZMfX11wwuvO2_x8P3GJYsb-ecGvQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: imx: No-op imx6_pcie_reset_phy() on i.MX7D
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, linux-imx@nxp.com,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 19, 2018 at 5:22 PM Trent Piepho <tpiepho@impinj.com> wrote:
>
> On Sat, 2018-11-17 at 10:12 -0800, Andrey Smirnov wrote:
> > PCIE PHY IP block on i.MX7D differs from the one used on i.MX6 family,
> > so none of the code in current implementation of imx6_pcie_reset_phy()
> > is applicable.
>
> Tested on IMX7d, still appears to work.
>

Thanks for testing! Unless you object, I'll add your Tested-by tag to
this patch.

> Note that your patches will collide with Stefan Agner's patch, "PCI:
> imx6: limit DBI register length", which was recently posted.
>
> He changed the way the variants are handled.  That method would allow
> some of the IMX7D || IMX8MQ checks to be re-written as
>
>  imx6_pcie->drvdata->boolean_attribute
>
> Where the attribute can be set in a table and be re-used in every place
> it comes into play and updated for new devices in one spot, instead of
> keeping piles of this version or that version or this other version
> checks up to date.

Thanks for the heads up! I am expecting that I'd have to re-base this
series on "next" in PCI tree before it can be applied. This should
provide for a good opportunity to discover and resolve all of the
conflicts, I think.

Thanks,
Andrey Smirnov
