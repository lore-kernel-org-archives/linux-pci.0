Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:43979 "EHLO
	nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349Ab3J2MRU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Oct 2013 08:17:20 -0400
Date: Tue, 29 Oct 2013 13:09:09 +0100
From: Martin Mares <mj@ucw.cz>
To: Zheng Huai Cheng <zhenghch@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] lspci: Skip scanning empty slot in sysfs_fill_slots
Message-ID: <mj+md-20131029.120828.26872.nikam@ucw.cz>
References: <526F4EB4.4090101@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <526F4EB4.4090101@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

> When slot is empty, lspci will report "pcilib: sysfs_fill_slots:
> Couldn't parse entry address 0000:01",this is because address entry will
> only contain domain and bus number when the slot is empty.
> 
> [root@uselp6 ~]# cat /sys/bus/pci/slots/U5802.001.RCHB059-P1-C7/address
> 0000:01

Is this behavior intentional?  It does not make much sense to me.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
This line is umop apisdn.
