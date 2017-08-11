Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 11 Aug 2017 10:56:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] PCI: Convert to using %pOF instead of full_name
Message-ID: <20170811155658.GA17039@bhelgaas-glaptop.roam.corp.google.com>
References: <20170718214339.7774-41-robh@kernel.org>
 <20170802223928.GQ20308@bhelgaas-glaptop.roam.corp.google.com>
 <CAL_JsqLznQdnWw+A2T8V8CTktYaPDF_800jGHAVa=G-Yhxyn+Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLznQdnWw+A2T8V8CTktYaPDF_800jGHAVa=G-Yhxyn+Q@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Jason Cooper <jason@lakedaemon.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Tyrel]

On Wed, Aug 09, 2017 at 05:04:43PM -0500, Rob Herring wrote:
> On Wed, Aug 2, 2017 at 5:39 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Jul 18, 2017 at 04:43:21PM -0500, Rob Herring wrote:
> >> Now that we have a custom printf format specifier, convert users of
> >> full_name to use %pOF instead. This is preparation to remove storing
> >> of the full path string for each node.
> >>
> >> Signed-off-by: Rob Herring <robh@kernel.org>
> >> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> >> Cc: Jason Cooper <jason@lakedaemon.net>
> >> Cc: Bjorn Helgaas <bhelgaas@google.com>
> >> Cc: Thierry Reding <thierry.reding@gmail.com>
> >> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> >> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >> Cc: Paul Mackerras <paulus@samba.org>
> >> Cc: Michael Ellerman <mpe@ellerman.id.au>
> >> Cc: linux-pci@vger.kernel.org
> >> Cc: linux-arm-kernel@lists.infradead.org
> >> Cc: linux-tegra@vger.kernel.org
> >> Cc: linuxppc-dev@lists.ozlabs.org
> >
> > Applied to pci/misc for v4.14, thanks!
> 
> This hasn't shown up in -next.

Thanks, it should be in next-20170811.

I updated it to add Tyrel's reviewed-by, but that's not in -next yet.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
