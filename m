Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752442AbdGXCGh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Jul 2017 22:06:37 -0400
Date: Sun, 23 Jul 2017 20:06:36 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Feng Kan <fkan@apm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH V2] pci: quirk: Apply APM ACS quirk to XGene devices
Message-ID: <20170723200636.3fa7f351@w520.home>
In-Reply-To: <CAL85gmBB=U_4jkChKwfZGPQR0zeoZ4=hg7e6HMnu-DS0u1-Wsg@mail.gmail.com>
References: <1500511611-2019-1-git-send-email-fkan@apm.com>
        <20170720162255.36e015f1@ul30vt.home>
        <CAL85gmBB=U_4jkChKwfZGPQR0zeoZ4=hg7e6HMnu-DS0u1-Wsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 21 Jul 2017 13:20:18 -0700
Feng Kan <fkan@apm.com> wrote:

> On Thu, Jul 20, 2017 at 3:22 PM, Alex Williamson
> <alex.williamson@redhat.com> wrote:
> > On Wed, 19 Jul 2017 17:46:51 -0700
> > Feng Kan <fkan@apm.com> wrote:
> >  
> >> The APM X-Gene PCIe root port does not support ACS at this point.
> >> However, the hw provides isolation and source validation through
> >> the SMMU. Turn on ACS but disable all the peer to peer features.
> >>
> >> Signed-off-by: Feng Kan <fkan@apm.com>
> >> ---
> >>  drivers/pci/quirks.c | 15 +++++++++++++++
> >>  1 file changed, 15 insertions(+)
> >>
> >> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> >> index 085fb78..0f8f1cd 100644
> >> --- a/drivers/pci/quirks.c
> >> +++ b/drivers/pci/quirks.c
> >> @@ -4120,6 +4120,19 @@ static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
> >>       return acs_flags ? 0 : 1;
> >>  }
> >>
> >> +static int pci_quirk_xgene_acs(struct pci_dev *dev, u16 acs_flags)
> >> +{
> >> +     /*
> >> +      * XGene root matching this quirk do not allow peer-to-peer
> >> +      * transactions with others, allowing masking out these bits as if they
> >> +      * were unimplemented in the ACS capability.
> >> +      */
> >> +     acs_flags &= ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
> >> +                    PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT);
> >> +
> >> +     return acs_flags ? 0 : 1;
> >> +}
> >> +
> >>  /*
> >>   * Many Intel PCH root ports do provide ACS-like features to disable peer
> >>   * transactions and validate bus numbers in requests, but do not provide an
> >> @@ -4368,6 +4381,8 @@ static int pci_quirk_mf_endpoint_acs(struct pci_dev *dev, u16 acs_flags)
> >>       { 0x10df, 0x720, pci_quirk_mf_endpoint_acs }, /* Emulex Skyhawk-R */
> >>       /* Cavium ThunderX */
> >>       { PCI_VENDOR_ID_CAVIUM, PCI_ANY_ID, pci_quirk_cavium_acs },
> >> +     /* APM XGene */
> >> +     { PCI_VENDOR_ID_AMCC, 0xE004, pci_quirk_xgene_acs },
> >>       { 0 }
> >>  };
> >>  
> >
> > Sorry, I'm not yet convinced there's an equivalent of SV, if a device
> > spoofs a different bdf and it reaches the smmu, what prevents that from
> > simply referencing the context for that alternate bdf?  
> Perhaps I am not understanding the question correctly. The bdf forms a
> stream id which is used to provide an context. Since there is no actual
> context created by an alternate bdf, the transaction would be rejected
> by the SMMU.

Unless that context does exist.  Take for example a basic topology:

-[0000:00]-+-00.0
           +-01.0-[01]----00.0
           +-02.0-[02]----00.0

Assume 00:01.0 and 00:02.0 are root ports and 01:00.0 and 02:00.0 are
their respective downstream endpoint.  A single iommu would typically
handle both of these endpoints using the requester ID, aka stream ID, to
reference the appropriate context.  Source validation at the root port
makes sure that any forwarded transaction has a requester ID that falls
between the secondary and subordinate bus number range of the root
port.  For instance, if device 01:00.0 was able to generate a
transaction with a requester ID of 02:00.0, source validation at the
root port would generate an ACS violation.  If the root port does not
support source validation, the transaction might successfully reference
the iommu context for the other endpoint.  Therefore I don't understand
what property of the SMMU is able to prevent this spoofing technique if
the root port provides no protection on its own.  Thanks,

Alex
