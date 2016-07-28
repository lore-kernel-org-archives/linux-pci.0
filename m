Return-Path: <swarren@wwwdotorg.org>
Return-Path: <swarren@wwwdotorg.org>
Subject: Re: [GIT PULL] PCI: tegra: Changes for v4.8-rc1
To: Thierry Reding <thierry.reding@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>
References: <20160701150056.26537-3-thierry.reding@gmail.com>
 <20160726200641.GB15037@localhost> <20160728141804.GD28342@ulmo.ba.sec>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-tegra@vger.kernel.org
From: Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <8786647f-d1e6-2343-056d-5aff0cd01202@wwwdotorg.org>
Date: Thu, 28 Jul 2016 09:59:29 -0600
MIME-Version: 1.0
In-Reply-To: <20160728141804.GD28342@ulmo.ba.sec>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 07/28/2016 08:18 AM, Thierry Reding wrote:
> On Tue, Jul 26, 2016 at 03:06:41PM -0500, Bjorn Helgaas wrote:
>> On Fri, Jul 01, 2016 at 05:00:56PM +0200, Thierry Reding wrote:
>>> Hi Bjorn,
>>>
>>> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
>>>
>>>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
>>>
>>> are available in the git repository at:
>>>
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.8-pci
>>>
>>> for you to fetch changes up to 0f32700faed919946e21e9d1dc4d74ae8f1b1226:
>>>
>>>   PCI: tegra: Correctly program PADS_REFCLK_CFG* registers (2016-06-30 15:30:16 +0200)
>>>
>>> There's a minor conflict between this and your pci/host-request-windows
>>> branch, let me know if you'd like me to rebase on top of that.
>>>
>>> Thierry
>>>
>>> ----------------------------------------------------------------
>>> PCI: tegra: Changes for v4.8-rc1
>>>
>>> A couple of cleanups and preparation work for 64-bit ARM support, as
>>> well as fixes for writing the PADS_REFCLK_CFG* registers.
>>>
>>> ----------------------------------------------------------------
>>> Stephen Warren (2):
>>>       PCI: tegra: Actually program PADS_REFCLK_CFG* on recent SoCs
>>
>> I don't see this patch on the list.  I'll attach it below for
>> completeness.
>>
>> I don't think the original changelog is quite right; I don't see
>> tegra_xusb_phy_enable() being involved at all.  I replaced it with the
>> following:
>>
>>     PCI: tegra: Program PADS_REFCLK_CFG* always, not just on legacy SoCs
>>
>>     tegra_pcie_phy_power_on() calls tegra_pcie_phy_enable() only for legacy
>>     SoCs.  However, part of tegra_pcie_phy_enable() needs to happen in all
>>     cases.  Move that code up one level into tegra_pcie_phy_power_on().
>>
>>
>> Here's the original commit from your git tree:
>>
>> commit 0ad9be61b5af
>> Author: Stephen Warren <swarren@nvidia.com>
>> Date:   Fri Jun 24 08:37:03 2016 -0600
>>
>>     PCI: tegra: Actually program PADS_REFCLK_CFG* on recent SoCs
>>
>>     On recent SoCs, tegra_pcie_phy_enable() isn't called; but instead
>>     tegra_pcie_enable_controller() calls tegra_xusb_phy_enable(). However,
>>     part of tegra_pcie_phy_enable() needs to happen in all cases. Move that
>>     code up one level into tegra_pcie_phy_power_on().
>>
>>     Signed-off-by: Stephen Warren <swarren@nvidia.com>
>>     Reviewed-by: Simon Glass <sjg@chromium.org>
>>     Signed-off-by: Thierry Reding <treding@nvidia.com>
>
> Yeah, that's fine. Thanks. FWIW, the reason why you don't see this on
> the list is probably because it is the same patch that was merged into
> U-Boot a few days earlier, which is also the reason why the commit
> message isn't quite right. I thought I had sanitized it, but evidently
> had missed the function name change.

Oops. Looks like I sent it to the Tegra and ARM mailing lists and forgot 
the PCI mailing list:-( Sorry.
