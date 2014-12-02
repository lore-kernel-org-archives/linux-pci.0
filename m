Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:61642 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932199AbaLBUN2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Dec 2014 15:13:28 -0500
Received: by mail-qa0-f51.google.com with SMTP id k15so9180363qaq.38
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2014 12:13:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHH3p5L5bX+9PfZCFHAYmyAS9+kg9CpdQWnAy7WZLCNBm+RYSA@mail.gmail.com>
References: <CAHH3p5L5bX+9PfZCFHAYmyAS9+kg9CpdQWnAy7WZLCNBm+RYSA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 2 Dec 2014 13:13:07 -0700
Message-ID: <CAErSpo6U9Zpw1Dd79yFmEksEdHSmqDJe517JsLUSN79P9iEJRA@mail.gmail.com>
Subject: Re: PCIE card link up w/ or w/o device connected
To: shiv prakash Agarwal <chhotu.shiv@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pratyush Anand <pratyush.anand@st.com>,
	Yinghai Lu <yinghai@kernel.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Pratyush, Yinghai, Alex, Rajat]

On Wed, Nov 26, 2014 at 7:57 AM, shiv prakash Agarwal
<chhotu.shiv@gmail.com> wrote:
> Hi All,
>
> Is anybody aware of any pcie card which gets detected by root port i.e
> link is up only when any device is connected to card? For example:
> PCIE USB3 card link is up only when a usb3 device is connected to it.
>
> Is it possible at least? Or card link will always be up whether any
> device is connected to it or not?

Yes, I think that's possible.  This is similar to the situation Rajat
has where the link state of a device can be controlled by some
external entity: e48f1b67f668 ("PCI: pciehp: Use link change
notifications for hot-plug and removal").

Bjorn
