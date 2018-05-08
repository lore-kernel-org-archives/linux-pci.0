Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 8 May 2018 11:58:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: okaya@codeaurora.org
Subject: Re: AER: Malformed TLP recovery deadlock with NVMe drives
Message-ID: <20180508165849.GC9529@bhelgaas-glaptop.roam.corp.google.com>
References: <8cf4e563-5f84-f8bd-88a6-8369cdf07b29@gmail.com>
 <7afd280ad80a73b39e6c9b9a9e29abcc@codeaurora.org>
 <5c97a7c2-cb53-4740-fda0-50ba92288c5c@gmail.com>
 <9fc90040d5712282ea223807ace39312@codeaurora.org>
 <1125ddf8-f342-3f8f-90ee-0aa94287360c@gmail.com>
 <16bdb0febb842ad0980db9214c8076c5@codeaurora.org>
 <3d4991bc2948430d910a16da36c90b91@ausx13mps321.AMER.DELL.COM>
 <1fdfaaa47ad782ee864f24c5a75a355a@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1fdfaaa47ad782ee864f24c5a75a355a@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Alex_Gagniuc@dellteam.com, linux-pci@vger.kernel.org,
 linux-nvme@lists.infradead.org, Shyam.Iyer@dell.com, mr.nuke.me@gmail.com,
 Austin.Bolen@dell.com, keith.busch@intel.com, linux-pci-owner@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 08, 2018 at 01:21:38AM +0100, okaya@codeaurora.org wrote:
> On 2018-05-08 00:57, Alex_Gagniuc@Dellteam.com wrote:
> > On 5/7/2018 5:46 PM, okaya@codeaurora.org wrote:
> > [snip]
> > > > If it were easy, somebody would have patched it by now ;)
> > > 
> > > Can you file a bugzilla CC me, keith and bjorn and attach all of your
> > > logs?
> > 
> > Sure. Which bugzilla?
> > 
> 
> https://bugzilla.kernel.org
> 
> Drivers -> pci

https://bugzilla.kernel.org/show_bug.cgi?id=199657

Thanks for the bugzilla.  Can you add the "lspci -vv" output (the
"lspci -tvnn" output doesn't have the details about individual
devices) and also the specifics about how you inject the error (I
assume you're using setpci to update MPS, but it would help others
reproduce it to see the exact command and the lspci output so they can
adjust to their local topology).

I don't know how you collected the dmesg logs, but they have a bunch
of gunk in them (looks like maybe colorizing escape sequences?).  I
always think it's nice to have the plain ASCII complete log from
beginning of boot, e.g., from "dmesg" command or similar.  But I
probably won't have time to look at them myself, and maybe what's
there is enough.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
