Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:45742 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754397Ab2IGQcx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 7 Sep 2012 12:32:53 -0400
Message-ID: <504A21B2.3030507@gmail.com>
Date: Fri, 07 Sep 2012 11:32:50 -0500
From: Rob Herring <robherring2@gmail.com>
MIME-Version: 1.0
To: Stephen Warren <swarren@wwwdotorg.org>
CC: Thierry Reding <thierry.reding@avionic-design.de>,
	linux-tegra@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	Colin Cross <ccross@android.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 08/10] of/address: Handle #address-cells > 2 specially
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de> <1343332512-28762-9-git-send-email-thierry.reding@avionic-design.de> <50183DA3.8020308@gmail.com> <20120815200655.GC12870@avionic-0098.mockup.avionic-design.de> <504A1FA4.9040302@wwwdotorg.org>
In-Reply-To: <504A1FA4.9040302@wwwdotorg.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/07/2012 11:24 AM, Stephen Warren wrote:
> On 08/15/2012 02:06 PM, Thierry Reding wrote:
>> On Tue, Jul 31, 2012 at 03:18:43PM -0500, Rob Herring wrote:
>>> On 07/26/2012 02:55 PM, Thierry Reding wrote:
>>>> When a bus specifies #address-cells > 2, of_bus_default_map()
>>>> now assumes that the mapping isn't for a physical address but
>>>> rather an identifier that needs to match exactly.
>>>>
>>>> This is required by bindings that use multiple cells to
>>>> translate a resource to the parent bus (device index, type,
>>>> ...).
>>>>
>>>> See here for the discussion:
>>>>
>>>> https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-June/016577.html
>>>>
>>>>
>>>>
> Originally-by: Arnd Bergmann <arnd@arndb.de>
>>>> Signed-off-by: Thierry Reding
>>>> <thierry.reding@avionic-design.de>
>>>
>>> Acked-by: Rob Herring <rob.herring@calxeda.com>
>>
>> Hi Rob,
>>
>> Were you going to take this through your DT tree? I'm trying to
>> reduce the number of patches in this series to make it more
>> manageable and split it into smaller chunks. There are also a
>> couple of issues that need to be resolved so I don't know if I can
>> get the whole series into shape for 3.7.
>>
>> However if you don't think this patch is useful to be applied by
>> itself I can also carry it until the complete series is ready.
> 
> Rob,
> 
> Are you able to take this patch now for 3.7, or should it be held off
> until the Tegra PCIe driver is re-written and requires this
> functionality (in which case I'd expect to take this through the Tegra
> tree at that time).
> 
> For reference, it's at http://patchwork.ozlabs.org/patch/173497/.

Applied for 3.7.

Rob

