Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:50148 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbeAVWL0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jan 2018 17:11:26 -0500
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23992781AbeAVVvBG1wxV (ORCPT <rfc822;linux-pci@vger.kernel.org>
        + 1 other); Mon, 22 Jan 2018 22:51:01 +0100
Date: Mon, 22 Jan 2018 22:50:57 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/5] devres: Move managed io function declarations into
 device.h
Message-ID: <20180122215056.GA27905@lenoch>
References: <20180121211432.GA15151@lenoch>
 <20180121211508.GB15151@lenoch>
 <20180122174903.z5ijxouq5bw2s36r@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180122174903.z5ijxouq5bw2s36r@dtor-ws>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 22, 2018 at 09:49:03AM -0800, Dmitry Torokhov wrote:
> On Sun, Jan 21, 2018 at 10:15:08PM +0100, Ladislav Michl wrote:
> > Moving managed io function declarations into device.h allows
> > removing forward struct device and resource definitions from
> > io(port).h
> 
> In the face of it, what is the issue with forward declarations of device
> and resource structures? device.h is supposed to be about Linux device
> model, not hardware. You would not want all devm_* functions to go into
> device.h (clock, regulator, input, rtc, hwmon, etc, etc devm API),
> right? Why would we want ioport there?

Allright, point taken. Then I would assume devm_ioremap_resource should
be moved from device.h into io.h, to get some consistency, right?
Any other comment (mainly to devm_ioremap_shared_resource) before v2?

Thank you,
	ladis
