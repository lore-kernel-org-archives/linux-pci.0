Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from xes-mad.com ([216.165.139.218]:54991 "EHLO xes-mad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752603AbaHTRFG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 20 Aug 2014 13:05:06 -0400
Date: Wed, 20 Aug 2014 11:21:56 -0500 (CDT)
From: Aaron Sierra <asierra@xes-inc.com>
To: Gokul C G <gokul.g@kalkitech.in>
Cc: linux-pci@vger.kernel.org, meta-freescale@yoctoproject.org,
	linuxppc-dev@lists.ozlabs.org, djiang@mvista.com
Message-ID: <1589883448.38884.1408551716508.JavaMail.zimbra@xes-inc.com>
In-Reply-To: <53F3629A.6060208@kalkitech.in>
References: <53F3629A.6060208@kalkitech.in>
Subject: Re: PCIe driver not working properly after upgrading to linux
 3.8.13
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

----- Original Message -----
> From: "Gokul C G" <gokul.g@kalkitech.in>
> Sent: Tuesday, August 19, 2014 9:43:38 AM
> 
> HI,
> 
> I am facing problem with PCIE driver in new Linux kernel compiled for powerpc
> architecture (Big endian) ,freescales P2040 processor.I was using old kernel
> Linux version 3.0.48 previously and now updated to Linux version
> 3.8.13-rt9.After updating to the new kernel, PCIe device drivers not working
> properly and i am getting some error messages in the boot-up .My intention
> is to use EXAR PCIe Multiport serial driver and add 8 serial ports in
> addition to 4 built in serial ports provided by P2040 processor. The PCIe
> driver form EXAR is compiled and loaded as kernel module . The same was
> working with linux kernel 3.0.48 and following prints observed while loading
> kernel module.
> 

Have you attempted to use the XR17V35x support present in the updated version
of the kernel that you're using (I assume it's Freescale SDK 1.4.x)?

8250 core support for Exar parts:
http://git.freescale.com/git/cgit.cgi/ppc/sdk/linux.git/tree/drivers/tty/serial/8250/8250.c?h=sdk-v.1.4.x#n296

PCI vendor and device IDs for 2, 4 and 8 port Exar parts:
http://git.freescale.com/git/cgit.cgi/ppc/sdk/linux.git/tree/drivers/tty/serial/8250/8250_pci.c?h=sdk-v.1.4.x#n1722

-Aaron
