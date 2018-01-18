Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 17 Jan 2018 19:56:15 -0700
From: Keith Busch <keith.busch@intel.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Oza Pawandeep <poza@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Wei Zhang <wzhang@fb.com>, Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v5 4/4] PCI/DPC: Enumerate the devices after DPC trigger
 event
Message-ID: <20180118025615.GF7562@localhost.localdomain>
References: <1516185438-31556-1-git-send-email-poza@codeaurora.org>
 <1516185438-31556-5-git-send-email-poza@codeaurora.org>
 <b255864b-1272-0626-f448-db2d9c3710c5@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b255864b-1272-0626-f448-db2d9c3710c5@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 17, 2018 at 08:27:39AM -0800, Sinan Kaya wrote:
> On 1/17/2018 5:37 AM, Oza Pawandeep wrote:
> > +static bool dpc_wait_link_active(struct pci_dev *pdev)
> > +{
> 
> I think you can also make this function common instead of making another copy here.
> Of course, this would be another patch.

It is actually very similar to __pcie_wait_link_active in pciehp_hpc.c,
so there's some opprotunity to make even more common code.
