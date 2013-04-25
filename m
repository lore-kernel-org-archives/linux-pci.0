Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nat28.tlf.novell.com ([130.57.49.28]:41965 "EHLO
	nat28.tlf.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756710Ab3DYJkW convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-pci@vger.kernel.org:6:1>);
	Thu, 25 Apr 2013 05:40:22 -0400
Message-Id: <5179164902000078000D0A26@nat28.tlf.novell.com>
Date: Thu, 25 Apr 2013 10:40:57 +0100
From: "Jan Beulich" <JBeulich@suse.com>
To: "Bjorn Helgaas" <bhelgaas@google.com>
Cc: "Jeremy Fitzhardinge" <jeremy@goop.org>,
	"Gavin Shan" <shangw@linux.vnet.ibm.com>,
	<xen-devel@lists.xensource.com>,
	"Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH v4 18/22] xen/pci: Pay attention to
 PCI_MSIX_TABLE_OFFSET
References: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
 <20130422231214.32621.37394.stgit@bhelgaas-glaptop>
 <CAErSpo6BF0Uvf=7LwYYT2Qn6kf5uk+rVqY-cKOe2qnVwcj4-+w@mail.gmail.com>
In-Reply-To: <CAErSpo6BF0Uvf=7LwYYT2Qn6kf5uk+rVqY-cKOe2qnVwcj4-+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>>> On 24.04.13 at 18:34, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Mon, Apr 22, 2013 at 5:12 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> The MSI-X Table structure may be at a non-zero offset into the
>> device BAR, and we should account for that.

NAK: The base is just being use to pass to the hypervisor, which
then takes care to add the offset. Recent hypervisors will actually
only consume this to issue a warning if not matching what gets
read from the corresponding BAR. Earlier hypervisors used this
instead of reading the BAR.

Jan

>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> ---
>>  arch/x86/pci/xen.c |    4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
>> index 94e7662..0e8a196 100644
>> --- a/arch/x86/pci/xen.c
>> +++ b/arch/x86/pci/xen.c
>> @@ -300,8 +300,10 @@ static int xen_initdom_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>>                         pci_read_config_dword(dev, pos + PCI_MSIX_TABLE,
>>                                               &table_offset);
>>                         bir = (u8)(table_offset & PCI_MSIX_FLAGS_BIRMASK);
>> +                       table_offset &= PCI_MSIX_TABLE_OFFSET;
>>
>> -                       map_irq.table_base = pci_resource_start(dev, bir);
>> +                       map_irq.table_base = pci_resource_start(dev, bir) +
>> +                               table_offset;
>>                         map_irq.entry_nr = msidesc->msi_attrib.entry_nr;
>>                 }
>>
>>


