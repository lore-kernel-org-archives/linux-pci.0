Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CADaLNDn77GqA6E3XPbgJkZzVUjQtDg6=cO_yQk6aFCdu+g5V9Q@mail.gmail.com>
References: <1434053294-10962-1-git-send-email-dhdang@apm.com>
 <20150612215900.GK23119@google.com> <CADaLNDn77GqA6E3XPbgJkZzVUjQtDg6=cO_yQk6aFCdu+g5V9Q@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 12 Jun 2015 18:08:01 -0500
Message-ID: <CAErSpo5Oc_8ca4h7xYSkGPFE1vxWg1sy1rJRc0B=u9LrdOLY7g@mail.gmail.com>
Subject: Re: [PATCH 1/1] PCI: X-Gene: Disable Configuration Request Retry
 Status for X-Gene v1 PCIe
To: Duc Dang <dhdang@apm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ian Campbell <ian.campbell@citrix.com>,
	Marcin Juszkiewicz <mjuszkiewicz@redhat.com>,
	Tanmay Inamdar <tinamdar@apm.com>, patches <patches@apm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 12, 2015 at 5:10 PM, Duc Dang <dhdang@apm.com> wrote:
> Hi Bjorn,
>
> On Fri, Jun 12, 2015 at 2:59 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> Hi Duc,
>>
>> On Thu, Jun 11, 2015 at 01:08:14PM -0700, Duc Dang wrote:
>>> X-Gene v1 PCIe controller has a bug in Configuration Request Retry
>>> Status (CRS) logic:
>>>   When CPU tries to read Vendor ID and Device ID of not-existed
>>>   remote device, the controller returns 0xFFFF0001 instead of
>>>   0xFFFFFFFF; this will add significant delay in boot time as
>>>   pci_bus_read_dev_vendor_id will wait for 60 seconds before
>>>   giving up.
>>
>> OK, help me understand how this works.  I think this is related to the
>> problem I reported where if the slot is empty, "lspci" doesn't show
>> anything, not even the Root Port leading to the slot.
>>
>> I think this happens because when we try to read the Root Port's config
>> space,
>>
>>   - the slot below the Root Port is empty
>>   - the Root Port's link is down
>>   - xgene_pcie_map_bus() returns NULL because !port->link_up
>>   - pci_generic_config_read32() returns PCIBIOS_DEVICE_NOT_FOUND
>>
>> so it looks like the Root Port itself doesn't exist.
>>
>> I proposed to change xgene_pcie_map_bus() so it didn't check whether the
>> link was up.  That change makes reads of the Root Port's config space work.
>>
>> After we learn the Root Port exists, the PCI core enumerates devices below
>> the Root Port, e.g., on bus 01.  X-Gene advertises that it supports CRS, so
>> we enable it.  When we try to read the Vendor ID of 01:00.0, there's no
>> response from the device (because the slot is empty), and the Root Complex
>> should complete the read by fabricating data of all ones, i.e., 0xFFFFFFFF.
>> But apparently X-Gene supplies 0xFFFF0001 instead, which means "there's a
>> device here, but it's not ready yet," so the PCI core retries the read for
>> 60 seconds before timing out.
>>
>> This patch is basically a quirk that keeps X-Gene from advertising CRS
>> support, so the PCI core won't enable CRS.  In the example above, I guess
>> that means the Root Complex will supply 0xFFFFFFFF and the core will see
>> that the slot is empty.
>>
>> But this patch leaves the "!port->link_up" test in xgene_pcie_map_bus().
>> Doesn't that mean the core will still not discover the Root Port when the
>> slot is empty?
>>
>> It seems to me that you would want both the xgene_pcie_map_bus() change and
>> this patch.  The first would fix the problem that we don't enumerate Root
>> Ports leading to empty slots, and the second would fix the problem that we
>> enable CRS and timeout when enumerating below those Root Ports.
>>
> Yes, you are right. I plan to send a follow up patch after this one to
> remove the port->link_up check in xgene_pcie_map_bus and make root
> port discoverable even when the slot is empty. I can combine this
> follow up patch with this one if you feel OK with it.

Two patches would be great.  I just didn't know about your plans for
the follow-up one.

Bjorn
