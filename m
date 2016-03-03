Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from li153-180.members.linode.com ([109.74.206.180]:41965 "EHLO
	mail.tekno-soft.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754611AbcCCJjF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2016 04:39:05 -0500
Subject: Re: iMX6q PCIe phy link never came up on kernel v4.4.x
To: Lucas Stach <l.stach@pengutronix.de>
References: <56D5E3DF.9030906@tekno-soft.it>
 <1456997527.3772.37.camel@pengutronix.de>
Cc: linux-pci@vger.kernel.org
From: Roberto Fichera <kernel@tekno-soft.it>
Message-ID: <56D80625.70903@tekno-soft.it>
Date: Thu, 3 Mar 2016 10:38:45 +0100
MIME-Version: 1.0
In-Reply-To: <1456997527.3772.37.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/03/2016 10:32 AM, Lucas Stach wrote:
> Hi Roberto,

Hi Lucas,

>
> Am Dienstag, den 01.03.2016, 19:47 +0100 schrieb Roberto Fichera:
>> Hi There,
>>
>> Working on a custom iMX6q board I'm getting a PCIe phy link never came up, even if uboot seems detecting
>> everything ok. My DTS is enabling PCIe with
>>
>> &pcie {
>>     pinctrl-names = "default";
>>     pinctrl-0 = <&pinctrl_pcie_reset>;
>>     reset-gpio = <&gpio7 12 0>;
>>     status = "okay";
>> };
>>
>> The PCIe is connected to a PCIe-to-PCI TI XIO2001. The XIO2001 power is controlled by GPIO_9 and 
>> the corresponding fixed regulator is set as
>>
>> 		reg_pcie: regulator@4 {
>> 			compatible = "regulator-fixed";
>> 			reg = <4>;
>> 			pinctrl-names = "default";
>> 			pinctrl-0 = <&pinctrl_pcie_reg>;
>> 			regulator-name = "MPCIE_3V3";
>> 			regulator-min-microvolt = <3300000>;
>> 			regulator-max-microvolt = <3300000>;
>> 			gpio = <&gpio1 9 0>;
>> 			regulator-always-on;
>> 			enable-active-high;
>> 		};
>>
>> so I'd like to know if there is any other special setup to do in order to get it to work on a v4.4.x kernel.
>> Or anyway how to debug it.
>>
>> Any suggestion?
> Is this a regression from earlier kernel versions?

No it isn't. I'm working with a brand new custom PCB so I've started my testing against v4.4.x kernel.

> If so, can you please revert 5c5fb40de8f14 (PCI: imx6: Add support for
> active-low reset GPIO) and see if this helps?

Currently for testing I've changed the reset procedure to follow exactly the one I've in uboot, which seems
working:

U-Boot 2014.04-imx_v2014.04_3.14.38_6qp_beta+g6e9282c (Mar 03 2016 - 10:21:24)

CPU:   Freescale i.MX6Q rev1.5 at 792 MHz
CPU:   Temperature 37 C, calibration data: 0x5664d569
Reset cause: WDOG
Board: Janas iMX6Q (ID:e315c064140749d4)
I2C:   ready
DRAM:  2 GiB
MMC:   FSL_SDHC: 0, FSL_SDHC: 1
DEBUG_R0: 0x03584e11, DEBUG_R1: 0x08000410
  LTSSM current state: 0x11 (S_L0)
  PIPE transmit K indication: 0
  PIPE Transmit data: 0x584e
  Receiver is receiving logical idle: yes
  Second symbol is also idle (16-bit PHY interface only): yes
  Currently receiving k237 (PAD) in place of link number: no
  Currently receiving k237 (PAD) in place of lane number: no
  Link control bits advertised by link partner: 0x0
  Receiver detected lane reversal: no
  TS2 training sequence received: no
  TS1 training sequence received: no
  Receiver reports skip reception: no
  LTSSM reports PHY link up: yes
  A skip ordered set has been transmitted: no
  Link number advertised/confirmed by link partner: 4
  Application request to initiate training reset: no
  PIPE transmit compliance request: no
  PIPE transmit electrical idle request: no
  PIPE receiver detect/loopback request: no
  LTSSM-negotiated link reset: yes
  LTSSM testing for polarity reversal: no
  LTSSM performing link training: no
  LTSSM in DISABLE state; link inoperable: no
  Scrambling disabled for the link: no
  00:01.0     - 16c3:abcd - Bridge device
   01:00.0    - 104c:8240 - Bridge device
    02:04.0   - 1397:08b4 - Network controller
In:    serial
Out:   serial
Err:   serial
Found PFUZE100! deviceid=10,revid=21
mmc1(part 0) is current device
Net:   Phy not found
PHY reset timed out
FEC [PRIME]
Normal Boot
Hit any key to stop autoboot:  0

Cheers,
Roberto Fichera.

>
> Regards,
> Lucas

