Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Patel, Mayurkumar" <mayurkumar.patel@intel.com>
To: 'Sinan Kaya' <okaya@codeaurora.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "timur@codeaurora.org" <timur@codeaurora.org>,
 "cov@codeaurora.org" <cov@codeaurora.org>, Bjorn Helgaas
 <bhelgaas@google.com>
Subject: RE: [PATCH V2] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
Date: Thu, 2 Mar 2017 16:05:17 +0000
Message-ID: <92EBB4272BF81E4089A7126EC1E7B28466669BFF@IRSMSX101.ger.corp.intel.com>
References: <1485891928-14573-1-git-send-email-okaya@codeaurora.org>
 <92EBB4272BF81E4089A7126EC1E7B2846666830C@IRSMSX101.ger.corp.intel.com>
 <b78207b6-2c22-3e6d-4837-8b4b396c4f5d@codeaurora.org>
 <92EBB4272BF81E4089A7126EC1E7B28466668774@IRSMSX101.ger.corp.intel.com>
 <f8f67b32-21eb-232b-2b7c-28b603865b9d@codeaurora.org>
In-Reply-To: <f8f67b32-21eb-232b-2b7c-28b603865b9d@codeaurora.org>
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
>Hi Bjorn,
>
>On 2/28/2017 1:57 PM, Patel, Mayurkumar wrote:
>>> I was trying to figure out when to use saved values vs. the values in
>>> registers by looking at the enable_cnt.
>>> enable_cnt is 0 during boot on my system.
>> enable_cnt for the root port on my system is set to 1 for "root port" already without saving
>> any ASPM related settings.
>>
>>
>
>What would be the best way to figure out when to save power-on values from
>the registers?
>

So in my case, pci_enable_device() for root port is called from pcie_port_device_register() at the boot time which
Is called from pcie_portdrv_probe() function which does not call pcie_aspm_init_link_state() but
Increment's enable_cnt field. When the Endpoint get plugged in, pcie_aspm_init_link_state() is called
from hotplug routine on "Root port" but due to enable_cnt is already incremented we do not set
right policy and aspm gets disabled by aspm driver.

Shall we introduce new atomic variable along with aspm_default in struct pci_dev and increment it in when called
first time pcie_aspm_init_link_state()  to save power-on values ( I have tested it locally, if you think could be good approach
I can upload the diffs) because enable_cnt in pci_enable_device() can be triggered
from multiple places at boot time so it might not be safe to use it? 
or adding pcie_aspm_init_link_state() in pcie_port_device_register() for ports before calling pci_enable_device()
although I am not sure whether it's the right approach and that would work for all the devices!

@Kaya/Bjorn: Do you have any other suggestions or Could you also please help by comment what would make sense?


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
