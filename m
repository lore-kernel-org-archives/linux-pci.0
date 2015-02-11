Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ns.mm-sol.com ([37.157.136.199]:55518 "EHLO extserv.mm-sol.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751234AbbBKHxc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 11 Feb 2015 02:53:32 -0500
Message-ID: <54DB0A52.4090907@mm-sol.com>
Date: Wed, 11 Feb 2015 09:52:50 +0200
From: Stanimir Varbanov <svarbanov@mm-sol.com>
MIME-Version: 1.0
To: Viresh Kumar <viresh.kumar@linaro.org>,
	"Matwey V. Kornilov" <matwey@sai.msu.ru>
CC: Mohit KUMAR <mohit.kumar@st.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 1/2] pci: spear: Use platform_driver_probe instead of
 platform_driver_register
References: <1423585882-5464-1-git-send-email-matwey@sai.msu.ru> <CAKohpoknDBJpDAfAGCGb2V_Uq6j3vL=CYOWLzsEn7p35Bi6oEg@mail.gmail.com>
In-Reply-To: <CAKohpoknDBJpDAfAGCGb2V_Uq6j3vL=CYOWLzsEn7p35Bi6oEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On 02/11/2015 05:35 AM, Viresh Kumar wrote:
> On 11 February 2015 at 00:31, Matwey V. Kornilov <matwey@sai.msu.ru> wrote:
>> Use platform_driver_probe instead of platform_driver_register
>> because the former allows us to use probe function placed into __init section
>> and the driver itself is not support hotplugging (yet?).
>>
>> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
>> ---
>> Changes from v1:
>>   - Use platform_driver_probe instead of platform_driver_register to make linker happy.
>>
>>   drivers/pci/host/pcie-spear13xx.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
>> index 866465f..51e1344 100644
>> --- a/drivers/pci/host/pcie-spear13xx.c
>> +++ b/drivers/pci/host/pcie-spear13xx.c
>> @@ -371,7 +371,6 @@ static const struct of_device_id spear13xx_pcie_of_match[] = {
>>   MODULE_DEVICE_TABLE(of, spear13xx_pcie_of_match);
>>
>>   static struct platform_driver spear13xx_pcie_driver __initdata = {
>> -       .probe          = spear13xx_pcie_probe,
>>          .driver = {
>>                  .name   = "spear-pcie",
>>                  .of_match_table = of_match_ptr(spear13xx_pcie_of_match),
>> @@ -382,7 +381,7 @@ static struct platform_driver spear13xx_pcie_driver __initdata = {
>>
>>   static int __init spear13xx_pcie_init(void)
>>   {
>> -       return platform_driver_register(&spear13xx_pcie_driver);
>> +       return platform_driver_probe(&spear13xx_pcie_driver, spear13xx_pcie_probe);
>>   }
>>   module_init(spear13xx_pcie_init);
>
> The problem here is that the driver is never registered. And we might never
> see it in sysfs. Probably a better solution would be to just remove all __init
> parts from this driver. Let it take space even after it is used. And don't care
> about it.
>
> Sorry was busy in a conference and couldn't reply to your earlier mail on this.

Using platform_driver_probe() prevents deferred probe which is problem 
because you get phy, clocks from probe, and these calls could return 
EPROBE_DEFFER.

Also dw_pcie_host_init() called from spear13xx_add_pcie_port() is 
annotated as __init. I wanted send a patch which removes __init from 
dw_pcie_host_init() but I haven't time, yet.

regards,
Stan
