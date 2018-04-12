Return-Path: <SRS0=TX9C=HB=fredlawl.com=fred@kernel.org>
Return-Path: <SRS0=TX9C=HB=fredlawl.com=fred@kernel.org>
Message-ID: <5ACEE178.2010107@fredlawl.com>
Date: Wed, 11 Apr 2018 23:32:56 -0500
From: Frederick Lawler <fred@fredlawl.com>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>
CC: mike.marciniszyn@intel.com, dennis.dalessandro@intel.com,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/2] IB/hfi1: Cleanup PCIe link configuration
References: <1523244898-25942-1-git-send-email-fred@fredlawl.com> <5ACBF5C6.60601@fredlawl.com> <20180410182933.GC24642@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180410182933.GC24642@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas wrote:
> On Mon, Apr 09, 2018 at 06:22:46PM -0500, Frederick Lawler wrote:
>> Frederick Lawler wrote:
>>> The IB/hfi1 driver uses custom macros to configure link speed. Some macros were
>>> previously replaced, but not fully. This patch series addresses the 
>>> configuration inconsistencies and introduces minor cleanup by replacing
>>> redundant magic number usage.
> 
> Sorry for not responding to the actual patches; I'm not subscribed to
> linux-rdma, so reading them via an archive.
> 
>>> Frederick Lawler (2):
>>>   IB/hfi1: Replace custom hfi1 macros with PCIe macros
> 
> s/This patch removes/Remove/
> s/infavor/in favor/
> 
>> @@ -320,7 +315,7 @@ int pcie_speeds(struct hfi1_devdata *dd)
>> -	if ((linkcap & PCI_EXP_LNKCAP_SLS) != GEN3_SPEED_VECTOR) {
>> +	if ((linkcap & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKSTA_CLS_8_0GB) {
> 
> Use PCI_EXP_LNKCAP_SLS_8_0GB (not PCI_EXP_LNKSTA_CLS_8_0GB) since
> we're testing a PCI_EXP_LNKCAP value.  They happen to be the same
> values, but we should use the matching definitions.
> 
>> @@ -1048,14 +1040,14 @@ int do_pcie_gen3_transition(struct hfi1_devdata *dd)
>> -		target_vector = GEN1_SPEED_VECTOR;
>> +		target_vector = PCI_EXP_LNKSTA_CLS_2_5GB;
> 
> target_vector is later ORed into a PCI_EXP_LNKCTL2 value.  We
> currently do not have any definitions for PCI_EXP_LNKCTL2.  We should
> add those, then use them here.  Similarly for the rest of this patch.
> 
>> -		target_speed = 8000;
>> +		target_speed = 8000;
> 
> Is there an unintended whitespace change here, e.g., trailing space or
> replacing tab with space?  I can't tell from the archive.
> 
>>>   IB/hfi1: Cleanup PCIe speed link configuration
> 
> s/speed link/link speed/

I'll add in the PCI_EXP_LINKCTL2_* macros into PCI and address the
remaining items.

Thanks for the feedback.

-- 
Frederick Lawler
