Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f193.google.com ([209.85.192.193]:45187 "EHLO
	mail-pd0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbaBJObK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Feb 2014 09:31:10 -0500
Received: by mail-pd0-f193.google.com with SMTP id fp1so2387314pdb.4
        for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2014 06:31:09 -0800 (PST)
Received: from [192.168.1.27] ([112.80.114.123])
        by mx.google.com with ESMTPSA id e6sm43096724pbg.4.2014.02.10.06.31.07
        for <linux-pci@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 10 Feb 2014 06:31:08 -0800 (PST)
Message-ID: <52F8E2A9.4000501@gmail.com>
Date: Mon, 10 Feb 2014 22:31:05 +0800
From: zsaitom <zsaitom@gmail.com>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
Subject: How to combine two PCIe devices in one domain?
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

I have a driver module which would drive two PCIe devices to access a same memory area with intel IOMMU enabled.
As the two devices are in two different domains, I should map the memory to every PCIe device.

How could I combine these two PCIe device in one domain so they share some address space?

Thanks.
