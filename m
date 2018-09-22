Return-Path: <SRS0=8Jd2=ME=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788CFC433F4
	for <linux-pci@archiver.kernel.org>; Sat, 22 Sep 2018 22:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF84C2150E
	for <linux-pci@archiver.kernel.org>; Sat, 22 Sep 2018 22:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYQYZyYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF84C2150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeIWD41 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 22 Sep 2018 23:56:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45829 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbeIWD41 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Sep 2018 23:56:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id a17-v6so1523439wrs.12;
        Sat, 22 Sep 2018 15:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t9c3J2n7IoUhVfssaUXQj+ieYH16JNHDZ1Z5sbABWEY=;
        b=ZYQYZyYkAp5fWCZRkYJYO3jTrt3cY8ITy7uyl+UZFlKzcWemnY21CC+AbZZcZAiN+e
         cBj77BC5i39GowLVGMPUu8PrSY0yRkLOv2lEAsqg8N2gRioPy31e6ces8FnhuAkCNTWN
         Oc5swGlosXpmGhbmaNFpEr73xcV3YFvX1hNMMKxh84vdiHnkxJbvugnIKOIjjURNA1LW
         nSvtFdln3ekHGa/f6AjW611SuoZRzblvxoaOjEZNAv8jTvsjRTaxEE4iJwyUulGkqozS
         IhWLc3WegZbLbVZT6YF6axLGnKfI6/+Nc/jWxdZw6f1E22cmb4augV1Xu4ApBIh06yXd
         oqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t9c3J2n7IoUhVfssaUXQj+ieYH16JNHDZ1Z5sbABWEY=;
        b=gEtlGSK9oCs/ttZNTT9KslnT5+QxGAizG+B9cUlJGOxjWbC5G/2uxnPNknm++6/iPn
         DT+bvXcEO75qi8Ivx0IoOPtQHEcKc5w9Kg2tCqucjrHEKtIKJ4z7m9Mkp4z+p+vtvVvZ
         HkUvfnJbILoarCVr4BCwtU529CfTmfHO+a36LK5QJA4M6KanmRLDrrOl7tmqd6jZ+kfw
         p3mppO814pn/2yU8zgOoom4h5V9+Y0MftSEVEDw1kZZGbK+Qx5w/yepSZ9PCozZN2MrX
         ZYGpUYdIjzjU3OOe4SsX3TlG9AMy0YZn70JMi7a+QxE/FQ5LRla+y9HVC0ARS9LqfuYm
         ZetQ==
X-Gm-Message-State: ABuFfojpgK8llR95HTp8dxhFgamlflIA565OgdHCbE3HwJWRYGwmMa2U
        FgA4LTHmKKhMr/S5fihVycG952HR
