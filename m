Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:33923 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbbJBWFi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2015 18:05:38 -0400
MIME-Version: 1.0
In-Reply-To: <1443816007.7936.24.camel@oracle.com>
References: <1443678807-786-1-git-send-email-yinghai@kernel.org>
	<1443678807-786-2-git-send-email-yinghai@kernel.org>
	<1443816007.7936.24.camel@oracle.com>
Date: Fri, 2 Oct 2015 15:05:37 -0700
Message-ID: <CAE9FiQX=qEO53rSw9bQv-2-3sSmYUO3YCJyj8m6mSNSTed3zEA@mail.gmail.com>
Subject: Re: [PATCH v6 01/53] sparc/PCI: Add mem64 resource parsing for root bus
From: Yinghai Lu <yinghai@kernel.org>
To: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary=001a1141673c1506ef0521265d88
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--001a1141673c1506ef0521265d88
Content-Type: text/plain; charset=UTF-8

On Fri, Oct 2, 2015 at 1:00 PM, Khalid Aziz <khalid.aziz@oracle.com> wrote:
> On Wed, 2015-09-30 at 22:52 -0700, Yinghai Lu wrote:
>> Found "no compatible bridge window" warning in boot log from T5-8.
>>
>> pci 0000:00:01.0: can't claim BAR 15 [mem 0x100000000-0x4afffffff pref]: no compatible bridge window
>>
>> That resource is above 4G, but does not get offset correctly as
>> root bus only report io and mem32.
>>
>> pci_sun4v f02dbcfc: PCI host bridge to bus 0000:00
>> pci_bus 0000:00: root bus resource [io  0x804000000000-0x80400fffffff] (bus address [0x0000-0xfffffff])
>> pci_bus 0000:00: root bus resource [mem 0x800000000000-0x80007effffff] (bus address [0x00000000-0x7effffff])
>> pci_bus 0000:00: root bus resource [bus 00-77]
>>
>> Add mem64 handling in pci_common for sparc, so we can have 64bit resource
>> registered for root bus at first.
>>
>> After patch, will have:
>> pci_sun4v f02dbcfc: PCI host bridge to bus 0000:00
>> pci_bus 0000:00: root bus resource [io  0x804000000000-0x80400fffffff] (bus address [0x0000-0xfffffff])
>> pci_bus 0000:00: root bus resource [mem 0x800000000000-0x80007effffff] (bus address [0x00000000-0x7effffff])
>> pci_bus 0000:00: root bus resource [mem 0x800100000000-0x8007ffffffff] (bus address [0x100000000-0x7ffffffff])
>> pci_bus 0000:00: root bus resource [bus 00-77]
>>
>> -v2: mem64_space should use mem_space.start as offset.
>> -v3: add IORESOURCE_MEM_64 flag
...
> PCI: Scanning PBM /pci@301
> pci_sun4v f0339c2c: PCI host bridge to bus 0009:00
> pci_bus 0009:00: root bus resource [io  0x2027e40000000-0x2027e4fffffff] (bus address [0x0000-0xfffffff])
> pci_bus 0009:00: root bus resource [mem 0x2024000100000-0x202407effffff] (bus address [0x00000000-0x7eefffff])
> pci_bus 0009:00: root bus resource [mem 0x2024100000000-0x2024dffffffff] (bus address [0xfff00000-0xdffefffff])

Looks like offset for mmio64 is not right.

Please check attached patch on the this platform  and T5-8.

Thanks

Yinghai

--001a1141673c1506ef0521265d88
Content-Type: text/x-patch; charset=US-ASCII; name="fix_sparc_mem64_offset.patch"
Content-Disposition: attachment; filename="fix_sparc_mem64_offset.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ifa766jz0

LS0tCiBhcmNoL3NwYXJjL2tlcm5lbC9wY2kuYyB8ICAgIDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKSW5kZXg6IGxpbnV4LTIuNi9hcmNoL3NwYXJj
L2tlcm5lbC9wY2kuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC0yLjYub3JpZy9hcmNoL3NwYXJjL2tl
cm5lbC9wY2kuYworKysgbGludXgtMi42L2FyY2gvc3BhcmMva2VybmVsL3BjaS5jCkBAIC02NTks
NyArNjU5LDcgQEAgc3RydWN0IHBjaV9idXMgKnBjaV9zY2FuX29uZV9wYm0oc3RydWN0CiAJCQkJ
cGJtLT5tZW1fc3BhY2Uuc3RhcnQpOwogCWlmIChwYm0tPm1lbTY0X3NwYWNlLmZsYWdzKQogCQlw
Y2lfYWRkX3Jlc291cmNlX29mZnNldCgmcmVzb3VyY2VzLCAmcGJtLT5tZW02NF9zcGFjZSwKLQkJ
CQkJcGJtLT5tZW1fc3BhY2Uuc3RhcnQpOworCQkJCQlwYm0tPm1lbTY0X3NwYWNlLnN0YXJ0KTsK
IAlwYm0tPmJ1c24uc3RhcnQgPSBwYm0tPnBjaV9maXJzdF9idXNubzsKIAlwYm0tPmJ1c24uZW5k
CT0gcGJtLT5wY2lfbGFzdF9idXNubzsKIAlwYm0tPmJ1c24uZmxhZ3MJPSBJT1JFU09VUkNFX0JV
UzsK
--001a1141673c1506ef0521265d88--
