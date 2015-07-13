Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35928 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbbGMPtX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2015 11:49:23 -0400
Received: by widjy10 with SMTP id jy10so73612201wid.1
        for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2015 08:49:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150713181025-mutt-send-email-mst@redhat.com>
References: <1435745608-21217-1-git-send-email-mst@redhat.com> <20150713181025-mutt-send-email-mst@redhat.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 13 Jul 2015 10:49:02 -0500
Message-ID: <CAErSpo4cbj58VheRbQOJ3XnyBn_SvmUi9ZyFhRnPWhf8ciJ7jg@mail.gmail.com>
Subject: Re: [PATCH] pci_regs: reintroduce PCI_MSIX_FLAGS_BIRMASK
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rajat Jain <rajatxjain@gmail.com>,
	"Chen, Gong" <gong.chen@linux.intel.com>,
	Guenter Roeck <groeck@juniper.net>,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	linux-api@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 13, 2015 at 10:11 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Wed, Jul 01, 2015 at 12:14:10PM +0200, Michael S. Tsirkin wrote:
>> This partially reverts commit 09a2c73ddfc7f173237fc7209a65b34dd5bcb5ed.
>>     PCI: Remove unused PCI_MSIX_FLAGS_BIRMASK definition
>>
>> That commit dropped a symbol from an exported header claiming "no one
>> uses it". This isn't how Linux normally approaches userspace API though,
>> and in fact QEMU build fails if trying to use updated headers from linux
>> 3.12 and up.
>>
>> Sure, userspace can be fixed to use the new symbol, but the cost
>> of keeping the old one around is fairly low, too.
>>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> Ping. Can this be included upstream please?

Yes, I plan to merge it, and I'll mark it for stable.  This looks like
a complete revert of 09a2c73ddfc7, not a partial revert.  Am I missing
something?

09a2c73ddfc7 appeared in v3.13 (not v3.12), so it wouldn't ordinarily
be post-merge window material.  But it seems pretty safe, so I might
put it in for v4.2 instead of waiting for v4.3.

>> ---
>>  include/uapi/linux/pci_regs.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>> index efe3443..66644ac 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -319,6 +319,7 @@
>>  #define PCI_MSIX_PBA         8       /* Pending Bit Array offset */
>>  #define  PCI_MSIX_PBA_BIR    0x00000007 /* BAR index */
>>  #define  PCI_MSIX_PBA_OFFSET 0xfffffff8 /* Offset into specified BAR */
>> +#define  PCI_MSIX_FLAGS_BIRMASK      PCI_MSIX_PBA_BIR /* deprecated */
>>  #define PCI_CAP_MSIX_SIZEOF  12      /* size of MSIX registers */
>>
>>  /* MSI-X Table entry format */
>> --
>> MST
