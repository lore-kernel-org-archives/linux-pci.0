Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V2] PCI: Do not enable extended tags on pre-dated (v1.x)
 systems
To: wim.ten.have@oracle.com
References: <1499439193-16628-1-git-send-email-okaya@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <7d6e99b9-bdef-845a-a542-2c47f429eb12@codeaurora.org>
Date: Fri, 7 Jul 2017 11:01:16 -0400
MIME-Version: 1.0
In-Reply-To: <1499439193-16628-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Wim,

On 7/7/2017 10:53 AM, Sinan Kaya wrote:
> According to extended tags ECN document, all PCIe receivers are expected
> to support extended tags support. It should be safe to enable extended
> tags on endpoints without checking compatibility.
> 
> This assumption seems to be working fine except for the legacy systems.
> The ECN has been written against PCIE spec version 2.0. Therefore, we need
> to exclude all version 1.0 devices from this change as there is HW out
> there that can't handle extended tags.
> 
> Note that the default value of Extended Tags Enable bit is implementation
> specific. Therefore, we are clearing the bit by default when incompatible
> HW is found without assuming that value is zero.
> 
> Reported-by: Wim ten Have <wim.ten.have@oracle.com>
> Link: https://pcisig.com/sites/default/files/specification_documents/ECN_Extended_Tag_Enable_Default_05Sept2008_final.pdf
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1467674
> Fixes: 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---

Can you also give this a spin? I don't have a system with v1 PCIe bridges.
I only tested v2 and later code path.

I tried to address Jike Song concerns on this version and removed your tested-by
since the code changed.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
