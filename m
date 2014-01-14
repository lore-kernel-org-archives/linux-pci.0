Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog103.obsmtp.com ([207.126.144.115]:44310 "EHLO
	eu1sys200aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750777AbaANIju (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2014 03:39:50 -0500
Message-ID: <52D4F7C8.50706@mellanox.com>
Date: Tue, 14 Jan 2014 10:39:36 +0200
From: Or Gerlitz <ogerlitz@mellanox.com>
MIME-Version: 1.0
To: Wei Yang <weiyang@linux.vnet.ibm.com>
CC: <linux-pci@vger.kernel.org>, <yinghai@kernel.org>,
	<bhelgaas@google.com>, <amirv@mellanox.com>,
	<jackm@dev.mellanox.co.il>, <eugenia@mellanox.com>,
	Guo Chao <yan@linux.vnet.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: mlx4_core probe error after applying Yinghai's patch
References: <20140114062215.GA19345@richard> <52D4ED5D.80105@mellanox.com> <20140114082749.GA21105@richard>
In-Reply-To: <20140114082749.GA21105@richard>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 14/01/2014 10:27, Wei Yang wrote:
> You can find the first three patches here:
> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/  pci/resource
>
> And the last one is here:
> https://lkml.org/lkml/2013/12/19/701
can you be more specific which is  the patch that introduced the 
regression, e.g if you apply them one by one, when things break?
