Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:48112 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285Ab3FZQcx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jun 2013 12:32:53 -0400
Received: by mail-ie0-f175.google.com with SMTP id a13so31246196iee.20
        for <linux-pci@vger.kernel.org>; Wed, 26 Jun 2013 09:32:53 -0700 (PDT)
Date: Wed, 26 Jun 2013 10:32:50 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Darren Hart <dvhart@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, peter.p.waskiewicz.jr@intel.com,
	andriy.shevchenko@linux.intel.com, danders@circuitco.com,
	vishal.l.verma@intel.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH 7/8] pci: Add CircuitCo VENDOR ID and MinnowBoard DEVICE
 ID
Message-ID: <20130626163250.GA29299@google.com>
References: <cover.1372211451.git.dvhart@linux.intel.com>
 <83879b07cd4ce95f086420d1faa926c1692d63b4.1372211451.git.dvhart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <83879b07cd4ce95f086420d1faa926c1692d63b4.1372211451.git.dvhart@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 25, 2013 at 06:53:27PM -0700, Darren Hart wrote:
> Add CircuitCo's newly created VENDOR ID and their first board subsystem
> ID for the MinnowBoard.
> 
> Signed-off-by: Darren Hart <dvhart@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: David Anders <danders@circuitco.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Peter Waskiewicz <peter.p.waskiewicz.jr@intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: linux-pci@vger.kernel.org
> ---
>  include/linux/pci_ids.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index c129162..b2879ce 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -149,6 +149,9 @@
>  #define PCI_DEVICE_ID_BERKOM_A4T		0xffa4
>  #define PCI_DEVICE_ID_BERKOM_SCITEL_QUADRO	0xffa8
>  
> +#define PCI_VENDOR_ID_CIRCUITCO			0x1cc8
> +#define PCI_DEVICE_ID_CIRCUITCO_MINNOWBOARD	0x0001
> +
>  #define PCI_VENDOR_ID_COMPAQ		0x0e11
>  #define PCI_DEVICE_ID_COMPAQ_TOKENRING	0x0508
>  #define PCI_DEVICE_ID_COMPAQ_TACHYON	0xa0fc
> -- 
> 1.8.1.2
> 

Per conversation at [1], I merged the patch below to my pci/misc branch
for v3.11:

[1] https://lkml.kernel.org/r/6c27e79870ec93f7a8c6692d4bcfebaee589fa6b.1372211451.git.dvhart@linux.intel.com


commit 9f4de80a09667538e1162fdecff96ccb5bb354a8
Author: Darren Hart <dvhart@linux.intel.com>
Date:   Tue Jun 25 20:08:46 2013 -0600

    PCI: Add CircuitCo vendor ID
    
    Add CircuitCo's newly created VENDOR ID
    
    [bhelgaas: sort, drop device ID (only used once)]
    Signed-off-by: Darren Hart <dvhart@linux.intel.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index c129162..8b1aa7f 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2476,6 +2476,8 @@
 
 #define PCI_VENDOR_ID_ASMEDIA		0x1b21
 
+#define PCI_VENDOR_ID_CIRCUITCO		0x1cc8
+
 #define PCI_VENDOR_ID_TEKRAM		0x1de1
 #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
 
