Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:32958 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754461AbbA0RLC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jan 2015 12:11:02 -0500
Date: Tue, 27 Jan 2015 09:11:01 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Paulo Fortuna Carvalho <pricardofc@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Hot add a PCIe device driver upon hotplug event
Message-ID: <20150127171101.GA18912@kroah.com>
References: <CAH9N0t8s+kcG_Qok0wpoDz9jzwvPk_QmBK_p-qbACZJjrr+iVQ@mail.gmail.com>
 <CAErSpo7NK6S8Dk3-FYFV=AVPR8cLRzmAWrBNQ2rke0BRADxAKw@mail.gmail.com>
 <CAH9N0t-+gog9wNFo7hqhzrWuttrRyf5HjjHciFrDGz1rZUiUfw@mail.gmail.com>
 <20150122222016.GF13072@google.com>
 <CAH9N0t_YoRZtPqWwAaNdHNW3m-HOfrCevBZGiOnM+VWGxeFwEQ@mail.gmail.com>
 <CAErSpo4bRnGkfmzLnGSUnv-aJfmZLtQ_jXhnZo+9Wm=CgHOB3A@mail.gmail.com>
 <CAH9N0t9o63GLEYyLgW2CThhP8TW3Bc7_RxbP4bdwwcd120-gRw@mail.gmail.com>
 <20150127164724.GC22764@kroah.com>
 <CAH9N0t-M2QfW84Jd3fRaLr+NdFvZEkjXzrXsgncoLhtYv-xQ3g@mail.gmail.com>
 <CAH9N0t-_JbwtZeU+Kyds8=NX=CBT-+_ecKiUWPKr1zXiLKm0vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAH9N0t-_JbwtZeU+Kyds8=NX=CBT-+_ecKiUWPKr1zXiLKm0vQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 27, 2015 at 05:06:33PM +0000, Paulo Fortuna Carvalho wrote:
> >Is it possible to cancel somehow the remove procedure if the device is
> >in use?
> 
> >Nope, you could have physically removed the device, so we can't cancel
> >that :)
> 
> ok.
> 
> >When we are using the device and remove occurs the kernel crashes.
> >Then we need to fix the kernel, what driver is crashing, and where?
> 
> The driver of the ATCA acquisition card crashes in a read data function
> through DMA accesses.

Do you have an oops callback?  All read functions need to be able to
handle a 0xff read when the device is removed and react properly.

thanks,

greg k-h
