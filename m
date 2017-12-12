Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp2130.oracle.com ([141.146.126.79]:39146 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbdLLPPB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Dec 2017 10:15:01 -0500
Subject: Re: [Xen-devel] [PATCH V3 2/2] Xen/PCIback: Implement PCI
 flr/slot/bus reset with 'reset' SysFS attribute
To: Jan Beulich <JBeulich@suse.com>
Cc: Juergen Gross <jgross@suse.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        xen-devel@lists.xenproject.org, boris.ostrovsky@Oracle.COM,
        roger.pau@citrix.com
References: <20171207222145.9769-1-Govinda.Tatti@Oracle.COM>
 <20171207222145.9769-3-Govinda.Tatti@Oracle.COM>
 <5A2A6AB10200007800195D4F@prv-mh.provo.novell.com>
 <8a3bc517-1255-4547-d244-5c400e44cc77@Oracle.COM>
 <5A2FFD690200007800196DFB@prv-mh.provo.novell.com>
From: Govinda Tatti <Govinda.Tatti@Oracle.COM>
Message-ID: <63e8c7c7-8c7d-3307-22bc-3c27f327b62a@Oracle.COM>
Date: Tue, 12 Dec 2017 09:14:09 -0600
MIME-Version: 1.0
In-Reply-To: <5A2FFD690200007800196DFB@prv-mh.provo.novell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 12/12/2017 9:01 AM, Jan Beulich wrote:
>>>> On 12.12.17 at 15:48, <Govinda.Tatti@Oracle.COM> wrote:
>> Thanks Jan for your review comments. Please see below for my comments.
> First of all - can you please do something about your reply style?
> HTML mail should be avoided. You'll see that the (plain text) reply
> as a result is rather hard to follow, too.
Sorry about it. I had an issue with my Thunderbird setting.
>
>> --- a/Documentation/ABI/testing/sysfs-driver-pciback
>> +++ b/Documentation/ABI/testing/sysfs-driver-pciback
>> @@ -11,3 +11,18 @@ Description:
>>                   #echo 00:19.0-E0:2:FF > /sys/bus/pci/drivers/pciback/quirks
>>                   will allow the guest to read and write to the configuration
>>                   register 0x0E.
>> +
>> +What:           /sys/bus/pci/drivers/pciback/reset
>> +Date:           Dec 2017
>> +KernelVersion:  4.15
>> +Contact:        xen-devel@lists.xenproject.org
>> +Description:
>> +                An option to perform a flr/slot/bus reset when a PCI device
>> + is owned by Xen PCI backend. Writing a string of DDDD:BB:DD.F
>> SSSS:BB:DD.F (or else the D-s are ambiguous, the more that "domain"
>> in Xen code is ambiguous anyway - I continue to be mislead by struct
>> pcistub_device_id's domain field)  Thanks for catching this issue. I will
>> fix it.
>>
>>
>> Also I assume the SSSS part is optional (default zero), which
>> probably can and should be expressed in some way.  SSSS can be 0 or
>> non-zero, subject to system configuration.
> The question isn't system configuration, but whether the field can
> be omitted on input, with zero being assumed in such a case. That's
> a common shorthand, considering that the vast majority of x86
> (and maybe other) systems aren't using segments other than zero
Yes, it can be omitted if SSSS is zero.I will add this information
to above documentation file.

Cheers
GOVINDA
