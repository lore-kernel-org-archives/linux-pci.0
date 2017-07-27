Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 27 Jul 2017 07:11:57 +0200
From: Borislav Petkov <bp@alien8.de>
To: David Daney <ddaney.cavm@gmail.com>
Subject: Re: [PATCH v8 1/3] perf: cavium: Support memory controller PMU
 counters
Message-ID: <20170727051157.GA4525@nazgul.tnic>
References: <20170726151314.GA10696@hc> <20170726153502.GE28875@nazgul.tnic>
 <20170726154515.GA11453@hc> <20170726155548.GF28875@nazgul.tnic>
 <20170726161949.GB15426@kroah.com>
 <20170726163049.GG28875@nazgul.tnic>
 <20170726173353.GB21705@kroah.com>
 <1a2eedea-040d-c746-eaf0-1d8085b3f2bf@gmail.com>
 <20170726200802.GA17722@kroah.com>
 <b27cda60-8bf8-47a1-15b5-bf8b3a83fc45@gmail.com>
MIME-Version: 1.0
In-Reply-To: <b27cda60-8bf8-47a1-15b5-bf8b3a83fc45@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>,
 Greg KH <gregkh@linuxfoundation.org>, Will Deacon <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jan Glauber <jan.glauber@caviumnetworks.com>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 26, 2017 at 02:02:42PM -0700, David Daney wrote:
> Also, if a given configuration disables CONFIG_EDAC there is some hackery
> needed to get the perf portion of the driver included.

Yes, and we don't do performance counters in EDAC.

So you could add a small memory controller driver which does the
arbitration or fix the firmware.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
