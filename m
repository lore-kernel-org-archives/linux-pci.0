Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:57593 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752355AbdLEDUl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Dec 2017 22:20:41 -0500
To: Romain Perier <romain.perier@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Aviad Krawczyk <aviad.krawczyk@huawei.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v15 4/5] scsi: mpt3sas: Replace PCI pool old API
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20171120193247.8187-1-romain.perier@gmail.com>
        <20171120193247.8187-5-romain.perier@gmail.com>
Date: Mon, 04 Dec 2017 22:20:17 -0500
In-Reply-To: <20171120193247.8187-5-romain.perier@gmail.com> (Romain Perier's
        message of "Mon, 20 Nov 2017 20:32:46 +0100")
Message-ID: <yq1y3mh509a.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Romain,

> The PCI pool API is deprecated. This commit replaces the PCI pool old
> API by the appropriate function with the DMA pool API.

Applied to 4.16/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
