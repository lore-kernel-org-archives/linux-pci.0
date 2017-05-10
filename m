Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:7373 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750711AbdEJRev (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 May 2017 13:34:51 -0400
Date: Wed, 10 May 2017 13:42:00 -0400
From: Keith Busch <keith.busch@intel.com>
To: Wesley Yung <wesley.yung@microsemi.com>
Cc: Wei Zhang <wzhang@fb.com>, Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Sammy Hui <sammy.hui@intel.com>,
        Joseph Gruher <joseph.r.gruher@intel.com>,
        Krishna Dhulipala <krishnad@fb.com>
Subject: Re: [PATCH 1/2] pcie/dpc: Skip DPC event if device is not present
Message-ID: <20170510174200.GF2572@localhost.localdomain>
References: <1493395369-20225-1-git-send-email-keith.busch@intel.com>
 <1493395369-20225-2-git-send-email-keith.busch@intel.com>
 <862590BB-8E84-4F2D-B5F9-A665000AA9CB@fb.com>
 <20170510131729.GD2572@localhost.localdomain>
 <9D9314D9-2EA5-45C1-AC60-54F7658FD4BC@fb.com>
 <20170510164452.GE2572@localhost.localdomain>
 <90C73AA5E5BE2A428BAACEC9EA6376C982286A7D@avsrvexchmbx2.microsemi.net>
 <90C73AA5E5BE2A428BAACEC9EA6376C982286ABC@avsrvexchmbx2.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <90C73AA5E5BE2A428BAACEC9EA6376C982286ABC@avsrvexchmbx2.microsemi.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Oh, I see what you're asking about. I'm not testing DPC capable RP's. I
do not have such capabilities on my platforms. In fact, the machines I
have are quite old, Sandy Bridge generation.

I've a switch connected to the RP, then the external enclosures are
downstream that.  This topology has multiple levels of switches and
devices, but I still can't unplug the top level as you expected; only
from anywhere in the middle.

Removing the enclosure triggers DPC on the switch connected to the RP.
Sometimes the interrupt handler for the now removed enclosure switches
triggers. The driver checking the DPC status gets a Completer Abort and
the reader see's all 1's, so this is not a CTO type situation.

On Wed, May 10, 2017 at 04:52:16PM +0000, Wesley Yung wrote:
> Just to add more colour:
> 
> If a switch is removed from the RP.  All non posted's will time out.  This includes a config read of any switch P2P.  I believe Keith is saying if a read comes down to read the DPC status on a Switch DS P2P that read will time out after the host TMO.  Once that occurs, the IIO will generate all 1s back to the DPC driver. 
> 
> It means all the back end drivers (DPC, AER, Hot Plug, NVMe) need to have some understanding that all 1s means "something happened".  In the case of the DPC driver, we know the DPC status should never have 1s in the most significant bits so returning all 1s is a special return type that needs to be handled.
> 
> Wes
> 
> -----Original Message-----
> From: Wesley Yung 
> Sent: Wednesday, May 10, 2017 9:43 AM
> To: 'Keith Busch' <keith.busch@intel.com>; Wei Zhang <wzhang@fb.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org; Sammy Hui <sammy.hui@intel.com>; Joseph Gruher <joseph.r.gruher@intel.com>; Krishna Dhulipala <krishnad@fb.com>
> Subject: RE: [PATCH 1/2] pcie/dpc: Skip DPC event if device is not present
> 
> Hey Keith,
> 
> Does the RC Downstream ports also have DPC capability so the driver actually loads for the Root Port DSPs?  Just trying to understand the mechanism.
> 
> For Wei's specific use case, removing a switch from the RP is not officially supported but technically it should be possible to do so.  On the switch end we just need to know where the ecosystem is at so we can make sure to play nice.
> 
> Wes
