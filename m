Return-Path: <SRS0=LK3s=LK=endlessm.com=jian-hong@kernel.org>
Return-Path: <SRS0=LK3s=LK=endlessm.com=jian-hong@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180823133805.GE154536@bhelgaas-glaptop.roam.corp.google.com>
References: <ac30d4e6-6411-09e6-1205-96e3e8e29f6f@gmail.com>
 <20180820184438.GA154536@bhelgaas-glaptop.roam.corp.google.com>
 <9d7d960a-6c55-dc4b-7969-f5cf46bff0ce@gmail.com> <20180821.123108.89921430801253333.davem@davemloft.net>
 <da97e198-7683-e0ff-92a9-3b1b22da3757@gmail.com> <alpine.DEB.2.21.1808221222260.2514@nanos.tec.linutronix.de>
 <36bd086d-8d26-5162-ae24-95b259571221@gmail.com> <CAPpJ_edz3H81EqRSg5jeOXoULt7AKwcTpNFL6Ntt8rhQBPFBFQ@mail.gmail.com>
 <20180823133805.GE154536@bhelgaas-glaptop.roam.corp.google.com>
From: Jian-Hong Pan <jian-hong@endlessm.com>
Date: Mon, 27 Aug 2018 18:46:42 +0800
Message-ID: <CAPpJ_ef3Kp3CwcV1=HrmOtE0iyXt=-RCRno=zhvxm0e=sqWLaw@mail.gmail.com>
Subject: Re: [PATCH] r8169: don't use MSI-X on RTL8106e
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
	David Miller <davem@davemloft.net>, Realtek linux nic maintainers <nic_swsd@realtek.com>, netdev@vger.kernel.org,
	Linux Kernel <linux-kernel@vger.kernel.org>, Linux Upstreaming Team <linux@endlessm.com>,
	linux-pci@vger.kernel.org, marc.zyngier@arm.com, hch@lst.de
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

2018-08-23 21:38 GMT+08:00 Bjorn Helgaas <helgaas@kernel.org>:
> On Thu, Aug 23, 2018 at 06:46:28PM +0800, Jian-Hong Pan wrote:
>> > On 22.08.2018 13:44, Thomas Gleixner wrote:
>> >> Can you please do the following:
>>
>> Tested on ASUS X441AUR equipped with RTL8106e.
>> This is the laptop whose ethernet does not come back after resume, if
>> it does not fallback to MSI.
>> ...
>
>> dev@endless:~$ sudo lspci -xnnvvs 02:00.0
>> ...
>> 00: ec 10 36 81 07 04 10 00 07 00 00 02 10 00 00 00
>> 10: 01 e0 00 00 00 00 00 00 04 00 10 ef 00 00 00 00
>> 20: 0c 00 00 e0 00 00 00 00 00 00 00 00 43 10 0f 20
>> 30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00
>>
>> After comparing, there is no difference between before suspend and
>> after resume.
>
> It'd be better to compare the hex data directly and ignore the lspci
> decoding, since lspci doesn't decode everything.  You only dumped the
> first 0x40 bytes of config space, and all capabilities, including the
> MSI and MSI-X capabilities, are past that:
>
>> Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>> Capabilities: [b0] MSI-X: Enable+ Count=4 Masked-
>> Vector table: BAR=4 offset=00000000
>> PBA: BAR=4 offset=00000800
>
> In addition, some of the MSI-X information for this device is in BAR
> 4.  "lspci -xxx" will dump all config space, and you can use a tool
> like http://cmp.felk.cvut.cz/~pisa/linux/rdwrmem.c or
> https://github.com/billfarrow/pcimem to dump the BAR contents.

Tested on ASUS X441AUR equipped with RTL8106e without fallbacking to MSI again.
Use lspci and https://github.com/billfarrow/pcimem

Here is the status before suspend:

dev@endless:~$ sudo lspci -xxxs 02:00.0
02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8101/2/6E PCI Express Fast/Gigabit Ethernet controller (rev 07)
00: ec 10 36 81 07 04 10 00 07 00 00 02 10 00 00 00
10: 01 e0 00 00 00 00 00 00 04 00 10 ef 00 00 00 00
20: 0c 00 00 e0 00 00 00 00 00 00 00 00 43 10 0f 20
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00
40: 01 50 c3 ff 08 00 00 00 00 00 00 00 00 00 00 00
50: 05 70 80 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 10 b0 02 02 c0 8d 90 05 10 20 10 00 11 7c 47 00
80: 42 01 11 10 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 1f 08 0c 00 00 04 00 00 02 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 11 d0 03 80 04 00 00 00 04 08 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

dev@endless:~$ sudo ~/pcimem/pcimem
/sys/devices/pci0000\:00/0000\:00\:1c.4/0000\:02\:00.0/resource4 0
b*16384
[sudo] password for dev:
/sys/devices/pci0000:00/0000:00:1c.4/0000:02:00.0/resource4 opened.
Target offset is 0x0, page size is 4096
mmap(0, 16384, 0x3, 0x1, 3, 0x0)
PCI Memory mapped to address 0x7f15186d1000.
0x0000: 0x38
0x0001: 0x03
0x0002: 0xE0
0x0003: 0xFE
0x0004: 0x00
...
0x0010: 0x41
0x0011: 0x72
.
.
.
0x003C: 0x01
0x003D: 0x00
...
0x1000: 0x38
0x1001: 0x03
.
.
.

After resume:

dev@endless:~$ sudo lspci -xxxs 02:00.0
02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8101/2/6E PCI Express Fast/Gigabit Ethernet controller (rev 07)
00: ec 10 36 81 07 04 10 00 07 00 00 02 10 00 00 00
10: 01 e0 00 00 00 00 00 00 04 00 10 ef 00 00 00 00
20: 0c 00 00 e0 00 00 00 00 00 00 00 00 43 10 0f 20
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00
40: 01 50 c3 ff 08 00 00 00 00 00 00 00 00 00 00 00
50: 05 70 80 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 10 b0 02 02 c0 8d 90 05 10 20 10 00 11 7c 47 00
80: 42 01 11 10 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 1f 08 0c 00 00 04 00 00 02 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 11 d0 03 80 04 00 00 00 04 08 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

dev@endless:~$ sudo ~/pcimem/pcimem
/sys/devices/pci0000\:00/0000\:00\:1c.4/0000\:02\:00.0/resource4 0
b*16384
/sys/devices/pci0000:00/0000:00:1c.4/0000:02:00.0/resource4 opened.
Target offset is 0x0, page size is 4096
mmap(0, 16384, 0x3, 0x1, 3, 0x0)
PCI Memory mapped to address 0x7f8d68dd5000.
0x0000: 0xFF
...


The config is the same, but values in BAR=4 is weird after resume.
They all become 0xFF.

Regards,
Jian-Hong Pan
