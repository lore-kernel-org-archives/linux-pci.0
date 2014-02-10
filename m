Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:65071 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbaBJO31 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Feb 2014 09:29:27 -0500
Received: by mail-pb0-f45.google.com with SMTP id un15so6321051pbc.32
        for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2014 06:29:27 -0800 (PST)
Received: from [192.168.1.27] ([112.80.114.123])
        by mx.google.com with ESMTPSA id om6sm43006785pbc.43.2014.02.10.06.29.24
        for <linux-pci@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 10 Feb 2014 06:29:26 -0800 (PST)
Message-ID: <52F8E242.4040106@gmail.com>
Date: Mon, 10 Feb 2014 22:29:22 +0800
From: zsaitom <zsaitom@gmail.com>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
Subject: How to combine two PCIe devices in one domain?
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

I have a driver module which would drive two PCIe devices to access a same memory area.
As the two devices are in different domains, I should map the memory to every PCIe device. And also the mapped address may be different for individual PCIe device.
How could I combine these two PCIe device in one domain so they share same address space?

Thanks.
