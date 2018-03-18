Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36900 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751934AbeCRKxj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 18 Mar 2018 06:53:39 -0400
Subject: Re: [PATCH V3] PCI: rcar: Use runtime PM to control controller clock
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org,
        Dien Pham <dien.pham.ry@rvc.renesas.com>,
        Hien Dang <hien.dang.eb@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20171110215411.31912-1-marek.vasut+renesas@gmail.com>
 <20180313112051.GB15480@e107981-ln.cambridge.arm.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <a11864d0-8cad-85fe-cf6a-94476558fa31@gmail.com>
Date: Sun, 18 Mar 2018 11:19:25 +0100
MIME-Version: 1.0
In-Reply-To: <20180313112051.GB15480@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/13/2018 12:20 PM, Lorenzo Pieralisi wrote:
> Hi Marek,

Hi,

> On Fri, Nov 10, 2017 at 10:54:11PM +0100, Marek Vasut wrote:
>> From: Dien Pham <dien.pham.ry@rvc.renesas.com>
>>
>> The controller clock can be switched off during suspend/resume,
>> let runtime PM take care of that.
>>
>> Signed-off-by: Dien Pham <dien.pham.ry@rvc.renesas.com>
>> Signed-off-by: Hien Dang <hien.dang.eb@renesas.com>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Phil Edworthy <phil.edworthy@renesas.com>
>> Cc: Simon Horman <horms+renesas@verge.net.au>
>> Cc: Wolfram Sang <wsa@the-dreams.de>
>> Cc: linux-renesas-soc@vger.kernel.org
>> To: linux-pci@vger.kernel.org
>> ---
>> V2: - Reorder the fail path in rcar_pcie_probe() to cater for the
>>       reordering of function calls in probe
>>     - Dispose of fail_clk in rcar_pcie_get_resources()
>> V3: - Fix up the failpath in probe function
>> ---
>>  drivers/pci/host/pcie-rcar.c | 40 ++++++++++++----------------------------
>>  1 file changed, 12 insertions(+), 28 deletions(-)
> 
> I would like to ask you if this patch is still applicable and if so
> whether you want me to apply it stand-alone (ie does it depend on
> other patches ?), please let me know.
It doesn't depend on other patches, but it needs a small adjustment when
rebasing. I'll repost a V4.

-- 
Best regards,
Marek Vasut
