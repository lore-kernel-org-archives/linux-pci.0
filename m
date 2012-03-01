Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 1 Mar 2012 11:03:23 -0800
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Yinghai Lu <yinghai@kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-usb@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] usb, PCI: split quirk for usb host controller to
 three
Message-ID: <20120301190323.GA5155@xanatos>
References: <1330622227-4209-1-git-send-email-yinghai@kernel.org>
 <20120301172435.GA8505@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120301172435.GA8505@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 01, 2012 at 09:24:35AM -0800, Greg Kroah-Hartman wrote:
> On Thu, Mar 01, 2012 at 09:17:07AM -0800, Yinghai Lu wrote:
> > so we avoid checking class again and again in that quirk.
> > 
> > need to be applied after pci/linux-next and usb/usb-next
> 
> As those are two independant trees, this needs to wait until after
> 3.4-rc1 is out.
> 
> > Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> > 
> > ---
> >  drivers/usb/host/pci-quirks.c |   42 ++++++++++++++++++++++++++++--------------
> >  1 file changed, 28 insertions(+), 14 deletions(-)
> 
> Is this really helping anything here?  You added code overall :(

I agree with Greg.  Why change this?  Does it shave off any boot time?
Please show hard numbers for what improvements this makes.  I really
don't want to change PCI init and break people's systems.

Sarah Sharp
