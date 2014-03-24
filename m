Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:26005
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751132AbaCXXTz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 24 Mar 2014 19:19:55 -0400
From: Rajat Jain <rajatjain@juniper.net>
To: Yinghai Lu <yinghai@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: Rajat Jain <rajatxjain@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Guenter Roeck <groeck@juniper.net>
Subject: RE: [PATCH v2] pciehp: only wait command complete for real hotplug
 control
Date: Mon, 24 Mar 2014 23:19:48 +0000
Message-ID: <83f00436a12b44f799bd1222b91297cd@DM2PR05MB671.namprd05.prod.outlook.com>
References: <CAA93t1rPE3yUh8nAGJDiqeGhixznZdhdyFwRoX_c1VWT3WEtvw@mail.gmail.com>
 <1395699232-28727-1-git-send-email-yinghai@kernel.org>
In-Reply-To: <1395699232-28727-1-git-send-email-yinghai@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Just a note  :-)

> -v2: use second way that is suggested by Bjorn.
>     It also solve the problem on Rajat's sytem that have wrong inital CC

Er, not wrong initial CC.

Just a different (but not necessarily wrong) different CC bit behavior :-). In my systems, the CC bit gets set for every write to the slot control register (even if Button, LED, EMI, power controller are not implemented).

> Tested-by: Rajat Jain <rajatxjain@gmail.com>

Yes, I tested and it seems to work fine on such systems too.

Best Regards,

Rajat

