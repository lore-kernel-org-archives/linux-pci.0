Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-dm3nam03on0079.outbound.protection.outlook.com ([104.47.41.79]:10252
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752789AbdEJQwg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 May 2017 12:52:36 -0400
From: Wesley Yung <wesley.yung@microsemi.com>
To: Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Sammy Hui <sammy.hui@intel.com>,
        Joseph Gruher <joseph.r.gruher@intel.com>,
        Krishna Dhulipala <krishnad@fb.com>
Subject: RE: [PATCH 1/2] pcie/dpc: Skip DPC event if device is not present
Date: Wed, 10 May 2017 16:52:16 +0000
Message-ID: <90C73AA5E5BE2A428BAACEC9EA6376C982286ABC@avsrvexchmbx2.microsemi.net>
References: <1493395369-20225-1-git-send-email-keith.busch@intel.com>
 <1493395369-20225-2-git-send-email-keith.busch@intel.com>
 <862590BB-8E84-4F2D-B5F9-A665000AA9CB@fb.com>
 <20170510131729.GD2572@localhost.localdomain>
 <9D9314D9-2EA5-45C1-AC60-54F7658FD4BC@fb.com>
 <20170510164452.GE2572@localhost.localdomain>
 <90C73AA5E5BE2A428BAACEC9EA6376C982286A7D@avsrvexchmbx2.microsemi.net>
In-Reply-To: <90C73AA5E5BE2A428BAACEC9EA6376C982286A7D@avsrvexchmbx2.microsemi.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Just to add more colour:

If a switch is removed from the RP.  All non posted's will time out.  This =
includes a config read of any switch P2P.  I believe Keith is saying if a r=
ead comes down to read the DPC status on a Switch DS P2P that read will tim=
e out after the host TMO.  Once that occurs, the IIO will generate all 1s b=
ack to the DPC driver.=20

It means all the back end drivers (DPC, AER, Hot Plug, NVMe) need to have s=
ome understanding that all 1s means "something happened".  In the case of t=
he DPC driver, we know the DPC status should never have 1s in the most sign=
ificant bits so returning all 1s is a special return type that needs to be =
handled.

Wes

-----Original Message-----
From: Wesley Yung=20
Sent: Wednesday, May 10, 2017 9:43 AM
To: 'Keith Busch' <keith.busch@intel.com>; Wei Zhang <wzhang@fb.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org; Sammy H=
ui <sammy.hui@intel.com>; Joseph Gruher <joseph.r.gruher@intel.com>; Krishn=
a Dhulipala <krishnad@fb.com>
Subject: RE: [PATCH 1/2] pcie/dpc: Skip DPC event if device is not present

Hey Keith,

Does the RC Downstream ports also have DPC capability so the driver actuall=
y loads for the Root Port DSPs?  Just trying to understand the mechanism.

For Wei's specific use case, removing a switch from the RP is not officiall=
y supported but technically it should be possible to do so.  On the switch =
end we just need to know where the ecosystem is at so we can make sure to p=
lay nice.

Wes

-----Original Message-----
From: Keith Busch [mailto:keith.busch@intel.com]=20
Sent: Wednesday, May 10, 2017 9:45 AM
To: Wei Zhang <wzhang@fb.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org; Wesley =
Yung <wesley.yung@microsemi.com>; Sammy Hui <sammy.hui@intel.com>; Joseph G=
ruher <joseph.r.gruher@intel.com>; Krishna Dhulipala <krishnad@fb.com>
Subject: Re: [PATCH 1/2] pcie/dpc: Skip DPC event if device is not present

EXTERNAL EMAIL


On Wed, May 10, 2017 at 04:35:06PM +0000, Wei Zhang wrote:
> Hi Keith,
>
> I see.  I thought the current CPU root complex does not support such a us=
e case, ie removing the DPC switch device itself and might result in kernel=
 panic.  But I agree this will make the code future-proof when CPU does sup=
port such a case in the future.

What do you mean in the future? I do this today (hotplug enclosures), but I=
 need this fix in place otherwise we get a use-after-free when the DPC work=
 queue runs after the hotplug code freed the topology that includes the DPC=
 parts.
