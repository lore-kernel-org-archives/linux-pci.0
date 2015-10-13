Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:45896 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326AbbJMULg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 13 Oct 2015 16:11:36 -0400
Subject: Re: [PATCH] PCI: iproc: fix 32-bit build error
To: Hauke Mehrtens <hauke@hauke-m.de>, Arnd Bergmann <arnd@arndb.de>,
	<linux-arm-kernel@lists.infradead.org>
References: <1442363962-29805-1-git-send-email-rjui@broadcom.com>
 <1442363962-29805-8-git-send-email-rjui@broadcom.com>
 <CAMAWPa_Hsuv+skzt3S6e9X_kWY=2JXAScbVEVOVTGmn81_bcFw@mail.gmail.com>
 <11199595.GgDE2yo8AA@wuerfel> <561D6458.40504@hauke-m.de>
CC: Kevin Hilman <khilman@kernel.org>,
	Tyler Baker <tyler.baker@linaro.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Olof Johansson <olof@lixom.net>,
	"Mark Brown" <broonie@kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	"Linux PCI" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
From: Ray Jui <rjui@broadcom.com>
Message-ID: <561D6576.2020107@broadcom.com>
Date: Tue, 13 Oct 2015 13:11:34 -0700
MIME-Version: 1.0
In-Reply-To: <561D6458.40504@hauke-m.de>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 10/13/2015 1:06 PM, Hauke Mehrtens wrote:
> On 10/13/2015 10:02 PM, Arnd Bergmann wrote:
>> The iproc PCI driver tries to figure out whether the MMIO window has
>> a valid size, but does this using a 64-bit modulo operation, which
>> is not allowed on 32-bit kernels and leads to a link error:
>>
>> drivers/built-in.o: In function `iproc_pcie_setup':
>> :(.text+0x4b798): undefined reference to `__aeabi_uldivmod'
>>
>> This works around that error by using the div64_u64() function
>> provided by the kernel. While this is an expensive operation,
>> it is harmless because we only call it during the probing
>> of the driver.
>>

Thanks, Arnd. Guess I did not see this issue when running on ARM32 based
platforms like Cygnus, because LAPE was not enabled by default for
multi_v7_defconfig. When LAPE is enabled, resource_size_t becomes 64-bit.

>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Fixes: 0ab99ca8eb6c ("PCI: iproc: Fix compile warnings")
>>
>> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
>> index f3481ddff344..abcb4be2ee19 100644
>> --- a/drivers/pci/host/pcie-iproc.c
>> +++ b/drivers/pci/host/pcie-iproc.c
>> @@ -235,12 +235,13 @@ static void iproc_pcie_enable(struct iproc_pcie *pcie)
>>   *
>>   * axi_addr -> iproc_pcie_address -> OARR -> OMAP -> pci_address
>>   */
>> -static int iproc_pcie_setup_ob(struct iproc_pcie *pcie, u64 axi_addr,
>> +int iproc_pcie_setup_ob(struct iproc_pcie *pcie, u64 axi_addr,
> 
> Why are you removing the static here?
> 

Yeah we should keep this function as static. The rest of this change
looks good!

>>  			       u64 pci_addr, resource_size_t size)
>>  {
>>  	struct iproc_pcie_ob *ob = &pcie->ob;
>>  	unsigned i;
>>  	u64 max_size = (u64)ob->window_size * MAX_NUM_OB_WINDOWS;
>> +	u64 remainder;
>>  
>>  	if (size > max_size) {
>>  		dev_err(pcie->dev,
>> @@ -249,7 +250,8 @@ static int iproc_pcie_setup_ob(struct iproc_pcie *pcie, u64 axi_addr,
>>  		return -EINVAL;
>>  	}
>>  
>> -	if (size % ob->window_size) {
>> +	div64_u64_rem(size, ob->window_size, &remainder);
>> +	if (remainder) {
>>  		dev_err(pcie->dev,
>>  			"res size %pap needs to be multiple of window size %pap\n",
>>  			&size, &ob->window_size);
>>
> 

Thanks,

Ray
