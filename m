Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:34042 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbcGME65 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2016 00:58:57 -0400
Subject: Error handling in drivers/pci/host/pcie-xilinx.c
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <e451321a-42de-9d5f-bf33-bbcb495ebc6f@wanadoo.fr>
Date: Wed, 13 Jul 2016 06:58:22 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

(resent because of broken cc)


Hi,

in file 'drivers/pci/host/pcie-xilinx.c', error handling in 
'xilinx_pcie_init_irq_domain()' seams to be broken.

The pattern used is:

    if (!var) {
       ...
       dev_err(...);
       return PTR_ERR(var);
    }

so we always return '0', which means success.

Returning PTR_ERR(-EINVAL) or PTR_ERR(-ENODEV) could be, IMHO, better.

Best regards,

CJ


