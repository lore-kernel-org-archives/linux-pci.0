Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1blp0184.outbound.protection.outlook.com ([207.46.163.184]:40052
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750938AbaHYSrY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 25 Aug 2014 14:47:24 -0400
Message-ID: <1408992434.6510.47.camel@snotra.buserror.net>
Subject: Re: PCIe driver not working properly after upgrading to linux 3.8.13
From: Scott Wood <scottwood@freescale.com>
To: Gokul C G <gokul.g@kalkitech.in>
CC: <linux-pci@vger.kernel.org>
Date: Mon, 25 Aug 2014 13:47:14 -0500
In-Reply-To: <53F9E486.9050801@kalkitech.in>
References: <53F3629A.6060208@kalkitech.in>
	 <1408491984.4058.48.camel@snotra.buserror.net>
	 <53F9E486.9050801@kalkitech.in>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 2014-08-24 at 18:41 +0530, Gokul C G wrote:
> HI all,
> 
> Thank you very much for your information .I solved my problem !!!
> 
> Here is my findings 
> =====================
>  I found out that support for the PCIe serial extension for
> ( XR17V35x) has been added to the standard Linux serial driver. If I
> just need to transmit/receive data, then this driver will work
> perfectly fine. The deficiencies is that you can not use any of the
> enhanced features in the XR17V35x such as the larger FIFOs, automatic
> hardware/software flow control, auto RS-485 half-duplex control, etc.
> 
> Now I have 2 options:
> 1. Remove support for the XR17V35x IDs and re-compile the kernel, then
> use the module driver.
> 2. Use an external EEPROM to use different Vendor and/or Device IDs so
> that you can use the module driver.

3. Remove the generic PCI serial driver from your config.
4. Dynamically unbind the device using sysfs, and either defer module
loading until after this, or rebind it to the already-loaded specialized
driver using sysfs.
5. Add these features to the standard PCI serial driver. :-)

-Scott



