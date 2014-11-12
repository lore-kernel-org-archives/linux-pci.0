Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:10686 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582AbaKLNc0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Nov 2014 08:32:26 -0500
Date: Wed, 12 Nov 2014 08:32:21 -0500
From: Jason Cooper <jason@lakedaemon.net>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH] PCI: mvebu: Add a blank line after declarations
Message-ID: <20141112133221.GI3698@titan.lakedaemon.net>
References: <002b01cffe28$a57021d0$f0506570$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <002b01cffe28$a57021d0$f0506570$%han@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 12, 2014 at 12:27:54PM +0900, Jingoo Han wrote:
> This patch fixes the following checkpatch warning.
> 
>   WARNING: Missing a blank line after declarations
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/pci/host/pci-mvebu.c |    3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
