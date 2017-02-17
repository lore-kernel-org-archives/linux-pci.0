Return-Path: <SRS0=+orK=Z6=gmail.com=yhlu.kernel@kernel.org>
Return-Path: <SRS0=+orK=Z6=gmail.com=yhlu.kernel@kernel.org>
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <20170217223916.GG17762@bhelgaas-glaptop.roam.corp.google.com>
References: <20170217061247.5591-1-yinghai@kernel.org> <20170217223916.GG17762@bhelgaas-glaptop.roam.corp.google.com>
From: Yinghai Lu <yinghai@kernel.org>
Date: Fri, 17 Feb 2017 15:36:48 -0800
Message-ID: <CAE9FiQXpghwUsHZL4QHV-LaVxq-ekhcRHkxNYWsAHRbPQ9NWCQ@mail.gmail.com>
Subject: Re: [PATCH] PCI,pciehp: Don't handle PDC for cards with attention button
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Mika Westerberg <mika.westerberg@linux.intel.com>,
	Keith Busch <keith.busch@intel.com>, Mayurkumar Patel <mayurkumar.patel@intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 17, 2017 at 2:39 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Thu, Feb 16, 2017 at 10:12:47PM -0800, Yinghai Lu wrote:
>
> I don't think it really makes sense to tie PDC handling with the
> attention button.  It might happen to avoid the problem on your
> system, but I don't see the logical connection between them.

but in pcie_enable_notification() we don't enable PDCE when ATTN is not there.

        cmd = PCI_EXP_SLTCTL_DLLSCE;
        if (ATTN_BUTTN(ctrl))
                cmd |= PCI_EXP_SLTCTL_ABPE;
        else
                cmd |= PCI_EXP_SLTCTL_PDCE;
        if (!pciehp_poll_mode)
                cmd |= PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE;

        mask = (PCI_EXP_SLTCTL_PDCE | PCI_EXP_SLTCTL_ABPE |
                PCI_EXP_SLTCTL_PFDE |
                PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE |
                PCI_EXP_SLTCTL_DLLSCE);

        pcie_write_cmd_nowait(ctrl, cmd, mask);

should we remove that check there ?

>
> Can you reproduce this by disabling pciehp and driving this sequence
> manually with setpci?  I suspect that we are tripping over our own
> feet because we read PCI_EXP_SLTSTA once, clear it (probably too
> early), then queue multiple events, then process those events possibly
> simultaneously.

sca15-2243-0a818158:~ # echo 1 > /sys/bus/pci/devices/0000\:3b\:00.0/remove
[  171.769322] pci 0000:3b:00.0: PME# disabled
[  171.774459] iommu: Removing device 0000:3b:00.0 from group 36
[  171.780984] pci 0000:3b:00.0: freeing pci_dev info
sca15-2243-0a818158:~ # setpci -s 0000:3a:00.0 0xa8.w
01cb
sca15-2243-0a818158:~ # setpci -s 0000:3a:00.0 0xaa.w
0050
sca15-2243-0a818158:~ # setpci -s 0000:3a:00.0 0xa8.w=0x05cb
sca15-2243-0a818158:~ # setpci -s 0000:3a:00.0 0xaa.w
0158

so after power off, status bit 3 the PDC get set.
