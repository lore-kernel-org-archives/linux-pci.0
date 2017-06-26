Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:35903 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751485AbdFZMwB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jun 2017 08:52:01 -0400
Message-ID: <1498481507.6075.10.camel@mtkswgap22>
Subject: Re: next-20170626 build: 1 failures 1 warnings (next-20170626)
From: Ryder Lee <ryder.lee@mediatek.com>
To: Mark Brown <broonie@kernel.org>
CC: <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
        <kernel-build-reports@lists.linaro.org>,
        <linaro-kernel@lists.linaro.org>, <linux-next@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pci@vger.kernel.org>
Date: Mon, 26 Jun 2017 20:51:47 +0800
In-Reply-To: <20170626115653.e4xs4lk4paibuphx@sirena.org.uk>
References: <E1dPPgG-0002pe-3A@optimist>
         <20170626115653.e4xs4lk4paibuphx@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2017-06-26 at 12:56 +0100, Mark Brown wrote:
> On Mon, Jun 26, 2017 at 09:47:36AM +0100, Build bot for Mark Brown wrote:
> 
> This build failure is still present in -next:
> 
> > 	arm-allmodconfig
> > ../drivers/pci/host/pcie-mediatek.c:485:8: error: implicit declaration of function 'pci_register_host_bridge' [-Werror=implicit-function-declaration]
> 
> and we're at -rc7 now.

Hi Mark,
 
This is due to we are in different branch but merge together...

Anyway, I could send a critical patch, but I need Bjorn help to apply to
-next. Seems he didn't response these days.

Not sure how could I send it?

Ryder.
