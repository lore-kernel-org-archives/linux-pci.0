Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.131]:58428 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753489AbaCNMHk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 14 Mar 2014 08:07:40 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Tanmay Inamdar <tinamdar@apm.com>
Subject: Re: [PATCH v4 2/4] arm64: dts: APM X-Gene PCIe device tree nodes
Date: Fri, 14 Mar 2014 13:07:22 +0100
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Rob Landley <rob@landley.net>,
	Liviu Dudau <liviu.dudau@arm.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@apm.com, jcm@redhat.com
References: <1394085963-27553-1-git-send-email-tinamdar@apm.com> <1394085963-27553-3-git-send-email-tinamdar@apm.com>
In-Reply-To: <1394085963-27553-3-git-send-email-tinamdar@apm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201403141307.23286.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 06 March 2014, Tanmay Inamdar wrote:
> +		pcie0: pcie@1f2b0000 {
> +			status = "disabled";
> +			device_type = "pci";
> +			compatible = "apm,xgene-storm-pcie", "apm,xgene-pcie";
> +			#interrupt-cells = <1>;
> +			#size-cells = <2>;
> +			#address-cells = <3>;
> +			reg = < 0x00 0x1f2b0000 0x0 0x00010000   /* Controller registers */
> +				0xe0 0xd0000000 0x0 0x00200000>; /* PCI config space */
> +			reg-names = "csr", "cfg";
> +			ranges = <0x01000000 0x00 0x00000000 0xe0 0x00000000 0x00 0x00010000   /* io */
> +				  0x02000000 0x00 0x10000000 0xe0 0x10000000 0x00 0x80000000>; /* mem */
> +			dma-ranges = <0x42000000 0x40 0x00000000 0x40 0x00000000 0x40 0x00000000>;
> +			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
> +			interrupt-map = <0x0 0x0 0x0 0x1 &gic 0x0 0xc2 0x1
> +					 0x0 0x0 0x0 0x2 &gic 0x0 0xc3 0x1
> +					 0x0 0x0 0x0 0x3 &gic 0x0 0xc4 0x1
> +					 0x0 0x0 0x0 0x4 &gic 0x0 0xc5 0x1>;
> +			clocks = <&pcie0clk 0>;
> +		};

Is 0x40.0x00000000 the start of your RAM? I had expected RAM to start at 0.0,
and in that case the dma-ranges property would be wrong.

	Arnd
