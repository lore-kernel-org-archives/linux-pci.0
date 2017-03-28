Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V5 0/4] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
To: "Patel, Mayurkumar" <mayurkumar.patel@intel.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <1490477893-9517-1-git-send-email-okaya@codeaurora.org>
 <f062dc8f-df66-bfd8-a0d7-50ac1cadf975@codeaurora.org>
 <92EBB4272BF81E4089A7126EC1E7B2846675AEDC@IRSMSX101.ger.corp.intel.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <c9820456-d9b1-cd97-533b-889905e27603@codeaurora.org>
Date: Tue, 28 Mar 2017 08:52:52 -0400
MIME-Version: 1.0
In-Reply-To: <92EBB4272BF81E4089A7126EC1E7B2846675AEDC@IRSMSX101.ger.corp.intel.com>
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

On 3/28/2017 2:02 AM, Patel, Mayurkumar wrote:
> Thanks for your patches. I am seeing kernel panic after applying
> these patches (on top of latest kernel) each time during early boot in pci_aspm_init() (any hints already?) function.
> Need to check if it's something related to my local setup or it's because of these changes.
> For now I don't have more details why it crashes but I will dig in further and I will provide
> you more data as soon as I have it.
> 

Interesting, I retested Qemu and I don't see an issue. 
Can you share your bootlog when you see the crash?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
