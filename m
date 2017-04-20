Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 4/4] nvme/pci: switch to pci_request_irq
To: Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>
References: <20170413070643.32165-1-hch@lst.de>
 <20170413070643.32165-5-hch@lst.de>
 <20170413200255.GB22775@localhost.localdomain>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e288a5fd-a30f-2b11-1051-e39feca3a652@grimberg.me>
Date: Thu, 20 Apr 2017 19:19:25 +0300
MIME-Version: 1.0
In-Reply-To: <20170413200255.GB22775@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> This is great. As an added bonus, more of struct nvme_queue's hot values
> are in the same cache line!
>
> Reviewed-by: Keith Busch <keith.busch@intel.com>

I think I can kill off for mlx5 as well.

Very useful Christoph!

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
