Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45709 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755209Ab2JBRiv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 2 Oct 2012 13:38:51 -0400
Message-ID: <506B26A2.2070603@redhat.com>
Date: Tue, 02 Oct 2012 13:38:42 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Yuval Mintz <yuvalmin@broadcom.com>
CC: linux-pci@vger.kernel.org, bhelgaas@google.com,
	bhutchings@solarflare.com, gregory.v.rose@intel.com,
	davem@davemloft.net
Subject: Re: [RFC] PCI: enable and disable sriov support via sysfs at per
 device level
References: <1349134020-62152-1-git-send-email-ddutile@redhat.com> <506A9892.5090707@broadcom.com>
In-Reply-To: <506A9892.5090707@broadcom.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/02/2012 03:32 AM, Yuval Mintz wrote:
>> +static void pci_sriov_remove_sysfs_dev_files(struct pci_dev *dev)
>> +{
>> +	int pos;
>> +
>> +	if ((dev->is_physfn)&&  pci_is_pcie(dev)) {
>> +            pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_SRIOV);
>> +            if (pos)
>> +		device_remove_file(&dev->dev, pci_dev_sriov_attrs);
>
> Shouldn't it iterate over the attributes when removing them?
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

good catch; that should be:
  +	int pos, i;
     ....
  +                for (i = 0; attr_name(pci_dev_sriov_attrs[i]); i++)
  +			device_remove_file(&dev->dev, &pci_dev_sriov_attrs);

it doesn't remove the files in reverse order, but neither does
the device-generic code for dev-attrs.


Another question for RFC:
-- above shows I didn't test with hot-plug
-- which makes me wonder/think if [get,put]_device([dev,parent]) needed
    during [create,remove]_file() calls.

