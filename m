Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:50677 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751834AbdGGIxU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jul 2017 04:53:20 -0400
Subject: Re: [PATCH 1/3] PCI: designware: add accessors for write permission
 of DBI read-only registers
To: "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC: "jingoohan1@gmail.com" <jingoohan1@gmail.com>
References: <1499322829-23018-1-git-send-email-Zhiqiang.Hou@nxp.com>
 <a4510ddb-3037-0787-c00e-b2703d66d54b@synopsys.com>
 <AM5PR0402MB2771B6A74E7DBF156BA066A484AA0@AM5PR0402MB2771.eurprd04.prod.outlook.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <7cebf6a4-bedd-015f-9d1a-1e82fa42d41d@synopsys.com>
Date: Fri, 7 Jul 2017 09:53:15 +0100
MIME-Version: 1.0
In-Reply-To: <AM5PR0402MB2771B6A74E7DBF156BA066A484AA0@AM5PR0402MB2771.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi Zhiqiang,

Às 4:48 AM de 7/7/2017, Z.q. Hou escreveu:
> Hi Joao,
> 
> 
> 
> Thanks a lot for your comments!
> 
> 
> 
>> -----Original Message-----
> 
>> From: Joao Pinto [mailto:Joao.Pinto@synopsys.com]
> 
>> Sent: 2017年7月6日 17:44
> 
>> To: Z.q. Hou <zhiqiang.hou@nxp.com>; linux-pci@vger.kernel.org;
> 
>> Joao.Pinto@synopsys.com
> 
>> Cc: bhelgaas@google.com; jingoohan1@gmail.com
> 
>> Subject: Re: [PATCH 1/3] PCI: designware: add accessors for write permission
> 
>> of DBI read-only registers
> 
>>
> 
>>
> 
>> Hi Zhiqiang,
> 
>>
> 
>> Às 7:33 AM de 7/6/2017, Zhiqiang Hou escreveu:
> 
>>> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
>>>
> 
>>> The read-only DBI registers can be written over the DBI when set the
> 
>>> "Write to RO Registers Using DBI" (DBI_RO_WR_EN) field of the
> 
>>> MISC_CONTROL_1_OFF register.
> 
>>
> 
>> I would suggest you to add a cover-letter next time to explain the global
> 
>> picture of the patch-set.
> 
> 
> 
> Thanks, I will.
> 
> 
> 
>>
> 
>> I understand your need for this patch, but I don't agree on the approach.
> 
> 
> 
> In the DWC common code, there is a function write a DBI read-only register 'Device class code', and the first 2 patches is to fix it.
> 
> The 3rd patch is to refactor the Layerscape PCIe driver's host_init function and reuse the new added accessors.
> 
> 
> 
>> Sometimes the people in charge of the hardware design / configuration, forget
> 
>> to specify the device class and that can be problematic for some drivers, and
> 
>> so the typical workaround is to set it in the driver using a quirk for example.
> 
>>
> 
>> You can see some examples here:
> 
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__git.kernel.org_pub_scm_linux_kernel_git_torvalds_linux.git_tree_drivers_&d=DwIGaQ&c=DPL6_X_6JkXFx7AXWqB0tg&r=s2fO0hii0OGNOv9qQy_HRXy-xAJUD1NNoEcc3io_kx0&m=0DrBCvOc_J7LaMXBei1qCXxxfbLxWaVErKZ6Rkm6bUc&s=sOEmExQFqrCEmpAx9LjSeKRvkW1D-W82ckX5WGCgFWw&e= 
> 
>> pci/quirks.c
> 
> 
> 
> I don't know the PCI quirks, do you mean remove the pci Device Class fix code from the DWC common code and add it to quirks?  
> 

In my opinion adding fixes to a common code is not a good approach. I would
suggest the fix to go into the quirks file.

@Bjorn: The quirks file is the best place for this type of fixes right?

Thanks,
Joao

> 
> 
> Thanks,
> 
> Zhiqiang 
> 
