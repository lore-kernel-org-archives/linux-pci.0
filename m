Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97067C10F06
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 16:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C83D2087C
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 16:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfCKQW5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:22:57 -0400
Received: from mail-oln040092254090.outbound.protection.outlook.com ([40.92.254.90]:6183
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726977AbfCKQW5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 12:22:57 -0400
Received: from HK2APC01FT058.eop-APC01.prod.protection.outlook.com
 (10.152.248.56) by HK2APC01HT068.eop-APC01.prod.protection.outlook.com
 (10.152.249.215) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1686.19; Mon, 11 Mar
 2019 16:22:48 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM (10.152.248.58) by
 HK2APC01FT058.mail.protection.outlook.com (10.152.249.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.19 via Frontend Transport; Mon, 11 Mar 2019 16:22:48 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::88f1:49d3:6e90:a74e]) by PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::88f1:49d3:6e90:a74e%5]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 16:22:48 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v2 0/4] PCI: Patch series to support Thunderbolt without any
 BIOS support
Thread-Topic: [PATCH v2 0/4] PCI: Patch series to support Thunderbolt without
 any BIOS support
Thread-Index: AQHU2CaqdQa6071WSkmqU0Pc1jpj/g==
Date:   Mon, 11 Mar 2019 16:22:47 +0000
Message-ID: <PS2P216MB0642DA40B66B36581A238EF580480@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0204.apcprd06.prod.outlook.com (2603:1096:4:1::36)
 To PS2P216MB0642.KORP216.PROD.OUTLOOK.COM (2603:1096:300:1c::16)
x-incomingtopheadermarker: OriginalChecksum:AC7D3C2EAD036E9F636AA8A703C3DE4CB6D83A6E11E139C19C6ED4FA4948EA35;UpperCasedChecksum:8644C89A79B8E13145DB4DB9E919588550328DB20CA09FF1CCD37FE48D1C1E6D;SizeAsReceived:7811;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.1
x-tmn:  [AV71UNgpAW4wQERF5pLRYrHjuvPv1g9l+TtL4gG7MmNxPZFBLa33hSuBNlRYXF4wXe9otEFFH/Q=]
x-microsoft-original-message-id: <20190311162154.3852-1-nicholas.johnson-opensource@outlook.com.au>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: =?iso-8859-1?Q?h70CqCTTlEGA/A4FN9C4MOCOMhnQuzId1ib/i/lwdiNmG0dGZoYG7k9hYV?=
 =?iso-8859-1?Q?3FTcCRgXJgXVe/AeXbtaZvzgAfzCEH8p3kfYr8wZ4bl9RPA0bJ8ouB6PcJ?=
 =?iso-8859-1?Q?8k7TaOrOEj0eJRjf6M4F0rp+yNDg/si2yojcFskXwL3wfnf8h7hOFn0TLl?=
 =?iso-8859-1?Q?bUxeQhROrgXtppisRq3JCm/IUP+TZII3LjmKnYeUh95ZcPSfXqmu1OzPSD?=
 =?iso-8859-1?Q?17TztBLlDIBo/MSz5lxgoIGktlzYP9NZcM23jjcxs8A5s7aFXGRMq1V/+b?=
 =?iso-8859-1?Q?+KiLmqcjwhQs0aUQc3QgbANHgNmQY5diS/tfkZJzW1gk3EiN8hfMd47UPW?=
 =?iso-8859-1?Q?vTmvxY+srwBQaWi4QGtNV455FsilG/RYjx4NGnUKnRmcpJjEsi9UfqvZjM?=
 =?iso-8859-1?Q?0ARxrSOvY8clMRPeyEAOVNfVaeLJy5W33YDkcX3O3qkyBNG4LJhLtK7M6u?=
 =?iso-8859-1?Q?Azv97Med01DlUwyYIET6NynUqGBC6468uphMpxmUtlNAwOxJZaUi0+5YH/?=
 =?iso-8859-1?Q?209Gy8hRwoPdgbKzKkMbr29IoU8l/zH6J28ClSR/lcNjk33Z7WKFafbzq2?=
 =?iso-8859-1?Q?U3fx5CpHw/1J5Nhgqx34qRNL5YTIVX5+U1EIy8yFC8+NZq14DdH5FcnDah?=
 =?iso-8859-1?Q?si3zi+SiVjtAnUDVD5XpCIKHjiJwKBEwrMtaFgLcrNxnWJafO+54gzkvRq?=
 =?iso-8859-1?Q?YDg1Lw+M6gj/z162WjSWRfoBUtcVRX4xt/WTyjTGYT1Dnl2Y9sUlF9/s95?=
 =?iso-8859-1?Q?hMOUR6UESgXhOeesnQvTnhml8dp3VuE1uKSOJUXqbxNBG6rd/yQwvJorE/?=
 =?iso-8859-1?Q?Eq7nSrmGsTLMl2Fks7AkXd51ZG8H+3KhOgdiE3UDqpGbk2jRIx8XTmsS9S?=
 =?iso-8859-1?Q?7dbYJqL++hN41bVPvkVWZcw0/Vqei4rC7j/9qDyV0+VUR+xqfzUHTWEKp3?=
 =?iso-8859-1?Q?w1OvDvR+dvqsAc8GdxhPSSJCS2aL/Hj+7PuriBhnnJyPj8afZ8KPaHyqHs?=
 =?iso-8859-1?Q?o9nKBqjYpML67mITx2HE6UnenoAyEvu2UA+Cgl8mvthc75lql4zRfGFDyU?=
 =?iso-8859-1?Q?zQgmkfG8KC4p4hWDAxz2du7V1or/GHfLua7gXwuzzDXW?=
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(201702181274)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:HK2APC01HT068;
x-ms-traffictypediagnostic: HK2APC01HT068:
x-microsoft-antispam-message-info: FofRrx84laREHdvrFWsilq8P/Y19uRqBWEX24munOxCS22a2jWCGltb/cZ5Ebmk8
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b167e0b6-ea15-4fd5-489e-08d6a63dcc11
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 16:22:48.3479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT068
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

