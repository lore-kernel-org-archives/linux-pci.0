Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:42479 "EHLO
	mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbcGLVVl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jul 2016 17:21:41 -0400
Date: Tue, 12 Jul 2016 23:21:39 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Xavier Gnata <xavier.gnata@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Add support for INTEL_FALCON_RIDGE_2C
 controller
Message-ID: <20160712212139.GB5488@wunner.de>
References: <5785474B.6070608@gmail.com>
 <20160712211324.GA5488@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160712211324.GA5488@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 12, 2016 at 11:13:24PM +0200, Lukas Wunner wrote:
> On Tue, Jul 12, 2016 at 09:38:51PM +0200, Xavier Gnata wrote:
> > Add support to INTEL_FALCON_RIDGE_2C controller and corresponding quirk to
> > support suspend/resume.
> > Tested against 4.7 master on a MacBook Air 11" 2015
[...]
> Please also add PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI to tb_switch_alloc()
> so that the message "unsupported switch device id" is not printed for this
> controller.

Sorry, I meant PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_BRIDGE rather than _NHI.

And Falcon Ridge 4C is also missing there.

Thanks,

Lukas