X-Google-Smtp-Source: ACcGV60+d8aKeoxpkNgkVXAW3Ma107ZkJqxxWeXElxCKKVIPP+/GmdRo6otE6vPz8cDa5Xj6C/aMLA==
X-Received: by 2002:a5d:6209:: with SMTP id y9-v6mr3174403wru.179.1537653679265;
        Sat, 22 Sep 2018 15:01:19 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id i4-v6sm27568314wrs.85.2018.09.22.15.01.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 15:01:17 -0700 (PDT)
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
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <649ec02e-1e0d-d4b2-cf26-7a7601b1f1d5@gmail.com>
Date:   Sat, 22 Sep 2018 19:06:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180918105130.GA1545@kunai>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 09/18/2018 12:51 PM, Wolfram Sang wrote:
> On Tue, Sep 18, 2018 at 11:15:55AM +0100, Lorenzo Pieralisi wrote:
>> On Tue, May 22, 2018 at 12:05:14AM +0200, Marek Vasut wrote:
>>> From: Phil Edworthy <phil.edworthy@renesas.com>
>>>
>>> The PCIe DMA controller on RCar Gen2 and earlier is on 32bit bus,
>>> so limit the DMA range to 32bit.
>>>
>>> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>>> Cc: Phil Edworthy <phil.edworthy@renesas.com>
>>> Cc: Simon Horman <horms+renesas@verge.net.au>
>>> Cc: Wolfram Sang <wsa@the-dreams.de>
>>> Cc: linux-renesas-soc@vger.kernel.org
>>> To: linux-pci@vger.kernel.org
>>> ---
>>> NOTE: I'm aware of https://patchwork.kernel.org/patch/9495895/ , but the
>>>       discussion seems to have gone way off, so I'm sending this as a
>>>       RFC. Any feedback on how to do this limiting properly would be nice.
>>> ---
>>>  drivers/pci/host/pcie-rcar.c | 28 ++++++++++++++++++++++++++++
>>>  1 file changed, 28 insertions(+)
>>
>> The issue solved by this patch was solved in a more generic way through
>> this series:
>>
>> https://lists.linuxfoundation.org/pipermail/iommu/2018-July/028792.html
>>
>> I will therefore drop this patch from the PCI patch queue.
> 
> Cool. Thanks for this series and thanks for the heads up!
> 
> Marek, can you confirm our issue is fixed (if you haven't done already)?

I assembled a setup with NVMe controller, which should be triggering
this issue according to [1], but I'm not having much success getting it
to work with or without this patchset. Logs are below, nvme smart-log
seems to produce completely bogus results, although the device is at
least recognized.

Maybe there's something else that's broken ?

[1] https://patchwork.kernel.org/patch/9495895/

# dmesg | egrep '(pci|nvm)'
rcar-pcie fe000000.pcie: host bridge /soc/pcie@fe000000 ranges:
rcar-pcie fe000000.pcie: Parsing ranges property...
rcar-pcie fe000000.pcie:    IO 0xfe100000..0xfe1fffff -> 0x00000000
rcar-pcie fe000000.pcie:   MEM 0xfe200000..0xfe3fffff -> 0xfe200000
rcar-pcie fe000000.pcie:   MEM 0x30000000..0x37ffffff -> 0x30000000
rcar-pcie fe000000.pcie:   MEM 0x38000000..0x3fffffff -> 0x38000000
rcar-pcie fe000000.pcie: PCIe x1: link up
rcar-pcie fe000000.pcie: Current link speed is 5 GT/s
rcar-pcie fe000000.pcie: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [bus 00-ff]
pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]
pci_bus 0000:00: root bus resource [mem 0xfe200000-0xfe3fffff]
pci_bus 0000:00: root bus resource [mem 0x30000000-0x37ffffff]
pci_bus 0000:00: root bus resource [mem 0x38000000-0x3fffffff pref]
pci_bus 0000:00: scanning bus
pci 0000:00:00.0: [1912:0025] type 01 class 0x060400
pci 0000:00:00.0: enabling Extended Tags
pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
pci 0000:00:00.0: PME# disabled
pci_bus 0000:00: fixups for bus
pci 0000:00:00.0: scanning [bus 01-01] behind bridge, pass 0
pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
pci_bus 0000:01: scanning bus
pci 0000:01:00.0: [8086:f1a5] type 00 class 0x010802
pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
pci 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5 GT/s
x1 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8 GT/s x4 link)
pci_bus 0000:01: fixups for bus
pci_bus 0000:01: bus scan returning with max=01
pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
pci_bus 0000:00: bus scan returning with max=01
pci 0000:00:00.0: BAR 14: assigned [mem 0xfe200000-0xfe2fffff]
pci 0000:01:00.0: BAR 0: assigned [mem 0xfe200000-0xfe203fff 64bit]
pci 0000:00:00.0: PCI bridge to [bus 01]
pci 0000:00:00.0:   bridge window [mem 0xfe200000-0xfe2fffff]
pcieport 0000:00:00.0: assign IRQ: got 0
pcieport 0000:00:00.0: enabling device (0000 -> 0002)
pcieport 0000:00:00.0: enabling bus mastering
pcieport 0000:00:00.0: Signaling PME with IRQ 198
rcar-pcie ee800000.pcie: host bridge /soc/pcie@ee800000 ranges:
rcar-pcie ee800000.pcie: Parsing ranges property...
rcar-pcie ee800000.pcie:    IO 0xee900000..0xee9fffff -> 0x00000000
rcar-pcie ee800000.pcie:   MEM 0xeea00000..0xeebfffff -> 0xeea00000
rcar-pcie ee800000.pcie:   MEM 0xc0000000..0xc7ffffff -> 0xc0000000
rcar-pcie ee800000.pcie:   MEM 0xc8000000..0xcfffffff -> 0xc8000000
rcar-pcie ee800000.pcie: PCIe link down
nvme 0000:01:00.0: assign IRQ: got 171
nvme nvme0: pci function 0000:01:00.0
nvme 0000:01:00.0: enabling device (0000 -> 0002)
nvme 0000:01:00.0: enabling bus mastering
nvme nvme0: Shutdown timeout set to 60 seconds

# lspci -nvvvs 01:00.0
01:00.0 0108: 8086:f1a5 (rev 03) (prog-if 02 [NVM Express])
        Subsystem: 8086:390a
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 171
        Region 0: Memory at fe200000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [70] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
SlotPowerLimit 0.000W
                DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+
Unsupported+
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
FLReset-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
TransPend-
                LnkCap: Port #0, Speed 8GT/s, Width x4, ASPM L1, Exit
Latency L0s <1us, L1 <8us
                        ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+,
LTR+, OBFF Via message
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-,
LTR-, OBFF Disabled
                LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance-
SpeedDis-
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
        Capabilities: [b0] MSI-X: Enable- Count=16 Masked-
                Vector table: BAR=0 offset=00002000
                PBA: BAR=0 offset=00002100
        Capabilities: [100 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
NonFatalErr+
                AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+
ChkEn-
        Capabilities: [158 v1] #19
        Capabilities: [178 v1] Latency Tolerance Reporting
                Max snoop latency: 0ns
                Max no snoop latency: 0ns
        Capabilities: [180 v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
ASPM_L1.1+ L1_PM_Substates+
                          PortCommonModeRestoreTime=10us
PortTPowerOnTime=10us
                L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                           T_CommonMode=0us LTR1.2_Threshold=0ns
                L1SubCtl2: T_PwrOn=10us
        Kernel driver in use: nvme
lspci: Unable to load libkmod resources: error -12

# nvme smart-log /dev/nvme0
Smart Log for NVME device:nvme0 namespace-id:ffffffff
critical_warning                    : 0
temperature                         : -273 C
available_spare                     : 0%
available_spare_threshold           : 0%
percentage_used                     : 0%
data_units_read                     : 0
data_units_written                  : 0
host_read_commands                  : 0
host_write_commands                 : 0
controller_busy_time                : 0
power_cycles                        : 0
power_on_hours                      : 0
unsafe_shutdowns                    : 0
media_errors                        : 0
num_err_log_entries                 : 0
Warning Temperature Time            : 0
Critical Composite Temperature Time : 0
Thermal Management T1 Trans Count   : 0
Thermal Management T2 Trans Count   : 0
Thermal Management T1 Total Time    : 0
Thermal Management T2 Total Time    : 0


-- 
Best regards,
Marek Vasut
