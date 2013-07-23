Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:54084 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933386Ab3GWXRs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jul 2013 19:17:48 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>,
	'Wolfram Sang' <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jingoo Han <jg1.han@samsung.com>
References: <1374602524-3398-1-git-send-email-wsa@the-dreams.de>
 <1374602524-3398-14-git-send-email-wsa@the-dreams.de>
 <CAErSpo4jazaN8YahJGs+KD1-j6o8QHe2LmiQwBY9+UweBVkHxQ@mail.gmail.com>
In-reply-to: <CAErSpo4jazaN8YahJGs+KD1-j6o8QHe2LmiQwBY9+UweBVkHxQ@mail.gmail.com>
Subject: Re: [PATCH 13/27] drivers/pci/host: don't check resource with
 devm_ioremap_resource
Date: Wed, 24 Jul 2013 08:17:46 +0900
Message-id: <004b01ce87fa$d77f9700$867ec500$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, July 24, 2013 3:13 AM, Bjorn Helgaas wrote:
> On Tue, Jul 23, 2013 at 12:01 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > devm_ioremap_resource does sanity checks on the given resource. No need to
> > duplicate this in the driver.
> >
> > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Jingoo, I can apply this, or if you have other pcie-designware.c
> updates this cycle, you can fold it into those.  Just let me know what
> you'd prefer.

Hi Bjorn Helgaas,

I will send other updates for pcie-designware.c.
I will fold it into those.
Thank you.

Best regards,
Jingoo Han



