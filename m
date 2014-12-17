Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:58149 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbaLQGVg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 17 Dec 2014 01:21:36 -0500
Received: by mail-ie0-f179.google.com with SMTP id rp18so13883018iec.24
        for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2014 22:21:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54911F32.1070909@huawei.com>
References: <CAGZFCEG-J=Qore8nWvWLe6m-bm59Mx+M=HdcaOBVNODm9beokQ@mail.gmail.com>
	<5490D5CB.5010200@huawei.com>
	<CAGZFCEFOiY+VmTVKOnPwDaKUKogUX9gkXtHuMATL3btw4kz2JQ@mail.gmail.com>
	<549119A9.4010406@huawei.com>
	<CAGZFCEGF2Do4Kus+T_yg6-A1wNSXKr-RBm3eSC6Wuw02OMWTOQ@mail.gmail.com>
	<54911F32.1070909@huawei.com>
Date: Wed, 17 Dec 2014 11:51:35 +0530
Message-ID: <CAGZFCEEFrLBbewsKmYVQGpnumeEY0Q7ZexrU+jydfyobuM7HTQ@mail.gmail.com>
Subject: Re: sysfs-pci remove
From: ratheesh kannoth <ratheesh.ksz@gmail.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 17, 2014 at 11:44 AM, Yijing Wang <wangyijing@huawei.com> wrote:
> Unbind won't release PCI device bar resource, resources in /proc/iomem is the
> physical address resource(added by request_resource()), if you iounmap the bar resource,
> it won't change anything in /proc/iomem.

who is calling request_resource() ...is it enic driver ?

Thanks,
Ratheesh
