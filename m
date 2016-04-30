Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41612 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750782AbcD3MTr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 30 Apr 2016 08:19:47 -0400
Date: Sat, 30 Apr 2016 07:19:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Yong, Jonathan" <jonathan.yong@intel.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH] PCI: PTM preliminary implementation
Message-ID: <20160430121944.GB10197@localhost>
References: <1461047358-4736-1-git-send-email-jonathan.yong@intel.com>
 <1461047358-4736-2-git-send-email-jonathan.yong@intel.com>
 <20160429162026.GC949@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160429162026.GC949@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 29, 2016 at 11:20:26AM -0500, Bjorn Helgaas wrote:
> On Tue, Apr 19, 2016 at 06:29:18AM +0000, Yong, Jonathan wrote:
> > ...
> > +static ssize_t ptm_status_show(struct device *dev,
> > +	struct device_attribute *attr, char *buf)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	u16 word;
> > +	int pos;
> > +
> > +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PTM);
> > +	if (!pos)
> > +		return -ENXIO;
> > +
> > +	pci_read_config_word(pdev, pos + PCI_PTM_CONTROL_REG_OFFSET, &word);
> 
> This is a 32-bit register; read it as a dword, even though the upper
> bits are currently reserved.
> 
> > +	return sprintf(buf, "%u\n", word & PCI_PTM_CTRL_ENABLE ? 1 : 0);
> > +}
> > +
> > +static ssize_t ptm_status_store(struct device *dev,
> > +	struct device_attribute *attr, const char *buf, size_t count)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	unsigned long val;
> > +	ssize_t ret;
> > +
> > +	ret = kstrtoul(buf, 0, &val);
> > +	if (ret)
> > +		return ret;
> > +	if (val)
> > +		return pci_enable_ptm(pdev);
> > +	pci_disable_ptm(pdev);
> > +	return 0;
> > +}
> > +
> > +static DEVICE_ATTR_RW(ptm_status);

Thinking about this sysfs interface some more...  Do you think we
really need a knob in sysfs?  What's the use case for it?  I suppose
there's potentially a performance impact because we'll send more
messages across the link, but I'd be surprised if it were measurable.
If it's basically free, there shouldn't be a need to enable/disable it
individually, except maybe to work around hardware bugs.  A kernel
boot parameter might be enough for that.  Even a kernel boot parameter
should be regarded as a debug/testing tool, not a solution.  If we
find broken devices, we should add quirks for them so users don't need
to use a boot parameter.

Bjorn
