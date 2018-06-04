Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 4 Jun 2018 17:30:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH][RFC] PCI: rcar: Add bus notifier so we can limit the DMA
 range
Message-ID: <20180604223048.GC30381@bhelgaas-glaptop.roam.corp.google.com>
References: <20180521220514.30256-1-marek.vasut+renesas@gmail.com>
 <CAK8P3a1PZ_MfgEcvWdUbN-eCcs5Xo38LQ54imLc4kNtSKO9Txw@mail.gmail.com>
 <c2897d82-fe33-52cd-5aa6-3bddb478cb9f@gmail.com>
MIME-Version: 1.0
In-Reply-To: <c2897d82-fe33-52cd-5aa6-3bddb478cb9f@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
 Phil Edworthy <phil.edworthy@renesas.com>, Arnd Bergmann <arnd@arndb.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa@the-dreams.de>,
 linux-pci <linux-pci@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Simon Horman <horms+renesas@verge.net.au>,
 linux-arm-kernel@lists.infradead.org,
 Marek Vasut <marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[+cc ARM64 folks, linux-kernel]

The original patch under discussion is:
https://lkml.kernel.org/r/20180521220514.30256-1-marek.vasut+renesas@gmail.com

On Tue, May 22, 2018 at 11:52:21AM +0200, Marek Vasut wrote:
> On 05/22/2018 10:10 AM, Arnd Bergmann wrote:
> > On Tue, May 22, 2018 at 12:05 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> >> From: Phil Edworthy <phil.edworthy@renesas.com>
> >>
> >> The PCIe DMA controller on RCar Gen2 and earlier is on 32bit bus,
> >> so limit the DMA range to 32bit.
> >>
> >> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> >> Cc: Arnd Bergmann <arnd@arndb.de>
> >> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> >> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> >> Cc: Simon Horman <horms+renesas@verge.net.au>
> >> Cc: Wolfram Sang <wsa@the-dreams.de>
> >> Cc: linux-renesas-soc@vger.kernel.org
> >> To: linux-pci@vger.kernel.org
> >> ---
> >> NOTE: I'm aware of https://patchwork.kernel.org/patch/9495895/ , but the
> >>       discussion seems to have gone way off, so I'm sending this as a
> >>       RFC. Any feedback on how to do this limiting properly would be nice.
> > 
> > Doing it in the driver is clearly not appropriate, we must do this in
> > common code. If I remember correctly, it's specifically ARM64 that is
> > broken here, it incorrectly allows setting a DMA mask to 64 bit
> > when that is not available.
> 
> Yep, that's correct. ARM64 with devices mapping tremendous amounts of
> memory. So did anything change since that discussion references in the NOTE?
> 
> -- 
> Best regards,
> Marek Vasut

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
