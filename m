Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:62417 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878AbaBJVrx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Feb 2014 16:47:53 -0500
Received: by mail-ob0-f180.google.com with SMTP id wp4so7867746obc.39
        for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2014 13:47:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHH3p5+zPk6Me6TjKAhL2RWP_osVvEsjh--4JR2i08te9A31qg@mail.gmail.com>
References: <CAHH3p5+zPk6Me6TjKAhL2RWP_osVvEsjh--4JR2i08te9A31qg@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 10 Feb 2014 14:47:32 -0700
Message-ID: <CAErSpo4yu6ug+A2QtkyADagmfNkDYBScJJZjJkWb-B+raPcVxA@mail.gmail.com>
Subject: Re: PCIE bandwidth utilization
To: shiv prakash Agarwal <chhotu.shiv@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pratyush Anand <pratyush.anand@st.com>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 6, 2014 at 5:22 AM, shiv prakash Agarwal
<chhotu.shiv@gmail.com> wrote:
> Hi All,
>
> Below queries:
>
> 1. Is there a way to find current PCIE bandwidth utilization? i.e How
> much of supported bandwidth is being used?

I suspect there is vendor-specific support for measuring things like
this, but I'm not aware of anything standardized or supported by
Linux.

I did find this: http://pcitop.berlios.de/, but I think it's only for
HP Itanium hardware.  I wonder if any of that functionality would make
sense in "perf"?

> 2. Can it happen that a device runs at lower speed that what is
> practically possible? i.e suppose a GPU can go upto 100 MBps, but it
> needs to run at 50 MBps only?

I'm not quite sure what you're asking, but it is possible to plug a
PCIe card into a slot larger than required, i.e., the slot may support
more lanes than the card:
http://en.wikipedia.org/wiki/PCI_Express#Form_factors

Bjorn
