Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48893 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751388AbbESRzI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 19 May 2015 13:55:08 -0400
Message-ID: <555B78F7.60908@redhat.com>
Date: Tue, 19 May 2015 10:55:03 -0700
From: Alexander Duyck <alexander.h.duyck@redhat.com>
MIME-Version: 1.0
To: Mark D Rustad <mark.d.rustad@intel.com>, bhelgaas@google.com
CC: linux-pci@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH] pci: Use a bus-global mutex to protect
 VPD operations
References: <20150519000037.56109.68356.stgit@mdrustad-wks.jf.intel.com>
In-Reply-To: <20150519000037.56109.68356.stgit@mdrustad-wks.jf.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 05/18/2015 05:00 PM, Mark D Rustad wrote:
> Some devices have a problem with concurrent VPD access to different
> functions of the same physical device, so move the protecting mutex
> from the pci_vpd structure to the pci_bus structure. There are a
> number of reports on support sites for a variety of devices from
> various vendors getting the "vpd r/w failed" message. This is likely
> to at least fix some of them. Thanks to Shannon Nelson for helping
> to come up with this approach.
>
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> Acked-by: Shannon Nelson <shannon.nelson@intel.com>
> Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

Instead of moving the mutex lock around you would be much better served 
by simply removing the duplicate VPD entries for a given device in a 
PCIe quirk.  Then you can save yourself the extra pain and effort of 
having to deal with serialized VPD accesses for a multifunction device.

The logic for the quirk should be fairly simple.
   1.  Scan for any other devices with VPD that share the same bus and 
device number.
   2.  If bdf is equal to us keep searching.
   3.  If bdf is less than our bdf we release our VPD area and set VPD 
pointer to NULL.

- Alex

