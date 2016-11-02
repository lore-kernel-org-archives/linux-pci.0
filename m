Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35959 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754875AbcKBPsE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2016 11:48:04 -0400
Received: by mail-qk0-f194.google.com with SMTP id h201so744411qke.3
        for <linux-pci@vger.kernel.org>; Wed, 02 Nov 2016 08:48:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1476482095-26289-1-git-send-email-niklass@axis.com>
References: <1476482095-26289-1-git-send-email-niklass@axis.com>
From: Olof Johansson <olof@lixom.net>
Date: Wed, 2 Nov 2016 08:48:02 -0700
Message-ID: <CAOesGMiCYh+fHKpcv6w19WtcZa2g+jj+Zn5OF5-2CaeR1=86HA@mail.gmail.com>
Subject: Re: [PATCH] PCI: designware: check for iATU unroll support after
 initializing host
To: Niklas Cassel <niklas.cassel@axis.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, pratyush.anand@gmail.com,
        Joao.Pinto@synopsys.com,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Niklas Cassel <niklass@axis.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Fri, Oct 14, 2016 at 2:54 PM, Niklas Cassel <niklas.cassel@axis.com> wrote:
> From: Niklas Cassel <niklas.cassel@axis.com>
>
> dw_pcie_iatu_unroll_enabled reads a dbi_base register.
> Reading any dbi_base register before pp->ops->host_init has been called
> causes "imprecise external abort" on platforms like ARTPEC-6, where the
> PCIe module is disabled at boot and first enabled in pp->ops->host_init.
> Move dw_pcie_iatu_unroll_enabled to dw_pcie_setup_rc, since it is after
> pp->ops->host_init, but before pp->iatu_unroll_enabled is actually used.
>
> Fixes: a0601a470537 ("PCI: designware: Add iATU Unroll feature")
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>

This fixes the regression I've seen on i.MX6 devices in my board farm as well.

Acked-by: Olof Johansson <olof@lixom.net>

Bjorn, can you please pick this up and get it sent up for 4.9-rc soon?
I worry about losing bisectability if this remains broken for a while.
Thanks!


-Olof
