Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33646 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbeAVXVl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jan 2018 18:21:41 -0500
Date: Mon, 22 Jan 2018 15:21:37 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/5] devres: Move managed io function declarations into
 device.h
Message-ID: <20180122232137.hdalkbpczjqfyyax@dtor-ws>
References: <20180121211432.GA15151@lenoch>
 <20180121211508.GB15151@lenoch>
 <20180122174903.z5ijxouq5bw2s36r@dtor-ws>
 <20180122215056.GA27905@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180122215056.GA27905@lenoch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 22, 2018 at 10:50:57PM +0100, Ladislav Michl wrote:
> On Mon, Jan 22, 2018 at 09:49:03AM -0800, Dmitry Torokhov wrote:
> > On Sun, Jan 21, 2018 at 10:15:08PM +0100, Ladislav Michl wrote:
> > > Moving managed io function declarations into device.h allows
> > > removing forward struct device and resource definitions from
> > > io(port).h
> > 
> > In the face of it, what is the issue with forward declarations of device
> > and resource structures? device.h is supposed to be about Linux device
> > model, not hardware. You would not want all devm_* functions to go into
> > device.h (clock, regulator, input, rtc, hwmon, etc, etc devm API),
> > right? Why would we want ioport there?
> 
> Allright, point taken. Then I would assume devm_ioremap_resource should
> be moved from device.h into io.h, to get some consistency, right?

Yes, I think that would be good.

> Any other comment (mainly to devm_ioremap_shared_resource) before v2?
> 
> Thank you,
> 	ladis

Thanks.

-- 
Dmitry
