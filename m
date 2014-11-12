Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:39839 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933967AbaKLEKD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Nov 2014 23:10:03 -0500
Received: by mail-qg0-f41.google.com with SMTP id q107so8389978qgd.14
        for <linux-pci@vger.kernel.org>; Tue, 11 Nov 2014 20:10:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1415765215.5124.30.camel@kernel.crashing.org>
References: <1412656696.30859.122.camel@pasglop> <CADnq5_NFt8neiOAg896d3-DbAn0rnrE7iXaTFmkNGSg-J9oSkA@mail.gmail.com>
 <1412746096.30859.229.camel@pasglop> <20141015221914.GD15225@google.com>
 <1413413732.11213.27.camel@pasglop> <20141111211248.GI28161@google.com>
 <1415759019.10731.1.camel@concordia> <1415765215.5124.30.camel@kernel.crashing.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 11 Nov 2014 21:09:42 -0700
Message-ID: <CAErSpo5yDtsFTMOuYzgF-HzKOVX2Q3cv2-63rk6yH=PSYJkg7Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] sound/radeon: Add quirk for broken 64-bit MSI
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
	Dave Airlie <airlied@linux.ie>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Anton Blanchard <anton@au1.ibm.com>,
	Takashi Iwai <tiwai@suse.de>,
	Yijing Wang <wangyijing@huawei.com>,
	Brian King <brking@linux.vnet.ibm.com>,
	Alex Deucher <alexdeucher@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 11, 2014 at 9:06 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2014-11-12 at 13:23 +1100, Michael Ellerman wrote:
>> On Tue, 2014-11-11 at 14:12 -0700, Bjorn Helgaas wrote:
>> > On Thu, Oct 16, 2014 at 09:55:32AM +1100, Benjamin Herrenschmidt wrote:
>> > > On Wed, 2014-10-15 at 16:19 -0600, Bjorn Helgaas wrote:
>> > > >   PCI/MSI: Add device flag indicating that 64-bit MSIs don't work
>> >
>> > I'm still assuming you're going to merge this series, but I don't see it in
>> > your tree (https://git.kernel.org/cgit/linux/kernel/git/benh/powerpc.git/)
>> > yet.  Do you want me to do anything with it?
>>
>> I'm doing the powerpc tree this cycle, so it'd be in my tree, but it's not:
>>
>>   https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/
>>
>> Ben if you want me to take it let me know.
>
> Hrm, I might have dropped the ball accidentally here. Bjorn did you
> actually Ack the core changes ? In that case we should probably pick it
> up.

Yep, I acked it earlier in this thread (Oct 15).

Bjorn
