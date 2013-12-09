Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:60558 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760229Ab3LIDJ7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 8 Dec 2013 22:09:59 -0500
Message-ID: <1386558448.5159.10.camel@pasglop>
Subject: Re: [PATCH] PCI/portdrv: Set master earlier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jean Delvare <jdelvare@suse.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Takashi Iwai <tiwai@suse.de>
Date: Mon, 09 Dec 2013 14:07:28 +1100
In-Reply-To: <CAE9FiQWGWPVO0W5e9qtbMx7PTEKDq8kUPi1RRT8tucMEy7prYw@mail.gmail.com>
References: <20131009163304.62b439a9@endymion.delvare>
	 <CAErSpo6ikaTXXvWzX_Z0=mabwD4aedoLoSVjsd+_E5kV9YJpuA@mail.gmail.com>
	 <CAE9FiQWGWPVO0W5e9qtbMx7PTEKDq8kUPi1RRT8tucMEy7prYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 2013-12-07 at 19:26 -0800, Yinghai Lu wrote:
> BenH mentioned that get_port_device_capability have some problem on
> powerpc and will return null.

Well, it has problems on anything that doesn't have ACPI :-)

I don't care what the "right" fix is but we need to makes sure nobody
does a pci_enable_device() on a bridge and doesn't also enable bus
master, otherwise the bridge bus master will never be set. This is what
was happening an breaking us.

Ben.


