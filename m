Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF970348C7F;
	Thu,  1 Oct 2026 12:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856554; cv=none; b=C5HsHB1DwYd8UZUMpDzEZvH0HsHRcdSbewWFwxI4YtPwdUtaPzjumw3y7KKEo+v0piKvqfXm+2vH+WzYjmYPWXylTSR1wvKDugLwKxcMSnksKWxEdvUNa5FdqHx3JoEvLEKfoD7klz8tVrbIBvpQ+YcJmRGomYRNmbZ8UWp+tZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856554; c=relaxed/simple;
	bh=bR2spzIh3zet0pPh6uVbRSV0HV+1esMYudDbDMvALRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVr6251vhEr+LTf8Md8b7ptGH5PYaoFlEoZyAF3fLEDAEDPiTdi+NKivMRQjd3C4jTAqrLI1A/YpMn8GH8HRQnU2briDcNhReJq74eyWUQNoF2evZQv5pE44iwY4Zbm/PFXgaQEDlI4vGgb1XbaV79ybUJZzZSqPWgfVVDQAMkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JQb22Aff; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JQb22Aff"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BF61F000FF;
	Thu,  1 Oct 2026 12:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790856545;
	bh=emxSo4AqFL/kIfhEjAFPntFEmGp1tnhrmjTZ125Rwio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JQb22Aff1tABubUE3XviqH/t8H91+biyOsMP3r15m8H24AKPjkrS/6oLadyjUQ3Bm
	 k6XTX8feVEGApmVxP+Pldj6l0TmU66qYAoTWsrE6vjrLQeQwOvyQbOZmGoXCf9Z6QC
	 YOT7vor1ZEb3lOlki392VjVwra5turBbYfXGOxyk=
Date: Thu, 1 Oct 2026 14:06:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Elder <elder@riscstar.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, arnd@arndb.de,
	bhelgaas@google.com, andersson@kernel.org, konradybcio@kernel.org,
	abelvesa@kernel.org, daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com, lorenzo.bianconi@oss.qualcomm.com,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: qcs6490-rb3gen2: add endpoint
 buses
Message-ID: <2026100159-retold-could-3468@gregkh>
References: <20260918152659.413268-1-elder@riscstar.com>
 <20260918152659.413268-4-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918152659.413268-4-elder@riscstar.com>

On Fri, Sep 18, 2026 at 10:26:58AM -0500, Alex Elder wrote:
> The TC9564 SoC incorporates a PCIe switch, which is connected via
> the second PCI segment (0001) on the RB3gen2 platform.  The third
> downstream port of that switch (pcie@3,0) has an embedded PCIe
> endpoint that implements two PCIe functions.
> 
> The SoC implements other peripherals, and they will be accessed via
> PCI endpoint bus.  Define the devicetree nodes representing these
> buses, including the mapping of each BAR's address range to its
> local address space.
> 
> The endpoint's ranges property must be defined, but it will be
> updated dynamically to include all BARs.  As a result of this update,
> the parent address portion of each range will reflect the specific
> address assigned to the BAR.
> 
> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 30 ++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 3bb5fca8e2b13..5b7f5292a8864 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -955,11 +955,41 @@ pcie@3,0 {
>  			bus-range = <0x5 0xff>;
>  
>  			dev@0,0 {
> +				compatible = "pci1179,0220";
>  				reg = <0x50000 0x0 0x0 0x0 0x0>;
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				/* Ranges will be updated dynamically */
> +				ranges = <0x0 0x0 0x0  0x83050000 0x0 0x0  0x0 0x4000>,
> +					 <0x2 0x0 0x0  0x83050000 0x0 0x4000  0x0 0x80000>,
> +					 <0x4 0x0 0x0  0x83050000 0x0 0x84000  0x0 0x200000>;
> +
> +				pci-ep-bus@4 {
> +					compatible = "simple-bus";
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +					/* Map 0x0-0x1fffff to BAR 4 */
> +					ranges = <0x0  0x4 0x0 0x0  0x200000>;
> +				};
>  			};
>  
>  			dev@0,1 {
> +				compatible = "pci1179,0220";
>  				reg = <0x50100 0x0 0x0 0x0 0x0>;
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				/* Ranges will be updated dynamically */
> +				ranges = <0x0 0x0 0x0  0x83050100 0x0 0x0  0x0 0x4000>,
> +					 <0x2 0x0 0x0  0x83050100 0x0 0x4000  0x0 0x80000>,
> +					 <0x4 0x0 0x0  0x83050100 0x0 0x84000  0x0 0x200000>;
> +
> +				pci-ep-bus@4 {
> +					compatible = "simple-bus";
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +					/* Map 0x0-0x1fffff to BAR 4 */
> +					ranges = <0x0  0x4 0x0 0x0  0x200000>;
> +				};
>  			};
>  		};
>  	};
> -- 
> 2.53.0
> 

This doesn't apply to the char-misc-testing branch :(

So I took the first two patches only.

thanks,

greg k-h
