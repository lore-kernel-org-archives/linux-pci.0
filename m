Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754168AbeEWIZS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 May 2018 04:25:18 -0400
Date: Wed, 23 May 2018 10:24:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rajat Jain <rajatja@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jes Sorensen <jsorensen@fb.com>,
        Kyle McMartin <jkkm@fb.com>, rajatxjain@gmail.com
Subject: Re: [PATCH 2/5] PCI/AER: Add sysfs stats for AER capable devices
Message-ID: <20180523082458.GE7247@kroah.com>
References: <20180522222805.80314-1-rajatja@google.com>
 <20180522222805.80314-3-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180522222805.80314-3-rajatja@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 22, 2018 at 03:28:02PM -0700, Rajat Jain wrote:
> +#define aer_stats_aggregate_attr(field)                                        \
> +	static ssize_t                                                         \
> +	field##_show(struct device *dev, struct device_attribute *attr,        \
> +		     char *buf)                                                \
> +{                                                                              \
> +	struct pci_dev *pdev = to_pci_dev(dev);                                \
> +	return sprintf(buf, "0x%llx\n", pdev->aer_stats->field);               \
> +}                                                                              \

Use tabs at the end please, otherwise your trailing \ look horrid.

> +static DEVICE_ATTR_RO(field)
> +
> +aer_stats_aggregate_attr(dev_total_cor_errs);
> +aer_stats_aggregate_attr(dev_total_fatal_errs);
> +aer_stats_aggregate_attr(dev_total_nonfatal_errs);
> +
> +static struct attribute *aer_stats_attrs[] __ro_after_init = {
> +	&dev_attr_dev_total_cor_errs.attr,
> +	&dev_attr_dev_total_fatal_errs.attr,
> +	&dev_attr_dev_total_nonfatal_errs.attr,
> +	NULL
> +};
> +
> +static umode_t aer_stats_attrs_are_visible(struct kobject *kobj,
> +					   struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (!pdev->aer_stats)
> +		return 0;
> +
> +	return a->mode;
> +}
> +
> +const struct attribute_group aer_stats_attr_group = {
> +	.name  = "aer_stats",
> +	.attrs  = aer_stats_attrs,
> +	.is_visible = aer_stats_attrs_are_visible,
> +};
> +
> +void pci_dev_aer_stats_incr(struct pci_dev *pdev, struct aer_err_info *info)
> +{
> +	int status, i, max = -1;
> +	u64 *counter = NULL;
> +	struct aer_stats *aer_stats = pdev->aer_stats;
> +
> +	if (unlikely(!aer_stats))
> +		return;

Can you measure the speed difference with and without that unlikely()
macro?  If not, please don't use it.  Hint, the cpu and compiler are
always always better at this than we are...

thanks,

greg k-h
