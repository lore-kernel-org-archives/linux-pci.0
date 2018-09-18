Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:40868 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729689AbeIRXma (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Sep 2018 19:42:30 -0400
Subject: Re: [Xen-devel] [PATCH V3 2/2] Xen/PCIback: Implement PCI
 flr/slot/bus reset with 'reset' SysFS attribute
To: George Dunlap <George.Dunlap@citrix.com>,
        =?UTF-8?B?UGFzaSBLw6Rya2vDpGlu?= =?UTF-8?Q?en?= <pasik@iki.fi>,
        Roger Pau Monne <roger.pau@citrix.com>
Cc: Jan Beulich <JBeulich@suse.com>, Juergen Gross <jgross@suse.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <20171207222145.9769-1-Govinda.Tatti@Oracle.COM>
 <20171207222145.9769-3-Govinda.Tatti@Oracle.COM>
 <5A2A6AB10200007800195D4F@prv-mh.provo.novell.com>
 <8a3bc517-1255-4547-d244-5c400e44cc77@Oracle.COM>
 <f19dbb09-ef22-2cf4-fb38-2a7c42b5dc48@Oracle.COM>
 <5A377E020200007800197FFA@prv-mh.provo.novell.com>
 <559ffd12-b541-8a69-60bd-fbe10e3dc159@oracle.com>
 <20180916114306.GF18222@reaktio.net>
 <a726840b-8a5c-0890-73c6-3a95a7205153@oracle.com>
 <20180918071519.GG18222@reaktio.net>
 <5E7DDB68-4E68-48A5-AEEC-EE1B21A50E9E@citrix.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <352310b3-ec9b-2ceb-83f0-4550718120c3@oracle.com>
Date: Tue, 18 Sep 2018 14:09:53 -0400
MIME-Version: 1.0
In-Reply-To: <5E7DDB68-4E68-48A5-AEEC-EE1B21A50E9E@citrix.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/18/18 5:32 AM, George Dunlap wrote:
>
>> On Sep 18, 2018, at 8:15 AM, Pasi Kärkkäinen <pasik@iki.fi> wrote:
>>
>> Hi,
>>
>> On Mon, Sep 17, 2018 at 02:06:02PM -0400, Boris Ostrovsky wrote:
>>> What about the toolstack changes? Have they been accepted? I vaguely
>>> recall there was a discussion about those changes but don't remember how
>>> it ended.
>>>
>> I don't think toolstack/libxl patch has been applied yet either.
>>
>>
>> "[PATCH V1 0/1] Xen/Tools: PCI reset using 'reset' SysFS attribute":
>> https://lists.xen.org/archives/html/xen-devel/2017-12/msg00664.html
>>
>> "[PATCH V1 1/1] Xen/libxl: Perform PCI reset using 'reset' SysFS attribute":
>> https://lists.xen.org/archives/html/xen-devel/2017-12/msg00663.html


Will this patch work for *BSD? Roger?


>>
>> George asked for some clarifications:
>> https://lists.xen.org/archives/html/xen-devel/2017-12/msg01044.html
>> https://lists.xen.org/archives/html/xen-devel/2017-12/msg01116.html
> Right, the description of the patch didn’t actually tell you what was going on.  It should have said something like, “xl currently attempts to reset a device using X; but that’s never been implemented in Linux.  Instead, use Y, which [is better for whatever reason]”.

Yes, the description can be tightened a bit ;-)

-boris
