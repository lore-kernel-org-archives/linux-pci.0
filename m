Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2389C31D72E;
	Fri,  2 Oct 2026 06:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790921842; cv=none; b=T8ptfVl76sUyybjNSpYPcdGOxqYkxwJOhWJ/xShAvsI2Q9odj5CA1r3cXVaWBVOgm9qwj3WstZDh0n/thA/KvDvuIrI+l4aI/6uzNc0tA4rvDZog7ug8kDJpgH/7Upp372/CweZ0MSGadW56czkPyvbCVBOFh4LhLPw0T0pJHT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790921842; c=relaxed/simple;
	bh=AeAbliq0jIjbFeMmcYDWqBHXCoF/g9GmMVhpk3xrVxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9Vk8NclHoKqM6UR8m8atJMN4SYzjAJexc1MPCCo1yynQkEFLQlHLbsi0umTZ7bOsYtiobCiOkVGl9X86o7yltm3dndwpOOiBARC1OCpjHh1CgZLBVqp5hefNporaGGWM1N9kNzJvmdBshYKb4+oLyjVf7+VGvOVCy27PyBsWrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dqma6TCI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dqma6TCI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BB21F000FF;
	Fri,  2 Oct 2026 06:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790921813;
	bh=u/9gAXcvZw+wzTRHcyd2C2q/kOrZa5hf8+Yk0jX/Uwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dqma6TCI0pQcbuM/AiwwahnDVha432Qz9O0PwaPS+FrXo6gfbm6mcA6PPhQnST/hF
	 dZAvahul+BTnvNK7LMPRcdd339AQdg7WOWlxSa2I9Tw8AdKM92RJJX80Sqi7kYJPq6
	 tUEx20BLVzKpuzrvTDzLwzedN0ACt1+XfoDP4rpQ=
Date: Fri, 2 Oct 2026 08:16:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Elder <elder@riscstar.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, arnd@arndb.de,
	bhelgaas@google.com, abelvesa@kernel.org, daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com, lorenzo.bianconi@oss.qualcomm.com,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: qcs6490-rb3gen2: add endpoint
 buses
Message-ID: <2026100234-chaos-density-47c4@gregkh>
References: <20260918152659.413268-1-elder@riscstar.com>
 <20260918152659.413268-4-elder@riscstar.com>
 <2026100159-retold-could-3468@gregkh>
 <9c426950-b3f3-42fd-b31d-f14085a7d2d1@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c426950-b3f3-42fd-b31d-f14085a7d2d1@riscstar.com>

On Thu, Oct 01, 2026 at 02:19:14PM -0500, Alex Elder wrote:
> On 10/1/26 7:06 AM, Greg KH wrote:
> > On Fri, Sep 18, 2026 at 10:26:58AM -0500, Alex Elder wrote:
> > > The TC9564 SoC incorporates a PCIe switch, which is connected via
> > > the second PCI segment (0001) on the RB3gen2 platform.  The third
> > > downstream port of that switch (pcie@3,0) has an embedded PCIe
> > > endpoint that implements two PCIe functions.
> > > 
> > > The SoC implements other peripherals, and they will be accessed via
> > > PCI endpoint bus.  Define the devicetree nodes representing these
> > > buses, including the mapping of each BAR's address range to its
> > > local address space.
> > > 
> > > The endpoint's ranges property must be defined, but it will be
> > > updated dynamically to include all BARs.  As a result of this update,
> > > the parent address portion of each range will reflect the specific
> > > address assigned to the BAR.
> > > 
> > > Co-developed-by: Daniel Thompson <daniel@riscstar.com>
> > > Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> > > Signed-off-by: Alex Elder <elder@riscstar.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 30 ++++++++++++++++++++
> > >   1 file changed, 30 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > index 3bb5fca8e2b13..5b7f5292a8864 100644
> > > --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > @@ -955,11 +955,41 @@ pcie@3,0 {
> > >   			bus-range = <0x5 0xff>;
> > >   			dev@0,0 {
> > > +				compatible = "pci1179,0220";
> > >   				reg = <0x50000 0x0 0x0 0x0 0x0>;
> > > +				#address-cells = <3>;
> > > +				#size-cells = <2>;
> > > +				/* Ranges will be updated dynamically */
> > > +				ranges = <0x0 0x0 0x0  0x83050000 0x0 0x0  0x0 0x4000>,
> > > +					 <0x2 0x0 0x0  0x83050000 0x0 0x4000  0x0 0x80000>,
> > > +					 <0x4 0x0 0x0  0x83050000 0x0 0x84000  0x0 0x200000>;
> > > +
> > > +				pci-ep-bus@4 {
> > > +					compatible = "simple-bus";
> > > +					#address-cells = <1>;
> > > +					#size-cells = <1>;
> > > +					/* Map 0x0-0x1fffff to BAR 4 */
> > > +					ranges = <0x0  0x4 0x0 0x0  0x200000>;
> > > +				};
> > >   			};
> > >   			dev@0,1 {
> > > +				compatible = "pci1179,0220";
> > >   				reg = <0x50100 0x0 0x0 0x0 0x0>;
> > > +				#address-cells = <3>;
> > > +				#size-cells = <2>;
> > > +				/* Ranges will be updated dynamically */
> > > +				ranges = <0x0 0x0 0x0  0x83050100 0x0 0x0  0x0 0x4000>,
> > > +					 <0x2 0x0 0x0  0x83050100 0x0 0x4000  0x0 0x80000>,
> > > +					 <0x4 0x0 0x0  0x83050100 0x0 0x84000  0x0 0x200000>;
> > > +
> > > +				pci-ep-bus@4 {
> > > +					compatible = "simple-bus";
> > > +					#address-cells = <1>;
> > > +					#size-cells = <1>;
> > > +					/* Map 0x0-0x1fffff to BAR 4 */
> > > +					ranges = <0x0  0x4 0x0 0x0  0x200000>;
> > > +				};
> > >   			};
> > >   		};
> > >   	};
> > > -- 
> > > 2.53.0
> > > 
> > 
> > This doesn't apply to the char-misc-testing branch :(
> 
> Sorry about that.  It does apply to to the for-next branch for
> Qualcomm, so this should probably get merged through that path.
> 
> https://lore.kernel.org/lkml/20260918152659.413268-1-elder@riscstar.com/

I suggest sending it to whoever maintains that tree.
