Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:35257 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbaJHGXU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Oct 2014 02:23:20 -0400
Received: by mail-qc0-f171.google.com with SMTP id i17so7020151qcy.2
        for <linux-pci@vger.kernel.org>; Tue, 07 Oct 2014 23:23:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1412746096.30859.229.camel@pasglop>
References: <1412656696.30859.122.camel@pasglop>
	<CADnq5_NFt8neiOAg896d3-DbAn0rnrE7iXaTFmkNGSg-J9oSkA@mail.gmail.com>
	<1412746096.30859.229.camel@pasglop>
Date: Wed, 8 Oct 2014 02:23:19 -0400
Message-ID: <CADnq5_MH+sLjm=_teX-oJ0k+2BsR+pthen7VDUDVFsKPJw6kqg@mail.gmail.com>
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

On Wed, Oct 8, 2014 at 1:28 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2014-10-07 at 19:47 -0400, Alex Deucher wrote:
>> > This moves the setting of the quirk flag to the audio driver.
>> >
>> > While recent ASICs have that problem fixed, they don't seem to
>> > be listed in the PCI IDs of the current driver, so let's quirk all
>> > the ATI HDMI for now. The consequences are nil on x86 anyway.
>> >
>> > Signed-off-by: Alex Deucher <alexdeucher@gmail.com>
>> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> > CC: <stable@vger.kernel.org>
>>
>> Further discussion with the hw teams have revealed that this is still
>> an issue on newer asics so I think your original patch is correct
>> after all.  Just disable 64 bit MSIs on all AMD audio PCI ids.
>
> Allright, I won't resend the whole series, I can just pickup my previous
> patch. Takashi, Bjorn, Dave, this series covers your 3 areas of
> maintainership, how do you want to proceed ? I'm happy to merge the
> whole lot via powerpc ASAP (since it's all CC'ed stable) if you guys
> send me the appropriate acks, otherwise, let me know.
>

I don't remember if I gave my formal review of your original patch, so if not,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Alex
