Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:6613 "EHLO
	ausc60ps301.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762214Ab2EQRlD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 May 2012 13:41:03 -0400
From: <Shyam_Iyer@Dell.com>
To: <prarit@redhat.com>, <linux-pci@vger.kernel.org>
CC: <bhelgaas@google.com>
Date: Thu, 17 May 2012 10:29:07 -0700
Subject: RE: [PATCH] pci, Add AER_panic sysfs file
Message-ID: <DBFB1B45AF80394ABD1C807E9F28D15707BC8F0CE9@BLRX7MCDC203.AMER.DELL.COM>
References: <1337274270-18785-1-git-send-email-prarit@redhat.com>
In-Reply-To: <1337274270-18785-1-git-send-email-prarit@redhat.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
> owner@vger.kernel.org] On Behalf Of Prarit Bhargava
> Sent: Thursday, May 17, 2012 1:05 PM
> To: linux-pci@vger.kernel.org
> Cc: Prarit Bhargava; Bjorn Helgaas
> Subject: [PATCH] pci, Add AER_panic sysfs file
> 
> Consider the following case
> 
> 		[ RP ]
> 		  |
> 		  |
> 	+---------+-----------+
> 	|	  |	      |
>        [H1]      [H2]        [X1]
> 
> where RP is a PCIE Root Port, H1 and H2 are devices with drivers that
> support
> PCIE AER driver error handling (ie, they have pci_error_handlers
> defined in
> the driver), and X1 is a device with a driver that does not support
> PCIE
> AER driver error handling.
> 
> If the Root Port takes an error what currently happens is that the
> bus resets and H1 & H2 call their slot_reset functions.  X1 does
> nothing.
> 
> In some cases a user may not wish the system to continue because X1 is
> an unhardened driver.  In these cases, the system should not do a bus
> reset,
> but rather the system should panic to avoid any further possible data
> corruption.

Do we neeed to panic for both correctable and uncorrectable errors.. ?

I thought correctable errors could recover without a bus reset.
