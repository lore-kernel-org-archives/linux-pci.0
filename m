Return-Path: <SRS0=bZRq=45=rsyncme.org=piotrgregor@kernel.org>
Return-Path: <SRS0=bZRq=45=rsyncme.org=piotrgregor@kernel.org>
Date: Wed, 24 May 2017 00:52:53 +0100
From: Piotr Gregor <piotrgregor@rsyncme.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Piotr Gregor <piotrek.gregor@gmail.com>,
	Alex Williamson <alex.williamson@redhat.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: Handle the case when PCI_COMMAND register hasn't
 changed in INTx masking test
Message-ID: <20170523235252.GA18765@westernst>
References: <20170510122959.4uupohiz3ukzm4c4@debian1.home>
 <20170522233820.GH19733@bhelgaas-glaptop.roam.corp.google.com>
 <20170523161929.GA24431@bhelgaas-glaptop.roam.corp.google.com>
 <20170523103904.3a20d0cc@w520.home>
 <CAO3obxb349aeDX1harujpzi_E2ZMq820wtjrODR5sYiZ=KtjwQ@mail.gmail.com>
 <20170523214531.GB20928@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170523214531.GB20928@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 23, 2017 at 04:45:31PM -0500, Bjorn Helgaas wrote:
> On Tue, May 23, 2017 at 08:14:26PM +0100, Piotr Gregor wrote:
> > Would the pci_setup_device() be a good place to move this check to?
> 
> Seems like a reasonable place.

Will upload new patch moving test of INTx masking support to
pci_setup_device(). There is just one thing: a quirk for devices
that have this support broken (e.g. Ralink RT2800 802.11n).

It is quirk_broken_intx_masking defined in quirks.c:

3190 /*
3191  * Some devices may pass our check in pci_intx_mask_supported() if
3192  * PCI_COMMAND_INTX_DISABLE works though they actually do not properly
3193  * support this feature.
3194  */
3195 static void quirk_broken_intx_masking(struct pci_dev *dev)
3196 {
3197         dev->broken_intx_masking = 1;
3198 }
3199 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x0030,
3200                         quirk_broken_intx_masking);
3201 DECLARE_PCI_FIXUP_FINAL(0x1814, 0x0601, /* Ralink RT2800 802.11n
PCI */
3202                         quirk_broken_intx_masking);

The pci_intx_mask_supported() currently does check for dev->broken_intx_masking
before performing INTx masking test by reading/writing registers.
If we move pci_intx_mask_supported() check
to pci_setup_device() just before header switch is entered:

1402         if (pci_intx_mask_supported(dev))
1403                 dev->intx_mask_support = 1;
1404 
1405         switch (dev->hdr_type) {                    /* header type
*/

will the quirk be already applied so that pci_intx_mask_supported() can
use broken_intx_masking() flag?
Or should it just perform the test without check for this flag and only
when checking later for INTx masking test we will use that flag (which
would be assigned later), so it could be for example

static inline bool pci_is_intx_mask_supported(struct pci_dev *pdev)
{
        return (pdev->intx_mask_support && !pdev->broken_intx_masking);
}
