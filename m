Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:47297 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967885Ab3DSD2x (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Apr 2013 23:28:53 -0400
Message-ID: <5170B9BD.6040408@huawei.com>
Date: Fri, 19 Apr 2013 11:27:57 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Frank Rizzo <thefrankrizzo@hotmail.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Rescan PCIE bus to find recently powered on device.
References: <SNT136-W425B9A4DBEA719E570080DB2C80@phx.gbl>
In-Reply-To: <SNT136-W425B9A4DBEA719E570080DB2C80@phx.gbl>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2013/4/19 10:59, Frank Rizzo wrote:
> Hey list.
> 
> I'm working on a driver for a device that's external from the PC.  It's connected to the PC via a weird cable that connects to a PCIE card inside the case that appears to be nothing other than glue logic to allow the signals from the cable to be tossed onto the bus.
> 
> When the external device is powered off during boot, nothing is found.  hwinfo doesn't find it, lspci doesn't find it, etc.  If you power on the device BEFORE booting, everything is found, and it works fine.  And lastly, if you power it on AFTER Linux has booted, you still can't find it.  I've tried echoing "1" to rescan, and everything else that I could find via Google search.
> 
> So, what are my options here?  I'm not allergic to adding code to the driver to scan for the device periodically, if I knew HOW to find it.  And, once found, how do I get it registered?
> 

When your device power off during boot, system maybe will not reserve resource like bus res for your device. So when you power on your device after system boot,
system cannot scan your device by rescan interface, I guess.

> 
> Thanks! 		 	   		  --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


-- 
Thanks!
Yijing

