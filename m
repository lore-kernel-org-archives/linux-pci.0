Return-Path: <SRS0=qyTy=6N=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACB8C83004
	for <linux-pci@archiver.kernel.org>; Wed, 29 Apr 2020 18:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FADF20B1F
	for <linux-pci@archiver.kernel.org>; Wed, 29 Apr 2020 18:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588186544;
	bh=q9AP5/1f5H0lI/5Q1aYWFF9szGbdO+zLdBeKR8D1y5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qUrjeFmVcUi0EZLH0u+rcHtHhqva6KMqZl6Yt47Bf+feM3ThX3N91KCpXAzJTebzg
	 LQ96yQ7RgGX0yZZtgtrIcWjtE5NCVb3PCq2Y9HnwRb26WpuT4uvljuJ6i3c8EuLnOA
	 q56jYapjOCexeo0ThVhheoApF27EkQ5HaAMaeWJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgD2Szn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 29 Apr 2020 14:55:43 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:44627 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgD2Szn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Apr 2020 14:55:43 -0400
Received: by mail-oo1-f65.google.com with SMTP id p67so666476ooa.11;
        Wed, 29 Apr 2020 11:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u16NUB++zzs8ASIrzVSF/fR0H3eWvFCKsVAOeZG9UVg=;
        b=Qtsk3cpCaPfBW1rwZ2GN8FasqARBsgTiv0V/ihpjNJPyfAg9mFzjDHVmw/vAVYb5nm
         u1YO7ASxx84MkQ6kV3aqBCVqlV3KUWFUTJc86NroeVfNOoOHe97WfOg6EIAct7U6qC5V
         lnyBwKkiJBhANfigqYRhjNSYh41Yz/RK2Dz31uWH7dsiHlkO2wmhWDwQnWfLxkQ65AII
         ycFrhNeAWivOfVEkEmyXArUxOUpkQS2i5F5tdT+cx/vQ/gZ6XXNPsmcZpXBhsdpsPd7U
         dtTKLY4s7v+IgpUO6fHL8oWnY/jouYpCstea2LjmxivDYXXKfStq5C1i5+7GkDYNqRPi
         wo7A==
X-Gm-Message-State: AGi0PuZ/jAQHmsHJtrB6L3lj1OKMwbop+o5dTJWJhutXoJIx4ogZ3MMj
        wCS626DifHZzlbrXj7MHxsKF+T8=
X-Google-Smtp-Source: APiQypKZmFn4ieLoQnLl00W9LHE8B+/oqsFhymLM2UBRFIfqezRtXikGpPwDFP7DIfapNQ/TtUH37Q==
X-Received: by 2002:a4a:a98b:: with SMTP id w11mr28658046oom.80.1588186542853;
        Wed, 29 Apr 2020 11:55:42 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t5sm650514oor.36.2020.04.29.11.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 11:55:42 -0700 (PDT)
Received: (nullmailer pid 31714 invoked by uid 1000);
        Wed, 29 Apr 2020 18:55:41 -0000
Date:   Wed, 29 Apr 2020 13:55:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com, rgummal@xilinx.com
Subject: Re: [PATCH v6 1/2] PCI: xilinx-cpm: Add device tree binding for
 Versal CPM Root Port
Message-ID: <20200429185541.atk5k4j7rgh7ipmr@bogus>
References: <1587729844-20798-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1587729844-20798-2-git-send-email-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587729844-20798-2-git-send-email-bharat.kumar.gogada@xilinx.com>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 24, 2020 at 05:34:03PM +0530, Bharat Kumar Gogada wrote:
> Add device tree binding documentation for Versal CPM Root Port driver.
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  .../devicetree/bindings/pci/xilinx-versal-cpm.txt  | 68 ++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/xilinx-versal-cpm.txt

DT bindings need to Cc DT list to be reviewed. Bindings are now in DT 
schema format. See Documentation/devicetree/writing-schema.rst.

Sorry to tell you this on v6, but first I'm seeing it.

> 
> diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.txt b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.txt
> new file mode 100644
> index 0000000..eac6144
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.txt
> @@ -0,0 +1,68 @@
> +* Xilinx Versal CPM DMA Root Port Bridge DT description
> +
> +Required properties:
> +- #address-cells: Address representation for root ports, set to <3>
> +- #size-cells: Size representation for root ports, set to <2>
> +- #interrupt-cells: specifies the number of cells needed to encode an
> +	interrupt source. The value must be 1.
> +- compatible: Should contain "xlnx,versal-cpm-host-1.00"
> +- reg: Should contain configuration space (includes bridge registers) and
> +	CPM system level control and status registers, and length
> +- reg-names: Must include the following entries:
> +	"cfg": configuration space region and bridge registers
> +	"cpm_slcr": CPM system level control and status registers
> +- interrupts: Should contain AXI PCIe interrupt
> +- interrupt-map-mask,
> +  interrupt-map: standard PCI properties to define the mapping of the
> +	PCI interface to interrupt numbers.
> +- bus-range: Range of bus numbers associated with this controller
> +- ranges: ranges for the PCI memory regions (I/O space region is not
> +	supported by hardware)
> +	Please refer to the standard PCI bus binding document for a more
> +	detailed explanation
> +- msi-map: Maps a Requester ID to an MSI controller and associated MSI
> +	sideband data
> +- interrupt-names: Must include the following entries:
> +	"misc": interrupt asserted when legacy or error interrupt is received

Don't really need a name when only 1.

> +
> +Interrupt controller child node
> ++++++++++++++++++++++++++++++++
> +Required properties:
> +- interrupt-controller: identifies the node as an interrupt controller
> +- #address-cells: specifies the number of cells needed to encode an
> +	address. The value must be 0.
> +- #interrupt-cells: specifies the number of cells needed to encode an
> +	interrupt source. The value must be 1.
> +
> +
> +Refer to the following binding document for more detailed description on
> +the use of 'msi-map':
> +	 Documentation/devicetree/bindings/pci/pci-msi.txt
> +
> +Example:
> +	pci@fca10000 {

Unit address is normally the first entry.

> +		#address-cells = <3>;
> +		#interrupt-cells = <1>;
> +		#size-cells = <2>;
> +		compatible = "xlnx,versal-cpm-host-1.00";
> +		interrupt-map = <0 0 0 1 &pcie_intc_0 0>,
> +				<0 0 0 2 &pcie_intc_0 1>,
> +				<0 0 0 3 &pcie_intc_0 2>,
> +				<0 0 0 4 &pcie_intc_0 3>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-parent = <&gic>;
> +		interrupt-names = "misc";
> +		interrupts = <0 72 4>;
> +		bus-range = <0x00 0xff>;
> +		ranges = <0x02000000 0x00000000 0xE0000000 0x0 0xE0000000 0x00000000 0x10000000>,

lowercase hex please.

> +			 <0x43000000 0x00000080 0x00000000 0x00000080 0x00000000 0x00000000 0x80000000>;
> +		msi-map = <0x0 &its_gic 0x0 0x10000>;
> +		reg = <0x6 0x00000000 0x0 0x10000000>,
> +		      <0x0 0xFCA10000 0x0 0x1000>;
> +		reg-names = "cfg", "cpm_slcr";
> +		pcie_intc_0: pci-interrupt-controller {

interrupt-controller {

> +			#address-cells = <0>;
> +			#interrupt-cells = <1>;
> +			interrupt-controller ;
> +		};
> +	};
> -- 
> 2.7.4
> 

