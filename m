Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:31077 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbcGME7s (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2016 00:59:48 -0400
Subject: Error handling in drivers/pci/host/pci-dra7xx.c
To: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <edb7b73b-3880-23a5-99ff-2b5b30f45ace@wanadoo.fr>
Date: Wed, 13 Jul 2016 06:59:32 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

(resent because of broken cc)


Hi,

in file 'drivers/pci/host/pci-dra7xx.c', error handling in 
'dra7xx_pcie_init_irq_domain()' seams to be broken.

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

