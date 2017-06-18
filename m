Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751068AbdFRBOk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 17 Jun 2017 21:14:40 -0400
Date: Sat, 17 Jun 2017 20:14:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Piotr Gregor <piotrgregor@rsyncme.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Neo Jia <cjia@nvidia.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Vlad Tsyrklevich <vlad@tsyrklevich.net>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Yongji Xie <xyjxie@linux.vnet.ibm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH] PCI: Move test of INTx masking to pci_setup_device
Message-ID: <20170618011433.GK11129@bhelgaas-glaptop.roam.corp.google.com>
References: <20170526210222.GA22204@westernst>
 <20170616225446.GG11129@bhelgaas-glaptop.roam.corp.google.com>
 <20170617174543.GA1723@westernst>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170617174543.GA1723@westernst>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 17, 2017 at 06:45:44PM +0100, Piotr Gregor wrote:
> Hi Bjorn,
> 
> The pci_cfg_access_lock is most likely not needed there.
> The assignment by return type is indeed preferred in this case.
> 
> However, you have changed the meaning of returned boolean information
> by pci_intx_mask_broken leaving pci_intx_mask_supported unchanged.
> The test should be: 
> 
>     if (new != toggle) /* the test failed */
> 	        return 1;
> 	return 0;

Oh, you're absolutely right, thanks for catching that!  I updated my
pci/enumeration branch.

> Regarding v2.3 - do you think it is worth to apply the check
> so we would have something like
> 
>     if ((new == toggle) || PCI_VERSION_PRIOR_TO_23) /* test OK or PCI prior to r2.3 */
> 	        return 0;
> 	return 1;

I'm not sure how to test for r2.3 compliance.  But even if we could, I
guess I think the current code is probably better because it actually
checks the property we care about, not a spec revision that is one
step removed from the property.

Bjorn