_________________________________________________________________

If possible, please try to include this in the upcoming release. I have 
been slow in getting PATCH v2 out but overall, it should not be too much 
to do.

You have seen the first patch before, which is the most complicated. It 
is based entirely on Mika Westerberg's code and he was happy that the 
changes are fine. So this should help a little in getting it through.

The second is merely comments and no code - easy to inspect.

The third has very few lines and should be easy to test and revert in 
the worst case.

The fourth brings the most changes functionally, but has nothing in it 
algorithmically. It is just taking command line parameters and setting 
the variables - hence it should be easy to visually inspect for 
correctness.

I have worked very hard on this and would be very appreciative if it 
could make the merge window so that the next eight weeks can be spent by 
me responding to any potential concerns about it.

Thank you!
_________________________________________________________________


This new revision of my patches solves some small problems and tidies up 
the commit notes, migrating background information into the cover 
letter.

Together, these patches allow for a Thunderbolt 3 Titan Ridge add-in 
card to be supported on any system with a PCI bus, without an inkling of 
firmware support. I have been using the following (somewhat overkill) 
kernel arguments for many weeks now with two dual-port add-in cards:

pci=assign-busses,hpbussize=0x33,realloc,hp_io_size=0,hp_mmio_size=256M,hp_mmio_pref_size=64G,nocrs 
[required on some other platforms] pcie_ports=native

This exceeds the official Intel Thunderbolt implementation in that 
arbitrary memory may be easily assigned, allowing for cards like Xeon 
Phi coprocessor with massive BARs (the size of their onboard RAM) to be 
placed on Thunderbolt.

PATCH 0001 solves the resource alignment bug here, which also applies to 
external graphics: https://bugzilla.kernel.org/show_bug.cgi?id=199581 
The resource alignment bug is not Thunderbolt-specific, and applies to 
nested PCI hotplug bridges. Hence, it needed to be fixed regardless of 
Thunderbolt. But Thunderbolt is the most likely use case affected by the 
bug.

PATCH 0002 is just comment clean-up and no code is changed. I noticed 
that a lot of the block comments in drivers/pci/setup-bus.c did not meet 
the kernel coding style guidelines so I fixed them all when I needed to 
change a comment. This has been separated into its own patch upon 
request of the maintainers.

PATCH 0003 fixes a bug that is nasty, but rarely shows. This bugfix is 
critical for that next Thunderbolt patch. I will provide the previously 
requested dmesg output showing the bug in another email. For this, I 
will be using an unmodified kernel and show how requesting 
hpmemsize=256M on my machine results in 512M being allocated in MMIO 
window, and hence the assignment failing because there is not enough 
space. I can show it assigning 256M in MMIO successfully after my patch 
is applied.

Symptoms: When the kernel makes multiple passes at assigning resources, 
it can sometimes assign double the hpmemsize specified in kernel 
parameters into the MMIO bridge window.

The cause: pbus_size_io() and pbus_size_mem() both call 
find_free_bus_resource() to identify which bridge window of the bus 
matches the required resource type. Because this function explicitly 
skips resources with a parent, it will return NULL if the desired 
resource has been successfully assigned in a previous pass. The 
functions pbus_size_io() and pbus_size_mem() return -ENOSPC if 
find_free_bus_resource() returns NULL, meaning an assigned resource is 
interpreted as "out of space", which can result in 
__pci_bus_size_bridges allocating the required size again in another 
window.

The solution: my proposed patch renames find_free_bus_resource() to 
find_bus_resource_of_type() and modifies it to not skip resources with 
r->parent. The name change is because returning an assigned resource 
makes the resource potentially not "free". The calling functions, 
pbus_size_io() and pbus_size_mem() have checks added for b_res->parent 
and they return 0 (success) in this case. This is because a resource 
with a parent is already assigned and should be interpreted as a 
success, not a failure.

Testing: I have been using this proposed patch for many weeks now and it 
appears to work flawlessly. It has the added benefit of slashing the 
number of attempts taken to assign a given BAR, meaning a much cleaner 
dmesg. I am so confident in it that if it were not to be accepted, I 
would continue to compile my own kernel each release with it included, 
for my own use.

PATCH 0004 allows MMIO and MMIO_PREF sizes to be requested independently 
in kernel parameters. This is the user-facing patch that delivers the 
functional requirement of being able to specify the resource sizes 
independently. The other patches are prep-work for this patch, allowing 
it to work flawlessly. This will also make at least one other person 
very happy, providing a solution where none previously existed (if this 
is accepted, I will be answering their question with this patch): 
https://superuser.com/questions/1054657/how-can-i-reserve-hotplug-bridges-memory-only-for-prefetchable-memory-using-the

Nicholas Johnson (4):
  PCI: Consider alignment of hot-added bridges when distributing
    available resources
  PCI: Cleanup comments in setup-bus.c to meet kernel coding style
    guidelines
  PCI: Fix serious bug when sizing bridges with additional size
  PCI: modify kernel parameters to differentiate between MMIO and
    MMIO_PREF sizes

 .../admin-guide/kernel-parameters.txt         |  21 +-
 drivers/pci/pci.c                             |  39 +-
 drivers/pci/setup-bus.c                       | 513 +++++++++---------
 include/linux/pci.h                           |   3 +-
 4 files changed, 323 insertions(+), 253 deletions(-)

-- 
2.20.1

