Return-Path: <linux-kernel-owner@vger.kernel.org>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Christoph Hellwig' <hch@infradead.org>,
        Oza Pawandeep <poza@codeaurora.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dongdong Liu <liudongdong3@huawei.com>,
        "Keith Busch" <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: RE: [PATCH v10 2/7] PCI/AER: factor out error reporting from AER
Date: Thu, 22 Feb 2018 18:42:32 +0000
Message-ID: <0cd107dfe3ec4dda89457b112e8f79e5@AcuMS.aculab.com>
References: <1519315332-26852-1-git-send-email-poza@codeaurora.org>
 <1519315332-26852-3-git-send-email-poza@codeaurora.org>
 <20180222183448.GB6267@infradead.org>
In-Reply-To: <20180222183448.GB6267@infradead.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Christoph Hellwig
> > -	pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
> > -	/* TODO: Should kernel panic here? */
> > -	pci_info(dev, "AER: Device recovery failed\n");
> > -}
> > +EXPORT_SYMBOL(pci_find_aer_service);
> 
> EXPORT_SYMBPOL_GPL please.

Is this a function that a 'normal' PCIe device driver would need to call?
If so it is a PITA requiring all drivers that want AER to be GPL.

	David
