Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:47075 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752494AbeCVKq5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Mar 2018 06:46:57 -0400
Received: by mail-io0-f177.google.com with SMTP id g14so10379651iob.13
        for <linux-pci@vger.kernel.org>; Thu, 22 Mar 2018 03:46:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180321144254.7406-6-lorenzo.pieralisi@arm.com>
References: <20180321144254.7406-1-lorenzo.pieralisi@arm.com> <20180321144254.7406-6-lorenzo.pieralisi@arm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Mar 2018 11:46:56 +0100
Message-ID: <CACRpkdYozqgrwueWBtdx7eaZ3ORCvp5N039jYtJN1ADFZrewJA@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] PCI: faraday: struct faraday_pci_variant can be static
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Ley Foon Tan <lftan@altera.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 21, 2018 at 3:42 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:

> From: Fengguang Wu <fengguang.wu@intel.com>
>
> This was generated from 0-day builder.
>
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
> [lorenzo.pieralisi@arm.com: reworked/split patch]
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
