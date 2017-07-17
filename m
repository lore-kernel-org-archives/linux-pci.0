Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:39798 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbdGQHHK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2017 03:07:10 -0400
Date: Mon, 17 Jul 2017 09:07:08 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: bhelgaas@google.com, jason@lakedaemon.net,
        linux-pci@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH] PCI: mvebu: Remove unneeded gpiod NULL check
Message-ID: <20170717090708.025d3ee4@windsurf>
In-Reply-To: <1500239773-15632-1-git-send-email-festevam@gmail.com>
References: <1500239773-15632-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Sun, 16 Jul 2017 18:16:13 -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> The gpiod API checks for NULL descriptors, so there is no need to
> duplicate the check in the driver.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  drivers/pci/host/pci-mvebu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
