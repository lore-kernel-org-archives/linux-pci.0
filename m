Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:35734 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754461AbbA0RKy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jan 2015 12:10:54 -0500
Received: by mail-la0-f49.google.com with SMTP id gf13so14389289lab.8
        for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2015 09:10:53 -0800 (PST)
MIME-Version: 1.0
Reply-To: pricardofc@gmail.com
In-Reply-To: <20150127164724.GC22764@kroah.com>
References: <CAH9N0t9KvhzmZDgD8PD5VBPR-pPhuE8MmBgK9RY8+ZtKyz++pQ@mail.gmail.com>
	<CAErSpo48mPENuHpES1Q73ep+NKG8x2Zgb+g71do02y7vufbtfQ@mail.gmail.com>
	<CAH9N0t8s+kcG_Qok0wpoDz9jzwvPk_QmBK_p-qbACZJjrr+iVQ@mail.gmail.com>
	<CAErSpo7NK6S8Dk3-FYFV=AVPR8cLRzmAWrBNQ2rke0BRADxAKw@mail.gmail.com>
	<CAH9N0t-+gog9wNFo7hqhzrWuttrRyf5HjjHciFrDGz1rZUiUfw@mail.gmail.com>
	<20150122222016.GF13072@google.com>
	<CAH9N0t_YoRZtPqWwAaNdHNW3m-HOfrCevBZGiOnM+VWGxeFwEQ@mail.gmail.com>
	<CAErSpo4bRnGkfmzLnGSUnv-aJfmZLtQ_jXhnZo+9Wm=CgHOB3A@mail.gmail.com>
	<CAH9N0t9o63GLEYyLgW2CThhP8TW3Bc7_RxbP4bdwwcd120-gRw@mail.gmail.com>
	<20150127164724.GC22764@kroah.com>
Date: Tue, 27 Jan 2015 17:10:52 +0000
Message-ID: <CAH9N0t9zOOqx_mwRbQFNmAi8=A3hP1c6eAz+k7z7_hfcXBQ2xg@mail.gmail.com>
Subject: Re: Hot add a PCIe device driver upon hotplug event
From: Paulo Fortuna Carvalho <pricardofc@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>Is it possible to cancel somehow the remove procedure if the device is in use? Nope, >you could have physically removed the device, so we can't cancel that :)

ok.

>When we are using the device and remove occurs the kernel crashes. Then we need to fix the kernel, what driver is crashing, and where?

The driver of the ATCA acquisition card crashes in a read data
function through DMA accesses.
