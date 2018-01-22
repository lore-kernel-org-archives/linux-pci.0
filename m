Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41558 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeAVRtH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jan 2018 12:49:07 -0500
Date: Mon, 22 Jan 2018 09:49:03 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/5] devres: Move managed io function declarations into
 device.h
Message-ID: <20180122174903.z5ijxouq5bw2s36r@dtor-ws>
References: <20180121211432.GA15151@lenoch>
 <20180121211508.GB15151@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180121211508.GB15151@lenoch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jan 21, 2018 at 10:15:08PM +0100, Ladislav Michl wrote:
> Moving managed io function declarations into device.h allows
> removing forward struct device and resource definitions from
> io(port).h

In the face of it, what is the issue with forward declarations of device
and resource structures? device.h is supposed to be about Linux device
model, not hardware. You would not want all devm_* functions to go into
device.h (clock, regulator, input, rtc, hwmon, etc, etc devm API),
right? Why would we want ioport there?

Thanks.

-- 
Dmitry
