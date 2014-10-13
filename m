Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:36196 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754465AbaJMUOn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 13 Oct 2014 16:14:43 -0400
Message-ID: <1413231118.26478.21.camel@pasglop>
Subject: Re: [PATCH v3 4/7] sound/radeon: Add quirk for broken 64-bit MSI
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Dave Airlie <airlied@linux.ie>, Takashi Iwai <tiwai@suse.de>,
	Brian King <brking@linux.vnet.ibm.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Anton Blanchard <anton@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Oct 2014 07:11:58 +1100
In-Reply-To: <1412746096.30859.229.camel@pasglop>
References: <1412656696.30859.122.camel@pasglop>
	 <CADnq5_NFt8neiOAg896d3-DbAn0rnrE7iXaTFmkNGSg-J9oSkA@mail.gmail.com>
	 <1412746096.30859.229.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2014-10-08 at 16:28 +1100, Benjamin Herrenschmidt wrote:

> > Further discussion with the hw teams have revealed that this is still
> > an issue on newer asics so I think your original patch is correct
> > after all.  Just disable 64 bit MSIs on all AMD audio PCI ids.
> 
> Allright, I won't resend the whole series, I can just pickup my previous
> patch. Takashi, Bjorn, Dave, this series covers your 3 areas of
> maintainership, how do you want to proceed ? I'm happy to merge the
> whole lot via powerpc ASAP (since it's all CC'ed stable) if you guys
> send me the appropriate acks, otherwise, let me know.

So I got an Ack from Takashi but so far silence from Bjorn and Dave :-)

Ping ?

Cheers,
Ben.


