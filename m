Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:41211 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751364AbeENI1Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 May 2018 04:27:25 -0400
Received: by mail-io0-f180.google.com with SMTP id e12-v6so14188598iob.8
        for <linux-pci@vger.kernel.org>; Mon, 14 May 2018 01:27:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180511171530.16068-2-robh@kernel.org>
References: <20180511171530.16068-1-robh@kernel.org> <20180511171530.16068-2-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 14 May 2018 10:27:24 +0200
Message-ID: <CACRpkdbLWMe9+6oi2h9Dr=YGrz6YKY=RXmQdM9R23XbXhbfSmA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] PCI: Move private DT related functions into
 private header
To: Rob Herring <robh@kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Ley Foon Tan <lftan@altera.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 11, 2018 at 7:15 PM, Rob Herring <robh@kernel.org> wrote:

> The functions in linux/of_pci.h are primarily used by host bridge
> drivers, so they can be private to drivers/pci/.
>
> The remaining functions are still used mostly in host bridge drivers
> that still live in arch specific code. Hopefully someday, those will get
> moved into drivers/pci as well.
>
> Acked-by: Jingoo Han <jingoohan1@gmail.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Nice patch!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
