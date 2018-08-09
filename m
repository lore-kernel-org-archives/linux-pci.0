Return-Path: <SRS0=Ly/z=KY=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=Ly/z=KY=deltatee.com=logang@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-doc@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
 Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Matthew Wilcox <willy@infradead.org>
References: <20180730161840.13733-1-logang@deltatee.com>
 <20180730161840.13733-4-logang@deltatee.com>
 <20180809211714.GG113140@bhelgaas-glaptop.roam.corp.google.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <16da0310-f369-4d44-291e-dce4c77b06ab@deltatee.com>
Date: Thu, 9 Aug 2018 15:21:52 -0600
MIME-Version: 1.0
In-Reply-To: <20180809211714.GG113140@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v8 3/4] PCI: Introduce disable_acs_redir quirk
List-ID: <linux-pci.vger.kernel.org>



On 09/08/18 03:17 PM, Bjorn Helgaas wrote:
> I assume these could go in drivers/pci/pci.h instead of
> include/linux/pci.h?

Yeah, I agree they'd be better suited in the local file. I just followed
what had already existed.

> I can do that (and add another patch to move the
> pci_dev_specific_acs_enabled() and pci_dev_specific_enable_acs()
> declarations, which also are only used inside drivers/pci) if you agree.

Sounds good to me.

Thanks,

Logan
