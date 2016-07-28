Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:60787 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751368AbcG1URy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jul 2016 16:17:54 -0400
Date: Thu, 28 Jul 2016 22:17:42 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] PCI: aardvark: Remove redundant dev_err call in
 advk_pcie_probe()
Message-ID: <20160728221742.403e558b@free-electrons.com>
In-Reply-To: <1469722634-15049-1-git-send-email-weiyj.lk@gmail.com>
References: <1469722634-15049-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Thu, 28 Jul 2016 16:17:14 +0000, Wei Yongjun wrote:
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
> 
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
> ---
>  drivers/pci/host/pci-aardvark.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
