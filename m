Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:54969 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750866AbdE2IDz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 May 2017 04:03:55 -0400
Subject: Re: [pci:pci/host-qcom 1/2] drivers/pci/dwc/pcie-qcom.c:587:27:
 error: 'struct qcom_pcie' has no member named 'pp'
To: Bjorn Helgaas <bhelgaas@google.com>,
        kbuild test robot <fengguang.wu@intel.com>
References: <201705251416.wWZWNQ8s%fengguang.wu@intel.com>
 <CAErSpo5snPK3t7EKmCsrNOEgeCPK+hMX=PrUp3NwOUTkUDhSQg@mail.gmail.com>
Cc: "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: John Crispin <john@phrozen.org>
Message-ID: <e26abbfd-b5c6-3e88-f91a-aeb1515d91f8@phrozen.org>
Date: Mon, 29 May 2017 10:03:53 +0200
MIME-Version: 1.0
In-Reply-To: <CAErSpo5snPK3t7EKmCsrNOEgeCPK+hMX=PrUp3NwOUTkUDhSQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 25/05/17 21:58, Bjorn Helgaas wrote:
> I think I fixed the problems below, but I'm a little confused as to
> why you didn't see them when you built this code.  So please
> double-check https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/host-qcom&id=a06cb1bf781789efb54c0f01a49e3011df9592ae
> and make sure I did it correctly.

yes the fix is correct. I was runtime testing on an older kernel rev. 
and apparently did not correctly compile test the version i sent on 
latest head.

     John

>
> On Thu, May 25, 2017 at 1:53 AM, kbuild test robot
> <fengguang.wu@intel.com> wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/host-qcom
>> head:   ebacba9579462bdc009f4cfc1b605b3ca7a7a1d2
>> commit: c48a46bd07da450476175f9081e83db29441d9d3 [1/2] PCI: qcom: Add support for IPQ4019 PCIe controller
>> config: arm-allmodconfig (attached as .config)
>> compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
>> reproduce:
>>          wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          git checkout c48a46bd07da450476175f9081e83db29441d9d3
>>          # save the attached .config to linux build tree
>>          make.cross ARCH=arm
>>
>> All errors (new ones prefixed by >>):
>>
>>     drivers/pci/dwc/pcie-qcom.c: In function 'qcom_pcie_get_resources_v3':
>>>> drivers/pci/dwc/pcie-qcom.c:587:27: error: 'struct qcom_pcie' has no member named 'pp'
>>       struct device *dev = pcie->pp.dev;
>>                                ^~
>>     drivers/pci/dwc/pcie-qcom.c: In function 'qcom_pcie_init_v3':
>>     drivers/pci/dwc/pcie-qcom.c:673:27: error: 'struct qcom_pcie' has no member named 'pp'
>>       struct device *dev = pcie->pp.dev;
>>                                ^~
>>
>> vim +587 drivers/pci/dwc/pcie-qcom.c
>>
>>     581          return 0;
>>     582  }
>>     583
>>     584  static int qcom_pcie_get_resources_v3(struct qcom_pcie *pcie)
>>     585  {
>>     586          struct qcom_pcie_resources_v3 *res = &pcie->res.v3;
>>   > 587          struct device *dev = pcie->pp.dev;
>>     588
>>     589          res->aux_clk = devm_clk_get(dev, "aux");
>>     590          if (IS_ERR(res->aux_clk))
>>
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
