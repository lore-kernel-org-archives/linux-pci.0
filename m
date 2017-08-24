Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:35796 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753821AbdHXQuM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2017 12:50:12 -0400
Received: by mail-io0-f173.google.com with SMTP id k22so60326iod.2
        for <linux-pci@vger.kernel.org>; Thu, 24 Aug 2017 09:50:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e1f5e20d-929f-db8d-1c60-181698e678f0@arm.com>
References: <20170821192907.8695-1-ard.biesheuvel@linaro.org>
 <20170821192907.8695-3-ard.biesheuvel@linaro.org> <e1f5e20d-929f-db8d-1c60-181698e678f0@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 24 Aug 2017 17:50:11 +0100
Message-ID: <CAKv+Gu-mxLnnrZ58PR1hfcBScddewQ8rT77b0fRDnHVViu2WiQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] pci: designware: add separate driver for the MSI part
 of the RC
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 24 August 2017 at 17:48, Robin Murphy <robin.murphy@arm.com> wrote:
> Hi Ard,
>
> On 21/08/17 20:29, Ard Biesheuvel wrote:
> [...]
>> +static int dw_pcie_msi_probe(struct platform_device *pdev)
>> +{
>> +     struct fwnode_handle *fwnode = of_node_to_fwnode(pdev->dev.of_node);
>
> Mini-nit: since fairly recently (f94277af03ea) dev->fwnode should
> already be set appropriately by of_platform_device_create(), so you
> should be able to make this entirely firmware-agnostic if you like.
>

Thanks for pointing that out. I'm not sure yet what it means exactly,
but I'm sure I will figure it out :-)
