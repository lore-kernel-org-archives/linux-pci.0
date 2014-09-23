Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:36990 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860AbaIWMpx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Sep 2014 08:45:53 -0400
MIME-Version: 1.0
In-Reply-To: <1411445498-20250-3-git-send-email-r65037@freescale.com>
References: <1411445498-20250-1-git-send-email-r65037@freescale.com>
	<1411445498-20250-3-git-send-email-r65037@freescale.com>
Date: Tue, 23 Sep 2014 09:45:52 -0300
Message-ID: <CAOMZO5CEdG+Z7H3GDefamMkjmyz7OVVQxNwxdOrEE_bx1r5wug@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] PCI: imx6: wait the clocks to stabilize after ref_en
From: Fabio Estevam <festevam@gmail.com>
To: Richard Zhu <r65037@freescale.com>
Cc: linux-pci-owner@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Shawn Guo <shawn.guo@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Tim Harvey <tharvey@gateworks.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 23, 2014 at 1:11 AM, Richard Zhu <r65037@freescale.com> wrote:
> - a while delay is mandatory required after pcie_ref_clk_en
> is set. Otherwise, the system would be hang on imx6qdl ard
> boards, because that imx6qdl boards don't have the reset_gpio.

The mx6qdl sabreauto boards do have PCI reset pins. They come from the
I2C MAX7310 expander.

Yes, there are boards that do not have PCI reset GPIO, but this commit
log need to be rewritten.
