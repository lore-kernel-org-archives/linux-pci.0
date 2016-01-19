Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41625 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757330AbcASW6O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 19 Jan 2016 17:58:14 -0500
Date: Tue, 19 Jan 2016 16:58:06 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Xavier Gnata <xavier.gnata@gmail.com>
Cc: linux-pci@vger.kernel.org,
	Ashwini Pahuja <ashwini.linux@gmail.com>,
	Felipe Balbi <balbi@ti.com>
Subject: Re: ID conflict between bdc_pci and "720p FaceTime HD Camera"
Message-ID: <20160119225806.GA1841@localhost>
References: <569BB4C2.3020602@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <569BB4C2.3020602@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Ashwini, Felipe]

On Sun, Jan 17, 2016 at 04:35:30PM +0100, Xavier Gnata wrote:
> Hello,
> 
> The development of a driver for
> 02:00.0 Multimedia controller [0480]: Broadcom Corporation 720p
> FaceTime HD Camera [14e4:1570]
> has started. It is still in an early stage but it's progressing and
> it already streams.
> https://github.com/patjak/bcwc_pcie
> 
> However, as you can see, this webcam shares the exact same ID as
> bdc_pci 0x1570 .
> 
> Could we use e.g. PCI_CLASS in bdc_pci to avoid grabbing the webcam
> incorrectly?
> The FaceTime HD Camera has PCI_CLASS 0x048000
> I hope that bdc_pci has another PCI_CLASS.
> Or maybe there is a better way to distinguish bdc_pci from FaceTime
> HD Camera. What do you think?

This is what the PCI Vendor/Device IDs are for.  It's a shame that
Broadcom apparently screwed up and used the same IDs in two different
devices.

At least, I *assume* they're different.  I can't really tell what the
bdc_pci driver does, so it's conceivable that it's using the same
device in a different way than you are.

If they really are different devices, using the class code sounds like
a reasonable way to differentiate them.

Bjorn
