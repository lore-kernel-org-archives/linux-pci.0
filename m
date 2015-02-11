Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <54DB1EAC.3060302@mm-sol.com>
Date: Wed, 11 Feb 2015 11:19:40 +0200
From: Stanimir Varbanov <svarbanov@mm-sol.com>
MIME-Version: 1.0
To: "Matwey V. Kornilov" <matwey@sai.msu.ru>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mohit KUMAR <mohit.kumar@st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCHv2 1/2] pci: spear: Use platform_driver_probe instead of
 platform_driver_register
References: <1423585882-5464-1-git-send-email-matwey@sai.msu.ru>	<CAKohpoknDBJpDAfAGCGb2V_Uq6j3vL=CYOWLzsEn7p35Bi6oEg@mail.gmail.com>	<54DB0A52.4090907@mm-sol.com> <CAJs94EYS003e_j0S4rzKFEL=PqCqEmT7yd0qdJdnMrziE1700Q@mail.gmail.com>
In-Reply-To: <CAJs94EYS003e_j0S4rzKFEL=PqCqEmT7yd0qdJdnMrziE1700Q@mail.gmail.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

please don't top posting.

On 02/11/2015 10:38 AM, Matwey V. Kornilov wrote:
> It sounds reasonable, but does current implementation support deferring?

yes, it uses deferred probe see devm_phy_get() and devm_clk_get() calls 
in .probe and how the returned values are checked.

> Struct  spear13xx_pcie_driver just dissapears from memory after init.

IMO this is expected because spear13xx_pcie_driver is annotated as 
__initdata.

The proper solution was pointed by Kumar below, but we also need to 
remove the __init from dw_pcie_host_init() which is called from driver 
.probe.

> 11.02.2015 11:18 пользователь "Stanimir Varbanov" <svarbanov@mm-sol.com>
> написал:
>
>> Hi,
>>
>> On 02/11/2015 05:35 AM, Viresh Kumar wrote:
>>
>>> On 11 February 2015 at 00:31, Matwey V. Kornilov <matwey@sai.msu.ru>
>>> wrote:
>>>
>>>> Use platform_driver_probe instead of platform_driver_register
>>>> because the former allows us to use probe function placed into __init
>>>> section
>>>> and the driver itself is not support hotplugging (yet?).
>>>>
>>>> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
>>>> ---
>>>> Changes from v1:
>>>>    - Use platform_driver_probe instead of platform_driver_register to
>>>> make linker happy.ven after it is used
>>>>
>>>>    drivers/pci/host/pcie-spear13xx.c | 3 +--
>>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-
>>>> spear13xx.c
>>>> index 866465f..51e1344 100644
>>>> --- a/drivers/pci/host/pcie-spear13xx.c
>>>> +++ b/drivers/pci/host/pcie-spear13xx.c
>>>> @@ -371,7 +371,6 @@ static const struct of_device_id
>>>> spear13xx_pcie_of_match[] = {
>>>>    MODULE_DEVICE_TABLE(of, spear13xx_pcie_of_match);
>>>>
>>>>    static struct platform_driver spear13xx_pcie_driver __initdata = {
>>>> -       .probe          = spear13xx_pcie_probe,
>>>>           .driver = {
>>>>                   .name   = "spear-pcie",
>>>>                   .of_match_table = of_match_ptr(spear13xx_pcie_
>>>> of_match),
>>>> @@ -382,7 +381,7 @@ static struct platform_driver spear13xx_pcie_driver
>>>> __initdata = {
>>>>
>>>>    static int __init spear13xx_pcie_init(void)
>>>>    {
>>>> -       return platform_driver_register(&spear13xx_pcie_driver);
>>>> +       return platform_driver_probe(&spear13xx_pcie_driver,
>>>> spear13xx_pcie_probe);
>>>>    }
>>>>    module_init(spear13xx_pcie_init);
>>>>
>>>
>>> The problem here is that the driver is never registered. And we might
>>> never
>>> see it in sysfs. Probably a better solution would be to just remove all
>>> __init
>>> parts from this driver. Let it take space even after it is used. And
>>> don't care
>>> about it.
>>>
>>> Sorry was busy in a conference and couldn't reply to your earlier mail on
>>> this.
>>>
>>
>> Using platform_driver_probe() prevents deferred probe which is problem
>> because you get phy, clocks from probe, and these calls could return
>> EPROBE_DEFFER.
>>
>> Also dw_pcie_host_init() called from spear13xx_add_pcie_port() is
>> annotated as __init. I wanted send a patch which removes __init from
>> dw_pcie_host_init() but I haven't time, yet.
>>
>> regards,
>> Stan
>>
>>
>
