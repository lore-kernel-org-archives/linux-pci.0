Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RFC PATCH v0.001] PCI: Add support for tango PCIe controller
To: Mason <slash.tmp@free.fr>, Robin Murphy <robin.murphy@arm.com>
References: <ab110ce2-8678-9b34-6bd1-6cfaaa7fea04@free.fr>
 <f13c385d-dcc9-dacd-2b2c-ca098228f4f4@free.fr>
 <9d23357c-fa59-d638-11ba-f1ab24dbeb43@arm.com>
 <89fab12d-82b1-512f-df48-666861eab22f@free.fr>
From: Thibaud Cornic <thibaud_cornic@sigmadesigns.com>
Message-ID: <3b91a0e8-c913-06bd-fa3f-6ba1acdd731c@sigmadesigns.com>
Date: Tue, 21 Mar 2017 13:53:41 +0100
MIME-Version: 1.0
In-Reply-To: <89fab12d-82b1-512f-df48-666861eab22f@free.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 linux-pci <linux-pci@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Liviu Dudau <liviu.dudau@arm.com>, iommu <iommu@lists.linux-foundation.org>,
 David Laight <david.laight@aculab.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 21/03/2017 13:43, Mason wrote:
> On 21/03/2017 12:36, Robin Murphy wrote:
>
>> On 21/03/17 10:15, Mason wrote:
>>
>>> I suppose one may consider the above limitation ("Only transfers
>>> within the BAR are forwarded to the host") as some form of weird
>>> IOMMU? (There is, in fact, some remapping logic in the controller
>>> setup which I haven't discussed so far.)
>> Not really. If it's the 8x128MB region thing mentioned elsewhere, that's
>> far too coarse a granularity to be much use with the existing IOMMU API
>> (this vaguely reminds me of a similar discussion about programmable
>> interconnects ages ago). Unless it's actually got some sort of GART-type
>> thing or better capable of page-granularity mappings within a
>> significantly-sized region, I'd put that idea to bed.
> I had a feeling my use-case was too quirky for a sane API :-)
>
>>> Since this SoC is used for TV, the media cartels mandate some way
>>> to limit where PCI bus masters can peek/poke in RAM.
>> FWIW, since that sounds like more of a box-ticking exercise than a real
>> practical concern, I'd point out that content protection is more or less
>> the poster child for TrustZone, and your TZASC should help tick that box
>> regardless.
> Interesting. In fact, our Linux runs as the non-secure OS,
> and we do have a custom "secure" OS running in parallel.
>
> My knowledge of TZ is limited to "call this SMC to offline
> that CPU", but our local TZ expert is CCed :-)
>
> TZASC = TrustZone Address Space Controller
>
> http://infocenter.arm.com/help/topic/com.arm.doc.ddi0431c/CHDBBGIC.html
>
> Is there a TZASC embedded in every ARM core?
> We're using Cortex-A9 MPCore r3p0 + PL310 r3p2
We don't have the TZASC, but a proprietary solution, on which the PCIe
can't be distinguished from other I/Os (e.g. SATA, USB).
But the requirement of limiting device accesses to only certain regions
of the DRAM is only for PCIe (it's special in the sense the device can
initiate accesses without any action on our chip's side).
Since we already had those 8x128MB remaps (which we now understand seem
wrong, as the root complex is not supposed to expose a BAR, but rather
forward all accesses to the internal bus), we simply put a lock on them,
and our partners were satisfied.

Regards.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
