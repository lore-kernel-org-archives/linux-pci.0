Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <951505b8-9580-7131-2f14-de92817190a7@codeaurora.org>
References: <1490880636-30542-1-git-send-email-okaya@codeaurora.org>
 <7c48ca8b-b834-3257-91dc-77e9d19def6c@codeaurora.org>
 <92EBB4272BF81E4089A7126EC1E7B28466761383@IRSMSX101.ger.corp.intel.com>
 <92EBB4272BF81E4089A7126EC1E7B2846676271D@IRSMSX101.ger.corp.intel.com>
 <951505b8-9580-7131-2f14-de92817190a7@codeaurora.org>
From: Rajat Jain <rajatja@google.com>
Date: Thu, 6 Apr 2017 10:10:58 -0700
Message-ID: <CACK8Z6FG7QHs1kQUoTJTcP3606+xBLFp9RUmLuv0m0X2mxH9XA@mail.gmail.com>
Subject: Re: [PATCH V7 0/5] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
To: Sinan Kaya <okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "Patel, Mayurkumar" <mayurkumar.patel@intel.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "timur@codeaurora.org" <timur@codeaurora.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Thu, Apr 6, 2017 at 8:19 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
>
> On 4/6/2017 9:23 AM, Patel, Mayurkumar wrote:
> > Actually, The enabling/configuring of ASPM L1.2 is opposite then ASPM L1.
> > In case of L1, Upstream must configure first L1 and then downstream according to PCIe spec.
> > In case of L1.2, Downstream must configure L1.2 and then upstream according (to L1.2 ECN spec. -> 5.5.4. L1 PM
> > substates Configuration).
> >
> > @Bjorn:
> > I even found that programming of pcie_config_aspm_l1ss() sub-states is done in the opposite way than described in
> > the spec.,
> >
> > The spec. says following and correct me If I am wrong or I misinterpret the spec. :
> >
> > 5.5.4. L1 PM Substates Configuration
> >
> > The Setting of any enable bit must be performed at the Downstream Port before the
> > corresponding bit is permitted to be Set at the Upstream Port. If any L1 PM Substates enable
> > bit is at a later time to be cleared, the enable bit(s) must be cleared in the Upstream Port
> > before the corresponding enable bit(s) are permitted to be cleared in the Downstream Port.
> >

Thanks for bringing to attention. My understanding / interpretation of
"Downstream port" was the port pointing downwards (from the "Upstream"
component). E.g. when an EP connects to a hub port, PCIe text refers
to the hub port as the "downstream port". Similarly "upstream port" is
used for referring to a switch's port that "points" upwards towards
the root port. Thus, I interpreted the text to mean that I need to
enable it in the "downstream port" (in the root port / switch port)
followed by the "upstream port" (in the device).

It would have been great if the PCIe spec was as clear for L1
substates as it was for L1:
----------------------------
ASPM L1 must be enabled by software in the Upstream
component on a Link prior to enabling ASPM L1 in the
Downstream component on that Link.
-----------------------------
For ASPM L1, the spec clearly says "Upstream component" which can only
mean the switch's "downstream" port. I'm open to changing it if there
is consensus that my interpretation is wrong.

I'm actually not sure if I understood what is the problem that is
being seen with L1 PM substates. Can you please elaborate?


>
>
> Thanks for testing.
>
> commit a142f4d3e5c54db5e942fa6ee5f3dc0e8c83207b
> Author: Rajat Jain <rajatja@google.com>
> Date:   Mon Jan 2 22:34:15 2017 -0800
>
>     PCI/ASPM: Add comment about L1 substate latency
>
>     Since the exit latencies for L1 substates are not advertised by a device,
>     it is not clear in spec how to do a L1 substate exit latency check.  We
>     assume that the L1 exit latencies advertised by a device include L1
>     substate latencies (and hence do not do any check).  If that is not true,
>     we should do some sort of check here.
>
>     (I'm not clear about what that check should like currently. I'd be glad to
>     take up any suggestions).
>
>     Signed-off-by: Rajat Jain <rajatja@google.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> I added Rajat for discussion on L1SS. I think this deserves its own discussion.

Thanks, The above commit specifically adds a comment to
pcie_aspm_check_latency(), because I wanted to leave a note
highlighting that potentially, we could add a more stringent check for
exit latency for L1SS. But that has nothing to do with how we are
configuring or enabling / disabling the L1 substates.

Thanks & Best Regards,

Rajat

> I'll look at the other part of your email and move things around a little bit
> less aggressively for the aspm_default.
>
>
> --
> Sinan Kaya
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
