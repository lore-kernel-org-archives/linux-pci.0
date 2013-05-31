Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:34447
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751161Ab3EaGnE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 31 May 2013 02:43:04 -0400
From: "Huang, Shane" <Shane.Huang@amd.com>
To: Jean Delvare <khali@linux-fr.org>
CC: Tejun Heo <tj@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: [PATCH 3/3] i2c-piix4: add AMD CZ SMBus device ID
Date: Fri, 31 May 2013 06:42:54 +0000
Message-ID: <43EB3AB3EEFE8D43B525F4D2EAF507E1085B8CC5@SCYBEXDAG04.amd.com>
References: <1369999333-2073-1-git-send-email-shane.huang@amd.com>
 <20130531080336.04481330@endymion.delvare>
In-Reply-To: <20130531080336.04481330@endymion.delvare>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jean,

> Please don't change the case. This makes your patch larger and
> increases the risk of conflict with other patches, for no good reason.
> 
> Other than that, the patch looks OK.

I didn't want to change it but checkpatch.pl warns due to
"Hudson-2" in i2c-piix4.c

Thanks,
Shane


