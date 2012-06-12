Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rs130.luxsci.com ([72.32.115.17]:36500 "EHLO rs130.luxsci.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752490Ab2FLVLz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Jun 2012 17:11:55 -0400
Message-ID: <4FD7B085.1020006@firmworks.com>
Date: Tue, 12 Jun 2012 11:11:33 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Stephen Warren <swarren@wwwdotorg.org>
CC: Thierry Reding <thierry.reding@avionic-design.de>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de> <1339427118-32263-8-git-send-email-thierry.reding@avionic-design.de> <4FD66410.7090001@wwwdotorg.org> <20120612062124.GE4040@avionic-0098.adnet.avionic-design.de> <4FD763C5.3090500@wwwdotorg.org> <20120612172041.GA28010@avionic-0098.adnet.avionic-design.de> <4FD7A36B.9090409@wwwdotorg.org>
In-Reply-To: <4FD7A36B.9090409@wwwdotorg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 6/12/2012 10:15 AM, Stephen Warren wrote:
> On 06/12/2012 11:20 AM, Thierry Reding wrote:
> ...
>> I came up with the following alternative:
>>
>> 	pci {
>> 		compatible = "nvidia,tegra20-pcie";
>> 		reg =<0x80003000 0x00000800   /* PADS registers */
>> 		       0x80003800 0x00000200   /* AFI registers */
>> 		       0x80004000 0x00100000   /* configuration space */
>> 		       0x80104000 0x00100000   /* extended configuration space */
>> 		       0x80400000 0x00010000   /* downstream I/O */
>> 		       0x90000000 0x10000000   /* non-prefetchable memory */
>> 		       0xa0000000 0x10000000>; /* prefetchable memory */
>> 		interrupts =<0 98 0x04   /* controller interrupt */
>> 		              0 99 0x04>; /* MSI interrupt */
>> 		status = "disabled";
>>
>> 		ranges =<0x80000000 0x80000000 0x00002000   /* 2 root ports */
>> 			  0x80004000 0x80004000 0x00100000   /* configuration space */
>> 			  0x80104000 0x80104000 0x00100000   /* extended configuration space */
>> 			  0x80400000 0x80400000 0x00010000   /* downstream I/O */
>> 			  0x90000000 0x90000000 0x10000000   /* non-prefetchable memory */
>> 			  0xa0000000 0xa0000000 0x10000000>; /* prefetchable memory */
>>
>> 		#address-cells =<1>;
>> 		#size-cells =<1>;
>>
>> 		port@80000000 {
>> 			reg =<0x80000000 0x00001000>;
>> 			status = "disabled";
>> 		};
>>
>> 		port@80001000 {
>> 			reg =<0x80001000 0x00001000>;
>> 			status = "disabled";
>> 		};
>> 	};
>>
>> The "ranges" property can probably be cleaned up a bit, but the most
>> interesting part is the port@ children, which can simply be enabled in board
>> DTS files by setting the status property to "okay". I find that somewhat more
>> intuitive to the variant with an "enable-ports" property.
>>
>> What do you think of this?
>
> As a general concept, this kind of design seems OK to me.
>
> The "port" child nodes I think should be named "pci@..." given Mitch's
> comments, I think.
>
> The port nodes probably need two entries in reg, given the following in
> our downstream driver:
>
>>          int rp_offset = 0;
>>          int ctrl_offset = AFI_PEX0_CTRL;
> ...
>>          for (port = 0; port<  MAX_PCIE_SUPPORTED_PORTS; port++) {
>>                  ctrl_offset += (port * 8);
>>                  rp_offset = (rp_offset + 0x1000) * port;
>>                  if (tegra_pcie.plat_data->port_status[port])
>>                          tegra_pcie_add_port(port, rp_offset, ctrl_offset);
>>          }
>
> (which actually looks likely to be horribly buggy for port>1 and only
> accidentally correct for port==1, but anyway...)
>
> But instead, I'd be tempted to make the top-level node say:
>
> 	#address-cells =<1>;
> 	#size-cells =<0>;
>
> ... so that the child nodes' reg is just the port ID. The parent node
> can calculate the addresses/offsets of the per-port registers within the
> PCIe controller's register space based on the ID using code roughly like
> what I quoted above:
>
> 	pci@0 {
> 		reg =<0>;
> 		status = "disabled";
> 	};
>
> 	pci@1 {
> 		reg =<0>;
> 		status = "disabled";
> 	};
reg = <1> ?

>
>
> That would save having to put 2 entries in the reg, and perhaps remove
> the need for any ranges property.

ISTM that having two reg entries, specifying the rp and ctrl registers, 
is preferable to having code to calculate the addresses.  That makes the 
code simpler and the device tree more directly descriptive of the 
hardware layout.  The less "magic" (in this case, the register address 
calculation), the better.

>
>
> I think you also need a property to specify the exact port layout; the
> Tegra20 controller supports:
>
> 1 x4 port
> 2 x2 ports (you can choose to use only 1 of these I assume)
>
> So just because only 1 of the ports is enabled, doesn't imply it's x4;
> it could still be x2.
>
> Tegra30 has more options.
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
>
