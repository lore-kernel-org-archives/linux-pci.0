Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from am1ehsobe003.messaging.microsoft.com ([213.199.154.206]:11157
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752650Ab3EaHeK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 31 May 2013 03:34:10 -0400
From: "Huang, Shane" <Shane.Huang@amd.com>
To: Jean Delvare <khali@linux-fr.org>
CC: Tejun Heo <tj@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: [PATCH 3/3] i2c-piix4: add AMD CZ SMBus device ID
Date: Fri, 31 May 2013 07:33:51 +0000
Message-ID: <43EB3AB3EEFE8D43B525F4D2EAF507E1085B8D06@SCYBEXDAG04.amd.com>
References: <1369999333-2073-1-git-send-email-shane.huang@amd.com>
	<20130531080336.04481330@endymion.delvare>
	<43EB3AB3EEFE8D43B525F4D2EAF507E1085B8CC5@SCYBEXDAG04.amd.com>
 <20130531092846.51f2e202@endymion.delvare>
In-Reply-To: <20130531092846.51f2e202@endymion.delvare>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Can you show the exact message? checkpatch doesn't complain here, and I
> can't think of any reason why it would care about that.

$ ./scripts/checkpatch.pl 0003-i2c-piix4-add-AMD-CZ-SMBus-device-ID.patch
WARNING: Avoid CamelCase: <Hudson>
#52: FILE: drivers/i2c/busses/i2c-piix4.c:25:
+       AMD Hudson-2, CZ

total: 0 errors, 1 warnings, 39 lines checked


Thanks,
Shane

