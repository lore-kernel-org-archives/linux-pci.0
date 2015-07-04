Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from sharehosting1.iut.ac.ir ([176.101.52.222]:48278 "EHLO
	sharehosting1.iut.ac.ir" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbbGENzN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 5 Jul 2015 09:55:13 -0400
To: <linux-kernel@vger.kernel.org>
Subject: HOWTO do Linux kernel development
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Sat, 04 Jul 2015 13:07:27 +0430
From: <salix@opencores.org>
Cc: <linux-pci@vger.kernel.org>
Message-ID: <c7923f5477f56a19f70f4450ef22c01f@sarv.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

hi,

I'm beginner in Device Driver Developing and I trying to write a WAN 
card driver for a FPGA
based card. I reading pc300too.c and wanxl.c codes in 
linux/drivers/net/wan/ directory to write my driver
also I using kscope-1.6.2, It's great software for reading codes.

I know there are some static and dynamic tools for testing drivers and 
kernel modules
such as KEDR, LDV, S2E, symDrive, cpaChecker, ...

which one is better for me to test wanxl.c and pc300too.c for reverse 
engineering and finally test my driver?
which tools you use? and how test your codes?

thanks
Best Regards

