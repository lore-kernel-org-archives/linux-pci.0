Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ams-iport-3.cisco.com ([144.254.224.146]:53089 "EHLO
	ams-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756006Ab2JaKMB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 31 Oct 2012 06:12:01 -0400
Message-ID: <5090F723.3090103@gmail.com>
Date: Wed, 31 Oct 2012 11:02:11 +0100
From: fpaolo63 <fpaolo63@gmail.com>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
Subject: Linux and multy domain PCIe.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi guru,

I'm working on a multi socket intel xeon platform.

We have 2 sockets and each socket has a PCIe RootComplex, and we'd to 
implement hw with 2 separated PCIe tree.

Can Linux kernel handle the 2 RC assigning a PCIe domain each one?

Do we need special BIOS in order to configure correctly the 2 sockets, 
QDPI channel, MMIO and MMU?

Can some one point me to one example or documents?

thanks in advanced

Paolo
