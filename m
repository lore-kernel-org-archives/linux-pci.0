Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 25 May 2018 17:20:10 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Aron Griffis <aron@arongriffis.com>
Subject: Re: PCIe unsupported request with Intel 760p
Message-ID: <20180525232009.GV11037@localhost.localdomain>
References: <CAKDfzeD5_AV=YtWqTPr=40vvW4oMFAs4gJs_r42PJWcb815zyQ@mail.gmail.com>
 <20180507123035.GA20097@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180507123035.GA20097@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, willy@infradead.org,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 07, 2018 at 08:30:35AM -0400, Aron Griffis wrote:
> (Reposting to fix line wrapping, and cc'ing linux-pci at Bjorn's request.)
> 
> I'm getting this error continuously with an Intel 760p on 4.16.5 (Fedora 28)
> 
> pcieport 0000:00:1d.0: AER: Uncorrected (Non-Fatal) error received: id=00e8
> pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=00e8(Requester ID)
> pcieport 0000:00:1d.0:   device [8086:a298] error status/mask=00100000/00010000
> pcieport 0000:00:1d.0:    [20] Unsupported Request    (First)
> pcieport 0000:00:1d.0:   TLP Header: 34000000 70000010 00000000 88468846
> pcieport 0000:00:1d.0: broadcast error_detected message
> pcieport 0000:00:1d.0: broadcast mmio_enabled message
> pcieport 0000:00:1d.0: broadcast resume message
> pcieport 0000:00:1d.0: AER: Device recovery successful
> 
> Willy graciously decoded this for me to a "Latency Tolerance Reporting
> Message," and suggested I send email to this list to check whether it's a
> problem with the device or driver.
> 
> lspci and full dmesg follow. Please let me know if something else would be
> helpful.

I have some information back from the development team to share. They
believe this may be a hardware errata and are investigating a firmware
side fix.

In the meantime, they think there may be other ways to work around this,
if these are acceptable. Specifically, disabling any non-operational
link states may make this go away, and adding kernel parameter
"pcie_aspm=off" should achieve that.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
