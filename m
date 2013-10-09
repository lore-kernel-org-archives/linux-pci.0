Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:17664 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753958Ab3JIBpl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 8 Oct 2013 21:45:41 -0400
Message-ID: <5254B52C.1050500@imgtec.com>
Date: Tue, 8 Oct 2013 18:45:16 -0700
From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	James Hogan <james.hogan@imgtec.com>,
	Qais Yousef <Qais.Yousef@imgtec.com>
Subject: Re: [PATCH v2 2/4] PCI/quirks: Rename piix4_[io|mem]_quirk to add
 acpi
References: <1380929453-15428-1-git-send-email-dengcheng.zhu@imgtec.com> <1380929453-15428-3-git-send-email-dengcheng.zhu@imgtec.com> <CAErSpo4mWXhfgvxWkYtD6GqtuSHZ26HZ0vTnf5NTZo6W+U04LQ@mail.gmail.com>
In-Reply-To: <CAErSpo4mWXhfgvxWkYtD6GqtuSHZ26HZ0vTnf5NTZo6W+U04LQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/08/2013 04:14 PM, Bjorn Helgaas wrote:
> On Fri, Oct 4, 2013 at 5:30 PM, Deng-Cheng Zhu <dengcheng.zhu@imgtec.com> wrote:
>> From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
>>
>> Rename piix4_[io|mem]_quirk to piix4_acpi_[io|mem]_quirk because these 2
>> functions only deal with the function 3 (power management) of PIIX4.
>>
>> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
>> Reviewed-by: James Hogan <james.hogan@imgtec.com>
> I don't really see the point in patches 2-4.  We end up with 50 more
> lines of code.  Most of this is new #defines.  They do add names where
> before we only had numbers, which *sounds* attractive, but it looks
> like each #define is used only once, and it's in chipset-dependent
> code where a careful reader has to compare every line with the spec
> anyway.  Adding a #define means you have to look at the definition,
> the use, and the spec.  Without the #define, you only have to look at
> the code and the spec.  I don't think it's worth it.

Sometimes (most of the time) reader doesn't want to dig into spec since the 
code is already there and the device is working. Reader may only want to 
know what the code is doing. The macros help (otherwise one can only know 
that pci_read_config_dword is reading a config register and then the output 
will be used to OR or AND). Variable names do give some hints, but macros 
give additional info. Yes, many of them are used only once, but they help a 
bit when used. Some examples are in the same file drivers/pci/quirks.c, 
such as ICH*. And you can easily find other examples by grepping, e.g. 
drivers/thermal/armada_thermal.c.

The above is about patch #4. About #2, it is an effort to make the code 
have more sense, as explained in the commit message. It IS an improvement, 
isn't it?

About #3, do you really think reusing the same logic by putting it in a 
function is worthless?


Deng-Cheng


