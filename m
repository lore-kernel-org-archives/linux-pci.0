Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db9lp0251.outbound.messaging.microsoft.com ([213.199.154.251]:28686
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751496Ab3LFDJ7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 5 Dec 2013 22:09:59 -0500
Received: from mail29-db9 (localhost [127.0.0.1])	by mail29-db9-R.bigfish.com
 (Postfix) with ESMTP id 1D928140742	for <linux-pci@vger.kernel.org>; Fri,  6
 Dec 2013 03:09:58 +0000 (UTC)
Received: from DB9EHSMHS006.bigfish.com (unknown [10.174.16.227])	by
 mail29-db9.bigfish.com (Postfix) with ESMTP id A57DD30007E	for
 <linux-pci@vger.kernel.org>; Fri,  6 Dec 2013 03:09:55 +0000 (UTC)
From: Guenter Roeck <groeck@juniper.net>
To: Rajat Jain <rajatjain@juniper.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: Getting a new vendor ID / device ID added to
 "include/linux/pci_ids.h"
Date: Fri, 6 Dec 2013 03:09:49 +0000
Message-ID: <f0f1cb7e25a04d5bb1ec9ccb3c423f5c@CO1PR05MB523.namprd05.prod.outlook.com>
References: <393f524403744e7598b594c1a8b3dfeb@DM2PR05MB671.namprd05.prod.outlook.com>
In-Reply-To: <393f524403744e7598b594c1a8b3dfeb@DM2PR05MB671.namprd05.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If it is needed in more than one upstream driver, you submit a patch. Otherwise keep it local.

Guenter

________________________________________
From: Rajat Jain
Sent: Thursday, December 05, 2013 6:16 PM
To: linux-pci@vger.kernel.org
Cc: Guenter Roeck
Subject: Getting a new vendor ID / device ID added to "include/linux/pci_ids.h"

Hi,

My company's vendor ID (Juniper Networks: 0x1304) shows up in:

http://www.pcidatabase.com/vendor_details.php?id=410

However, I do not see that in "include/linux/pci_ids.h".

Can you please let me know what is the procedure to get a vendor / product ID added to this file? I'm assuming it's not as simple as submitting a patch?

Thanks,

Rajat

