Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 16 May 2017 15:41:44 +0800
From: kbuild test robot <lkp@intel.com>
To: Oza Pawandeep <oza.oza@broadcom.com>
Subject: Re: [PATCH v6 3/3] PCI/of fix of_dma_get_range; get PCI specific
 dma-ranges
Message-ID: <201705161534.hBTKNcfz%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
In-Reply-To: <1494912127-12890-4-git-send-email-oza.oza@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Oza Pawandeep <oza.pawandeep@gmail.com>,
 linux-pci@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 bcm-kernel-feedback-list@broadcom.com, kbuild-all@01.org,
 Oza Pawandeep <oza.oza@broadcom.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Oza,

[auto build test ERROR on v4.9-rc8]
[cannot apply to next-20170516]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Oza-Pawandeep/of-pci-dma-fix-DMA-configuration-for-PCI-masters/20170516-141222
config: c6x-evmc6678_defconfig (attached as .config)
compiler: c6x-elf-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=c6x 

All errors (new ones prefixed by >>):

>> drivers//of/address.c:580:21: error: 'of_bus_isa_get_dma_ranges' undeclared here (not in a function)
      .get_dma_ranges = of_bus_isa_get_dma_ranges,
                        ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers//of/address.c:591:21: error: 'of_bus_default_get_dma_ranges' undeclared here (not in a function)
      .get_dma_ranges = of_bus_default_get_dma_ranges,
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +/of_bus_isa_get_dma_ranges +580 drivers//of/address.c

   574			.addresses = "reg",
   575			.match = of_bus_isa_match,
   576			.count_cells = of_bus_isa_count_cells,
   577			.map = of_bus_isa_map,
   578			.translate = of_bus_isa_translate,
   579			.get_flags = of_bus_isa_get_flags,
 > 580			.get_dma_ranges = of_bus_isa_get_dma_ranges,
   581		},
   582		/* Default */
   583		{
   584			.name = "default",
   585			.addresses = "reg",
   586			.match = NULL,
   587			.count_cells = of_bus_default_count_cells,
   588			.map = of_bus_default_map,
   589			.translate = of_bus_default_translate,
   590			.get_flags = of_bus_default_get_flags,
 > 591			.get_dma_ranges = of_bus_default_get_dma_ranges,
   592		},
   593	};
   594	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--jI8keyz6grp/JLjh
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--jI8keyz6grp/JLjh--
