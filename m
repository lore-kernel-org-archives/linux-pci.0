Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:46642 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbeFENEU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jun 2018 09:04:20 -0400
MIME-Version: 1.0
In-Reply-To: <CAHp75VciAimPhuMDOzYdMP=S1OWGyOUh4dN4BqfsLVOpTnRBRQ@mail.gmail.com>
References: <20180604155523.14906-1-mr.nuke.me@gmail.com> <CAHp75VciAimPhuMDOzYdMP=S1OWGyOUh4dN4BqfsLVOpTnRBRQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 Jun 2018 16:04:19 +0300
Message-ID: <CAHp75VdmHvfXvLDUpyVb9QiWCG0YSPErQ+O=Lvdj2NS6WrcdZQ@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: Check for PCIe downtraining conditions
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 5, 2018 at 3:27 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Jun 4, 2018 at 6:55 PM, Alexandru Gagniuc <mr.nuke.me@gmail.com> wrote:
>> PCIe downtraining happens when both the device and PCIe port are
>> capable of a larger bus width or higher speed than negotiated.
>> Downtraining might be indicative of other problems in the system, and
>> identifying this from userspace is neither intuitive, nor straigh
>> forward.
>>
>> The easiest way to detect this is with pcie_print_link_status(),
>> since the bottleneck is usually the link that is downtrained. It's not
>> a perfect solution, but it works extremely well in most cases.
>
> Have you seen any of my comments?
> For your convenience repeating below.

Ah, found the answer in a pile of emails. OK, I see your point about
helper, though the rest is still applicable here.

-- 
With Best Regards,
Andy Shevchenko
