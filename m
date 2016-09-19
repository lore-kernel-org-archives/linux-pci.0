Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:24343 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751033AbcISRgL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Sep 2016 13:36:11 -0400
Date: Mon, 19 Sep 2016 13:47:23 -0400
From: Keith Busch <keith.busch@intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Wei Zhang <wzhang@fb.com>
Subject: Re: [PATCHv2 1/4] pci: Add is_removed state
Message-ID: <20160919174723.GA8000@keith>
References: <1473199219-3369-1-git-send-email-keith.busch@intel.com>
 <1473199219-3369-2-git-send-email-keith.busch@intel.com>
 <20160917083506.GA1235@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160917083506.GA1235@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 17, 2016 at 10:35:06AM +0200, Lukas Wunner wrote:
> On Tue, Sep 06, 2016 at 04:00:16PM -0600, Keith Busch wrote:
> > -	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);
> > +	if (pdev->is_removed)
> > +		return false;
> > +
> > +	if (!pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0)) {
> > +		pdev->is_removed = 1;
> > +		return false;
> > +	}
> > +	return true;
> >  }
> >  EXPORT_SYMBOL_GPL(pci_device_is_present);
> 
> I've kept this series on my development branch and found a bug now:
> 
> In the above hunk, it's okay to return false if pdev->is_removed is set,
> but it's not okay to set pdev->is_removed if pci_bus_read_dev_vendor_id()
> returns false.  That's because pci_bus_read_dev_vendor_id() can fail for
> other reasons, such as the device being powered down to D3cold, or
> currently unreachable because a PCIe port above it was suspended to D3hot
> so that the link is down.  Those are transient issues, the device isn't
> removed in those cases.

Thanks for the info. I wasn't sure about making the removed return sticky
on a failed vendor id check, so I will remove that from this path and
resend the entire series.
