Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from zimbra1.kalray.eu ([92.103.151.219]:43129 "EHLO
        zimbra1.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751514AbeAEPhL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Jan 2018 10:37:11 -0500
Date: Fri, 5 Jan 2018 16:30:26 +0100 (CET)
From: Marta Rybczynska <mrybczyn@kalray.eu>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <281272464.115248600.1515166226009.JavaMail.zimbra@kalray.eu>
In-Reply-To: <20180104190137.7654-10-logang@deltatee.com>
References: <20180104190137.7654-1-logang@deltatee.com> <20180104190137.7654-10-logang@deltatee.com>
Subject: Re: [PATCH 09/12] nvme-pci: Use PCI p2pmem subsystem to manage the
 CMB
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> @@ -429,10 +429,7 @@ static void __nvme_submit_cmd(struct nvme_queue *nvmeq,
> {
> 	u16 tail = nvmeq->sq_tail;
> 
> -	if (nvmeq->sq_cmds_io)
> -		memcpy_toio(&nvmeq->sq_cmds_io[tail], cmd, sizeof(*cmd));
> -	else
> -		memcpy(&nvmeq->sq_cmds[tail], cmd, sizeof(*cmd));
> +	memcpy(&nvmeq->sq_cmds[tail], cmd, sizeof(*cmd));
> 

Why is it always memcpy() and not memcpy_toio()? I'd expect something like
if (nvmeq->sq_cmds_is_io)
	memcpy_toio(&nvmeq->sq_cmds_io[tail], cmd, sizeof(*cmd));
else
	memcpy(&nvmeq->sq_cmds[tail], cmd, sizeof(*cmd));

Marta
