Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH V3 2/2] PCI: handle CRS returned by device after FLR
To: Alex Williamson <alex.williamson@redhat.com>
References: <1475473021-14251-1-git-send-email-okaya@codeaurora.org>
 <1475473021-14251-3-git-send-email-okaya@codeaurora.org>
 <ac667a77-028d-d5da-f574-61f787fec72c@codeaurora.org>
 <20170221135138.791ba4e2@t450s.home>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
        cov@codeaurora.org, vikrams@codeaurora.org,
        Lorenzo.Pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <fa4f3b57-dccc-c64a-0787-1ecd3687534f@codeaurora.org>
Date: Tue, 21 Feb 2017 21:37:23 -0500
MIME-Version: 1.0
In-Reply-To: <20170221135138.791ba4e2@t450s.home>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2/21/2017 3:51 PM, Alex Williamson wrote:
> On Tue, 21 Feb 2017 12:04:24 -0500
> Sinan Kaya <okaya@codeaurora.org> wrote:
> 
>> Hi Alex,
>>
>> I'm coming back to work on this. 
>>
>> On 10/3/2016 1:37 AM, Sinan Kaya wrote:
>>> An endpoint is allowed to issue CRS following an FLR request to indicate
>>> that it is not ready to accept new requests. Changing the polling mechanism
>>> in FLR wait function to go read the vendor ID instead of the command/status
>>> register. A CRS indication will only be given if the address to be read is
>>> vendor ID.
>>>
>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>>> ---
>>>  drivers/pci/pci.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>> index c8749b9..7580b00 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -3725,7 +3725,8 @@ static void pci_flr_wait(struct pci_dev *dev)
>>>  
>>>  	do {
>>>  		msleep(100);
>>> -		pci_read_config_dword(dev, PCI_COMMAND, &id);  
>>
>> Your comment here puzzled me. 
>>
>> https://patchwork.kernel.org/patch/8331851/
>>
>> "Self nak on this one, didn't account for VFs not implementing the first
>> dword.  Thanks,"
>>
>> I'm trying to add Configuration Request Retry Status (CRS) support to FLR
>> with this patch. 
>>
>> Basically, the root port will return 0xFFFF0001 only when a config read
>> request is sent to the vendor ID register and CRS visibility is set.
>> The SW needs to poll until this special read ID disappears. See the
>> implementation note on Configuration Request Retry Status in PCIE
>> specification for details.
>>
>> pci_bus_read_dev_vendor_id implements this loop for us.
>>
>> You are saying that there are VFs that do not implement vendor ID register.
>> Can you give some history on this?
> 
> SR-IOV spec rev 1.1, 3.4.1.1 & 3.4.1.2, Vendor ID and Device ID fields
> for the VF return 0xFFFF when read.  The "Virtualization Intermediary"
> is supposed to use the vendor ID from the PF and the device ID defined
> in the PF SR-IOV capability.


Interesting. Since lspci was showing the correct vendor id and device id, I
assumed that it is coming from offset 0.

Maybe, the right thing is to figure out if this is a virtual function or not.
If it is a physical function, check the CRS first before reading the command
register in the existing loop.


> 
>>
>>> +		pci_bus_read_dev_vendor_id(dev->bus, dev->devfn, &id,
>>> +					   60 * 1000);
>>>  	} while (i++ < 10 && id == ~0);
> 
> pci_bus_read_dev_vendor_id() seems like it will return false with an
> id value of ~0 for a functional VF, so this loop will spin longer than
> necessary and report an invalid error.  Patch 1/2 from this series
> would cause pci_dev_restore() to be a no-op on VFs.  Thanks,
> 
> Alex
> 
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
