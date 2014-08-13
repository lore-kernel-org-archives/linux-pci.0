Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from na3sys010aog101.obsmtp.com ([74.125.245.70]:41102 "HELO
	na3sys010aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752829AbaHMRAm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 13 Aug 2014 13:00:42 -0400
Received: by mail-pd0-f173.google.com with SMTP id w10so27596pde.18
        for <linux-pci@vger.kernel.org>; Wed, 13 Aug 2014 10:00:41 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] PCI: pciehp: Use ordered workqueue for HPC events
From: Sandeep S Mann <sandeep@purestorage.com>
In-Reply-To: <CAA93t1pK8b80_Yn=0J5Dxrd=hJpqMSpGK9VQALLewz7xaFSswA@mail.gmail.com>
Date: Wed, 13 Aug 2014 10:00:39 -0700
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Message-Id: <A503A44A-EA3C-4CD7-9D31-1505D3DD7C49@purestorage.com>
References: <1406933232-1560-1-git-send-email-sandeep@purestorage.com> <20140812213626.GA6333@google.com> <361417F9-AEA8-4C83-BD04-D5DD8CD4A391@purestorage.com> <CAA93t1rZ23dUQ4mJfLaHHdDBzEwnm=oYbv=B4fpYxuDieOapew@mail.gmail.com> <E43BF28E-A4E6-4114-81D5-A7D4C1E22D49@purestorage.com> <CAA93t1pK8b80_Yn=0J5Dxrd=hJpqMSpGK9VQALLewz7xaFSswA@mail.gmail.com>
To: rajatxjain@gmail.com
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


On Aug 12, 2014, at 5:33 PM, Rajat Jain <rajatxjain@gmail.com> wrote:

> Actually I was referring to the power controller for the hotplug slot
> i.e. in the Slot capabilities register.

Here is the capability.

        Capabilities: [68] Express (v2) Downstream Port (Slot+), MSI 00
                DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
                        ExtTag- RBE+ FLReset-
                DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
                LnkCap: Port #4, Speed 8GT/s, Width x4, ASPM L1, Latency L0 <4us, L1 <4us
                        ClockPM- Surprise+ LLActRep+ BwNot+
                LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
                        Slot #300, PowerLimit 25.000W; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
                        Changed: MRL- PresDet- LinkState-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis- ARIFwd+
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
                LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-


> However, it is a moot point now since you mentioned that you tree is
> behind the current one (these changes are present in 3.15 onwards).

Thanks we will pick up these changes once we move forward to 3.15.