Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:56635 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751225Ab3IPP5K (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2013 11:57:10 -0400
Date: Mon, 16 Sep 2013 17:57:06 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	'Jason Cooper' <jason@lakedaemon.net>
Subject: Re: [PATCH 3/3] PCI: mvebu: add missing __iomem annotation
Message-ID: <20130916175706.3b43b3c4@skate>
In-Reply-To: <000501ceaf9b$acaec690$060c53b0$%han@samsung.com>
References: <000201ceaf9b$098780b0$1c968210$%han@samsung.com>
	<000501ceaf9b$acaec690$060c53b0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jingoo Han,

On Thu, 12 Sep 2013 18:37:18 +0900, Jingoo Han wrote:

>  	ret = of_address_to_resource(np, 0, &regs);
>  	if (ret)
> -		return ERR_PTR(ret);
> +		return (void __iomem *)ERR_PTR(ret);

This doesn't look very pretty to tell the truth, but I don't quite see
any other option. Just return NULL when of_address_to_resource() fails
instead of trying to propagate the error? Make this entire function
return an 'int' and have the iomem address returned through a pointer
passed by address as argument to the function? Any other suggestion?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
