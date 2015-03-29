Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 29 Mar 2015 22:40:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Alexei Starovoitov <ast@plumgrid.com>,
	stephen hemminger <stephen@networkplumber.org>,
	Masahiro Yamada <yamada.m@jp.panasonic.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Stephane Eranian <eranian@google.com>,
	Huang Rui <ray.huang@amd.com>,
	Peter Neubauer <pneubauer@bluerwhite.org>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 01/86] pci: export pci_ids.h
Message-ID: <20150329204047.GA5902@kroah.com>
References: <1427635734-24786-1-git-send-email-mst@redhat.com>
 <1427635734-24786-2-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427635734-24786-2-git-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Mar 29, 2015 at 03:37:01PM +0200, Michael S. Tsirkin wrote:
> The macros in pci_ids.h are pretty useful for userspace
> using the pci sysfs interface.
> At the moment userspace is forced to duplicate these macros
> (e.g. QEMU does this), it is better to expose them in
> /usr/include/linux/pci_ids.h so everyone can just include
> this header.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/linux/pci_ids.h      | 2998 +-----------------------------------------
>  include/uapi/linux/pci_ids.h | 2997 +++++++++++++++++++++++++++++++++++++++++

No, please use the pci ids file from the upstream pci id database
instead.  We shouldn't be putting these all in one file, and pulling
them out of drivers isn't ok.

Userspace shouldn't need to know any of these, use libpci.

thanks,

greg k-h
