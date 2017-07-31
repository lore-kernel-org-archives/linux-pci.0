Return-Path: <SRS0=Smq5=7C=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=Smq5=7C=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH V4] PCI: handle CRS returned by device after FLR
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 alex.williamson@redhat.com, vikrams@codeaurora.org,
 Lorenzo.Pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
References: <1499375234-23928-1-git-send-email-okaya@codeaurora.org>
 <20170713234910.GB5944@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <7271b29d-5394-997c-a2af-0621d9f3283c@codeaurora.org>
Date: Mon, 31 Jul 2017 17:45:46 -0400
MIME-Version: 1.0
In-Reply-To: <20170713234910.GB5944@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 7/13/2017 7:49 PM, Bjorn Helgaas wrote:
> On Thu, Jul 06, 2017 at 05:07:14PM -0400, Sinan Kaya wrote:
>> An endpoint is allowed to issue Configuration Request Retry Status (CRS)
>> following a Function Level Reset (FLR) request to indicate that it is not
>> ready to accept new requests.
>>
>> Seen a timeout message with Intel 750 NVMe drive and FLR reset.
>>
>> Kernel enables CRS visibility in pci_enable_crs() function for each bridge
>> it discovers. The OS observes a special vendor ID read value of 0xFFFF0001
>> in this case. We need to keep polling until this special read value
>> disappears. pci_bus_read_dev_vendor_id() takes care of CRS handling for a
>> given vendor id read request under the covers.
> 
> This patch isn't about how CRS works; we already have support for
> that.  So this paragraph is mostly extraneous and can be replaced by a
> simple reference to CRS in the spec.  
> 
>> Adding a vendor ID read if this is a physical function before attempting
>> to read any other registers on the endpoint. A CRS indication will only
>> be given if the address to be read is vendor ID register.
>>
>> Note that virtual functions report their vendor ID through another
>> mechanism.
> 
> How VFs report vendor ID is irrelevant.
> 
> What *is* relevant is how FLR affects VFs.  The SR-IOV spec, r1.1,
> sec 2.2.2, says FLR doesn't affect a VF's existence in config space.
> 
> That suggests to me that reading a VF's PCI_COMMAND register after an
> FLR should always return valid data (never ~0).  I suppose an FLR VF
> reset isn't instantaneous, though, so I suppose we do need the 100ms
> delay.  But maybe we should just return immediately after that,
> without reading any VF config space?
> 
> pci_flr_wait() was added by 5adecf817dd6 ("PCI: Wait for up to 1000ms
> after FLR reset"); maybe Alex has more insight into this.
> 
>> The spec is calling to wait up to 1 seconds if the device is sending CRS.
>> The NVMe device seems to be requiring more. Relax this up to 60 seconds.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>  drivers/pci/pci.c | 14 ++++++++++----
>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index aab9d51..83a9784 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3723,10 +3723,16 @@ static void pci_flr_wait(struct pci_dev *dev)
>>  	int i = 0;
>>  	u32 id;
>>  
>> -	do {
>> -		msleep(100);
>> -		pci_read_config_dword(dev, PCI_COMMAND, &id);
>> -	} while (i++ < 10 && id == ~0);
>> +	if (dev->is_virtfn) {
>> +		do {
>> +			msleep(100);
>> +			pci_read_config_dword(dev, PCI_COMMAND, &id);
>> +		} while (i++ < 10 && id == ~0);
>> +	} else {
>> +		if (!pci_bus_read_dev_vendor_id(dev->bus, dev->devfn, &id,
>> +						60*1000))
>> +			id = ~0;
>> +	}
>>  
>>  	if (id == ~0)
>>  		dev_warn(&dev->dev, "Failed to return from FLR\n");
>> -- 
>> 1.9.1
>>
>>

Welcome back from vacation. Let's pick up from where we left. 

Based on our email conversation, here are things I noted:

1. You want to go back to 100ms for virtual functions.
2. You want to print some user visible information when CRS is taking longer.
I can call the vendor ID function 60 times and print a message on each loop
if it helps.
3. You are looking for maximum CRS time reference from the spec. The reference
depends on how you interpret it. I interpreted it as 1 second maximum CRS time.
Keith interpreted it as 1 second being a reference to conventional reset maximum
time rather than CRS time. The fact that no time limit specified in the CRS chapter
also makes me lean towards Keith's interpretation. 
4. I'll clean up the commit message based on your feedback.

Please let me know if I missed anything.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
