Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from goliath.siemens.de ([192.35.17.28]:35429 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752150AbeB1KB1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Feb 2018 05:01:27 -0500
Subject: Re: [PATCH v2 2/6] PCI: Scan all functions when running over
 Jailhouse
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jailhouse-dev@googlegroups.com, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Benedikt Spranger <b.spranger@linutronix.de>
References: <cover.1519799691.git.jan.kiszka@siemens.com>
 <021d3dde4276c9bf4325f7bdc37e3c47069e48fc.1519799691.git.jan.kiszka@siemens.com>
 <alpine.DEB.2.21.1802280938380.1886@nanos.tec.linutronix.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8adf7f98-3b05-2a76-48ec-111921219920@siemens.com>
Date: Wed, 28 Feb 2018 11:01:05 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1802280938380.1886@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-02-28 09:44, Thomas Gleixner wrote:
> On Wed, 28 Feb 2018, Jan Kiszka wrote:
> 
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Per PCIe r4.0, sec 7.5.1.1.9, multi-function devices are required to
>> have a function 0.  Therefore, Linux scans for devices at function 0
>> (devfn 0/8/16/...) and only scans for other functions if function 0
>> has its Multi-Function Device bit set or ARI or SR-IOV indicate
>> there are more functions.
>>
>> The Jailhouse hypervisor may pass individual functions of a
>> multi-function device to a guest without passing function 0, which
>> means a Linux guest won't find them.
>>
>> Change Linux PCI probing so it scans all function numbers when
>> running as a guest over Jailhouse.
> 
>>  void pcibios_scan_specific_bus(int busn)
>>  {
>> +	int stride = jailhouse_paravirt() ? 1 : 8;
>>  	int devfn;
>>  	u32 l;
>>  
>>  	if (pci_find_bus(0, busn))
>>  		return;
>>  
>> -	for (devfn = 0; devfn < 256; devfn += 8) {
>> +	for (devfn = 0; devfn < 256; devfn += stride) {
>>  		if (!raw_pci_read(0, busn, devfn, PCI_VENDOR_ID, 2, &l) &&
>>  		    l != 0x0000 && l != 0xffff) {
>>  			DBG("Found device at %02x:%02x [%04x]\n", busn, devfn, l);
> 
> Shouldn't that take the situation into account where the MFD bit is set on
> a regular devfn, i.e. (devfn % 8) == 0? In that case you'd scan the
> subfunctions twice.

Good point, and it also applies to pci_scan_child_bus_extend. Will add
some filters.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
