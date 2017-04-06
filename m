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
Message-ID: <951505b8-9580-7131-2f14-de92817190a7@codeaurora.org>
Date: Thu, 6 Apr 2017 11:19:07 -0400
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
 "timur@codeaurora.org" <timur@codeaurora.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 4/6/2017 9:23 AM, Patel, Mayurkumar wrote:
> Actually, The enabling/configuring of ASPM L1.2 is opposite then ASPM L1.
> In case of L1, Upstream must configure first L1 and then downstream according to PCIe spec.
> In case of L1.2, Downstream must configure L1.2 and then upstream according (to L1.2 ECN spec. -> 5.5.4. L1 PM
> substates Configuration).  
> 
> @Bjorn:
> I even found that programming of pcie_config_aspm_l1ss() sub-states is done in the opposite way than described in
> the spec.,
> 
> The spec. says following and correct me If I am wrong or I misinterpret the spec. :
> 
> 5.5.4. L1 PM Substates Configuration
> 
> The Setting of any enable bit must be performed at the Downstream Port before the
> corresponding bit is permitted to be Set at the Upstream Port. If any L1 PM Substates enable
> bit is at a later time to be cleared, the enable bit(s) must be cleared in the Upstream Port
> before the corresponding enable bit(s) are permitted to be cleared in the Downstream Port.
> 

Thanks for testing. 

commit a142f4d3e5c54db5e942fa6ee5f3dc0e8c83207b
Author: Rajat Jain <rajatja@google.com>
Date:   Mon Jan 2 22:34:15 2017 -0800

    PCI/ASPM: Add comment about L1 substate latency

    Since the exit latencies for L1 substates are not advertised by a device,
    it is not clear in spec how to do a L1 substate exit latency check.  We
    assume that the L1 exit latencies advertised by a device include L1
    substate latencies (and hence do not do any check).  If that is not true,
    we should do some sort of check here.

    (I'm not clear about what that check should like currently. I'd be glad to
    take up any suggestions).

    Signed-off-by: Rajat Jain <rajatja@google.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

I added Rajat for discussion on L1SS. I think this deserves its own discussion. 
I'll look at the other part of your email and move things around a little bit
less aggressively for the aspm_default.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
