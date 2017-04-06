Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V7 0/5] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
To: "Patel, Mayurkumar" <mayurkumar.patel@intel.com>
References: <1490880636-30542-1-git-send-email-okaya@codeaurora.org>
 <7c48ca8b-b834-3257-91dc-77e9d19def6c@codeaurora.org>
 <92EBB4272BF81E4089A7126EC1E7B28466761383@IRSMSX101.ger.corp.intel.com>
 <92EBB4272BF81E4089A7126EC1E7B2846676271D@IRSMSX101.ger.corp.intel.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <5a4b37c7-0319-2fa5-cd3e-93261cf45b99@codeaurora.org>
Date: Thu, 6 Apr 2017 11:36:06 -0400
MIME-Version: 1.0
In-Reply-To: <92EBB4272BF81E4089A7126EC1E7B2846676271D@IRSMSX101.ger.corp.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "timur@codeaurora.org" <timur@codeaurora.org>, Rajat Jain <rajatja@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Mayurkumar,

On 4/6/2017 9:23 AM, Patel, Mayurkumar wrote:
> The patch seems to be working for ASPM L1 so far. I am seeing a problem now with your patches for L1.2 as following:
> 
> ASPM L1.2 does not get enabled on the Upstream as well as downstream port due to following reasons.
> In the case, I see now, if the EP is not connected while reboot of the Machine, Root Port does not configure
> It's own L1.2 also from the BIOS. (I am not sure whether it's even advisable to enable L1.2 on root
> Port when no downstream device is not connected to it as it may have an impact on CLKREQ# and device is connected
> At later stage may have a problem with it)
> 

I have two questions:

1. if the endpoint is connected during boot and have ASPM L1.2 enabled during boot,
do you see that L1.2 gets re-enabled following a hotplug remove and then insert. 
This is the goal of this patch. If yes, we achieved our goal. This is working on
my platform but I do not have L1SS support on my platform.

2. if you do not connect any endpoint during boot and insert the card, do you
see any ASPM enabled at all with and without my patch using the default policy? 
I think this is the part you are describing above. I'll confirm this on my platform
too. I think this one will require another patch/discussion unless I broke something.


> Later when the Device get connected, BIOS configures L1.2 for Root port and EP but due to policy set to incorrect,
> Kernel disables ASPM L1.2.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
