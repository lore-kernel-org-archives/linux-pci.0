Return-Path: <SRS0=Z6GG=Z5=linux.vnet.ibm.com=gwshan@kernel.org>
Return-Path: <SRS0=Z6GG=Z5=linux.vnet.ibm.com=gwshan@kernel.org>
Date: Fri, 17 Feb 2017 09:38:08 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, mpe@ellerman.id.au, bhelgaas@google.com
Subject: Re: [PATCH 0/3] pci/hotplug/pnv-php: More bug fixes
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1487200954-14681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20170216140925.GA21042@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170216140925.GA21042@bhelgaas-glaptop.roam.corp.google.com>
Message-Id: <20170216223808.GA7493@gwshan>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 16, 2017 at 08:09:26AM -0600, Bjorn Helgaas wrote:
>On Thu, Feb 16, 2017 at 10:22:31AM +1100, Gavin Shan wrote:
>> This series bases on the series: https://patchwork.ozlabs.org/patch/713513.
>> This series fixes couple of issues:
>> 
>>    * Remove WARN_ON() in pnv_php_put_slot(). The parent slot's refcount
>>      is decreased when releasing PCI slot. The parent slot can be NULL
>>      and no need to give a warning.
>>    * The MSI (or MSIx) could be enabled prior to load pnv-php.ko. A
>>      backtrace is thrown when phv-php.ko attempts to enable MSI again.
>>      PATCH[2/3] skips enabling surprise hotplug if MSI has been enabled
>>      by other driver.
>>    * PATCH[3/3] doesn't disable MSI that was enabled by other dirver.
>>      Also, the upstream port of the PCI slot is disabled when it's
>>      destroyed.
>> 
>> Gavin Shan (3):
>>   pci/hotplug/pnv-php: Remove WARN_ON() in pnv_php_put_slot()
>>   pci/hotplug/pnv-php: Disable surprise hotplug capability on conflicts
>>   pci/hotplug/pnv-php: Disable MSI and PCI device properly
>> 
>>  drivers/pci/hotplug/pnv_php.c | 32 +++++++++++++++++++++++---------
>>  1 file changed, 23 insertions(+), 9 deletions(-)
>
>Since this is specific to pnv_php.c and depends on a previous series
>applied by Michael, I assume he'll handle this series as well.
>

Bjorn, yes, I think Michael will take care of this series and all
changes to pnv_php.c in future, as we all agreed previously. I was
asked by Michael to copy linux-pci@ and you when posting patches for
this component.

Thanks,
Gavin
