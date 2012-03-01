Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 1 Mar 2012 09:24:35 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-usb@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] usb, PCI: split quirk for usb host controller to
 three
Message-ID: <20120301172435.GA8505@kroah.com>
References: <1330622227-4209-1-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330622227-4209-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 01, 2012 at 09:17:07AM -0800, Yinghai Lu wrote:
> so we avoid checking class again and again in that quirk.
> 
> need to be applied after pci/linux-next and usb/usb-next

As those are two independant trees, this needs to wait until after
3.4-rc1 is out.

> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> 
> ---
>  drivers/usb/host/pci-quirks.c |   42 ++++++++++++++++++++++++++++--------------
>  1 file changed, 28 insertions(+), 14 deletions(-)

Is this really helping anything here?  You added code overall :(

greg k-h
