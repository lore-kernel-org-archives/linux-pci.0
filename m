Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 13 Mar 2016 19:24:58 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andrey Utkin <andrey_utkin@fastmail.com>
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Bluecherry Maintainers <maintainers@bluecherrydvr.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Kalle Valo <kvalo@codeaurora.org>,
	Joe Perches <joe@perches.com>, Jiri Slaby <jslaby@suse.com>,
	devel@driverdev.osuosl.org, kernel-mentors@selenic.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Subject: Re: [PATCH] Add tw5864 driver
Message-ID: <20160314022458.GA4036@kroah.com>
References: <1457920461-20713-1-git-send-email-andrey_utkin@fastmail.com>
 <1457920514-20792-1-git-send-email-andrey_utkin@fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457920514-20792-1-git-send-email-andrey_utkin@fastmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 14, 2016 at 03:55:14AM +0200, Andrey Utkin wrote:
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2333,6 +2333,7 @@
>  #define PCI_VENDOR_ID_CAVIUM		0x177d
>  
>  #define PCI_VENDOR_ID_TECHWELL		0x1797
> +#define PCI_DEVICE_ID_TECHWELL_5864	0x5864
>  #define PCI_DEVICE_ID_TECHWELL_6800	0x6800
>  #define PCI_DEVICE_ID_TECHWELL_6801	0x6801
>  #define PCI_DEVICE_ID_TECHWELL_6804	0x6804

Please read the comments at the top of this file for why you don't need
to put any new ids into it.

thanks,

greg k-h
