Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 2/6] ipr: use pci_irq_allocate_vectors
To: Christoph Hellwig <hch@lst.de>, hans.verkuil@cisco.com,
        brking@us.ibm.com, haver@linux.vnet.ibm.com,
        ching2048@areca.com.tw, axboe@fb.com, alex.williamson@redhat.com
References: <1473600688-24043-1-git-send-email-hch@lst.de>
 <1473600688-24043-3-git-send-email-hch@lst.de>
Cc: kvm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, linux-media@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
From: Brian King <brking@linux.vnet.ibm.com>
Date: Thu, 29 Sep 2016 09:01:44 -0500
MIME-Version: 1.0
In-Reply-To: <1473600688-24043-3-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
Message-Id: <200e5b3f-8555-9cd3-7940-0ec0f2867b95@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks Christoph. Very nice. As I was reviewing the patch, I noticed
the additional PCI_IRQ_AFFINITY flag, which is currently not being set
in this patch. Is the intention to set that globally by default, or
should I follow up with a one liner to add that to the ipr driver
in the next patch set I send out?

Acked-by: Brian King <brking@linux.vnet.ibm.com>

Thanks,

Brian


-- 
Brian King
Power Linux I/O
IBM Linux Technology Center
