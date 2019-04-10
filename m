Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9A7C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 09:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D432B20820
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 09:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="KguHGdKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbfDJJx5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:53:57 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19956 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729986AbfDJJx5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Apr 2019 05:53:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cadbd2f0000>; Wed, 10 Apr 2019 02:53:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 10 Apr 2019 02:53:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 10 Apr 2019 02:53:54 -0700
Received: from [10.24.47.181] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Apr
 2019 09:53:42 +0000
Subject: Re: [PATCH 09/10] PCI: tegra: Add Tegra194 PCIe support
To:     Liviu Dudau <liviu.dudau@arm.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <lorenzo.pieralisi@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <mperttunen@nvidia.com>, <tiwai@suse.de>, <spujar@nvidia.com>,
        <skomatineni@nvidia.com>, <krzk@kernel.org>, <heiko@sntech.de>,
        <horms+renesas@verge.net.au>, <olof@lixom.net>,
        <maxime.ripard@bootlin.com>, <andy.gross@linaro.org>,
        <bjorn.andersson@linaro.org>, <jagan@amarulasolutions.com>,
        <enric.balletbo@collabora.com>, <ezequiel@collabora.com>,
        <stefan.wahren@i2se.com>, <marc.w.gonzalez@free.fr>,
        <l.stach@pengutronix.de>, <tpiepho@impinj.com>,
        <hayashi.kunihiko@socionext.com>, <yue.wang@amlogic.com>,
        <shawn.lin@rock-chips.com>, <xiaowei.bao@nxp.com>,
        <devicetree@vger.kernel.org>, <mmaddireddy@nvidia.com>,
        <kthota@nvidia.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190329203159.GG24180@google.com>
 <5eb9599c-a6d6-d3a3-beef-5225ed7393f9@nvidia.com>
 <20190402183110.GE141706@google.com>
 <dcbfbb32-9980-7ee4-89cd-baedfe624ce5@nvidia.com>
 <20190403173641.GI141706@google.com>
 <6cc7e047-bc7e-fa60-88ba-0b69c3d5a3f0@nvidia.com>
 <20190405185842.GC26522@google.com>
 <40c97eaa-e37e-860e-111d-879a135d9f51@nvidia.com>
 <20190409132604.GA256045@google.com>
 <a414b42c-ce10-e2db-55f0-9428cfd23e68@nvidia.com>
 <20190410081448.GC15144@e110455-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <31385c64-86b9-ebe3-99e3-6d156b66fb6a@nvidia.com>
Date:   Wed, 10 Apr 2019 15:23:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410081448.GC15144@e110455-lin.cambridge.arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554890031; bh=/Grtf11dpW8it/+4rfzzUrQ3SvDeBO6exfHfaBkeFq0=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=KguHGdKfOkqddvBVhXWAijvw2mJ3EP/JAVj40a6H2IwEI8BMFHpy6Oa/KvWx5tcbJ
         r7dKXmzvrkBtspYTXCf3MjWyLTs7IATQx1P2Au5XrIp8W+liUMuekwt1MDdq+8jkK2
         nLL367Rbsp3HCepwUUuwd33xvu/b79+NL5DyX+ljKz/3/Jmb7nxXV+Y7r+c5xfPlgF
         /ncfKNK2EdbmAwHBrFZTBdFbmgFqZxdD2G/5ED7q0Bu/LjCX3jSORYScMwiXYtbyUP
         Vcz52K8Uf24F+yb8kkDfvUxvTFa4eGPu7g1RjHxq6HDRq7JkrDso+pDTPeuJyoDKjO
         GAmeQSdLkho/g==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/10/2019 1:44 PM, Liviu Dudau wrote:
