Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from goliath.siemens.de ([192.35.17.28]:58454 "EHLO
	goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbcFWRcF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2016 13:32:05 -0400
Subject: Re: [PATCH] pci: Add support for unbinding the generic PCI host
 controller
To: Will Deacon <will.deacon@arm.com>
References: <57698276.6050606@siemens.com> <20160622060638.GY29165@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <576C1CF6.7020804@siemens.com>
Date: Thu, 23 Jun 2016 19:31:34 +0200
MIME-Version: 1.0
In-Reply-To: <20160622060638.GY29165@arm.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2016-06-22 08:06, Will Deacon wrote:
> Hi Jan,
> 
> On Tue, Jun 21, 2016 at 08:07:50PM +0200, Jan Kiszka wrote:
>> Particularly useful when working in virtual environments where the
>> controller may come and go, but possibly not only there.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  drivers/pci/ecam.h                  |  1 +
>>  drivers/pci/host/pci-host-common.c  | 13 +++++++++++++
>>  drivers/pci/host/pci-host-generic.c |  1 +
>>  3 files changed, 15 insertions(+)
>>
>> diff --git a/drivers/pci/ecam.h b/drivers/pci/ecam.h
>> index 9878beb..5a5f607 100644
>> --- a/drivers/pci/ecam.h
>> +++ b/drivers/pci/ecam.h
>> @@ -63,5 +63,6 @@ extern struct pci_ecam_ops pci_generic_ecam_ops;
>>  /* for DT-based PCI controllers that support ECAM */
>>  int pci_host_common_probe(struct platform_device *pdev,
>>  			  struct pci_ecam_ops *ops);
>> +int pci_host_common_remove(struct platform_device *pdev);
>>  #endif
>>  #endif
>> diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/host/pci-host-common.c
>> index 8cba7ab..c0ff4b1 100644
>> --- a/drivers/pci/host/pci-host-common.c
>> +++ b/drivers/pci/host/pci-host-common.c
>> @@ -164,6 +164,19 @@ int pci_host_common_probe(struct platform_device *pdev,
>>  	}
>>  
>>  	pci_bus_add_devices(bus);
>> +	platform_set_drvdata(pdev, bus);
>> +	return 0;
>> +}
>> +
>> +int pci_host_common_remove(struct platform_device *pdev)
>> +{
>> +	struct pci_bus *bus = platform_get_drvdata(pdev);
>> +
>> +	pci_lock_rescan_remove();
>> +	pci_stop_root_bus(bus);
>> +	pci_remove_root_bus(bus);
>> +	pci_unlock_rescan_remove();
> 
> A couple of comments/questions about this:
> 
>   - The probe path seems to have some stateful operations outside of PCI
>     resources. For example, kzalloc'ing the bus_range resource in
>     of_pci_get_host_bridge_resources. Do we need to clean these up
>     explicitly?
> 
>   - Similarly, we don't seem to tear-down the config space mappings and
>     data structures for that, so we leak VA space afaict.
> 

Good points. But to my understanding, everything is released
automatically on pci_remove_root_bus because all the resources are
registered with the bus which takes care of them during destruction. And
if I trace the release, I find this e.g.

...
devres_release_all() {
  _raw_spin_lock_irqsave();
  release_nodes() {
    _raw_spin_unlock_irqrestore();
    devm_action_release() {
      gen_pci_unmap_cfg() {

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
