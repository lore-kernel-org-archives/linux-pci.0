Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20171013062728.GA56763@google.com>
References: <20171012205220.130048-1-briannorris@chromium.org>
 <20171013031523.GB25517@bhelgaas-glaptop.roam.corp.google.com>
 <20171013062728.GA56763@google.com>
From: Brian Norris <briannorris@chromium.org>
Date: Fri, 13 Oct 2017 17:06:48 -0700
Message-ID: <CA+ASDXM2UnoGOkyVy=y3XToTvLZ1djLNaDESkB89mf-mzqGHRg@mail.gmail.com>
Subject: Re: [PATCH 0/3] PCI: rockchip: assert PERST# in S3
To: Bjorn Helgaas <helgaas@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Heiko Stuebner <heiko@sntech.de>, furquan@chromium.org,
 linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
 linux-kernel@vger.kernel.org,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Rajat Jain <rajatja@google.com>, Frank Rowand <frowand.list@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

One piece of information to add:

On Thu, Oct 12, 2017 at 11:27 PM, Brian Norris <briannorris@chromium.org> wrote:
> On Thu, Oct 12, 2017 at 10:15:23PM -0500, Bjorn Helgaas wrote:
> > Is this a hole in those specs?  Is this something that needs to be
> > clarified by the PCI-SIG to improve interoperability?
>
> After re-re-reading the specifications, I'm more convinced that the
> first Wifi vendor got it wrong. I also don't trust them to get many
> things right in general, so this is pretty much par for the course.
>
> The only things I can suggest:
> * "main power" is never defined, as far as I can tell. So "main" and
>   "auxiliary" power don't have much meaning for many M.2 cards, and so
>   I end up reading much of the spec with a grain of salt

This part is where the first vendor seems to disagree. They claim that
because power is not switched off, PERST# can remain asserted or
deasserted -- whichever leads to least power consumption. (i.e., they
don't consider they need to follow the parts that describe "when
removing main power" (e.g., in S3) we must assert PERST#.

> * S3 is never defined in the PCIe Card EM spec, but it's thrown around a
>   few times
> * if possible, the PCIe base spec should mention something about the
>   fundamental reset which is expected with an L2 transition. It's not
>   clear what to do if you don't want to switch off power completely (and
>   so enter L3), but you also don't have "auxiliary" power

Brian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