> On Wed, Apr 10, 2019 at 11:40:40AM +0530, Vidya Sagar wrote:
>> On 4/9/2019 6:56 PM, Bjorn Helgaas wrote:
>>> On Tue, Apr 09, 2019 at 05:00:53PM +0530, Vidya Sagar wrote:
>>>> On 4/6/2019 12:28 AM, Bjorn Helgaas wrote:
>>>>> On Fri, Apr 05, 2019 at 01:23:51AM +0530, Vidya Sagar wrote:
>>>>>> On 4/3/2019 11:06 PM, Bjorn Helgaas wrote:
>>>>>>> On Wed, Apr 03, 2019 at 03:13:09PM +0530, Vidya Sagar wrote:
>>>>>>>> On 4/3/2019 12:01 AM, Bjorn Helgaas wrote:
>>>>>>>>> On Tue, Apr 02, 2019 at 12:47:48PM +0530, Vidya Sagar wrote:
>>>>>>>>>> On 3/30/2019 2:22 AM, Bjorn Helgaas wrote:
>>>>>>>>>>> On Tue, Mar 26, 2019 at 08:43:26PM +0530, Vidya Sagar wrote:
>>>>>>>>>>>> Add support for Synopsys DesignWare core IP based PCIe host controller
>>>>>>>>>>>> present in Tegra194 SoC.
>>>>>>>>>
>>>>>>>>>        - Why does this chip require pcie_pme_disable_msi()?  The only other
>>>>>>>>>          use is a DMI quirk for "MSI Wind U-100", added by c39fae1416d5
>>>>>>>>>          ("PCI PM: Make it possible to force using INTx for PCIe PME
>>>>>>>>>          signaling").
>>>>>>>>
>>>>>>>> Because Tegra194 doesn't support raising PME interrupts through MSI line.
>>>
>>>>> There's something wrong here.  Either the question of how PME is
>>>>> signaled is generic and the spec provides a way for the OS to discover
>>>>> that method, or it's part of the device-specific architecture that
>>>>> each host bridge driver has to know about its device.  If the former,
>>>>> we need to make the PCI core smart enough to figure it out.  If the
>>>>> latter, we need a better interface than this ad hoc
>>>>> pcie_pme_disable_msi() thing.  But if it is truly the latter, your
>>>>> current code is sufficient and we can refine it over time.
>>>>
>>>> In case of Tegra194, it is the latter case.
>>>
>>> This isn't a Tegra194 question; it's a question of whether this
>>> behavior is covered by the PCIe spec.
>> AFAIU the spec and what I heard from Nvidia hardware folks is that spec doesn't
>> explicitly talk about this and it was a design choice made by Nvidia hardware
>> folks to route these interrupts through legacy line instead of MSI line.
>>
>>>
>>>>> What I suspect should happen eventually is the DWC driver should call
>>>>> devm_pci_alloc_host_bridge() directly, as all the non-DWC drivers do.
>>>>> That would require a little reorganization of the DWC data structures,
>>>>> but it would be good to be more consistent.
>>>>>
>>>>> For now, I think stashing the pointer in pcie_port or dw_pcie would be
>>>>> OK.  I'm not 100% clear on the difference, but it looks like either
>>>>> should be common across all the DWC drivers, which is what we want.
>>>>
>>>> Since dw_pcie is common for both root port and end point mode structures,
>>>> I think it makes sense to keep the pointer in pcie_port as this structure
>>>> is specific to root port mode of operation.
>>>> I'll make a note to reorganize code to have devm_pci_alloc_host_bridge()
>>>> used in the beginning itself to be inline with non-DWC implementations.
>>>> But, I'll take it up later (after I'm done with upstreaming current series)
>>>
>>> Fair enough.
>>>
>>>>>> .remove() internally calls pm_runtime_put_sync() API which calls
>>>>>> .runtime_suspend(). I made a new patch to add a host_deinit() call
>>>>>> which make all these calls. Since host_init() is called from inside
>>>>>> .runtime_resume() of this driver, to be in sync, I'm now calling
>>>>>> host_deinit() from inside .runtime_suspend() API.
>>>>>
>>>>> I think this is wrong.  pci_stop_root_bus() will detach all the
>>>>> drivers from all the devices.  We don't want to do that if we're
>>>>> merely runtime suspending the host bridge, do we?
>>>>
>>>> In the current driver, the scenarios in which .runtime_suspend() is called
>>>> are
>>>> a) during .remove() call and
>>>
>>> It makes sense that you should call pci_stop_root_bus() during
>>> .remove(), i.e., when the host controller driver is being removed,
>>> because the PCI bus will no longer be accessible.  I think you should
>>> call it *directly* from tegra_pcie_dw_remove() because that will match
>>> what other drivers do.
>>>
>>>> b) when there is no endpoint found and controller would be shutdown
>>>> In both cases, it is required to stop the root bus and remove all devices,
>>>> so, instead of having same call present in respective paths, I kept them
>>>> in .runtime_suspend() itself to avoid code duplication.
>>>
>>> I don't understand this part.  We should be able to runtime suspend
>>> the host controller without detaching drivers for child devices.
>>>
>>> If you shutdown the controller completely and detach the *host
>>> controller driver*, sure, it makes sense to detach drivers from child
>>> devices.  But that would be handled by the host controller .remove()
>>> method, not by the runtime suspend method.
>> I think it is time I give some background about why I chose to implement
>> .runtime_suspend() and .runtime_resume() APIs in the first place. We wanted to
>> powerdown PCIe controller if there is no link up (i.e. slot is open and no endpoint
>> devices are connected). We want to achieve this without returning a failure in
>> .probe() call. Given PCIe IP power partitioning is handled by generic power domain
>> framework, power partition gets unpowergated before .probe() gets called and gets
>> powergated either when a failure is returned in .probe() or when pm_runtime_put_sync()
>> is called. So, I chose to call pm_runtime_put_sync() in no-link-up scenario and chose
>> to implement .runtime_suspend() to handle all the cleanup work before PCIe partition
>> getting powergated. In fact, to match this, I'm doing all the PCIe IP bring up
>> activity in .runtime_resume() implementation which gets invoked by pm_runtime_get_sync()
>> which in turn is called in .probe() path. In fact the very dw_pcie_host_init() itself
>> is called from .runtime_resume() implementation. So, it is because of these reasons that
>> I called pci_stop_root_bus() and pci_remove_root_bus() as part of .runtime_suspend()
>> implementation as pm_runtime_put_sync() is called from both .remove() and also during
>> no-link-up scenario. Please do let me know if there is a better way to do this.
> 
> I think you're missing the case where .runtime_suspend() is called when
> there are no *active* devices on the bus, i.e. everyone is dormant. It
> doesn't mean that you need to remove them from the bus and re-probe them
> back on .runtime_resume(). Most of the drivers for PCI devices don't
> expect to be removed during idle, as they will configure the hardware to
> be in a "quick wake" state (see PCIe Dx power states).
> 
> You should probe and configure the bus during .probe() and remove and
> detach all drivers during .remove(). For .runtime_suspend() all you need
> to do is put the host controller in low power mode if it has one, or
> stop all clocks that are not required for responding to devices waking
> up from PCIe Dx state. For .runtime_resume() you then restore the
> clocks, without re-scanning the bus.
Since this is a host controller driver and the device as such is sitting on platform
bus instead of PCIe bus, is it still the case that .runtime_suspend() and
.runtime_resume() of this driver get called when devices on PCIe bus are idle?

Having asked that, I start to feel what I'm doing as part of .runtime_suspend() and
.runtime_resume() doesn't really justify these API names. Since I know where I'm
calling pm_runtime_get/put_sync() APIs (which eventually call .runtime_resume/suspend())
I should probably move the content of these APIs before calling pm_runtime_get/put_sync().
Do you agree with that?

> 
> Best regards,
> Liviu
> 
> 
>>
>>>
>>> Bjorn
>>>
>>
> 

