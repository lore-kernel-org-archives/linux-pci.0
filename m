Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 18 May 2018 10:28:04 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH V6 11/11] nvme: pci: support nested EH
Message-ID: <20180518162804.GA27795@localhost.localdomain>
References: <20180516040313.13596-1-ming.lei@redhat.com>
 <20180516040313.13596-12-ming.lei@redhat.com>
 <20180516141242.GA20119@localhost.localdomain>
 <20180516231058.GB28727@ming.t460p>
 <20180517022030.GB21959@localhost.localdomain>
 <20180517084129.GA26570@lst.de>
 <20180517142051.GB22063@localhost.localdomain>
 <20180517142345.t6bnyfne7ndgrxkg@linux-x5ow.site>
MIME-Version: 1.0
In-Reply-To: <20180517142345.t6bnyfne7ndgrxkg@linux-x5ow.site>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Laurence Oberman <loberman@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-pci@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Ming Lei <ming.lei@redhat.com>, Keith Busch <keith.busch@intel.com>,
 Jianchao Wang <jianchao.w.wang@oracle.com>, bhelgaas@google.com,
 arjan@linux.intel.com, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 17, 2018 at 04:23:45PM +0200, Johannes Thumshirn wrote:
> > Agreed. Alternatively possibly call the driver's reset_preparei/done
> > callbacks.
> 
> Exactly, but as long as we can issue the reset via sysfs the test-case
> is still valid.

I disagree the test case is valid. The test writes '0' to the
pci-sysfs 'enable', but the driver also disables the pci device as part
of resetting, which is a perfectly reasonable thing for a driver to do.

If the timing of the test's loop happens to write '0' right after the
driver disabled the device that it owns, a 'write error' on that sysfs
write occurs, and blktests then incorrectly claims the test failed.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
