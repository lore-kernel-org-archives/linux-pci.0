Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 31 Jul 2012 15:25:55 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jon Mason <jon.mason@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [RFC v2 1/2] PCI-Express Non-Transparent Bridge Support
Message-ID: <20120731222555.GB19134@kroah.com>
References: <1343607994-32415-1-git-send-email-jon.mason@intel.com>
 <1343607994-32415-2-git-send-email-jon.mason@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343607994-32415-2-git-send-email-jon.mason@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jul 29, 2012 at 05:26:33PM -0700, Jon Mason wrote:
> +struct ntb_transport_qp;
> +
> +struct ntb_client {
> +	char *name;
> +	int (*probe) (struct pci_dev *pdev);
> +	void (*remove) (struct pci_dev *pdev);
> +};

Why isn't this tied into the driver model?  That looks like you really
want to use a 'struct device' here, right?

Then you have drivers that bind to them, and your devices show up in
sysfs, which is probably a requirement you have, right?

greg k-h
