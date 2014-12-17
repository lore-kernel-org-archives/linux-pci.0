Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:61881 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbaLQBBM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Dec 2014 20:01:12 -0500
Message-ID: <5490D5CB.5010200@huawei.com>
Date: Wed, 17 Dec 2014 09:00:59 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: ratheesh kannoth <ratheesh.ksz@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: sysfs-pci remove
References: <CAGZFCEG-J=Qore8nWvWLe6m-bm59Mx+M=HdcaOBVNODm9beokQ@mail.gmail.com>
In-Reply-To: <CAGZFCEG-J=Qore8nWvWLe6m-bm59Mx+M=HdcaOBVNODm9beokQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014/12/17 1:51, ratheesh kannoth wrote:
> Hi list,
> 
> https://www.kernel.org/doc/Documentation/filesystems/sysfs-pci.txt
> talks about "remove" entry.
> The 'remove' file is used to remove the PCI device, by writing a non-zero
> integer to the file.  if i remove the device , will the bar resource
> map still appear on /proc/iomem ?

Of course not.

> 
> 
> -Ratheesh
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


-- 
Thanks!
Yijing

