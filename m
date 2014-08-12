Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog132.obsmtp.com ([207.126.144.207]:53415 "EHLO
	eu1sys200aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752162AbaHLH5h (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Aug 2014 03:57:37 -0400
Message-ID: <53E9C79D.6080704@mellanox.com>
Date: Tue, 12 Aug 2014 10:51:57 +0300
From: Amir Vadai <amirv@mellanox.com>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Wei Yang <weiyang@linux.vnet.ibm.com>
CC: <linux-pci@vger.kernel.org>, <alex.williamson@redhat.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Yevgeny Petrilin <yevgenyp@mellanox.com>,
	Eli Cohen <eli@mellanox.com>, Peter Paneah <peter@mellanox.com>
Subject: Re: [PATCH v2] PCI: Mark broken INTx masking for Mellanox devices
References: <1406868871-350-1-git-send-email-gwshan@linux.vnet.ibm.com> <20140811134854.GA5794@richard> <20140812035226.GA15421@shangw>
In-Reply-To: <20140812035226.GA15421@shangw>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/12/2014 6:52 AM, Gavin Shan wrote:
> On Mon, Aug 11, 2014 at 09:48:54PM +0800, Wei Yang wrote:
>> >On Fri, Aug 01, 2014 at 02:54:31PM +1000, Gavin Shan wrote:
>>> >>The VFIO driver is routing LSI interrupts by capturing, masking,
>>> >>and then delivering. When passing though Mallanox adapters from
>> >
>> >one typo                                  Mellanox
>> >
>> >Others, looks good to me.
>> >
> Thanks, Richard. I'll correct it in next revision. However, I'm
> still waiting for comments or ACK from Alex/Eli/Amir.
> 
> Thanks,
> Gavin
> 

Hi Gavin,

Sorry for the delay - wanted to understand the exact limitations with
our Hardware/Firmware guys.

Please change the device to PCI_ANY_ID since all Mellanox devices
currently need the quirk.
The issue will be fixed in the next GA firmwares.

Thanks,
Amir
