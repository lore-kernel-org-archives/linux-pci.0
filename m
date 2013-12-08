Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:40962 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708Ab3LHFIG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 8 Dec 2013 00:08:06 -0500
Date: Sat, 7 Dec 2013 21:09:35 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Rajat Jain <rajatjain@juniper.net>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Guenter Roeck <groeck@juniper.net>
Subject: Re: Getting a new vendor ID / device ID added to
 "include/linux/pci_ids.h"
Message-ID: <20131208050935.GA20118@kroah.com>
References: <393f524403744e7598b594c1a8b3dfeb@DM2PR05MB671.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <393f524403744e7598b594c1a8b3dfeb@DM2PR05MB671.namprd05.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 06, 2013 at 02:16:50AM +0000, Rajat Jain wrote:
> Hi,
> 
> My company's vendor ID (Juniper Networks: 0x1304) shows up in:
> 
> http://www.pcidatabase.com/vendor_details.php?id=410
> 
> However, I do not see that in "include/linux/pci_ids.h".

Please read the top of that file for why you shouldn't add new ids
there.

Is it causing a problem with the id not being in that file?  Why do you
need it there?

thanks,

greg k-h
