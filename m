Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:34541 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933439AbbLVSV7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 Dec 2015 13:21:59 -0500
To: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Scott Branden <sbranden@broadcom.com>
From: Ray Jui <rjui@broadcom.com>
Subject: About PCIe PRBS loopback
Message-ID: <567994C6.8040604@broadcom.com>
Date: Tue, 22 Dec 2015 10:21:58 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

We have a PCIe Serdes that is capable of generating some PRBS loopback 
test. Our HW team is using this test to validate the PCIe interfaces on 
our boards. To trigger this test, it requires us to configure the Serdes 
by writing to its registers through an internal MDIO interface.

Does it make any sense to have a standalone kernel driver for this type 
of test? Or test code like this should really belong to a bootloader 
like UEFI or something similar?

Any feedback is appreciated!

Thanks,

Ray
