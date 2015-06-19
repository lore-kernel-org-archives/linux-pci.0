Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f47.google.com ([209.85.213.47]:34680 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbbFSHsv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jun 2015 03:48:51 -0400
MIME-Version: 1.0
In-Reply-To: <8520D5D51A55D047800579B094147198C79891@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <8520D5D51A55D047800579B094147198C79891@XAP-PVEXMBX01.xlnx.xilinx.com>
Date: Fri, 19 Jun 2015 13:18:50 +0530
Message-ID: <CAHM4w1mWk7XWD0po-O4ozA_+JS0a3o-Q7dOQd-2DkgrhkoFWTw@mail.gmail.com>
Subject: Re: PCIe patch for ARM64
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 19, 2015 at 11:20 AM, Bharat Kumar Gogada
<bharat.kumar.gogada@xilinx.com> wrote:
> Hi
>
> I am developing PCIe root port driver for Xilinx device. We have used following patch for ARM64 bit support "https://lkml.org/lkml/2014/7/3/764". The link explains it as temporary patch and main line will be updated soon with those changes. We have not seen the changes till now. Can you let us know when we can expect the changes in mainline? We are planning to push our drivers to mainline.

Please have a look to the latest kernel and try to see what is
available for ARM64 PCIe.

You may see drivers/pci/host/pci-xgene.c as reference.

I see that there is already a driver for xilinx PCIe controller with
ARM platform.
drivers/pci/host/pcie-xilinx.c

If it is the same device on ARM64, then you need to take similar
approach what is being discussed
for designware on ARM64.

http://marc.info/?l=devicetree&m=143394380815743&w=2

~Pratyush
