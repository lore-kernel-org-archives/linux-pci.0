Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 31 Jul 2012 15:32:40 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthew Garrett <mjg@redhat.com>
Cc: matt.fleming@intel.com, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH V2 1/4] EFI: Stash ROMs if they're not in the PCI BAR
Message-ID: <20120731223240.GD19134@kroah.com>
References: <1343407934-459-1-git-send-email-mjg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343407934-459-1-git-send-email-mjg@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 27, 2012 at 12:52:11PM -0400, Matthew Garrett wrote:
> EFI provides support for providing PCI ROMs via means other than the ROM
> BAR. This support vanishes after we've exited boot services, so add support
> for stashing copies of the ROMs in setup_data if they're not otherwise
> available.
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> Tested-by: Seth Forshee <seth.forshee@canonical.com>
> ---
>  arch/x86/boot/compressed/eboot.c |  118 ++++++++++++++++++++++++++++++++++++++
>  arch/x86/include/asm/bootparam.h |    1 +
>  arch/x86/include/asm/pci.h       |   12 ++++
>  include/linux/efi.h              |   71 +++++++++++++++++++++++
>  4 files changed, 202 insertions(+)

With this series, does the latest MacBook work properly for the Intel
graphics driver?  Or is this to resolve some other hardware issue?

thanks,

greg k-h
