Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: hans.verkuil@cisco.com, brking@us.ibm.com,
        haver@linux.vnet.ibm.com, ching2048@areca.com.tw, axboe@fb.com,
        alex.williamson@redhat.com, kvm@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] genwqe: use pci_irq_allocate_vectors
References: <1473600688-24043-1-git-send-email-hch@lst.de>
        <1473600688-24043-6-git-send-email-hch@lst.de>
Date: Thu, 29 Sep 2016 15:28:02 -0300
In-Reply-To: <1473600688-24043-6-git-send-email-hch@lst.de> (Christoph
        Hellwig's message of "Sun, 11 Sep 2016 15:31:27 +0200")
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87twcyk1cd.fsf@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> Simply the interrupt setup by using the new PCI layer helpers.

Good clean up.  Tested and:

Acked-by: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>

> One odd thing about this driver is that it looks like it could request
> multiple MSI vectors, but it will then only ever use a single one.

I'll take a look at this.

-- 
Gabriel Krisman Bertazi
