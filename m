Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:54650 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751944Ab3IWHYr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Sep 2013 03:24:47 -0400
Date: Mon, 23 Sep 2013 09:24:41 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	'Jason Cooper' <jason@lakedaemon.net>
Subject: Re: [PATCH V3 3/3] PCI: mvebu: return NULL instead of ERR_PTR(ret)
Message-ID: <20130923092441.18d79397@skate>
In-Reply-To: <001001ceb816$5d1aecc0$1750c640$%han@samsung.com>
References: <001a01ceb366$5e9481b0$1bbd8510$%han@samsung.com>
	<001001ceb816$5d1aecc0$1750c640$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jingoo Han,

On Mon, 23 Sep 2013 13:35:42 +0900, Jingoo Han wrote:
> Return NULL instead of ERR_PTR(ret) in order to fix the following
> sparse warning:
> 
> drivers/pci/host/pci-mvebu.c:744:31: warning: incorrect type in return expression (different address spaces)
> drivers/pci/host/pci-mvebu.c:744:31:    expected void [noderef] <asn:2>*
> drivers/pci/host/pci-mvebu.c:744:31:    got void *
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
-- 
Thomas Petazzoni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
