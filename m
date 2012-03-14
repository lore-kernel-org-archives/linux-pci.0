Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4F605A9E.3020205@intel.com>
Date: Wed, 14 Mar 2012 08:45:18 +0000
From: Tadeusz Struk <tadeusz.struk@intel.com>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
CC: bhelgaas@google.com, jbarnes@virtuousgeek.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Device specific reset function
References: <4f5e2a73.YyO0Gu2m5JhSVsu6%tadeusz.struk@intel.com> <1331606555.22608.6.camel@ul30vt>
In-Reply-To: <1331606555.22608.6.camel@ul30vt>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 13/03/12 02:42, Alex Williamson wrote:
> On Mon, 2012-03-12 at 16:55 +0000, Tadeusz Struk wrote:
>> I have a use case where I need to cleanup resource allocated for Virtual
>> Functions after a guest OS that used it crashed. This cleanup needs to
>> be done before the VF is being FLRed. The only possible way to do this
>> seems to be by using pci_dev_specific_reset() function.
>> This patch adds specific reset function to the pci_driver struct.
>>
>> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
>> ---
>>  drivers/pci/quirks.c |    4 ++++
>>  include/linux/pci.h  |    1 +
>>  2 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 6476547..13d224b 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -3081,8 +3081,12 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>>  
>>  int pci_dev_specific_reset(struct pci_dev *dev, int probe)
>>  {
>> +	struct pci_driver *drv = dev->driver;
>>  	const struct pci_dev_reset_methods *i;
>>  
>> +	if (drv && drv->reset)
>> +		return drv->reset(dev, probe);
>> +
> 
> Isn't this exactly what the below code is for (pci_dev_reset_methods)?
> In the case of KVM device assignment, the device should be reset via
> this path if the guest crashes, but it may or may not be attached to
> pci-stub at the time.  I assume you're not adding a reset handler to
> pci-stub, so we'll pass through here and use FLR, violating the premise
> of the patch.  Thanks,
> 
> Alex

Hi,
The reset handler supposed to be in the "real" driver not in the pci-stub.
You are right, at this stage the VF can still be assigned to the pci-stub, which makes it useless in my case.
I think the only option for me will be to go with the v2 of the patch.
I'll do a bit more testing to make sure this is the case and resend the v2.
Thanks,
Tadeusz


