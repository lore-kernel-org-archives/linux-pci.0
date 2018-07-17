Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 17 Jul 2018 11:48:47 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v7 3/4] PCI: Introduce disable_acs_redir quirk
Message-ID: <20180717114847.5c407c59@t450s.home>
In-Reply-To: <20180717170204.30470-4-logang@deltatee.com>
References: <20180717170204.30470-1-logang@deltatee.com>
        <20180717170204.30470-4-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 17 Jul 2018 11:02:03 -0600
Logan Gunthorpe <logang@deltatee.com> wrote:

> Intel SPT PCH hardware has an implementation of the ACS bits that
> does not comply with the PCI express standard. To deal with this
> the existing code has an enable_acs() quirk for the hardware.
> 
> In order to be able to correctly disable the ACS redirect bits for
> all hardware we need an analagous quirk to disable those bits.
> 
> This adds the function pci_dev_specific_disable_acs_redir() which
> behaves similarly to pci_dev_specific_enable_acs() but uses a new
> function pointer for quirks which disables the ACS redirect bits.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/pci/quirks.c | 78 ++++++++++++++++++++++++++++++++++++++++++++--------
>  include/linux/pci.h  |  5 ++++
>  2 files changed, 71 insertions(+), 12 deletions(-)

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
