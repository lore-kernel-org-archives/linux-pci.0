Return-Path: <SRS0=IzY1=RG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58382C10F00
	for <linux-pci@archiver.kernel.org>; Sun,  3 Mar 2019 17:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267F02146E
	for <linux-pci@archiver.kernel.org>; Sun,  3 Mar 2019 17:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfLtDHc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfCCRux (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 3 Mar 2019 12:50:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46616 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfCCRux (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 3 Mar 2019 12:50:53 -0500
Received: by mail-wr1-f68.google.com with SMTP id i16so3017820wrs.13;
        Sun, 03 Mar 2019 09:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oebZDyM933K9G40rqLs4BJHaI5sNHNiq04G+YQA4ZB8=;
        b=OfLtDHc+xOfhZvZe+ovFYvFGwZISyxtYbWQRFjelhUDYTgVEilN3n06pUUaOVen+i5
         mPdpiJ5QMxuVunzeIr1TeAWtrmgr8A2ABWic7/Pu8HAcgOp1UmMDjhxagrmEzObqztzI
         /ndCPLaRZc5pJ5sPS6xnTQGguamx1DVGw1CLgbiKLphd3roa9ZdM9bBL50eoL7MUny7v
         g9LiPelNj8R7p8YoG2xa/RrdOLn7IyesYyzUETsDhJ3D1+6rHu7Oyo0n1QAjA/hPWkxm
         kkURYAINw8n/YIaTmOzNYdOFz2L5iekstc5TR3//LknfZD5MdArtpGcvgCDWasYyS2Vn
         1UFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oebZDyM933K9G40rqLs4BJHaI5sNHNiq04G+YQA4ZB8=;
        b=DeL06U7Iu5vqZ0GpnKIUb6UgpH61KnUhTWssBPQlHD4rbj+SH0MjsGyfe2S4jMTiEj
         0KERDgV4Ogc252a9+4vV/HSv2TRdlcxP24Ni65YyyBEiNNvCXnAUpQZszD25zrje9Jil
         CfEQXTDr3izqlS940XawA+Cqm00xMga9DHOWI6sVMsUCuwWBOkqWbj95T7mZuzFybyD1
         AYgjd1GhQdY/efcBWV9PfR+yVQLE0NbPLwuZWK8Eykks8hBnQV1VkYeTwPTnSXU12IXV
         JKJUbnrMlIApdVUWl/ZSYS9BPSRq0axcidsHIXovxF+8gyWB8RXD0g9AqRsE5P9pe2lH
         zsXQ==
X-Gm-Message-State: APjAAAWsR1rqIdyzapf4IhgcbQza6PD4X7TJ3QvNoa1u0tJ0DYhuBtlu
        PfxoIhawwq03RsaI0CNmmUkUizyn
X-Google-Smtp-Source: APXvYqzawi14K8+nukEhL/oqDNNIaYBKJZqOPFbxZIxhuPErjNTMHszvESsCWp5iqQNO87TL6U2Bfg==
X-Received: by 2002:a5d:4f86:: with SMTP id d6mr10100404wru.89.1551635449442;
        Sun, 03 Mar 2019 09:50:49 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id o127sm6921246wmo.20.2019.03.03.09.50.47
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 09:50:48 -0800 (PST)
Subject: Re: [PATCH][RFC] PCI: rcar: Add bus notifier so we can limit the DMA
 range
To:     Wolfram Sang <wsa@the-dreams.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        linux-renesas-soc@vger.kernel.org
References: <20180521220514.30256-1-marek.vasut+renesas@gmail.com>
 <20180918101555.GB26886@e107981-ln.cambridge.arm.com>
 <20180918105130.GA1545@kunai>
 <649ec02e-1e0d-d4b2-cf26-7a7601b1f1d5@gmail.com>
 <a23080b3-0044-3352-d459-0cb6c7d0f2ee@gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <2dd55c92-05fd-f5f3-f733-8c9c1f97b1d3@gmail.com>
Date:   Sun, 3 Mar 2019 18:48:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <a23080b3-0044-3352-d459-0cb6c7d0f2ee@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/2/18 12:44 AM, Marek Vasut wrote:
> On 09/22/2018 07:06 PM, Marek Vasut wrote:
>> On 09/18/2018 12:51 PM, Wolfram Sang wrote:
>>> On Tue, Sep 18, 2018 at 11:15:55AM +0100, Lorenzo Pieralisi wrote:
>>>> On Tue, May 22, 2018 at 12:05:14AM +0200, Marek Vasut wrote:
>>>>> From: Phil Edworthy <phil.edworthy@renesas.com>
>>>>>
>>>>> The PCIe DMA controller on RCar Gen2 and earlier is on 32bit bus,
>>>>> so limit the DMA range to 32bit.
>>>>>
>>>>> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
>>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>>>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>>>>> Cc: Phil Edworthy <phil.edworthy@renesas.com>
>>>>> Cc: Simon Horman <horms+renesas@verge.net.au>
>>>>> Cc: Wolfram Sang <wsa@the-dreams.de>
>>>>> Cc: linux-renesas-soc@vger.kernel.org
>>>>> To: linux-pci@vger.kernel.org
>>>>> ---
>>>>> NOTE: I'm aware of https://patchwork.kernel.org/patch/9495895/ , but the
>>>>>       discussion seems to have gone way off, so I'm sending this as a
>>>>>       RFC. Any feedback on how to do this limiting properly would be nice.
>>>>> ---
>>>>>  drivers/pci/host/pcie-rcar.c | 28 ++++++++++++++++++++++++++++
>>>>>  1 file changed, 28 insertions(+)
>>>>
>>>> The issue solved by this patch was solved in a more generic way through
>>>> this series:
>>>>
>>>> https://lists.linuxfoundation.org/pipermail/iommu/2018-July/028792.html
>>>>
>>>> I will therefore drop this patch from the PCI patch queue.
>>>
>>> Cool. Thanks for this series and thanks for the heads up!
>>>
>>> Marek, can you confirm our issue is fixed (if you haven't done already)?
>>
>> I assembled a setup with NVMe controller, which should be triggering
>> this issue according to [1], but I'm not having much success getting it
>> to work with or without this patchset. Logs are below, nvme smart-log
>> seems to produce completely bogus results, although the device is at
>> least recognized.
>>
>> Maybe there's something else that's broken ?
>>
>> [1] https://patchwork.kernel.org/patch/9495895/
>>
>> # dmesg | egrep '(pci|nvm)'
>> rcar-pcie fe000000.pcie: host bridge /soc/pcie@fe000000 ranges:
>> rcar-pcie fe000000.pcie: Parsing ranges property...
>> rcar-pcie fe000000.pcie:    IO 0xfe100000..0xfe1fffff -> 0x00000000
>> rcar-pcie fe000000.pcie:   MEM 0xfe200000..0xfe3fffff -> 0xfe200000
>> rcar-pcie fe000000.pcie:   MEM 0x30000000..0x37ffffff -> 0x30000000
>> rcar-pcie fe000000.pcie:   MEM 0x38000000..0x3fffffff -> 0x38000000
>> rcar-pcie fe000000.pcie: PCIe x1: link up
>> rcar-pcie fe000000.pcie: Current link speed is 5 GT/s
>> rcar-pcie fe000000.pcie: PCI host bridge to bus 0000:00
>> pci_bus 0000:00: root bus resource [bus 00-ff]
>> pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]
>> pci_bus 0000:00: root bus resource [mem 0xfe200000-0xfe3fffff]
>> pci_bus 0000:00: root bus resource [mem 0x30000000-0x37ffffff]
>> pci_bus 0000:00: root bus resource [mem 0x38000000-0x3fffffff pref]
>> pci_bus 0000:00: scanning bus
>> pci 0000:00:00.0: [1912:0025] type 01 class 0x060400
>> pci 0000:00:00.0: enabling Extended Tags
>> pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
>> pci 0000:00:00.0: PME# disabled
>> pci_bus 0000:00: fixups for bus
>> pci 0000:00:00.0: scanning [bus 01-01] behind bridge, pass 0
>> pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
>> pci_bus 0000:01: scanning bus
>> pci 0000:01:00.0: [8086:f1a5] type 00 class 0x010802
>> pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
>> pci 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5 GT/s
>> x1 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8 GT/s x4 link)
>> pci_bus 0000:01: fixups for bus
>> pci_bus 0000:01: bus scan returning with max=01
>> pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
>> pci_bus 0000:00: bus scan returning with max=01
>> pci 0000:00:00.0: BAR 14: assigned [mem 0xfe200000-0xfe2fffff]
>> pci 0000:01:00.0: BAR 0: assigned [mem 0xfe200000-0xfe203fff 64bit]
>> pci 0000:00:00.0: PCI bridge to [bus 01]
>> pci 0000:00:00.0:   bridge window [mem 0xfe200000-0xfe2fffff]
>> pcieport 0000:00:00.0: assign IRQ: got 0
>> pcieport 0000:00:00.0: enabling device (0000 -> 0002)
>> pcieport 0000:00:00.0: enabling bus mastering
>> pcieport 0000:00:00.0: Signaling PME with IRQ 198
>> rcar-pcie ee800000.pcie: host bridge /soc/pcie@ee800000 ranges:
>> rcar-pcie ee800000.pcie: Parsing ranges property...
>> rcar-pcie ee800000.pcie:    IO 0xee900000..0xee9fffff -> 0x00000000
>> rcar-pcie ee800000.pcie:   MEM 0xeea00000..0xeebfffff -> 0xeea00000
>> rcar-pcie ee800000.pcie:   MEM 0xc0000000..0xc7ffffff -> 0xc0000000
>> rcar-pcie ee800000.pcie:   MEM 0xc8000000..0xcfffffff -> 0xc8000000
>> rcar-pcie ee800000.pcie: PCIe link down
>> nvme 0000:01:00.0: assign IRQ: got 171
>> nvme nvme0: pci function 0000:01:00.0
>> nvme 0000:01:00.0: enabling device (0000 -> 0002)
>> nvme 0000:01:00.0: enabling bus mastering
>> nvme nvme0: Shutdown timeout set to 60 seconds
>>
>> # lspci -nvvvs 01:00.0
>> 01:00.0 0108: 8086:f1a5 (rev 03) (prog-if 02 [NVM Express])
>>         Subsystem: 8086:390a
>>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>> ParErr- Stepping- SERR- FastB2B- DisINTx-
>>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>         Latency: 0
>>         Interrupt: pin A routed to IRQ 171
>>         Region 0: Memory at fe200000 (64-bit, non-prefetchable) [size=16K]
>>         Capabilities: [40] Power Management version 3
>>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
>> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>         Capabilities: [70] Express (v2) Endpoint, MSI 00
>>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
>> unlimited, L1 unlimited
>>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
>> SlotPowerLimit 0.000W
>>                 DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+
>> Unsupported+
>>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
>> FLReset-
>>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>>                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
>> TransPend-
>>                 LnkCap: Port #0, Speed 8GT/s, Width x4, ASPM L1, Exit
>> Latency L0s <1us, L1 <8us
>>                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
>>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>                 LnkSta: Speed 5GT/s, Width x1, TrErr- Train- SlotClk+
>> DLActive- BWMgmt- ABWMgmt-
>>                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+,
>> LTR+, OBFF Via message
>>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-,
>> LTR-, OBFF Disabled
>>                 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance-
>> SpeedDis-
>>                          Transmit Margin: Normal Operating Range,
>> EnterModifiedCompliance- ComplianceSOS-
>>                          Compliance De-emphasis: -6dB
>>                 LnkSta2: Current De-emphasis Level: -6dB,
>> EqualizationComplete-, EqualizationPhase1-
>>                          EqualizationPhase2-, EqualizationPhase3-,
>> LinkEqualizationRequest-
>>         Capabilities: [b0] MSI-X: Enable- Count=16 Masked-
>>                 Vector table: BAR=0 offset=00002000
>>                 PBA: BAR=0 offset=00002100
>>         Capabilities: [100 v2] Advanced Error Reporting
>>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
>> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
>>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
>> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
>> UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
>> NonFatalErr-
>>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
>> NonFatalErr+
>>                 AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+
>> ChkEn-
>>         Capabilities: [158 v1] #19
>>         Capabilities: [178 v1] Latency Tolerance Reporting
>>                 Max snoop latency: 0ns
>>                 Max no snoop latency: 0ns
>>         Capabilities: [180 v1] L1 PM Substates
>>                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
>> ASPM_L1.1+ L1_PM_Substates+
>>                           PortCommonModeRestoreTime=10us
>> PortTPowerOnTime=10us
>>                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>>                            T_CommonMode=0us LTR1.2_Threshold=0ns
>>                 L1SubCtl2: T_PwrOn=10us
>>         Kernel driver in use: nvme
>> lspci: Unable to load libkmod resources: error -12
>>
>> # nvme smart-log /dev/nvme0
>> Smart Log for NVME device:nvme0 namespace-id:ffffffff
>> critical_warning                    : 0
>> temperature                         : -273 C
>> available_spare                     : 0%
>> available_spare_threshold           : 0%
>> percentage_used                     : 0%
>> data_units_read                     : 0
>> data_units_written                  : 0
>> host_read_commands                  : 0
>> host_write_commands                 : 0
>> controller_busy_time                : 0
>> power_cycles                        : 0
>> power_on_hours                      : 0
>> unsafe_shutdowns                    : 0
>> media_errors                        : 0
>> num_err_log_entries                 : 0
>> Warning Temperature Time            : 0
>> Critical Composite Temperature Time : 0
>> Thermal Management T1 Trans Count   : 0
>> Thermal Management T2 Trans Count   : 0
>> Thermal Management T1 Total Time    : 0
>> Thermal Management T2 Total Time    : 0
> 
> Any suggestions ?

Thank you for all your suggestions and support!

I revisited this issue with current linux-next, since I was curious why
the NVME SSD didn't work for me on ARM64, while it works on x86-64. It
still doesn't work on ARM64 and I still don't know why.

I limited the link speed to 2.5GT/s x1, but that doesn't help.

I suspect the problem is with the 64bit mapping of the BAR0, while the
controller has the 32bit DMA limitation. I tried Intel i210 NIC and
Intel 82574L NIC and they both work fine, but they only map BAR0 as
32bit. Could that be the problem ? I was under the impression that this
patch should address it.

-- 
Best regards,
Marek Vasut
