Return-Path: <SRS0=6A7A=Q3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F17C43381
	for <linux-pci@archiver.kernel.org>; Wed, 20 Feb 2019 09:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86852183F
	for <linux-pci@archiver.kernel.org>; Wed, 20 Feb 2019 09:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfBTJZA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:25:00 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:1263 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfBTJZA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Feb 2019 04:25:00 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 2818713F8F0;
        Wed, 20 Feb 2019 10:24:41 +0100 (CET)
Subject: Re: WIP: PCIe on MSM8998
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     MSM <linux-arm-msm@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
References: <c97b6f4e-4b4c-027f-5a0b-80b3f7054177@free.fr>
Message-ID: <50873e4c-72c0-88ac-cf55-b11c2e0ce644@free.fr>
Date:   Wed, 20 Feb 2019 10:24:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <c97b6f4e-4b4c-027f-5a0b-80b3f7054177@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19/02/2019 17:54, Marc Gonzalez wrote:

> Current situation: HANG + REBOOT :-)
> Probably some silly typo in an address in my DT. Investigating...
> 
> # modprobe phy-qcom-qmp
> REMAP: PA=0c010000 VA=ffffff8010005000 SIZE=18c
> REMAP: PA=0c010200 VA=ffffff801000d200 SIZE=128
> REMAP: PA=0c010400 VA=ffffff801002d400 SIZE=200
> REMAP: PA=0c010c00 VA=ffffff8010035c00 SIZE=20c
> REMAP: PA=0c010600 VA=ffffff8010051600 SIZE=128
> REMAP: PA=0c010800 VA=ffffff8010053800 SIZE=200
> qcom-qmp-phy c010000.phy: PHY pcs_misc-reg not used
> qcom-qmp-phy c010000.phy: Registered Qcom-QMP phy
> [    CLK_BASE + 6b004] = 00282000
> REMAP: PA=01c00000 VA=ffffff8010b72000 SIZE=2000
> REMAP: PA=01c06000 VA=ffffff8010055000 SIZE=1000
> REMAP: PA=1b000000 VA=ffffff801005d000 SIZE=f1d
> REMAP: PA=01c07000 VA=ffffff8010065000 SIZE=200
> REMAP: PA=1b000f20 VA=ffffff801006df20 SIZE=a8
> REMAP: PA=01c07200 VA=ffffff8010075200 SIZE=200
> [    CLK_BASE + 6b004] = a0282001
> REMAP: PA=01c07400 VA=ffffff801007d400 SIZE=200
> qcom-qmp-phy 1c06000.phy: PHY pcs_misc-reg not used
> qcom-qmp-phy 1c06000.phy: Registered Qcom-QMP phy
> [    CLK_BASE + 6b004] = 00282000
> REMAP: PA=01c00000 VA=ffffff8010d02000 SIZE=2000
> REMAP: PA=1b000000 VA=ffffff801005d000 SIZE=f1d
> REMAP: PA=1b000f20 VA=ffffff801006df20 SIZE=a8
> qcom-pcie 1b000000.pci: 1b000000.pci supply vdda not found, using dummy regulator
> qcom-pcie 1b000000.pci: 1b000000.pci supply vddpe-3v3 not found, using dummy regulator
> qcom-qmp-phy 1c06000.phy: Initializing QMP phy
> [    CLK_BASE + 6f000] = 00000001
> [    CLK_BASE + 6f014] = 00000001
> [    CLK_BASE + 6f00c] = 00000001
> [    CLK_BASE + 6f00c] = 00000000
> [    CLK_BASE + 6f014] = 00000000
> [    CLK_BASE + 6f000] = 00000000
> [    CLK_BASE + 6f004] = 80000001
> [    CLK_BASE + 6b010] = 80008001
> [    CLK_BASE + 8800c] = 80000001
> [    PCIE_DBI + 00404] = 0000000b
> [    PCIE_DBI + 00034] = 0000001c
> [    PCIE_DBI + 00038] = 00000010
> [    PCIE_DBI + 00174] = 00000033
> [    PCIE_DBI + 00194] = 00000006
> [    PCIE_DBI + 000c8] = 00000042
> [    PCIE_DBI + 00128] = 00000000
> [    PCIE_DBI + 00144] = 000000ff
> [    PCIE_DBI + 00148] = 0000001f
> [    PCIE_DBI + 00178] = 00000001
> [    PCIE_DBI + 0019c] = 00000001
> [    PCIE_DBI + 0018c] = 00000000
> [    PCIE_DBI + 00184] = 0000000a
> [    PCIE_DBI + 0000c] = 00000009
> [    PCIE_DBI + 000d0] = 00000082
> [    PCIE_DBI + 000e4] = 00000003
> [    PCIE_DBI + 000e0] = 00000055
> [    PCIE_DBI + 000dc] = 00000055
> [    PCIE_DBI + 00054] = 00000000
> [    PCIE_DBI + 00050] = 0000001a
> [    PCIE_DBI + 0004c] = 0000000a
> [    PCIE_DBI + 00174] = 00000033
> [    PCIE_DBI + 0003c] = 00000002
> [    PCIE_DBI + 00040] = 0000001f
> [    PCIE_DBI + 000ac] = 00000004
> [    PCIE_DBI + 00078] = 0000000b
> [    PCIE_DBI + 00084] = 00000016
> [    PCIE_DBI + 00090] = 00000028
> [    PCIE_DBI + 0010c] = 00000000
> [    PCIE_DBI + 00108] = 00000080
> [    PCIE_DBI + 00010] = 00000001
> [    PCIE_DBI + 0001c] = 00000031
> [    PCIE_DBI + 00020] = 00000001
> [    PCIE_DBI + 00014] = 00000002
> [    PCIE_DBI + 00018] = 00000000
> [    PCIE_DBI + 00024] = 0000002f
> [    PCIE_DBI + 00028] = 00000019
> [    PCIE_DBI + 000c4] = 00000015
> [    PCIE_DBI + 00070] = 0000000f
> [    PCIE_DBI + 00048] = 0000000f
> [    PCIE_DBI + 00074] = 00000019
> [    PCIE_DBI + 00038] = 00000010
> [    PCIE_DBI + 00178] = 00000000
> [    PCIE_DBI + 000c4] = 00000040
> [    PCIE_DBI + 00400] = 0000000a
> [    PCIE_DBI + 00408] = 0000000b
> [    CLK_BASE + 6b018] = 80004001
> [    PCIE_DBI + 00068] = 00000045
> [    PCIE_DBI + 00094] = 00000006
> [    01c07200 + 00110] = 0000001c
> [    01c07200 + 000d8] = 00000001
> [    01c07200 + 000dc] = 00000000
> [    01c07200 + 000e0] = 000000db
> [    01c07200 + 00120] = 00000018
> [    01c07200 + 0001c] = 00000004
> [    01c07200 + 00010] = 00000004
> [    01c07200 + 00048] = 0000004b
> [    01c07200 + 0011c] = 00000014
> [    01c07200 + 00118] = 00000019
> [    01c07400 + 00058] = 0000004c
> [    01c07400 + 000a0] = 00000000
> [    01c07400 + 000a4] = 00000001
> [    01c07400 + 000a8] = 00000005
> [    01c07400 + 00054] = 00000005
> [    01c07400 + 00004] = 00000002
> [    01c07400 + 0006c] = 00000000
> [    01c07400 + 00060] = 000000a3
> [    01c07400 + 00028] = 0000000e
> [    01c07400 + 00004] = 00000003
> [    01c07400 + 00000] = 00000000
> [    01c07400 + 00008] = 0000000a
> qcom-pcie 1b000000.pci: host bridge /soc/pci@1b000000 ranges:
> qcom-pcie 1b000000.pci: Parsing ranges property...
> qcom-pcie 1b000000.pci:    IO 0x1b200000..0x1b2fffff -> 0x1b200000
> qcom-pcie 1b000000.pci:   MEM 0x1b300000..0x1bffffff -> 0x1b300000
> REMAP: PA=1b100000 VA=ffffff8011400000 SIZE=80000
> REMAP: PA=1b180000 VA=ffffff8011500000 SIZE=80000
> [    CLK_BASE + 6b014] = 80000001
> [    CLK_BASE + 6b00c] = 80004221
> [    CLK_BASE + 6b008] = 8000c221
> [   PCIE_PARF + 00040] = 00000000
> [   PCIE_PARF + 00168] = 00000000
> [   PCIE_PARF + 00000] = 00000000
> [   PCIE_PARF + 00174] = 00000010
> [   PCIE_PARF + 001a8] = 80000000
> dw_pcie_read: addr=ffffff801005d710 size=4
> Internal error: synchronous external abort: 96000210 [#1] PREEMPT SMP
> Modules linked in: phy_qcom_qmp
> ...
> Call trace:
>  dw_pcie_read+0x90/0x110
>  __dw_pcie_read_dbi+0x70/0xa0
>  dw_pcie_setup+0x60/0x160
>  dw_pcie_setup_rc+0x38/0x360
>  qcom_pcie_host_init+0xbc/0x160
>  dw_pcie_host_init+0x248/0x510
>  qcom_pcie_probe+0x20c/0x250

The splat occurs when dw_pcie_setup() executes

	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);

#define PCIE_PORT_LINK_CONTROL 0x710

I'll try comparing with the downstream kernel...
