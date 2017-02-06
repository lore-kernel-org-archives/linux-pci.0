Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:8822 "EHLO
        lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750953AbdBFLPx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2017 06:15:53 -0500
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Keith Busch <keith.busch@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH 2/2] pcie-dpc: Wait for root port busy to clear
Date: Mon, 6 Feb 2017 11:15:42 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1FA0FD8E@lhreml507-mbx>
References: <1486158373-18655-1-git-send-email-keith.busch@intel.com>
 <1486158373-18655-2-git-send-email-keith.busch@intel.com>
In-Reply-To: <1486158373-18655-2-git-send-email-keith.busch@intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Keith

> -----Original Message-----
> From: Keith Busch [mailto:keith.busch@intel.com]
> Sent: 03 February 2017 21:46
> To: linux-pci@vger.kernel.org; Bjorn Helgaas
> Cc: Gabriele Paoloni; Keith Busch
> Subject: [PATCH 2/2] pcie-dpc: Wait for root port busy to clear
> 
> Root Ports implementing DPC optionally advertise extensions that, when
> advertised, require the driver wait for the RP Busy status to clear
> prior
> to releasing from containment. Results are undefined if we release from
> containment while this bit is set.

Many thanks for this I should be able to test it in March.
BTW the patch looks ok to me

Cheers
Gab

> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---

[...]
