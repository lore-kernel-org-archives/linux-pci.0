Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125]:41610 "EHLO
	eu1sys200aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752479AbaA3IJs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jan 2014 03:09:48 -0500
Message-ID: <52EA089E.4010802@mellanox.com>
Date: Thu, 30 Jan 2014 10:09:02 +0200
From: Or Gerlitz <ogerlitz@mellanox.com>
MIME-Version: 1.0
To: Jack Morgenstein <jackm@dev.mellanox.co.il>
CC: Wei Yang <weiyang@linux.vnet.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	<yinghai@kernel.org>, <bhelgaas@google.com>, <amirv@mellanox.com>,
	Guo Chao <yan@linux.vnet.ibm.com>, <linux-pci@vger.kernel.org>
Subject: Re: mlx4_core probe error after applying Yinghai's patch
References: <20140114103712.GD27684@richard> <20140114132340.50df7d6f@jpm-OptiPlex-GX620> <52d52032.4981e00a.3dcc.ffff81fdSMTPIN_ADDED_BROKEN@mx.google.com> <20140115094113.64ca756e@jpm-OptiPlex-GX620> <1389772791.6933.84.camel@pasglop> <52d653d3.8425e00a.76d0.1e60SMTPIN_ADDED_BROKEN@mx.google.com> <20140115160204.24a44af0@jpm-OptiPlex-GX620> <20140116020946.GA8702@richard> <20140116021429.GB8702@richard> <52E8C0D6.3030105@mellanox.com> <20140130070850.GA24083@richard>
In-Reply-To: <20140130070850.GA24083@richard>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 30/01/2014 09:08, Wei Yang wrote:
> Or,
>
> Even this patch really could make the machine boot up, we didn't find the root
> cause of the failure as mentioned in the first mail. I will find some time to
> dig into it if I have more time and will send you update if I find it.
>
> For this patch, we(Gavin and I) don't think it is a formal patch. We send it
> here just let you know we find a work around and this one really helps. As I
> mentioned in the previous mail, we suggest you guys to create a formal patch
> with this function, since you are more familiar with this device and the
> driver.
>
> If you think it would be nice for a patch from us, I am very glad to do this.:-)
Jack?
