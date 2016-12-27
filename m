Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932461AbcL0QoN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Dec 2016 11:44:13 -0500
MIME-Version: 1.0
In-Reply-To: <20161227163200.6noed454fmtgozrv@kozik-lap>
References: <20161226052029.10552-1-jh80.chung@samsung.com>
 <CGME20161226052031epcas1p43a300fe9e59c2af410c48861cd8554d1@epcas1p4.samsung.com>
 <20161226052029.10552-7-jh80.chung@samsung.com> <20161227163200.6noed454fmtgozrv@kozik-lap>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 27 Dec 2016 18:33:28 +0200
Message-ID: <CAJKOXPcx-epK2=ug_ZtOGx5w755CN1xe7A+SgyS+rVFxG5ggcg@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] ARM64: exynos: add the pcie node for TM2
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        kgene@kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        kishon@ti.com, will.deacon@arm.com, catalin.marinas@arm.com,
        cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 27, 2016 at 6:32 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Mon, Dec 26, 2016 at 02:20:29PM +0900, Jaehoon Chung wrote:
>> Add the Exxynos5433 pcie node for TM2.
>> This pcie device is used for supporting WiFi.
>>
>> And some gpios are already requested from pinctrl. so it doesn't need to
>> initialize.
>> GPJ2-0 is used for supplying to WiFi PCIe chip.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---


Ahhh, and one more comment - please add missing 'dts' prefix in the subject.

BR,
Krzysztof
