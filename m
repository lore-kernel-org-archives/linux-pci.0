Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:17536 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755041Ab2DNSmt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 14 Apr 2012 14:42:49 -0400
Message-ID: <4F89C513.3000006@snewbury.org.uk>
Date: Sat, 14 Apr 2012 19:42:27 +0100
From: Steven Newbury <steve@snewbury.org.uk>
MIME-Version: 1.0
To: Steven Newbury <steve@snewbury.org.uk>
CC: Yinghai Lu <yinghai@kernel.org>,
	"Barnes, Jesse" <jesse.barnes@intel.com>,
	Dave Airlie <airlied@linux.ie>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	DRI mailing list <dri-devel@lists.freedesktop.org>
Subject: Re: PCI resources above 4GB
References: <1333968563.5678.19.camel@infinity>  <CAErSpo7hGvJSmq4U37XN9T7ZaYn55fyy9t3ER5BBCDdQ3XZxqw@mail.gmail.com>  <4F84110E.3000400@snewbury.org.uk>  <CAE9FiQVHf_pcXUspOtLXx4XminmzdWja3Ra2Wh5jQRbfNOQ1eQ@mail.gmail.com>  <4F8467AA.90305@snewbury.org.uk>  <CAE9FiQWaop0NE7ZJu6jVW3SnxLkOJ9hRKh4xMNk64XjCAMRMMw@mail.gmail.com>  <4F848357.3060007@snewbury.org.uk>  <CAE9FiQXTgh3X4x+xD1T0ipsEbhbPtctYucfGeuWK=cq7kHeZ1Q@mail.gmail.com>  <4F848E10.1090703@snewbury.org.uk>  <CAE9FiQXvwYrJhLi91VDVtD4+OOfbGQ1U20-Cap+8tBZUt7QCkA@mail.gmail.com>  <1334089568.4083.2.camel@Nokia-N900>  <CAE9FiQWnvB2VbBQQaEnDE0nf+Zwy6nyoGrEuVrUesQEzgYfbvA@mail.gmail.com>  <4F84A3EC.6030903@snewbury.org.uk>  <CAE9FiQU+EEtBWrc66Sw4GFQjSy9Vh9fyFvhgQUheev_aVpAzrw@mail.gmail.com>  <1334229754.30606.7.camel@Nokia-N900>   <CAE9FiQXhzAOErMeQxz6U-BSYAK1LirHMpiFH90iRoXxwduPhPw@mail.gmail.com> <1334248841.2910.6.camel@Nokia-N900> <4F89B5E8.3040906@snewbury.org.uk> <4F89BC84.50308@snewbury.org.uk>
In-Reply-To: <4F89BC84.50308@snewbury.org.uk>
Content-Type: multipart/mixed;
 boundary="------------030108080205020703000006"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------030108080205020703000006
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 14/04/12 19:05, Steven Newbury wrote:
> On 14/04/12 18:37, Steven Newbury wrote:
>> On 12/04/12 17:40, Steven Newbury wrote:
>>> On Thu, 12 Apr 2012, 17:07:33 BST, Yinghai Lu 
>>> <yinghai@kernel.org> wrote:
> 
>>>> On Thu, Apr 12, 2012 at 4:22 AM, Steven Newbury 
>>>> <steve@snewbury.org.uk> wrote:
>>>>> Thanks, that fixed it! :) I had a similar patch I've been 
>>>>> working on but I had my fix in the wrong place!
>>>>> 
>>>>> In the working case, initially the BIOS has set GMA to 
>>>>> within the low system DRAM 0xC0000000 obviously invalid. 
>>>>> This conflict is detected and it's relallocated to 
>>>>> 0x12000000.
>>>>> 
>>>>> I've attempted to modify probe.c to disable 64-bit BARs not
>>>>>  allocated above 4G so they get reallocated above when 
>>>>> possible later.  It seemed to work, but again broke GMA 
>>>>> despite the BAR originally containing an invalid address
>>>>> as mentioned above, it seems for some reason something is 
>>>>> different when the conflict is detected and rellocated, 
>>>>> compared to disabling it early then allocating a valid 
>>>>> value..?
>>>>> 
>> I've created a new quirk utilising an extra PCI resource flag to 
>> force reallocation of the resource.  It's the first approach
>> I've had any success at.  It does work.  Only "Intel Page Flush"
>> now gets allocated @0xe0000000!
> 
> 
> Hopefully this should fix "Intel Flush Page"
Need to export pci_bus_alloc_resource_fit for intel-gtt.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+JxRMACgkQGcb56gMuC61LegCcCuANujog4iiIziKwFtcCla1s
7BEAoLfLEEXKT1WhboX/m8bMBP90QCgb
=zwK6
-----END PGP SIGNATURE-----

--------------030108080205020703000006
Content-Type: text/x-patch;
 name="export-resource_fit.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="export-resource_fit.diff"

commit fe2ccc15c3cd75af2a582dc6e2b4deb544aca307
Author: Steven Newbury <steve@snewbury.org.uk>
Date:   Sat Apr 14 19:37:32 2012 +0100

    PCI: Export pci_bus_alloc_resource_fit()

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 6d2b073..acb51bd 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -391,6 +391,7 @@ void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
 EXPORT_SYMBOL_GPL(pci_walk_bus);
 
 EXPORT_SYMBOL(pci_bus_alloc_resource);
+EXPORT_SYMBOL(pci_bus_alloc_resource_fit);
 EXPORT_SYMBOL_GPL(pci_bus_add_device);
 EXPORT_SYMBOL(pci_bus_add_devices);
 EXPORT_SYMBOL(pci_enable_bridges);

--------------030108080205020703000006--
