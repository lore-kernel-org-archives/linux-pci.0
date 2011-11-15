Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54467 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754840Ab1KONCm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2011 08:02:42 -0500
Received: by vws1 with SMTP id 1so6229305vws.19
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2011 05:02:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJNCFVJG_T+booCV2VoWQTtUJgp3z3KchWOdwQTUgDJ_QQZjRw@mail.gmail.com>
References: <CAJNCFVJzj5ODFXTLjuQ0g8fbAHGpr4q5JaxXugQk1mED-Gg6DA@mail.gmail.com>
	<CAJNCFVKHw9dTS-A4m0ABwDDk91yXfJYqiZHSkKEKj4DLnfv9rg@mail.gmail.com>
	<CAErSpo4k6mCaz7VzQNE2=U5pJr6nm2-TqnGGUMrJO0fUoN-esg@mail.gmail.com>
	<CAJNCFV+qCAu=MR+64Z2oy9eeaoPfNJdgU07o3QOiVm6VxOnqKg@mail.gmail.com>
	<CAErSpo5hEd0MaiHxhTOW8hqxc7a0mvPBo_JDX6neBqO_sr4cpA@mail.gmail.com>
	<CAJNCFVLWCERyxWVPieyxfVnR--zP6_D4Lqqe+VGA4M2KaEwfsw@mail.gmail.com>
	<CAErSpo4UXCVutCyar7a43wWOfm+TgEzAQAO49ek6hdDS7uhAzw@mail.gmail.com>
	<CAJNCFVLCk46yqVvxe+dxpOhcMn2t09XU0PB1ebiYm7BTWkdT=A@mail.gmail.com>
	<CAHM4w1n4+GA=uXOtYzX7UrYY9vj5V-i2SsehyaRk7AJ2ZM6m4Q@mail.gmail.com>
	<CAJNCFVJG_T+booCV2VoWQTtUJgp3z3KchWOdwQTUgDJ_QQZjRw@mail.gmail.com>
Date: Tue, 15 Nov 2011 21:02:41 +0800
Message-ID: <CAJNCFVK8PvhGzwvSLiZpSQ93o14W=9RhzovJJSyNjgHvBySPzA@mail.gmail.com>
Subject: Re: failed to access the mem resource space of the pcie device on arm platform
From: Richard Zhu <richard.zhu@linaro.org>
To: Pratyush Anand <pratyush.anand@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi:
The mem resource access failure had been fixed.
The root cause is that the cmd reg of PCIe host is not set to IO, MEM,
and Master enable, and the iATU configurations is not correct.

Up to now, the firmware can be downloaded by the intel4965 wifi driver.
But system still halt when I run the "ifconfig wlan0 up"

$ ifconfig wlan0 up
ieee80211 phy0: U iwl_prep_station Add STA to driver ID 31: ff:ff:ff:ff:ff:ff
ieee80211 phy0: U iwl_prepare_card_hw iwl_prepare_card_hw enter
ieee80211 phy0: U iwl_set_hw_ready hardware ready
ieee80211 phy0: U iwl_apm_init Init card's basic functions
<halt>

