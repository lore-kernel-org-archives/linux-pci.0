Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36763 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbbLLNDF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 12 Dec 2015 08:03:05 -0500
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH] drivers:pci:host Fix missing line after declarations
From: sasa bogicevic <brutallesale@gmail.com>
In-Reply-To: <20151212132316.27e10a6d@free-electrons.com>
Date: Sat, 12 Dec 2015 14:03:01 +0100
Cc: bhelgaas@google.com, Richard.Zhu@freescale.com,
	l.stach@penguintronix.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-Id: <FA0282DC-E821-413F-AC5A-11105B4D0EDE@gmail.com>
References: <1449920508-105873-1-git-send-email-brutallesale@gmail.com> <20151212132316.27e10a6d@free-electrons.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Thomas,
I just went with checkpatch.pl approach I hope this patch didn’t ruin your day :)


{
	name: Bogicevic Sasa
	phone: +381606006200
}



> On Dec 12, 2015, at 13:23, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:
> 
> Dear Bogicevic Sasa,
> 
> On Sat, 12 Dec 2015 03:41:48 -0800, Bogicevic Sasa wrote:
>> This fixes few warnings about missing line after declarations and one
>> no whitespace is necesarry before that "("
>> 
>> Signed-off-by: Bogicevic Sasa <brutallesale@gmail.com>
> 
> I am not a big fan of this struct rule that insists in having an empty
> line after declarations, I believe when a for() loop or if() condition
> has only one line of declaration and one line of useful code, it
> doesn't make much sense. But oh well, that's the rule, so let's do it
> this way.
> 
>> ---
>> drivers/pci/host/pci-imx6.c  | 2 +-
>> drivers/pci/host/pci-mvebu.c | 3 +++
>> drivers/pci/host/pcie-rcar.c | 2 ++
>> 3 files changed, 6 insertions(+), 1 deletion(-)
> 
> For the pci-mvebu.c part:
> 
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> Thomas
> -- 
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com

