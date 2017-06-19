Return-Path: <SRS0=viw0=5Y=rsyncme.org=piotrgregor@kernel.org>
Return-Path: <SRS0=viw0=5Y=rsyncme.org=piotrgregor@kernel.org>
Date: Mon, 19 Jun 2017 01:26:52 +0100
From: Piotr Gregor <piotrgregor@rsyncme.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neo Jia <cjia@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
	Vlad Tsyrklevich <vlad@tsyrklevich.net>,
	Arvind Yadav <arvind.yadav.cs@gmail.com>,
	Yongji Xie <xyjxie@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] PCI: Move test of INTx masking to pci_setup_device
Message-ID: <20170619002651.GA29796@westernst>
References: <20170526210222.GA22204@westernst>
 <20170616225446.GG11129@bhelgaas-glaptop.roam.corp.google.com>
 <20170617174543.GA1723@westernst>
 <20170618011433.GK11129@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170618011433.GK11129@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 17, 2017 at 08:14:33PM -0500, Bjorn Helgaas wrote:
> On Sat, Jun 17, 2017 at 06:45:44PM +0100, Piotr Gregor wrote:
> > Hi Bjorn,
> > 
> > The pci_cfg_access_lock is most likely not needed there.
> > The assignment by return type is indeed preferred in this case.
> > 
> > However, you have changed the meaning of returned boolean information
> > by pci_intx_mask_broken leaving pci_intx_mask_supported unchanged.
> > The test should be: 
> > 
> >     if (new != toggle) /* the test failed */
> > 	        return 1;
> > 	return 0;
> 
> Oh, you're absolutely right, thanks for catching that!  I updated my
> pci/enumeration branch.
> 
> > Regarding v2.3 - do you think it is worth to apply the check
> > so we would have something like
> > 
> >     if ((new == toggle) || PCI_VERSION_PRIOR_TO_23) /* test OK or PCI prior to r2.3 */
> > 	        return 0;
> > 	return 1;
> 
> I'm not sure how to test for r2.3 compliance.  But even if we could, I
> guess I think the current code is probably better because it actually
> checks the property we care about, not a spec revision that is one
> step removed from the property.
> 
> Bjorn

Hi Bjorn,

You are right, having

        if ((new == toggle) || PCI_VERSION_PRIOR_TO_23) /* test OK or PCI prior to r2.3 */
		        return 0;
        return 1;

would be incorrect, as if new != toggle then PCI_COMMAND_INTX_DISABLE is not writable
so INTx masking support should be considered broken (regardless of PCI version).

Piotr
