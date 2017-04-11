Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 11 Apr 2017 17:41:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V8 0/5] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
Message-ID: <20170411224139.GA736@bhelgaas-glaptop.roam.corp.google.com>
References: <1491627351-1111-1-git-send-email-okaya@codeaurora.org>
 <20170411211924.GC14778@bhelgaas-glaptop.roam.corp.google.com>
 <7b94bfbb-b3e6-cbc3-06a1-4490f4142ffe@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <7b94bfbb-b3e6-cbc3-06a1-4490f4142ffe@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org, mayurkumar.patel@intel.com,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 11, 2017 at 05:27:59PM -0400, Sinan Kaya wrote:
> On 4/11/2017 5:19 PM, Bjorn Helgaas wrote:
> > Hi Sinan,
> > 
> > What are these patches based on?  I normally apply things to my "master"
> > branch, which is typically -rc1 or -rc2.  Right now it's v4.11-rc1, and
> > these don't apply cleanly:
> > 
> >   04:17:59 ~/linux (master)$ stg branch --create pci/aspm-sk-v8 v4.11-rc1
> >   Checking for changes in the working directory ... done
> >   Don't know how to determine parent branch from "v4.11-rc1"
> >   Branch "pci/aspm-sk-v8" created
> >   04:18:18 ~/linux (pci/aspm-sk-v8)$ stg import -M --sign m/sk-v8
> >   Checking for changes in the working directory ... done
> >   Importing patch "pci-aspm-introduce" ... done
> >   Importing patch "pci-aspm-split-pci_aspm_init" ... done
> >   Importing patch "pci-aspm-add-init-hook-to" ... error: patch failed: drivers/pci/pcie/aspm.c:798
> >   error: drivers/pci/pcie/aspm.c: patch does not apply
> >   stg import: Diff does not apply cleanly
> 
> This is what I have.
> 
> 41a7175 PCI/ASPM: move link_state cleanup to bridge remove
> 3b646e2 PCI/ASPM: save power on values during bridge init
> 181510d PCI/ASPM: add init hook to device_add
> 282d008 PCI/ASPM: split pci_aspm_init() into two
> 8e89fc2 PCI/ASPM: introduce pci_aspm_init() and add to pci_init_capabilities()
> 97da385 Linux 4.11-rc3

Thanks, I guess I should have figured that out since my for-linus branch
includes an ASPM patch.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
