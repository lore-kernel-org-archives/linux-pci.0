Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10336 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965463Ab3E2KKW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 May 2013 06:10:22 -0400
From: Jay Agarwal <jagarwal@nvidia.com>
To: 'Stephen Warren' <swarren@wwwdotorg.org>,
	"'thierry.reding@avionic-design.de'"
	<thierry.reding@avionic-design.de>
CC: "'linux@arm.linux.org.uk'" <linux@arm.linux.org.uk>,
	"'bhelgaas@google.com'" <bhelgaas@google.com>,
	"'olof@lixom.net'" <olof@lixom.net>,
	"'mturquette@linaro.org'" <mturquette@linaro.org>,
	"'linux-arm-kernel@lists.infradead.org'"
	<linux-arm-kernel@lists.infradead.org>,
	"'linux-tegra@vger.kernel.org'" <linux-tegra@vger.kernel.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>
Date: Wed, 29 May 2013 15:40:17 +0530
Subject: RE: [PATCH 4/4] ARM: tegra: pcie: Enable PCIe controller on Cardhu
Message-ID: <C79B248886DD134989C8FF6B096A91AB91B616BE9B@BGMAIL01.nvidia.com>
References: <1368010660-31465-1-git-send-email-jagarwal@nvidia.com>
 <1368010660-31465-4-git-send-email-jagarwal@nvidia.com>
 <518A8596.7070702@wwwdotorg.org>
 <C79B248886DD134989C8FF6B096A91AB91B4886B5D@BGMAIL01.nvidia.com>
 <C79B248886DD134989C8FF6B096A91AB91B4886B6C@BGMAIL01.nvidia.com>
In-Reply-To: <C79B248886DD134989C8FF6B096A91AB91B4886B6C@BGMAIL01.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> > > So, if I apply this series, I do see the PCIe bridge and Ethernet
> > > device get enumerated, but I don't see the USB3 controller get
> > > enumerated. I believe that is a PCIe device behind the same bridge
> > > on the
> > same Tegra PCIe port.
> > > Shouldn't this device show up?
> > I have also reproduced this problem. I see somehow no non-
> > prefetchable memory is assigned to any of pcie devices.
> > Probably that is the reason for USB3 (pci 0000:04:00.0) not getting
> > enumerated since it uses only non-prefetchable memory.
> 
> 1. Bus4(on which usb3 device resides) always return 0xffffffff from it's
> config space. which means device is not present?
> 2. That's why it is not assigned any resources and hence no usb3 probe
> happens.
> 3. But same bus does return valid info like vendor/device id etc from it's
> config space in downstream kernel and hence usb3 probe does happen.
> 
> Thierry, Stephen,
> 4. Any idea why bus4 should return 0xffffffff values in upstream kernel?
> Anything missing?
> 5. Also, how config space of all pcie devices are mapped? I mean if I change
> the config space offset in dts file, then also I find correct vendor/device id
> etc for bus0/device0/fun0.
>     So how this mapping happens that even after changing the config space
> offset in PCIe address space, it always finds correct vendor/device id.

 Any idea on this?
