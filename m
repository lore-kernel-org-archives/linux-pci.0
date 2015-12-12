Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:49167 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751624AbbLLMXT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 12 Dec 2015 07:23:19 -0500
Date: Sat, 12 Dec 2015 13:23:16 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bogicevic Sasa <brutallesale@gmail.com>
Cc: bhelgaas@google.com, Richard.Zhu@freescale.com,
	l.stach@penguintronix.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers:pci:host Fix missing line after declarations
Message-ID: <20151212132316.27e10a6d@free-electrons.com>
In-Reply-To: <1449920508-105873-1-git-send-email-brutallesale@gmail.com>
References: <1449920508-105873-1-git-send-email-brutallesale@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Bogicevic Sasa,

On Sat, 12 Dec 2015 03:41:48 -0800, Bogicevic Sasa wrote:
> This fixes few warnings about missing line after declarations and one
> no whitespace is necesarry before that "("
> 
> Signed-off-by: Bogicevic Sasa <brutallesale@gmail.com>

I am not a big fan of this struct rule that insists in having an empty
line after declarations, I believe when a for() loop or if() condition
has only one line of declaration and one line of useful code, it
doesn't make much sense. But oh well, that's the rule, so let's do it
this way.

> ---
>  drivers/pci/host/pci-imx6.c  | 2 +-
>  drivers/pci/host/pci-mvebu.c | 3 +++
>  drivers/pci/host/pcie-rcar.c | 2 ++
>  3 files changed, 6 insertions(+), 1 deletion(-)

For the pci-mvebu.c part:

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
