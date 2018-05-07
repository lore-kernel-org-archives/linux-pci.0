Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 7 May 2018 10:08:53 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Aron Griffis <aron@arongriffis.com>
Subject: Re: PCIe unsupported request with Intel 760p
Message-ID: <20180507160853.GF20686@localhost.localdomain>
References: <CAKDfzeD5_AV=YtWqTPr=40vvW4oMFAs4gJs_r42PJWcb815zyQ@mail.gmail.com>
 <20180507123035.GA20097@gmail.com>
 <20180507134354.GF18116@bombadil.infradead.org>
 <20180507151246.GB20686@localhost.localdomain>
 <20180507155759.GA13397@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180507155759.GA13397@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 07, 2018 at 11:57:59AM -0400, Aron Griffis wrote:
> Keith Busch wrote:  [Mon May 07 2018, 11:12:47AM EDT]
> > Aron,
> > Could you let me know the firmware revision you're currently running?
> 
> Hi Keith, is this what you need?
> 
> $ sudo nvme list
> Node             SN                   Model                                    Namespace Usage                      Format           FW Rev
> ---------------- -------------------- ---------------------------------------- --------- -------------------------- ---------------- --------
> /dev/nvme0n1     BTHH807007N4512D     INTEL SSDPEKKW512G8                      1         512.11  GB / 512.11  GB    512   B +  0 B   001C

Thank you, that's what I needed. That appears to be the latest released
firmware for this device. I'll let you know as soon as I find more
information.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
