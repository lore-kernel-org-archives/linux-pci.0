Return-Path: <SRS0=PfZj=ZB=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=PfZj=ZB=linuxfoundation.org=gregkh@kernel.org>
Date: Thu, 19 Jan 2017 11:38:30 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-kernel@vger.kernel.org, Andreas Noever <andreas.noever@gmail.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Tomeu Vizoso <tomeu.vizoso@collabora.com>,
	Chen Yu <yu.c.chen@intel.com>, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 0/8] Runtime PM for Thunderbolt on Macs
Message-ID: <20170119103830.GB19476@kroah.com>
References: <cover.1484486499.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1484486499.git.lukas@wunner.de>
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jan 15, 2017 at 09:03:45PM +0100, Lukas Wunner wrote:
> Power down Thunderbolt controllers on Macs when nothing is plugged in
> to save around 2W per controller.
> 
> For background info please see the cover letter of v3:
> https://lkml.org/lkml/2016/12/17/56
> 
> 
> Patches [1/8] to [3/8] need an ack from Bjorn and/or Rafael.
> Patches [4/8] to [6/8] need an ack from Rafael.
> Patches [7/8] to [8/8] need an ack from Andreas.
> 
> 
> Changes since v4:
> 
> - Patch [2/8] has been reviewed by Mika. (Thanks!)
> 
> - Patch [3/8] now uses a separate helper function instead of stuffing
>   its code into pci_dev_check_d3cold(), as requested by Mika.
> 
> As usual the patches can be reviewed/fetched on GitHub:
> https://github.com/l1k/linux/commits/thunderbolt_runpm_v5
> 
> Thanks,
> 
> Lukas


Due to all of the PCI changes, these should probably go through the PCI
tree, so:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Unless Bjorn wants me to take them?  If so, I need his ack for them.

thanks,

greg k-h
