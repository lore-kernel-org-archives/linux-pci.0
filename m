Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34592 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbeAWKyl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jan 2018 05:54:41 -0500
Received: by mail-pg0-f49.google.com with SMTP id r19so32585pgn.1
        for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2018 02:54:41 -0800 (PST)
Date: Tue, 23 Jan 2018 18:54:25 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>, project-aspen-dev@linaro.org,
        Jianguo Sun <sunjianguo1@huawei.com>
Subject: Re: [PATCH] PCI: histb: add power control GPIO for PCIe slot
Message-ID: <20180123105424.GB23797@dragon>
References: <1516669477-20151-1-git-send-email-shawn.guo@linaro.org>
 <CAOMZO5DFR=qJ_Q9ag+6Ov92VMZL3wiLSQJee=nKUJFtZ1mW1RQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOMZO5DFR=qJ_Q9ag+6Ov92VMZL3wiLSQJee=nKUJFtZ1mW1RQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 22, 2018 at 11:12:44PM -0200, Fabio Estevam wrote:
> Hi Shawn,
> 
> On Mon, Jan 22, 2018 at 11:04 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > From: Jianguo Sun <sunjianguo1@huawei.com>
> >
> > Besides the GPIO for controlling reset, there is also possibly another
> > GPIO for turning on/off the power of PCIe slot.  Let's add the support
> > for that with another optional device tree property 'power-gpios'.
> 
> It seems that a better approach would be to add regulator support
> instead as it is more general.

It's a sensible suggestion.  I will take it in v2.  Thanks, Fabio.

Shawn
