Return-Path: <SRS0=nWNg=CU=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=nWNg=CU=huawei.com=liudongdong3@kernel.org>
From: Dongdong Liu <liudongdong3@huawei.com>
Subject: [Question] Unsupported Request During PCI Enumeration
To: Bjorn Helgaas <helgaas@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>
CC: Linuxarm <linuxarm@huawei.com>,
        liudongdong 00290354
	<liudongdong3@huawei.com>
Message-ID: <26340670-2744-b2e0-eed7-eb8e0ad2bc84@huawei.com>
Date: Wed, 22 Nov 2017 15:38:59 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

I found a correctable error when boot linux kernel. The corrected error
is UR (Unsupported Request). It seems that PCIe device will produce UR
during PCIe enumeration. We have configured _HPX in firmware to make sure
UR report is enabled after calling pci_configure_device().

If I disable UR report by setting Device Control Register Unsupported
Request Reporting Enable to 0 ,it will not report the correctable error.
But disable UR report is not responsible, so my question is
how to make sure it does not report the correctable error during enumeration
and after enumeration, PCIe device can report UR correctly ?

[  127.158876] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 2
[  127.171734] {1}[Hardware Error]: It has been corrected by h/w and requires no further action
[  127.181872] {1}[Hardware Error]: event severity: corrected
[  127.189099] {1}[Hardware Error]:  Error 0, type: corrected
[  127.195437] {1}[Hardware Error]:   section_type: PCIe error
[  127.201697] {1}[Hardware Error]:   port_type: 5, upstream switch port

Thanks,
Dongdong
