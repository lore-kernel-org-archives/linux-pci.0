Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:60412 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932304AbbA0QrZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jan 2015 11:47:25 -0500
Date: Tue, 27 Jan 2015 08:47:24 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Paulo Fortuna Carvalho <pricardofc@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Hot add a PCIe device driver upon hotplug event
Message-ID: <20150127164724.GC22764@kroah.com>
References: <CAH9N0t9KvhzmZDgD8PD5VBPR-pPhuE8MmBgK9RY8+ZtKyz++pQ@mail.gmail.com>
 <CAErSpo48mPENuHpES1Q73ep+NKG8x2Zgb+g71do02y7vufbtfQ@mail.gmail.com>
 <CAH9N0t8s+kcG_Qok0wpoDz9jzwvPk_QmBK_p-qbACZJjrr+iVQ@mail.gmail.com>
 <CAErSpo7NK6S8Dk3-FYFV=AVPR8cLRzmAWrBNQ2rke0BRADxAKw@mail.gmail.com>
 <CAH9N0t-+gog9wNFo7hqhzrWuttrRyf5HjjHciFrDGz1rZUiUfw@mail.gmail.com>
 <20150122222016.GF13072@google.com>
 <CAH9N0t_YoRZtPqWwAaNdHNW3m-HOfrCevBZGiOnM+VWGxeFwEQ@mail.gmail.com>
 <CAErSpo4bRnGkfmzLnGSUnv-aJfmZLtQ_jXhnZo+9Wm=CgHOB3A@mail.gmail.com>
 <CAH9N0t9o63GLEYyLgW2CThhP8TW3Bc7_RxbP4bdwwcd120-gRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAH9N0t9o63GLEYyLgW2CThhP8TW3Bc7_RxbP4bdwwcd120-gRw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 27, 2015 at 04:31:04PM +0000, Paulo Fortuna Carvalho wrote:
> Hello Bjorn,
> 
> Is it possible to cancel somehow the remove procedure if the device is in use?

Nope, you could have physically removed the device, so we can't cancel
that :)

> When we are using the device and remove occurs the kernel crashes.

Then we need to fix the kernel, what driver is crashing, and where?

thanks,

greg k-h
