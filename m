Return-Path: <SRS0=+xF7=7Z=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=+xF7=7Z=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH V10 2/3] PCI: handle CRS returned by device after FLR
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 alex.williamson@redhat.com, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-kernel@vger.kernel.org
References: <1502470596-4112-1-git-send-email-okaya@codeaurora.org>
 <1502470596-4112-2-git-send-email-okaya@codeaurora.org>
 <20170818210134.GO28977@bhelgaas-glaptop.roam.corp.google.com>
 <4da26c10-3426-e752-4a59-25bb59cde8cd@codeaurora.org>
 <20170821180030.GB28977@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <48497e49-21c2-9289-f546-2b0ef938beb0@codeaurora.org>
Date: Tue, 22 Aug 2017 23:21:24 -0400
MIME-Version: 1.0
In-Reply-To: <20170821180030.GB28977@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 8/21/2017 2:00 PM, Bjorn Helgaas wrote:
> On Mon, Aug 21, 2017 at 09:44:09AM -0400, Sinan Kaya wrote:
>> Hi Bjorn,
>>
>> On 8/18/2017 5:01 PM, Bjorn Helgaas wrote:

> 
> It would still be interesting to see the lspci output.  Likely <MAbort
> in the upstream bridge will be set even before the FLR because of
> aborts during enumeration.  The PCI core should probably clear that
> after enumeration.  I expect that if you manually clear it with
> setpci, do the lspci, do the FLR, do another lspci, you will probably
> see <MAbort being set by this pci_flr_wait() loop.  We might want to
> consider clearing it here as well.


     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 345
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: 00100000-002fffff
        Prefetchable memory behind bridge: 0000090400000000-00000904001fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-

FLR reset here with CRS to the NVMe drive.
	
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 345
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: 00100000-002fffff
        Prefetchable memory behind bridge: 0000090400000000-00000904001fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	
I don't see <MAbort getting set. 




-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
