Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V5 0/4] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
To: "Patel, Mayurkumar" <mayurkumar.patel@intel.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <1490477893-9517-1-git-send-email-okaya@codeaurora.org>
 <f062dc8f-df66-bfd8-a0d7-50ac1cadf975@codeaurora.org>
 <92EBB4272BF81E4089A7126EC1E7B2846675AEDC@IRSMSX101.ger.corp.intel.com>
 <c9820456-d9b1-cd97-533b-889905e27603@codeaurora.org>
 <1f677feb-b561-1dd3-69ad-afd4049b6d59@codeaurora.org>
 <f3e76f8d-16bb-8ec5-da9b-d62ca66dafd6@codeaurora.org>
 <92EBB4272BF81E4089A7126EC1E7B2846675D8C4@IRSMSX101.ger.corp.intel.com>
 <beb63ced-3e63-c09c-8c2c-5d5b0956d2fc@codeaurora.org>
 <92EBB4272BF81E4089A7126EC1E7B2846675D9B9@IRSMSX101.ger.corp.intel.com>
 <b0327163-2500-1541-6c23-454e3f28b6ea@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <7b0c887b-cd99-b752-c162-66fc7c864731@codeaurora.org>
Date: Wed, 29 Mar 2017 19:08:31 -0400
MIME-Version: 1.0
In-Reply-To: <b0327163-2500-1541-6c23-454e3f28b6ea@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "timur@codeaurora.org" <timur@codeaurora.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 3/29/2017 4:36 PM, Sinan Kaya wrote:
> On 3/29/2017 4:16 PM, Patel, Mayurkumar wrote:
>> Actually, I have taken same patches of yours which proposed and applied it correctly. Will try it with clean
>> build if that helps.
>>
>> But what I could understand from following patch is https://patchwork.codeaurora.org/patch/207653/ 
>>
>> We still have a flow of pci_aspm_init() -> alloc_pcie_link_state() -> pci_function_0()
>> Where I see the first Kernel NULL pointer crash while accessing pdev->subordinate in pci_function_0() function.
> 
> OK. It looks like somebody moved function_0 call around. I was looking at 4.11-rc1.
> 
> 3bd7db63a841e8c5297bb18ad801df67d5e38ad2 (PCI/ASPM: Always set link->downstream to avoid NULL dereference on remove)
> 
> I see the change in 4.11-rc3 now. 
> 
> Let me see what's going on.
> 

I posted V6 a minute ago with the bugfix. Let me know how that works for you.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
