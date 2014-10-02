Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:56913 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122AbaJBOgh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 2 Oct 2014 10:36:37 -0400
Received: by mail-qc0-f173.google.com with SMTP id x13so2240924qcv.32
        for <linux-pci@vger.kernel.org>; Thu, 02 Oct 2014 07:36:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2135522.DVGa59N1mx@wuerfel>
References: <1411765707-28822-1-git-send-email-tinamdar@apm.com>
 <20141001191403.GC22713@google.com> <2135522.DVGa59N1mx@wuerfel>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 2 Oct 2014 08:36:16 -0600
Message-ID: <CAErSpo4i4+0c6Qy9w3tKXex2M7Q=Ry8aG-cbO1_uiC8wtD7puQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/4] APM X-Gene PCIe host controller
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tanmay Inamdar <tinamdar@apm.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Rob Landley <rob@landley.net>,
	Liviu Dudau <liviu.dudau@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	patches <patches@apm.com>, Jon Masters <jcm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 2, 2014 at 6:20 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 01 October 2014 13:14:03 Bjorn Helgaas wrote:
>> On Fri, Sep 26, 2014 at 02:08:23PM -0700, Tanmay Inamdar wrote:
>> > This patch adds support for AppliedMicro X-Gene PCIe host controller. The
>> > driver is tested on X-Gene platform with different gen1/2/3 PCIe endpoint
>> > cards.
>> >
>> > X-Gene PCIe controller driver has depedency on the pcie arm64 arch support.
>> > Liviu Dudau from ARM has sent a patch set for pcie arm64 arch support and
>> > support for creating generic pcie bridge from device tree. Liviu's patches
>> > are available here
>> > https://lkml.org/lkml/2014/9/23/852
>> >
>> > If someone wishes to test PCIe on X-Gene with this patch set, above mentioned
>> > patches from Liviu must be applied before the patches in this patch set. Also
>> > please use latest xgene u-boot firmware.
>>
>> I applied these on pci/host-xgene (based on pci/host-generic).  I hope to
>> merge these for v3.18.  It'd be nice to have a device tree person like Arnd
>> or Rob take a look at the arch/arm64/boot/dts/ bits.
>
> Those changes should normally go through the arm-soc tree, but we
> have not done that so far for arm64 stuff, so I'm not blaming anybody.
>
> The dts changes all look good to me, and I think it's ok to have them
> go through your tree this time.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> In the future, we should all have an eye on this more to ensure that
> the .dts changes all go through arm-soc.

The arch/arm64/boot/dts patch is at the tip of my branch, and I'd be
more than happy to drop it.  It would be nice to have it in v3.18
along with the driver, though, so I'll keep it until somebody chimes
in to put it in arm-soc.

Bjorn
