Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:51102 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbaLQGI2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 17 Dec 2014 01:08:28 -0500
Received: by mail-ig0-f179.google.com with SMTP id r2so8392858igi.6
        for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2014 22:08:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <549119A9.4010406@huawei.com>
References: <CAGZFCEG-J=Qore8nWvWLe6m-bm59Mx+M=HdcaOBVNODm9beokQ@mail.gmail.com>
	<5490D5CB.5010200@huawei.com>
	<CAGZFCEFOiY+VmTVKOnPwDaKUKogUX9gkXtHuMATL3btw4kz2JQ@mail.gmail.com>
	<549119A9.4010406@huawei.com>
Date: Wed, 17 Dec 2014 11:38:27 +0530
Message-ID: <CAGZFCEGF2Do4Kus+T_yg6-A1wNSXKr-RBm3eSC6Wuw02OMWTOQ@mail.gmail.com>
Subject: Re: sysfs-pci remove
From: ratheesh kannoth <ratheesh.ksz@gmail.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 17, 2014 at 11:20 AM, Yijing Wang <wangyijing@huawei.com> wrote:
> If the device 06:0.0 was removed by "echo 1 > /sys/.../0000:6:0.0/remove",
> you could not see lspci info for this device anymore.
> Do you really remove the device ?

Oh , my bad. I did not remove the device. I did an unbind

 echo -n "0000:06:00.0" > /sys/bus/pci/drivers/enic/unbind0

Unbind wont remove it from /proc/iomem ? I thought enic pci driver is
the one is calling ioremap on those memory ?

Thanks,
Ratheesh
