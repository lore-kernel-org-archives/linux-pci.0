Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0046.outbound.protection.outlook.com ([104.47.36.46]:60648
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750979AbdGaGkz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jul 2017 02:40:55 -0400
Subject: Re: [PATCH] usb: xhci: Add quirk for Certain failing HP keyboard on
 reset after resume
To: Greg KH <gregkh@linuxfoundation.org>,
        Sandeep Singh <Sandeep.Singh@amd.com>
References: <1501144509-19357-1-git-send-email-Sandeep.Singh@amd.com>
 <20170730141159.GA21849@kroah.com>
Cc: mathias.nyman@intel.com, bhelgaas@google.com,
        dheitmueller@kernellabs.com, stern@rowland.harvard.edu,
        samuel.thibault@ens-lyon.org, lukas@oxygene.sk,
        linux-usb@vger.kernel.org, linux-pci@vger.kernel.org,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
From: Sandeep Singh <ssingh1@amd.com>
Message-ID: <060e5b58-07ff-4e2c-9739-d75c3c40c085@amd.com>
Date: Mon, 31 Jul 2017 12:10:08 +0530
MIME-Version: 1.0
In-Reply-To: <20170730141159.GA21849@kroah.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Greg,

Thanks for review. Apart from pci_ids.h, I see only 3 options, add this id as macro in pci_quirks.c
or pci_quirks.h or just hardcode it.

please suggest what will good option as per your view.

Regards
Sandeep

On 7/30/2017 7:41 PM, Greg KH wrote:
> On Thu, Jul 27, 2017 at 02:05:09PM +0530, Sandeep Singh wrote:
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index c71e532..d3f2296 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -583,6 +583,7 @@
>>  #define PCI_DEVICE_ID_AMD_HUDSON2_SMBUS		0x780b
>>  #define PCI_DEVICE_ID_AMD_HUDSON2_IDE		0x780c
>>  #define PCI_DEVICE_ID_AMD_KERNCZ_SMBUS  0x790b
>> +#define PCI_DEVICE_ID_AMD_TAISHAN	0x145c
>>  
>>  #define PCI_VENDOR_ID_TRIDENT		0x1023
>>  #define PCI_DEVICE_ID_TRIDENT_4DWAVE_DX	0x2000
> 
> Please read the top of this file for why you shouldn't be adding new ids
> to it.
> 
> thnaks,
> 
> greg k-h
> 
