Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gateway36.websitewelcome.com ([192.185.196.23]:20043 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732353AbeGaRRe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jul 2018 13:17:34 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 5FE70400F7ECA
        for <linux-pci@vger.kernel.org>; Tue, 31 Jul 2018 09:16:29 -0500 (CDT)
Subject: Re: [PATCH 1/2] PCI: pciehp: Avoid implicit fallthroughs in switch
 statements
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org
References: <92c3c456edb461494d5c44e1ff6bab2711228ff1.1532754355.git.lukas@wunner.de>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <07e51d4b-db10-a402-8f08-40f98a86f7ba@embeddedor.com>
Date: Tue, 31 Jul 2018 10:13:22 -0500
MIME-Version: 1.0
In-Reply-To: <92c3c456edb461494d5c44e1ff6bab2711228ff1.1532754355.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 07/28/2018 12:22 AM, Lukas Wunner wrote:
> Per Mika's request, add an explicit break to the last case of switch
> statements everywhere in pciehp to be more defensive towards future
> amendments.
> 
> Per Gustavo's request, mark all non-empty implicit fallthroughs with a
> comment to silence warnings triggered by -Wimplicit-fallthrough=2.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---


Acked-by: Gustavo A. R. Silva <gustavo@embeddedor.com>


Thanks
--
Gustavo
