Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V8 4/5] PCI/ASPM: save power on values during bridge init
To: Rajat Jain <rajatja@google.com>
References: <1491627351-1111-1-git-send-email-okaya@codeaurora.org>
 <1491627351-1111-5-git-send-email-okaya@codeaurora.org>
 <CACK8Z6GXfMWxakNQnvMToig9z9McnJKeYFc2BAAFy7ys8=PUWg@mail.gmail.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <d3857812-7e03-4b62-f7cb-ac0d139b6123@codeaurora.org>
Date: Fri, 14 Apr 2017 15:12:35 -0400
MIME-Version: 1.0
In-Reply-To: <CACK8Z6GXfMWxakNQnvMToig9z9McnJKeYFc2BAAFy7ys8=PUWg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "Patel, Mayurkumar" <mayurkumar.patel@intel.com>,
 Rajat Jain <rajatxjain@gmail.com>, David Daney <david.daney@cavium.com>,
 linux-pci@vger.kernel.org, timur@codeaurora.org, linux-kernel@vger.kernel.org,
 Julia Lawall <Julia.Lawall@lip6.fr>, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn,

On 4/12/2017 3:19 PM, Rajat Jain wrote:
> On Fri, Apr 7, 2017 at 9:55 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> Now that we added a hook to be called from device_add, save the
>> default values from the HW registers early in the boot for further
>> reuse during hot device add/remove operations.
>>
>> If the link is down during boot, assume that we want to enable L0s
>> and L1 following hotplug insertion as well as L1SS if supported.
> 
> IIUC, so far POLICY_DEFAULT meant that we'd just use & follow what
> BIOS has done, and play it safe (never try to be more opportunistic).
> With this change however, we'd be slightly overstepping and giving
> ourselves benefit of doubt if the BIOS could not enable ASPM states
> because the link was not up. This may be good, but I think we should
> call it out, and add some more elaborate comment on the POLICY_DEFAULT
> description (what to, and what not to expect in different situations).
> 
> It is important because existing systems today, that used to boot
> without cards and later hotplugged them, didn't have ASPM states
> enabled. They will now suddenly start seeing all ASPM states enabled
> including L1 substates for the first time (if supported).
> 

Rajat has a good point here. Would you like me to update the ASPM document
with this new behavior for hotplug?

Do you have another behavior preference when it comes this?

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
