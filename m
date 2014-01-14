Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ea0-f171.google.com ([209.85.215.171]:64594 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbaANIyQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2014 03:54:16 -0500
Received: by mail-ea0-f171.google.com with SMTP id h10so3806471eak.30
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2014 00:54:15 -0800 (PST)
Date: Tue, 14 Jan 2014 10:54:12 +0200
From: Jack Morgenstein <jackm@dev.mellanox.co.il>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, yinghai@kernel.org, bhelgaas@google.com,
	amirv@mellanox.com, ogerlitz@mellanox.com, eugenia@mellanox.com,
	Guo Chao <yan@linux.vnet.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: mlx4_core probe error after applying Yinghai's patch
Message-ID: <20140114105412.16756f4e@jpm-OptiPlex-GX620>
In-Reply-To: <20140114062215.GA19345@richard>
References: <20140114062215.GA19345@richard>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,
In addition, I would like to know if you have enabled SRIOV in the
driver.

Please provide the output of the console command below.

grep "mlx4_core" /etc/modprobe.d/*.conf


Thanks.

-Jack
