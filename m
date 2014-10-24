Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:63006 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbaJXBvQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Oct 2014 21:51:16 -0400
MIME-Version: 1.0
In-Reply-To: <1411445498-20250-3-git-send-email-r65037@freescale.com>
References: <1411445498-20250-1-git-send-email-r65037@freescale.com>
	<1411445498-20250-3-git-send-email-r65037@freescale.com>
Date: Thu, 23 Oct 2014 23:51:14 -0200
Message-ID: <CAOMZO5D6_py-OUsz57mcJOdCShQk0jOjJMPD=4VTzj_FoOkMjQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] PCI: imx6: wait the clocks to stabilize after ref_en
From: Fabio Estevam <festevam@gmail.com>
To: Richard Zhu <r65037@freescale.com>
Cc: "linux-pci-owner@vger.kernel.org" <linux-pci-owner@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Shawn Guo <shawn.guo@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Tim Harvey <tharvey@gateworks.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Richard,

On Tue, Sep 23, 2014 at 1:11 AM, Richard Zhu <r65037@freescale.com> wrote:
> - a while delay is mandatory required after pcie_ref_clk_en
> is set. Otherwise, the system would be hang on imx6qdl ard
> boards, because that imx6qdl boards don't have the reset_gpio.
> - the clocks should be stable already after the
> "clk_prepare_enable" is return. So I think it's ok to move the
> usleep delay after the pcie_ref_en is set.
>
> Signed-off-by: Richard Zhu <r65037@freescale.com>

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>

Without this patch we notice that the kernel does not boot anymore
since commit  3fce0e882f61 (PCI: imx6: Delay enabling reference clock
for SS until it stabilizes) on a system that does not pass the PCI
gpio reset in the dtb. This causes a regression on mx6 nitrogen
boards.

I would suggest that you resend this patch only so that it could be
applied into 3.18 as a bug fix.
