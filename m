Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33951 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755080AbbETV03 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2015 17:26:29 -0400
Message-ID: <555CFC03.5080604@gmail.com>
Date: Wed, 20 May 2015 14:26:27 -0700
From: Alexander Duyck <alexander.duyck@gmail.com>
MIME-Version: 1.0
To: "Rustad, Mark D" <mark.d.rustad@intel.com>,
	Alexander Duyck <alexander.h.duyck@redhat.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [Intel-wired-lan] [PATCH] pci: Use a bus-global mutex to protect
 VPD operations
References: <20150519000037.56109.68356.stgit@mdrustad-wks.jf.intel.com> <555B78F7.60908@redhat.com> <20150519160158.00002cd6@unknown> <555BD029.7050803@redhat.com> <F47DC49C-CCC5-4693-8905-20ABCE6F5993@intel.com> <555BDD14.2080807@redhat.com> <C73FDF83-62F7-47F4-905A-CD7D482F0709@intel.com>
In-Reply-To: <C73FDF83-62F7-47F4-905A-CD7D482F0709@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/20/2015 09:00 AM, Rustad, Mark D wrote:
>> On May 19, 2015, at 6:02 PM, Alexander Duyck <alexander.h.duyck@redhat.com> wrote:
>>
>> My suspicion is that we have a number of bugs floating around out there like the Broadcom issue.  Specifically, one of the ones I found was that the r8169 seems to have a similar issue as called out in the email thread at http://permalink.gmane.org/gmane.linux.network/232260.  I'm wondering if we shouldn't add an initializer for the read/write functions that will go through and pull out the 3 or 4 headers from the VPD data needed to get the actual length.  Then it would lock down the VPD and save some serious time on reads since most devices don't have 32K of VPD to read.
> That is interesting. I noticed that there are functions already present to find VPD tags. If the VPD were invalid, would this block its being read at all, or would it default to allow reading/writing anything? I don't know if there might be people using Linux to completely write the VPD area. Presumably your idea would prevent rewriting the VPD area to something larger.

What we probably would need to do is split the vpd read/write functions 
up a bit further as it turns out some vendors are using it as a means of 
reading/writing the EEPROM for the device.  So we could have something 
like maybe a _raw version of the read/write and one that is intended for 
actually reading VPD.  The VPD one could call something to initialize a 
set of offsets for the read-only descriptor, the read-write descriptor, 
and the end descriptor.  If any read/write goes past the end descriptor 
you could then just return 0 for the read value or skip it for the write.

By my math that means only having to read at most 6 locations in order 
to fill in all the descriptor info and then you could save significant 
time on VPD read for all drivers because would would cut the 32K read 
down to something like 256 bytes which is the more common VPD size.

- Alex