After debug, I found that the system is halt at the following place when
------------------------------codes---------------------------------
static inline int _iwl_grab_nic_access(struct iwl_priv *priv)
{
         int ret;
         u32 val;

         /* this bit wakes up the NIC */
         _iwl_set_bit(priv, CSR_GP_CNTRL,
CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);   <--- here.


wifi driver try to do the following stuff:
------------------------------codes---------------------------------
 /*
  * Activate/Deactivate Tx DMA/FIFO channels according tx fifos mask
  * must be called under priv->lock and mac access
  */
 static void iwl4965_txq_set_sched(struct iwl_priv *priv, u32 mask)
{
         iwl_write_prph(priv, IWL49_SCD_TXFACT, mask);
}


BTW, 2.6.38 kernel is used.

Best Richard
RichardZhu

On 31 October 2011 16:13, Richard Zhu <richard.zhu@linaro.org> wrote:
> Hi Pratyush:
> Thanks for your help.
> The RC host:
> ---------------------------------------------
> root@freescale ~$ ./memtool -32 0x01ffc034 1
> Reading 0x1 count starting at address 0x01FFC034
> 0x01FFC034:  00000040
>
> root@freescale ~$ ./memtool -32 0x01ffc040 1
> Reading 0x1 count starting at address 0x01FFC040
> 0x01FFC040:  DBC35001  <-- First cap
>
> root@freescale ~$ ./memtool -32 0x01ffc050 1
> Reading 0x1 count starting at address 0x01FFC050
> 0x01FFC050:  01807005  <-- second cap
>
> root@freescale ~$ ./memtool -32 0x01ffc070 1
> Reading 0x1 count starting at address 0x01FFC070
> 0x01FFC070:  00420010  <-- the last cap
>
> root@freescale ~$ ./memtool -32 0x01ffc078 1
> Reading 0x1 count starting at address 0x01FFC078
> 0x01FFC078:  00102010   <-- CFG_PCIE_CAP+0x8
> NOTE:
> Max_Payload_Size 3'b000 (128 bytes)
> Max_Read_Request_Size 3'b000 (128 bytes)
>
>
> The EP target:
> ---------------------------------------------
> root@freescale ~$ ./memtool -32 0x01ff0034 1
> Reading 0x1 count starting at address 0x01FF0034
> 0x01FF0034:  000000C8
>
> root@freescale ~$ ./memtool -32 0x01ff00c8 1
> Reading 0x1 count starting at address 0x01FF00C8
> 0x01FF00C8:  C823D001  <-- First cap
>
> root@freescale ~$ ./memtool -32 0x01ff00d0 1
> Reading 0x1 count starting at address 0x01FF00D0
> 0x01FF00D0:  0080E005  <-- Second cap
>
> root@freescale ~$ ./memtool -32 0x01ff00e0 1
> Reading 0x1 count starting at address 0x01FF00E0
> 0x01FF00E0:  00010010  <-- Last cap
>
> root@freescale ~$ ./memtool -32 0x01ff00e8 1
> Reading 0x1 count starting at address 0x01FF00E8
> 0x01FF00E8:  00100810   <-- CFG_PCIE_CAP+0x8
> NOTE:
> Max_Payload_Size 3'b000 (128 bytes)
> Max_Read_Request_Size 3'b000 (128 bytes)
>
> Best Regards
> Richard Zhu
>
> On 28 October 2011 12:12, Pratyush Anand <pratyush.anand@gmail.com> wrote:
>> Hi Richard,
>>
>> PCI analyser log would definitely have been a great help in such cases.
>> Anyway, can you please check "Max_Read_Request_Size"  and
>> "Max_Payload_Size" [CFG_PCIE_CAP + 0x08] for both your RC and EP.
>> Can you please let us know the value programmed in PCIe capabilities
>> cfg registers
>> for both RC and EP.
>>
>> Regards
>> Pratyush
>>
>> On Fri, Oct 28, 2011 at 8:20 AM, Richard Zhu <richard.zhu@linaro.org> wrote:
>>> Hi Bjorn
>>> The x86 lspci is not related to my arm system, just a lspci log referrence.
>>>
>>> I only have one 4965agn mini pcie card, not sure that any PCIe cards
>>> can work on my platform or not.
>>> BTW, I don't have the PCIe analyzer either.
>>> So it's hard to debug the PCIe RC and ahcive the breakthrough.
>>>
>>> Best Regards
>>> Richard Zhu.
>>>
>>> On 28 October 2011 00:03, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>>> I have no idea.  I don't know how the x86 lspci is related at all.  Is
>>>> it related to your arm system somehow?
>>>>
>>>> Do any PCIe cards work on the arm system?  Can you use a PCIe analyzer
>>>> to see if any MMIO transactions appear on the link?
>>>>
>>>> On Thu, Oct 27, 2011 at 1:04 AM, Richard Zhu <richard.zhu@linaro.org> wrote:
>>>>> Hi Bjorn:
>>>>> About the complete lspci on x86 and the dmesg on arm platform, pls
>>>>> refer to the attached file.
>>>>>
>>>>> Thanks.
>>>>>
>>>>> Best Regard.
>>>>>
>>>>> On 26 October 2011 22:08, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>>>>> On Wed, Oct 26, 2011 at 4:08 AM, Richard Zhu <richard.zhu@linaro.org> wrote:
>>>>>>> Hi Bjorn:
>>>>>>> Thanks for your comments firstly.
>>>>>>> The platform only has one PCIe RC mode host, connected one INTEL
>>>>>>> 4965AGN wifi card.
>>>>>>> Doesn't have PCIe bridge device.
>>>>>>>
>>>>>>> The following log is generated on one X86 machine. It seems that the
>>>>>>> 00:00:0 is assigned to the PCI bridge device, is it?
>>>>>>> "00:00.0 Host bridge: Intel Corporation 5520 I/O Hub to ESI Port (rev 13)"
>>>>>>
>>>>>> If you attached a dmesg log, I didn't get it.  How about the complete
>>>>>> "lspci" output, too?
>>>>>>
>>>>>>> About the device address, do you means that the RC mode PCIe host
>>>>>>> should be scanned,
>>>>>>> and assigned the address too?
>>>>>>
>>>>>> I just mean that normal devices (NICs, storage HBAs, USB, VGA, etc.,)
>>>>>> usually are not at bus 0, device 0, function 0.  The fact that your
>>>>>> wifi NIC is apparently is at bus 0, device 0, function 0, is unusual,
>>>>>> so I would investigate that.  Maybe there's something wrong with your
>>>>>> platform's PCI device enumeration.
>>>>>>
>>>>>>>> A complete dmesg log is always a good start.
>>>>>>>>
>>>>>>>> I don't see anything obviously wrong.  The device address (bus 0,
>>>>>>>> device 0, function 0) is unusual, so I'd double-check that.  At least
>>>>>>>> on x86, 00:00.0 is usually something in the north bridge, not a normal
>>>>>>>> device.
>>>>>>>>
>>>>>>>> Bjorn
>>>>>>
>>>>>
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>



-- 
Richard Zhu
Best Regards
