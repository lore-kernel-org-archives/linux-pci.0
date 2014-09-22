Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:49790 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753880AbaIVNQK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Sep 2014 09:16:10 -0400
Date: Mon, 22 Sep 2014 06:15:19 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Richard Zhu <r65037@freescale.com>
Cc: linux-pci-owner@vger.kernel.org, stable@vger.kernel.org,
	linux-pci@vger.kernel.org, l.stach@pengutronix.de
Subject: Re: [PATCH RFC 1/2] PCI: imx6: enable pcie on imx6qdl sabresd and
 sabreauto
Message-ID: <20140922131519.GA30055@kroah.com>
References: <1411376498-14653-1-git-send-email-r65037@freescale.com>
 <1411376498-14653-2-git-send-email-r65037@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411376498-14653-2-git-send-email-r65037@freescale.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 22, 2014 at 05:01:37PM +0800, Richard Zhu wrote:
> - enable pcie support on imx6qdl sabresd and asbreauto boards.
> - sabresd board has the pcie power on and reset gpios, but
> sabreauto doesn't have these two gpios.
> 
> Signed-off-by: Richard Zhu <r65037@freescale.com>
> ---
>  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 4 ++++
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi   | 2 ++
>  2 files changed, 6 insertions(+)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
