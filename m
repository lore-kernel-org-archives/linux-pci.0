Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db8lp0185.outbound.messaging.microsoft.com ([213.199.154.185]:25874
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751807Ab3LFCQ7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 5 Dec 2013 21:16:59 -0500
Received: from mail130-db8 (localhost [127.0.0.1])	by
 mail130-db8-R.bigfish.com (Postfix) with ESMTP id 70BF2804E2	for
 <linux-pci@vger.kernel.org>; Fri,  6 Dec 2013 02:16:57 +0000 (UTC)
Received: from DB8EHSMHS026.bigfish.com (unknown [10.174.8.254])	by
 mail130-db8.bigfish.com (Postfix) with ESMTP id 7D25F20232	for
 <linux-pci@vger.kernel.org>; Fri,  6 Dec 2013 02:16:55 +0000 (UTC)
From: Rajat Jain <rajatjain@juniper.net>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: Guenter Roeck <groeck@juniper.net>
Subject: Getting a new vendor ID / device ID added to
 "include/linux/pci_ids.h"
Date: Fri, 6 Dec 2013 02:16:50 +0000
Message-ID: <393f524403744e7598b594c1a8b3dfeb@DM2PR05MB671.namprd05.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

My company's vendor ID (Juniper Networks: 0x1304) shows up in:

http://www.pcidatabase.com/vendor_details.php?id=410

However, I do not see that in "include/linux/pci_ids.h".

Can you please let me know what is the procedure to get a vendor / product ID added to this file? I'm assuming it's not as simple as submitting a patch?

Thanks,

Rajat

