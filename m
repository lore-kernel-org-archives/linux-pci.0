Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:56600 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbaJMUjD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 13 Oct 2014 16:39:03 -0400
Received: by mail-qa0-f54.google.com with SMTP id i13so4968068qae.13
        for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2014 13:39:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1413231118.26478.21.camel@pasglop>
References: <1412656696.30859.122.camel@pasglop>
	<CADnq5_NFt8neiOAg896d3-DbAn0rnrE7iXaTFmkNGSg-J9oSkA@mail.gmail.com>
	<1412746096.30859.229.camel@pasglop>
	<1413231118.26478.21.camel@pasglop>
Date: Mon, 13 Oct 2014 16:39:02 -0400
Message-ID: <CADnq5_Od-cr5u8vsMbLw3sTTsbKDGwJcbvoMNgKETAeDpUXhTw@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] sound/radeon: Add quirk for broken 64-bit MSI
From: Alex Deucher <alexdeucher@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dave Airlie <airlied@linux.ie>, Takashi Iwai <tiwai@suse.de>,
	Brian King <brking@linux.vnet.ibm.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Anton Blanchard <anton@au1.ibm.com>, linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 13, 2014 at 4:11 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2014-10-08 at 16:28 +1100, Benjamin Herrenschmidt wrote:
>
>> > Further discussion with the hw teams have revealed that this is still
>> > an issue on newer asics so I think your original patch is correct
>> > after all.  Just disable 64 bit MSIs on all AMD audio PCI ids.
>>
>> Allright, I won't resend the whole series, I can just pickup my previous
>> patch. Takashi, Bjorn, Dave, this series covers your 3 areas of
>> maintainership, how do you want to proceed ? I'm happy to merge the
>> whole lot via powerpc ASAP (since it's all CC'ed stable) if you guys
>> send me the appropriate acks, otherwise, let me know.
>
> So I got an Ack from Takashi but so far silence from Bjorn and Dave :-)
>
> Ping ?

I'm fine with the radeon patches going through your tree rather than
through my tree.

Alex
