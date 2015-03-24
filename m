Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:61927 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752294AbbCXPih (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 24 Mar 2015 11:38:37 -0400
Message-ID: <5511849F.3050903@intel.com>
Date: Tue, 24 Mar 2015 23:37:03 +0800
From: Aaron Lu <aaron.lu@intel.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] PCI / ACPI: PCI delay optimization from ACPI
References: <54FD4FB9.2060802@intel.com> <5222588.FaRe37n2T1@vostro.rjw.lan> <54FE93A4.9040908@intel.com> <20150320210354.GK26935@google.com> <550FDA38.2090505@intel.com> <20150323150955.GR26935@google.com> <551128BA.7070508@intel.com> <20150324140812.GB2495@google.com>
In-Reply-To: <20150324140812.GB2495@google.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/24/2015 10:08 PM, Bjorn Helgaas wrote:
> On Tue, Mar 24, 2015 at 05:04:58PM +0800, Aaron Lu wrote:
>> @@ -575,6 +637,9 @@ static void pci_acpi_setup(struct device *dev)
>>  	if (!adev)
>>  		return;
>>  
>> +	if (pci_dev->pm_cap)
>> +		pci_acpi_delay_optimize(pci_dev, adev->handle);
> 
> Is the "pm_cap" test really necessary?  If we do it this way, we then have
> to convince ourselves that pdev->d3cold_delay and pdev->d3_delay are only
> needed when pdev has a pm_cap.
> 
> If we *always* fill in the delay values, it's possible they won't be used,
> but we don't have to prove any connection between them and a pm_cap, so
> the code is easier to analyze.

I remembered why I did the pm_cap test: the d3cold_delay and d3_delay is
only filled when pm_cap is set in pci_pm_init - if the device doesn't
have PCI_CAP_ID_PM set, its pm_cap will be 0 and d3cold_delay, d3_delay
will not be assigned.
