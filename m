Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:41159 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbdGVUbp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Jul 2017 16:31:45 -0400
Date: Sat, 22 Jul 2017 22:31:39 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH v2] PCI: armada8k: Check the return value from
 clk_prepare_enable()
Message-ID: <20170722223139.0b942330@windsurf>
In-Reply-To: <1500755119-19983-1-git-send-email-festevam@gmail.com>
References: <1500755119-19983-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Sat, 22 Jul 2017 17:25:19 -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> clk_prepare_enable() may fail, so we should better check its return value
> and propagate it in the case of error.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
