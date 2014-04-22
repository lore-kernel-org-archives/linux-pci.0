Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:44392 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754465AbaDVBC0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 Apr 2014 21:02:26 -0400
Received: by mail-pd0-f171.google.com with SMTP id r10so4233915pdi.16
        for <linux-pci@vger.kernel.org>; Mon, 21 Apr 2014 18:02:25 -0700 (PDT)
Message-ID: <5355BF9C.5020107@kernel.dk>
Date: Mon, 21 Apr 2014 19:02:20 -0600
From: Jens Axboe <axboe@kernel.dk>
MIME-Version: 1.0
To: Alexander Gordeev <agordeev@redhat.com>,
	linux-kernel@vger.kernel.org
CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Mike Miller <mike.miller@hp.com>, iss_storagedev@hp.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RESEND 0/2] : block: Use pci_enable_msix_exact()
References: <cover.1398093399.git.agordeev@redhat.com>
In-Reply-To: <cover.1398093399.git.agordeev@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014-04-21 09:19, Alexander Gordeev wrote:
> Hi Jens,
>
> The series is against v3.15-rc1. The patches complete converison
> of block layer device drivers to the new MSI initialization API.

Thanks, applied for 3.16.

-- 
Jens Axboe

