Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Patel, Mayurkumar" <mayurkumar.patel@intel.com>
To: Sinan Kaya <okaya@codeaurora.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "timur@codeaurora.org" <timur@codeaurora.org>,
 "cov@codeaurora.org" <cov@codeaurora.org>, Bjorn Helgaas
 <bhelgaas@google.com>
Subject: RE: [PATCH V2] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
Date: Fri, 3 Mar 2017 09:43:43 +0000
Message-ID: <92EBB4272BF81E4089A7126EC1E7B2846666A1D5@IRSMSX101.ger.corp.intel.com>
References: <1485891928-14573-1-git-send-email-okaya@codeaurora.org>
 <92EBB4272BF81E4089A7126EC1E7B2846666830C@IRSMSX101.ger.corp.intel.com>
 <b78207b6-2c22-3e6d-4837-8b4b396c4f5d@codeaurora.org>
 <92EBB4272BF81E4089A7126EC1E7B28466668774@IRSMSX101.ger.corp.intel.com>
 <f8f67b32-21eb-232b-2b7c-28b603865b9d@codeaurora.org>
 <92EBB4272BF81E4089A7126EC1E7B28466669BFF@IRSMSX101.ger.corp.intel.com>
 <fed12fe1-3b13-0118-6a11-5004779d9c06@codeaurora.org>
In-Reply-To: <fed12fe1-3b13-0118-6a11-5004779d9c06@codeaurora.org>
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

Hi Kaya

>
>Hi Mayurkumar
>
>On 3/2/2017 11:05 AM, Patel, Mayurkumar wrote:
>>>
>>> Hi Bjorn,
>>>
>>> On 2/28/2017 1:57 PM, Patel, Mayurkumar wrote:
>>>>> I was trying to figure out when to use saved values vs. the values in
>>>>> registers by looking at the enable_cnt.
>>>>> enable_cnt is 0 during boot on my system.
>>>> enable_cnt for the root port on my system is set to 1 for "root port" already without saving
>>>> any ASPM related settings.
>>>>
>>>>
>>>
>>> What would be the best way to figure out when to save power-on values from
>>> the registers?
>>>
>>
>> I can upload the diffs) because enable_cnt in pci_enable_device() can be triggered
>> from multiple places at boot time so it might not be safe to use it?
>
>Go ahead and share your diff. It doesn't hurt to look at other alternatives.
>

So basically, I introduced a new atomic variable to save the aspm_policy for the first time.
Below is my diff.

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 3dd8bcb..c8e1e3a 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -338,8 +338,9 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
        }
 }

-static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
+static void pcie_aspm_cap_init(struct pci_dev *pdev, int blacklist)
 {
+       struct pcie_link_state *link = pdev->link_state;
        struct pci_dev *child, *parent = link->pdev;
        struct pci_bus *linkbus = parent->subordinate;
        struct aspm_register_info upreg, dwreg;
@@ -397,8 +398,21 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
        link->latency_up.l1 = calc_l1_latency(upreg.latency_encoding_l1);
        link->latency_dw.l1 = calc_l1_latency(dwreg.latency_encoding_l1);

-       /* Save default state */
-       link->aspm_default = link->aspm_enabled;
+       /*
+        * Save default state from FW when enabling ASPM for the first time
+        * during boot by looking at the calculated link->aspm_enabled bits
+        * above and aspm_enable_cnt will be zero.
+        *
+        * If this path is getting called for the second/third time
+        * (aspm_enable_cnt will be non-zero). Assume that the current state
+        * of the ASPM registers may not necessarily match what FW asked us to
+        * do as in the case of hotplug insertion/removal.
+        */
+       if (atomic_inc_return(&pdev->aspm_enable_cnt) == 1)
+               pdev->aspm_default = link->aspm_default = link->aspm_enabled;
+       else
+               link->aspm_default = pdev->aspm_default;
+

        /* Setup initial capable state. Will be updated later */
        link->aspm_capable = link->aspm_support;
@@ -606,7 +620,7 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
         * upstream links also because capable state of them can be
         * update through pcie_aspm_cap_init().
         */
-       pcie_aspm_cap_init(link, blacklist);
+      pcie_aspm_cap_init(pdev, blacklist);

        /* Setup initial Clock PM state */
        pcie_clkpm_cap_init(link, blacklist);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e2d1a12..aa7bd7e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -321,6 +321,8 @@ struct pci_dev {

 #ifdef CONFIG_PCIEASPM
         struct pcie_link_state  *link_state;    /* ASPM link state */
+       unsigned int    aspm_default;           /* ASPM policy set by BIOS */
+       atomic_t        aspm_enable_cnt;        /* ASPM policy initialization */
 #endif

        pci_channel_state_t error_state;        /* current connectivity state */


>>
>> @Kaya/Bjorn: Do you have any other suggestions or Could you also please help by comment what would make sense?
>>
>>
>>> --
>>> Sinan Kaya
>>> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
>>> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
>> Intel Deutschland GmbH
>> Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
>> Tel: +49 89 99 8853-0, www.intel.de
>> Managing Directors: Christin Eisenschmid, Christian Lamprechter
>> Chairperson of the Supervisory Board: Nicole Lau
>> Registered Office: Munich
>> Commercial Register: Amtsgericht Muenchen HRB 186928
>>
>>
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
