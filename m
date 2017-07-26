Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11869 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965735AbdGTWHX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jul 2017 18:07:23 -0400
Subject: Re: [PATCH] PCI: vmd: Free up IRQs on suspend path
To: Scott Bauer <scott.bauer@intel.com>
Cc: linux-pci@vger.kernel.org, keith.busch@intel.com,
        david.fugate@intel.com, bhelgaas@google.com
References: <20170720202858.1918-1-scott.bauer@intel.com>
 <cfc64209-82cb-432b-8ca1-c02c50d34d68@intel.com>
 <20170720213420.lxllowcwnp24gmxf@sbauer-Z170X-UD5>
From: Jon Derrick <jonathan.derrick@intel.com>
Message-ID: <a8fa0b4a-a918-6c98-169c-2b9c35bd8cdb@intel.com>
Date: Tue, 25 Jul 2017 20:36:10 -0600
MIME-Version: 1.0
In-Reply-To: <20170720213420.lxllowcwnp24gmxf@sbauer-Z170X-UD5>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/20/2017 03:34 PM, Scott Bauer wrote:
[snip]
>>> +	for (i = 0; i < vmd->msix_count; i++) {
>>> +		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
>>> +				       vmd_irq, IRQF_NO_THREAD,
>> The flag here looks redundant to me because the fn calls into
>> request_threaded_irq with no thread_fn. But since it's a bit more
>> verbose, can you change the other devm_request_irq to use IRQF_NO_THREAD?
> 
> I actually yanked the request irq from the other call. It was changed
> to NO_THREAD in April:
> 
> (3eefa790c968) PCI: host: Mark PCIe/PCI (MSI) cascade ISR as IRQF_NO_THREAD
> 

Ah so it was. Sorry was looking at v4.12


I think we'll need to do more than free the irq handlers because if an
interrupt occurs after that, I think it'll get kicked to handle_bad_irq.
I think we just need to add pci_disable_device after save and
pcim_enable_device after restore.
