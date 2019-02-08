Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FDEC169C4
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 12:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2608C218DA
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 12:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="OVoNxJ6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfBHMii (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:38:38 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32992 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbfBHMii (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Feb 2019 07:38:38 -0500
Received: by mail-wr1-f65.google.com with SMTP id a16so3459043wrv.0
        for <linux-pci@vger.kernel.org>; Fri, 08 Feb 2019 04:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=za3n79uTXhuAg89Odl5K7zA3/4teHlFt8f/2UCul1pI=;
        b=OVoNxJ6L+4h0zmcRL0/+4rPL4qAp+s8E3C9mBgNG/yVgl7yp+6sLCgN44Re9Gu9Wik
         f5q3MpCGafDHKYYqZ/Yl9KI4QDOZQ+NY+A1WSs8brIvZ5W/8k1hH5FE+Ltz5vD5IW5Y0
         t+A80vouwIa00ZgMDXFMn6bwZrkAi9VYz/t4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=za3n79uTXhuAg89Odl5K7zA3/4teHlFt8f/2UCul1pI=;
        b=W3nbNPAYK+QDkXZzNcvd9u1GGVrwFOaMouQt1VGRajhChf7dVmUn6g6MZMcZEp4HMf
         hQYl8q6vluAyUk2U/QPmqyJmpQkrsihTuEGvsbHlQxLkFavAtigAq27ppO7N8DKBoCfN
         4Fgbg3TtKfrxzw/7mNOeS9C8MHyX8RAZUI52uaM8u9qMLDFsp7pmBmR7wwZfBtNVeElA
         sDbMfc/eERUVm6dpZ+4vco6sCV+wcuWvEXK1s1H0FuG8STl/q/9JLdgo2IxIZjy4R7RN
         MuYda2CVH3wSWmzTXqT+yr/bLAIQzMmG/Et11BApn7CkTWzbhH+N5Ii4lr9tKdyNwyew
         qkbA==
X-Gm-Message-State: AHQUAubwQpJox2fgPjwSjoA6VP8Tt5vlLwVIGkS4wNt1X4YVR3YhAq+K
        Q3/EkNnP88YW6YcIf7beTzA1yLeGhUcTuWgUmxjM8A==
X-Google-Smtp-Source: AHgI3Iatp5BtTgrEbIDAPsLDPC8Il8bwT1QG2XB42RwPY79StgZWtwjcGnSo0DQr+93S2X94tfqQdYfUBTw6ZWcFbfU=
X-Received: by 2002:a5d:468e:: with SMTP id u14mr14295242wrq.253.1549629516223;
 Fri, 08 Feb 2019 04:38:36 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com> <20190129080926.36773-18-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-18-Zhiqiang.Hou@nxp.com>
From:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date:   Fri, 8 Feb 2019 18:11:15 +0530
Message-ID: <CAFZiPx0faPHN1mqPV28XTZfOxA2GgDPuc=RVdXEiGGNAUe=Fxw@mail.gmail.com>
Subject: Re: [PATCHv3 17/27] PCI: mobiveil: fix the checking of valid device
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ZQ,

On Tue, Jan 29, 2019 at 1:40 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> Avoid to issue CFG transactions to link partner when the PCIe
> link is not up. And allow CFG transactions to all functions of
> Endpoint implemented multiple functions.
>
> Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host
> Bridge IP driver")
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V3:
>  - No change
>
>  drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> index dc5324d94466..1ae82e790562 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> @@ -29,6 +29,10 @@ static bool mobiveil_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
>  {
>         struct mobiveil_pcie *pcie = bus->sysdata;
>
> +       /* If there is no link, then there is no device */
> +       if (bus->number > pcie->rp.root_bus_nr && !mobiveil_pcie_link_up(pcie))
> +               return false;
> +
>         /* Only one device down on each root port */
>         if ((bus->number == pcie->rp.root_bus_nr) && (devfn > 0))
>                 return false;
> @@ -37,7 +41,7 @@ static bool mobiveil_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
>          * Do not read more than one device on the bus directly
>          * attached to RC
>          */
> -       if ((bus->primary == pcie->rp.root_bus_nr) && (devfn > 0))
> +       if ((bus->primary == pcie->rp.root_bus_nr) && (PCI_SLOT(devfn) > 0))
here change "primary" to "number", as it's a bug in the original driver too.

>                 return false;
>
>         return true;
> --
> 2.17.1
>
