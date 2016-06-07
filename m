Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 6 Jun 2016 19:28:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] pci: introduce read_bridge/write_bridge pci ops
Message-ID: <20160607002822.GA1391@localhost>
References: <1464784332-3775650-1-git-send-email-arnd@arndb.de>
 <4967020.J4dsRYGugq@wuerfel> <20160602140001.GB8262@localhost>
 <3585926.N1C2xx3GaB@wuerfel>
MIME-Version: 1.0
In-Reply-To: <3585926.N1C2xx3GaB@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Pratyush Anand <pratyush.anand@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
 linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
 Wenrui Li <wenrui.li@rock-chips.com>, Doug Anderson <dianders@chromium.org>,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Alex Williamson <alex.williamson@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 02, 2016 at 05:06:55PM +0200, Arnd Bergmann wrote:
> On Thursday, June 2, 2016 9:00:01 AM CEST Bjorn Helgaas wrote:
> > > I just did a count of the implementations of pci_ops: I found 107
> > > instances of 'struct pci_ops', and 67 of them treat type0 and type1
> > > access differently in some form.
> > > 
> > > I'd estimate that about half of them, or roughly a third of the total
> > > instances would benefit from my change, if we were to do them again.
> > > Clearly there is no need to change the existing code here when it works,
> > > unless the benefit is very clear and the code is actively maintained.
> > > 
> > > In some cases, the difference is only that the root bus has a limited
> > > set of devices that are allowed to be accessed, so there would
> > > likely be no benefit of this, compared to e.g. yet another callback
> > > that checks the validity.
> > > Some other instances have type0 registers at a different memory location
> > > from type1, some use different layout inside of that space, and some
> > > are completely different.
> > 
> > The type0/type1 distinction still seems out of place to me at the call
> > site.  Is there any other reason a caller would care about the
> > difference between type0 and type1?
> 
> The callers really shouldn't care, but they also shouldn't call the
> pci_ops function pointer (and as we found earlier, there are only
> three such callers).
> 
> The distinction between type0 and type1 in my mind is an implementation
> detail of the pci_{read,write}_config_{byte,word,dword} functions
> that call the low-level operations here.

The caller is performing one abstract operation: reading or writing
config space of a PCI device.  In the caller's context, it makes no
difference whether it's a type0 or type1 access.

Moving the test from the host bridge driver to pci_read_config_byte()
does move a little code from the callee to the caller, and there are
more callees than callers, so in that sense it does remove code
overall.  If you consider a single driver by itself, I'm not sure it
makes much difference.

The pcie-designware.c patch is a net removal of 17 lines, but that's
not all from moving the type0/type1 test: restructuring along the same
lines but keeping the original type0/type1 test removes about 9 lines.

Anyway, I think I'd rather work first on your RFC patches to make
pci_host_bridge the primary structure for probing PCI.  I think
there will be a *lot* of benefit there.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
