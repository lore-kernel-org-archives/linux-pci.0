Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Patel, Mayurkumar" <mayurkumar.patel@intel.com>
To: Sinan Kaya <okaya@codeaurora.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "timur@codeaurora.org" <timur@codeaurora.org>,
 "cov@codeaurora.org" <cov@codeaurora.org>
Subject: RE: [PATCH V2] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
Date: Tue, 28 Feb 2017 18:57:19 +0000
Message-ID: <92EBB4272BF81E4089A7126EC1E7B28466668774@IRSMSX101.ger.corp.intel.com>
References: <1485891928-14573-1-git-send-email-okaya@codeaurora.org>
 <92EBB4272BF81E4089A7126EC1E7B2846666830C@IRSMSX101.ger.corp.intel.com>
 <b78207b6-2c22-3e6d-4837-8b4b396c4f5d@codeaurora.org>
In-Reply-To: <b78207b6-2c22-3e6d-4837-8b4b396c4f5d@codeaurora.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

>
>On 2/28/2017 6:03 AM, Patel, Mayurkumar wrote:
>>> -	/* Save default state */
>>> -	link->aspm_default = link->aspm_enabled;
>> But, I am finding a problem with this change, if Policy is set to default,
>> BIOS enables ASPM L1, but pcie_config_aspm_link() disables ASPM L1
>> due to link->aspm_enabled is different than link->aspm_default while
>> called from pcie_aspm_init_link_state() during hotplug insertion.
>>
>
>Thanks for testing. I think it means the enable count logic I put below
>is not working.

Yes I believe so.

>
>I was trying to figure out when to use saved values vs. the values in
>registers by looking at the enable_cnt.

>enable_cnt is 0 during boot on my system.

enable_cnt for the root port on my system is set to 1 for "root port" already without saving
any ASPM related settings. 


>
>The enable_cnt should have been non-zero following an insertion following
>remove and default and enabled values should have been identical.
>

pcie_aspm_init_link_state() is called on the "root port" from hotplug routine when I plug in PCIE Endpoint.
And in my case root port "enable_cnt" is already set to 1 because of root port driver probed already. So
link->aspm_default by  default always sets to pdev->aspm_default which is 0 as it was never set to
BIOS values before. I will continue dig in further to see how the "root port" probe gets triggered
and why it does not call pcie_aspm_init_link_state() to store aspm policy before "enable_cnt" becomes 1 for it.

>Can you print out the values of pdev->aspm_default, link->aspm_default,
>and link->aspm_enabled in this function along with atomic_read(&pdev->enable_cnt)?
>
>>

Yes. Also printed link control register(lnkctl) set by BIOS for upstream port and downstream port
Which gets disabled afterwards due to the link->aspm_default is 0. The prints are in pcie_aspm_cap_init()
Function.

[  199.287732] pci 0000:03:00.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[  199.287748] pci 0000:03:00.0: reg 0x18: [mem 0x00000000-0x000000ff 64bit]
[  199.287864] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[  199.288000] pci 0000:03:00.0: System wakeup disabled by ACPI
[  199.299868] upreg lnkcap 00000003 lnkctl=00000042
[  199.299996] dwreg lnkcap  00000002 lnkctl=00000142
[  199.300076] pdev_aspm_default: 0x00000000 link_aspm_default: 0x00000000 aspm_enabled: 0x00000004 enable_cnt: 0x00000001 
[  199.300402] pci 0000:03:00.0: BAR 0: assigned [mem 0xaa000000-0xaa000fff 64bit]
[  199.300413] pci 0000:03:00.0: BAR 2: assigned [mem 0xaa001000-0xaa0010ff 64bit]


>>> +	/*
>>> +	 * Save default state from FW when enabling ASPM for the first time
>>> +	 * during boot by looking at the calculated link->aspm_enabled bits
>>> +	 * above and enable_cnt will be zero.
>>> +	 *
>>> +	 * If this path is getting called for the second/third time
>>> +	 * (enable_cnt will be non-zero). Assume that the current state of the
>>> +	 * ASPM registers may not necessarily match what FW asked us to do as
>>> +	 * in the case of hotplug insertion/removal.
>>> +	 */
>>> +	if (!atomic_read(&pdev->enable_cnt))
>>> +		pdev->aspm_default = link->aspm_default = link->aspm_enabled;
>>> +	else
>>> +		link->aspm_default = pdev->aspm_default;
>
>
>--
>Sinan Kaya
>Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
>Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Christian Lamprechter
Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
